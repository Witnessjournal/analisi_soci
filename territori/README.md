# Istruzioni

Questa cartella contiene le pagine dedicate ai territori. L'indice delle pagine è automaticamente aggiornato con una nuova scheda per ogni file con estensione `.qmd` in questa cartella.

I file `.qmd` sono documenti [quarto](https://quarto.org/docs/guide/), formattati in Markdown, con alcune funzionalità aggiuntive per la formattazione più avanzata e per la possibilità per integrare blocchi di codice R o Python. Questi blocchi vegono eseguiti **al momento della generazione del sito** e il loro output viene incluso nel documento finale. 

Il sito viene generato direttamente da una GitHub action ogni volta che viene fatto un push sul branch `main`. Per generare il sito in locale (preview), è necessario installare [quarto](https://quarto.org/docs/get-started/installation/) e [R](https://cran.r-project.org/) (o [Python](https://www.python.org/downloads/) se si usano blocchi di codice Python). Una volta installati, è possibile generare il sito con il comando:

```bash
quarto preview
```

Per lo sviluppo, si consiglia l'uso di RStudio ([posit.co](https://posit.co)) oppure, in seconda battuta, Visual Studio Code con le estensioni per Quarto.

## Preambolo

Si consiglia di partire da una delle pagine di territorio esistenti (come `Trento.qmd`). 
La prima cosa da modificare è il *preambolo*, che è l'intestazione del file compresa tra `---` e che è in formato YAML (quindi le tabulazioni sono importanti).

Nel preambolo vanno modificati questi campi:

- `title`: Il titolo della pagina. Il testo `{{< bi geo >}}` inserisce l'icona della puntina.
- `author`: L'autore della pagina.
- `date`: La data di creazione della pagina
- `image`: Il link ad un'immagine da usare nell'elenco delle pagine dei territori. Può essere un'URL completa oppure il nome di un file locale. In questo caso inserire un JPG nella cartella `images` e inserire `images/Città.jpg` come nome del file.
- `params`: impostare il nome della provincia (in maiuscole). Serve per il conteggio dei membri.


## Testo

Il corpo della pagina comincia con un blocco di codice che carica i dati statistici sugli utenti. Di norma questo blocco **non va modificato**.

### Mini-galleria immagini

Nella parte compresa tra `:::{layout-ncol=4}` e `:::` è possibile inserire una mini-galleria di immagini. Per ogni immagine, sostituire l'URL con quello delle proprie immagini remote o locali (nella cartella `images`).

### Testo

Utilizzare liberamente le sezioni **Informazioni** e **Contatti**. La sezione **Membri attivi** è generata automaticamente e non va modificata. 

Ulteriori sezioni possono essere aggiunte a piacere, utilizzando le intestazioni di secondo livello (##) e di terzo livello (###).


# Pubblicazione

* Lavorare su un *fork* della repository GitHub. 
* L'effetto delle modifiche può essere visualizzato in anteprima con il comando `quarto preview`. 
* Per pubblicare le modifiche, fare un *commit* della propria repository, seguito da un *pull request* sulla repository principale, <https://github.com/Witnessjournal/witnessjournal.github.io>. Quando il *pull request* viene accettato, il sito viene automaticamente aggiornato (il processo di pubblicazione richiede qualche minuto).

