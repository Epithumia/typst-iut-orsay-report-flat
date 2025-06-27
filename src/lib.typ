#import "@preview/colorful-boxes:1.4.1": colorbox
// The main color of the Paris-Saclay University visual identity
#let prune = rgb(99, 0, 60)

// Yellow background color for highlighting
#let yellow-highlighting = rgb("#fffd11a1") // default color of highlight() https://typst.app/docs/reference/text/highlight/#parameters-fill

// An highlighted empty rectangle for missing parameters
#let missing-field(width: 10em) = box(
  fill: yellow-highlighting,
  width: width,
  height: 1em,
  baseline: 0.2em
)

// A box to have a small summary for a section/sub-section
#let summary(body) = {
  colorbox(
    title: text(font: "Open Sans")[En résumé],
    radius: 2pt,
    width: auto,
    box-colors: (
      prune: (stroke: prune, fill: white, title: white),
    ),
    color: "prune"
  )[
    #body
    #v(2pt)
  ]
}

// Allows to have non numbered sections, eg. 
//= Addendum <unnumbered>

#show selector(<unnumbered>): set heading(numbering: none)

// List of tables
#let table-list() = {
  heading("Liste des tables",numbering:none)
  outline(target: figure.where(kind: table), title: none)
}

// List of figures
#let figure-list() = {
  heading("Liste des figures",numbering:none)
  outline(target: figure.where(kind: image), title: none)
}

// Lexicon
#let lexicon(content) = {
  heading("Lexique",numbering:none)
  (content)
}

// A "Remarque : " text box

#let remark(number: none, body) = {
  block(stroke: (left: 1pt), inset: 0.5em)[
    #smallcaps[Remarque #number :] #body
  ] 
}

// The function takes the whole document as `body` parameter
// and formats it for a IUT Orsay report
#let iut-orsay-report(

  // The first and last names of the candidate
  student-name: highlight[Prénom Nom],

  // The thesis title in French
  title: highlight[Titre de la thèse],

  // The translated thesis title in English
  subtitle: highlight[Title of the thesis],

  // The keywords of the thesis subject, in French
  keywords: (highlight[Mot-clé 1], highlight[Mot-clé 2], highlight[Mot-clé 3]),

  // Abstract of the thesis, in French
  abstract: highlight(lorem(200)),

  // The line for the doctoral school number and name
  diploma: [Département #missing-field()],

  // The line for the specialty
  specialty: [],

  // The line for the graduate school
  level: [#missing-field() année],

  // The date of the PhD defense
  report-date: [#missing-field()],

  // Training/Alternance
  company-name:[],
  company-logo:"img/empty.png",

  // The list of thesis examiners (rapporteurs and defense examiners)
  thesis-examiners: (
    (
      name: missing-field(),
      title: missing-field(width: 25em),
      status: highlight[Président(e)]
    ),
    (
      name: missing-field(),
      title: missing-field(width: 25em),
      status: highlight[Rapporteur &\ Examinateur/trice]
    ),
    (
      name: missing-field(),
      title: missing-field(width: 25em),
      status: highlight[Rapporteur &\ Examinateur/trice]
    ),
    (
      name: missing-field(),
      title: missing-field(width: 25em),
      status: highlight[Examinateur/trice]
    ),
  ),

  // Spacings in the first page
  vertical-spacing-1: 15pt,
  vertical-spacing-2: 55pt,
  vertical-spacing-3: 40pt,
  vertical-spacing-4: 40pt,
  vertical-spacing-5: 40pt,
  horizontal-spacing-1: 50pt,
  horizontal-spacing-2: 100pt,

  // The thesis content
  body

) = {

  set page(
    paper: "a4",
    margin: (
      left: 0pt,
      top: 0pt,
      bottom: 0pt,
      right: 2.5cm
    )
  )

  set text(
    font: ("Open Sans"),
    size: 12pt,
    lang: "fr"
  )

  let rectangle_width = 16.4%*21cm // 16.4% of the page width

  grid(
    columns: (rectangle_width, 100%-rectangle_width),
    gutter: 25pt,
    [
      #rect(
        fill: prune,
        width: 100%,// 100% of rectangle_width,
        height: 100%
      )
    ],
    [ // right part of the grid

      #v(vertical-spacing-1)

      #image("img/iut-orsay.svg", width: 50%*21cm)

      #v(vertical-spacing-2)

      #align(right)[
        #text(
          size: 20pt,
          fill: prune,
        )[
          #title
        ]\
        #v(2pt)
        #text(
          size: 13pt,
          fill: black,
          style: "italic"
        )[
          #subtitle
        ]\

        #v(vertical-spacing-3)

        #text(
          size: 13pt,
          weight: 400,
        )[
          #if specialty != none [*#diploma --- #specialty*] else [*#diploma*]\
        ]
        #text(
          size: 12pt,
        )[
          #level
        ]

        #text(
          size: 11pt,
        )[
          *Rapport rédigé le #report-date, par* \
        ]

        #text(
          size: 20pt,
          fill: prune,
          weight: 600,
        )[
          #student-name
        ]
      ]

      #v(vertical-spacing-4)

      #align(center)[
      
        #text(
          size: 12pt,
        )[
          #company-name
        ]

        #image(company-logo, width: 100%, height: 25%, fit: "contain")
      
      ]
      

      #v(vertical-spacing-4)

      #v(1fr)

      #grid(
        columns: (horizontal-spacing-1, auto),
        row-gutter: 1em,
        stroke: (x,y) => if x == 1 and y == 1 { (left: (1pt + prune)) },
        [],
        [
          #text(size: 14pt, fill: prune)[*Encadrement*]
        ],
        [],
        [
          #set text(10pt)
          #grid(
            columns: (auto, auto),
            column-gutter: horizontal-spacing-2,
            inset: (x: 6pt, y: 3pt),
            align: horizon,
            ..for thesis-examiner in thesis-examiners {
              (thesis-examiner.name, grid.cell(rowspan: 2)[#thesis-examiner.status], text(size: 9pt)[#thesis-examiner.title])
              if thesis-examiner != thesis-examiners.last() {
                ([],[])
              }
            }
          )
        ],
      )

      #v(vertical-spacing-5)
    ]
  ) // end grid

  // from the second page, default margins of the A4 paper size
  set page(
    margin: auto
  )

  pagebreak()

  image("img/iut-orsay.svg", width: 60%)

  v(10pt)

  grid(
    columns: (100%),
    rows: 1,
    gutter: 40pt,
    inset: 10pt,
    stroke: 1pt+prune,
    [
      #set text(10pt)
      *Titre :* #title\
      *Mots-clés :* #for keyword in keywords {
        (keyword)
        if keyword != keywords.last() {
          (", ")
        }
      }\
      #v(5pt)
      *Résumé :* #abstract
    ]
  )

  pagebreak(weak: true)

  body
}