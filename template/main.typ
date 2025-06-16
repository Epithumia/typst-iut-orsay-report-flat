#import "@preview/iut-orsay-report-flat:1.0.0": iut-orsay-report, prune, summary, table-list, figure-list, lexicon, remark

///////////////////////////////////////////
// 1/3 If not already done, download the
//     "Open Sans" font (see README)
/////////////////////////////////////////// 

///////////////////////////////////////////
// 2/3 Change the value of the following
//     parameters to edit the first two pages.
//     All parameters have a default value, so
//     you can remove some to highlight which
//     ones are still missing.
/////////////////////////////////////////// 

#show: iut-orsay-report.with(
  student-name: [Tiphaine Patraque],
  title: [Rapport d'apprentissage],
  subtitle: [Cercle des sorcières du Disque-monde],
  keywords: ("Causse", "sorcellerie", "magie occulte"),
  abstract: lorem(200),
  diploma: [BUT Sorcellerie],
  specialty: [Parcours A : magie des miroirs],
  level: [Troisième année],
  report-date: [20 octobre 1955],
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
  // You can also adjust spacings in the first page with
  // `vertical-spacing-1` to `vertical-spacing-5`
  // and `horizontal-spacing-1` to `horizontal-spacing-2`
)

///////////////////////////////////////////
// 3/3 Starting from here, the third page,
//     no formatting is imposed.
//     However here are some tweaks you
//     might like.
///////////////////////////////////////////

// Switch to a serif font family, size 11

#set text(
  font: "Libertinus Serif",
  size: 11pt
)

// Show links in blue

#show link: set text(fill: blue)

// Show numbers in references (to a bibliography entry, a section, a figure) in blue
// thanks Eric Biedert https://github.com/typst/typst/discussions/4143

#show cite: it => {
  // reference to a bibliography entry -> color only the number, not square brackets, not the potential supplement
  show regex("\[",): set text(fill: black) // enforce square brackets in black
  show regex("^\[(\d+)",): set text(fill: blue) // only the first number, in case there is a number in the supplement
  it
}
#show ref: it => {
  if it.element == none {
    // reference to a bibliography entry -> manage by `#show cite` above
    return it
  }
  // reference to a section or a figure
  show regex("[\d]+[\.]?[\d]*[\.]?[\d]*"): set text(fill: blue) // find something like "1", "1.2" or "1.3"
  it
}

// Figure legends in italic and with smaller font size

#show figure.caption: it => [
  #text(size: 10pt, style: "italic")[#it]
]

// Headings numbering & refer to a section with "Chapitre X" instead of "Section X"

#set heading(numbering: "1.1", supplement: "Chapitre")

// Refer to an equation with "Équation X" instead of "Equation X"

#set math.equation(supplement: "Équation")

// Headings formatting

#let heading_text_size = (none, 18pt, 15pt, 12pt, 11pt) // for each heading level
#show heading.where(level: 1): header => {
  set text(
    size: heading_text_size.at(1),
    fill: prune,
    font: "Open Sans",
    weight: "bold"
  )
  let number = context counter(heading).display("1 • ") // prefix format
  pagebreak(weak: true) // start level 1 headings on a new page
  block(breakable: false)[
    #if header.numbering != none [ #number ]
    #upper(header.body)
  ]
  v(heading_text_size.at(1)) // same height spacing as the font size
}
#show heading.where(level: 2): header => {
  set text(
    size: heading_text_size.at(2),
    font: "Open Sans",
    weight: "bold"
  )
  v(heading_text_size.at(2)) // same height spacing as the font size
  box()[
    #counter(heading).display()~
    #upper(header.body)
  ]
  v(heading_text_size.at(2)) // same height spacing as the font size
}
#show heading.where(level: 3): header => {
  set text(
    size: heading_text_size.at(3),
    font: "Open Sans",
    weight: "bold"
  )
  v(heading_text_size.at(3)) // same height spacing as the font size
  box()[
    #h(10pt) // small indent
    #counter(heading).display()~
    #header.body
  ]
  v(heading_text_size.at(3)) // same height spacing as the font size
}

// Headings formatting in the outline

#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true) // small spacing before
  strong(it) // in bold
}
#show outline.entry.where(level: 3): it => {
  text(size: 10pt)[#it] // slightly smaller
}

// Footer with the page number

#set page(footer: context [
    #set align(center)
    #text(
      fill: black,
      size: 12pt,
      weight: "regular"
    )[
      #counter(page).display("1")
    ]
  ]
)

// Text justification

#set par(
  justify: true,
  linebreaks: "optimized"
)



// Display the outline

#outline(
  title: [Table des matières],
  indent: 1em
)

///////////////////////////////////////////
// Write your report below. Bon courage !
///////////////////////////////////////////

= Chapitre <ch:chapitre>

#lorem(50)

#summary[
  #lorem(25)
]

== Sous-chapitre <ch:sous-chapitre>

#lorem(25)

=== Sous-sous-chapitre <ch:sous-sous-chapitre>

#lorem(50) @bib:concerning-hobbits

#remark[
  #lorem(25)
]

#remark(number:1,
  [On peut aussi numéroter les remarques.]
)

#lorem(50)

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [Timing results],
)


#table-list()

#figure-list()

#lexicon(
  [
    / Ligature: A merged glyph.
    / Kerning: A spacing adjustment between two adjacent letters.
  ]
)

#bibliography("bib.yml", title: [Bibliographie])