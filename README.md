# The `iut-orsay-report-flat` Typst package

An unofficial, flat-design Typst template for IUT Orsay (part of Paris-Saclay University) reports

[![Maintenance Level: Actively Maintained](https://badgen.net/badge/Maintenance%20Level/Actively%20Maintained?color=97ca00)](https://gist.github.com/cheerfulstoic/d107229326a01ff0f333a1d3476e068d)

<p align="center">
<img src="https://github.com/Epithumia/typst-iut-orsay-report-flat/blob/main/thumbnails/p1.png?raw=true" alt="page 1 of an example thesis based on this template" width="49%">
<img src="https://github.com/sebmestrallet/typst-iut-orsay-report-flat/blob/main/thumbnails/p2.png?raw=true" alt="page 2 of an example thesis based on this template" width="49%">
</p>

<details>
<summary>About the name</summary>

- `typst-iut-orsay-report-flat` is the name of the GitHub repo, `iut-orsay-report-flat` is the name of the Typst template
- The Typst template name does not contain `typst`, because it is redundant[^typst_template_naming]
- The Typst template name is not just `iut-orsay-report`, because it is not an official template[^typst_template_naming]. It is based on the [paris-saclay-thesis-flat](https://github.com/sebmestrallet/typst-paris-saclay-thesis-flat) package.

[^typst_template_naming]: https://github.com/typst/packages?tab=readme-ov-file#submission-guidelines

</details>

## Usage

<!-- from https://github.com/typst/templates/tree/main/charged-ieee -->

You can use this template in the [Typst web app](https://typst.app/) by clicking "Start from template" on the dashboard and searching for `iut-orsay-report-flat`.

Alternatively, you can use the CLI to kick this project off using the command:

```bash
typst init @preview/iut-orsay-report-flat
cd iut-orsay-report-flat
```

Then download the _Open Sans_ font, e.g. from [here](https://fonts.google.com/specimen/Open+Sans), and place the .ttf files e.g. in a `fonts/` subfolder.

If you use the CLI, you must tell the binary where to look for additional fonts with the `--font-path` argument:

```bash
typst watch main.typ --font-path fonts
```

And if you use [VS Code](https://code.visualstudio.com/) and [tinymist](https://github.com/Myriad-Dreamin/tinymist), set `["${workspaceFolder}/fonts"]` for `tinymist.fontPaths` in VS Code settings.

In the web app, [project fonts are automatically discovered](https://typst.app/docs/reference/text/text/#parameters-font).

## Configuration

This template exports the `iut-orsay-report` function with the following named arguments:

- `student-name`: Name of the PhD candidate [type: content]
- `title`: Report title [content]
- `subtitle`: Sub-title [content]
- `keywords`: Keywords of the report subject [strings array]
- `abstract`: Abstract of the report [content]
- `diploma`: Line mentioning the diploma this report is for [content]
- `specialty`: Line mentioning the specialty [content]
- `level`: Line mentioning the diploma level (e.g. first year, second year...) [content]
- `report-date`: Date of the report [content]
- `thesis-examiners`: List of thesis examiners [array of dictionaries, each with a `name`, `title` and `status` field, of type content]

Some spacings are adjustable, see [`src/lib.typ`](src/lib.typ) for the complete list of arguments.

The template will initialize your package with a sample call to the `iut-orsay-report` function in a show rule. If you want to change an existing project to use this template, you can add a show rule like this at the top of your file:

```typst
#import "@preview/iut-orsay-report-flat:1.0.0": iut-orsay-report

#show: paris-saclay-thesis.with(
  student-name: [Tiphaine Patraque],
  title: [Rapport de projet S601],
  subtitle: [Têtologie],
  keywords: ("Causse", "sorcellerie", "magie occulte", "têtologie"
  abstract: lorem(200),
  diploma: [BUT Sorcellerie],
  specialty: [Parcours A : magie des miroirs],
  level: [Troisième année],
  report-date: [20 octobre 1955],
  company-name: [Cercle des Sorcières],
  thesis-examiners: (
    (
      name: [*Esmé Ciredutemps*],
      title: [Sorcière],
      status: [Maîtresse d'apprentissage]
    ),
    (
      name: [*Perspicacia Tique*],
      title: [Sorcière],
      status: [Tutrice]
    ),
    (
      name: [*Nac mac Feegle*],
      title: [Fées],
      status: [Tuteurs]
    ),
  ),
)

// Your content goes below.
```

## Resources

- [paris-saclay-thesis-flat](https://github.com/sebmestrallet/typst-paris-saclay-thesis-flat) package
- [Official MS Word & LaTeX templates](https://www.universite-paris-saclay.fr/recherche/doctorat-et-hdr/le-guide-de-la-soutenance-de-doctorat#Ressources) from the Paris-Saclay University

## License

[MIT-0](./LICENSE)
