# Situazione sociale WitnessJournal

Questo progetto contiene un sito statico generato in Quarto via R che analizza la situazione dei soci dell'associazione. Il sito è ospitato su GitHub Pages e il codice sorgente è disponibile su GitHub.

Nessun dato sociale sensibile è contenuto in questa repository né nel sito generato. I dati sono ottenuti via Web API Winddoc all'atto della generazione del sito su una macchina personale.

Perché la generazione sia possibile, è necessario disporre localmente di un file contenente i [token di accesso a Winddoc](https://developers.winddoc.com){target="_blank"}. Il file deve essere chiamato `winddoc_tokens.R` e deve trovarsi nella cartella principale del progetto. Il file avere questa struttura:

```r
tokens <- list(
  token_app = "toke_app here", 
  token = "token here"
)
```