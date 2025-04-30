library(httr2)

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


