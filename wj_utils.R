library(httr2)

wj_tokens <- function(tokens_file = "winddoc_tokens.R") {
  if (file.exists(tokens_file)) {
    source("winddoc_tokens.R")
  } else {
    tokens <- list(token = Sys.getenv("WJ_TOKEN"),
                   token_app = Sys.getenv("WJ_TOKEN_APP"))
  }
  return(tokens)
}

wj_paged_associates <- function(tokens, page=1, url = "https://app.winddoc.com/v1/api_json.php") {
  soci <- request(url) |>
    req_method("POST") |> 
    req_headers("Content-Type" = "application/json") |>
    req_body_json(
      list(
        method = "associazioni_soci_lista",
        request = list(
          token_key = list(token = tokens$token, token_app = tokens$token_app),
          pagina = page
        )
      )
    ) |>
    req_perform() |>
    resp_body_json()
  return(soci)
}

wj_list_associates <- function(tokens, url = "https://app.winddoc.com/v1/api_json.php") {
  page <- 1
  associates <- data.frame()
  repeat {
    s <- wj_paged_associates(tokens, page = page, url = url)
    if (length(s$lista) == 0) break
    associates <- dplyr::bind_rows(associates, s$lista)
    paste0("Page: ", page, "/", s$numero_pagine, " - ", length(s$lista), " associates") |> message()
    page <- page + 1
  }
  return(associates)
}

wj_list_associates_lazy <- memoise::memoise(
  wj_list_associates, 
  cache = cachem::cache_disk(max_age = 3600*24, dir="cache"))

wj_data <- function(tokens, url = "https://app.winddoc.com/v1/api_json.php") {
  wj_list_associates_lazy(tokens) %>%
    select(
      nome,
      cognome,
      codice_fiscale,
      data_iscrizione,
      data_nascita = contatto_data_nascita,
      contatto_indirizzo_citta,
      contatto_indirizzo_cap,
      contatto_indirizzo_provincia,
      contatto_indirizzo_nazione,
      data_iscrizione,
      data_scadenza_quota,
      deve_rinnovare
    ) %>%
    rename_with(~ str_replace_all(.x, "contatto_indirizzo_", ""),
                everything())
}

wj_soci <- function(data, province_file = "data/province.txt") {
  province <- read_tsv(province_file, na = c(""))
  data %>% 
    mutate(
      età = interval(ymd(data_nascita), today()) %/% years(1),
      provincia = str_to_upper(provincia) %>% 
        str_replace_all("[\\s]+$", "") %>% 
        str_replace_all("[\\s]", "-")
    ) %>% 
    relocate(età, .after = data_nascita) %>%
    left_join(
      province, 
      by = c("provincia" = "PROVINCIA")
    ) %>% 
    mutate(
      provincia = ifelse(is.na(SIGLA), provincia, SIGLA),
      citta = str_to_title(citta),
      genere_n = str_sub(codice_fiscale, 10, 11) %>% as.numeric(),
      genere = ifelse(genere_n>30, "F", "M")
    ) %>% 
    select(-c(SIGLA, REGIONE, genere_n)) %>% 
    relocate(genere, .after=età)
}