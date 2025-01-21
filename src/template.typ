// Import necessary packages.
#import "@preview/codelst:2.0.0": code-frame
#import "@preview/showybox:2.0.1": showybox

// Define RFC statuses
#let draft-status = text(
    font: "Fira Mono",
    weight: "bold",
    fill: luma(100)
)[DRAFT STANDARD]

#let proposed-status = text(
    font: "Fira Mono",
    weight: "bold",
    fill: yellow
)[PROPOSED STANDARD]

#let adopted-status = text(
    font: "Fira Mono",
    weight: "bold",
    fill: green
)[ADOPTED STANDARD]

#let obsoleted-status(new_rfc) = text(
    font: "Fira Mono",
    weight: "bold",
    fill: luma(80)
)[OBSOLETED BY #new_rfc]

#let project(
    title, 
    authors: (), 
    status: "The status of the RFC, whether it has been adopted as a standard by the Director or if it is still a draft (use variables " + `draft-status, proposed-status` + " or " + `approved-status` + ")", 
    abstract: "A summary of the RFC, especially its most important provisions",
    body
) = style(styles => {
    // Font Settings
    set text(font: "Fira Sans", size: 11pt, lang: "en")
    show raw: set text(font: "JetBrains Mono", size: 9pt, lang: "en")

    // Define header
    let header = [
        #stack(dir: ltr, spacing: 8pt)[
            #block(fill: white, height: 34pt, image("res/logo-black.svg"))
        ][
            #set block(spacing: 0.5em)
            #block(strong[University of the Philippines Center for Student Innovations])
            #block[College of Engineering]
            #block[University of the Philippines Diliman]
        ]
        #block(fill: black, height: 1pt, width: 100%)
        #v(2em)
    ]

    // Define footer
    let footer = context [
        #v(2em)
        #counter(page).display() | _Unauthorized reproduction or communication of the material is forbidden._
    ]

    // Document Metadata
    set document(author: authors, title: title)
    set page(
        paper: "us-letter",
        margin: (top: 1in + measure(header, styles).height, bottom: 1in + measure(footer, styles).height, rest: 1in),
        background: image(height: 100% - 2in, "res/transparent-logo-colored.svg"),
        header: header,
        footer: footer,
        header-ascent: 0%,
        footer-descent: 0%,
    )

    // Fancy Source Code Styling
    set raw(syntaxes: "Svelte.sublime-syntax")
    show raw.where(block: true): code => context {
        set par(justify: false)
        set align(left)
        let code-lines = code.text.split("\n")
        let max = measure(box(align(right, text(1em, luma(160), str(code-lines.len()) + h(measure([\s\s], styles).width)))), styles).width
        let line-nos = range(0, code-lines.len()).map(line => {
            box(width: max, align(right, text(1em, luma(160), str(line + 1) + h(measure([\s\s], styles).width))))
            hide(code-lines.at(line))
            linebreak()
        })
        code-frame[
            #v(0.08em)
            #grid(
                columns: (100% - max, 100% - max),
                column-gutter: 2*max - 100%,
                line-nos.join(),
                code,
            )
        ]
    }

    // URL Styles
    show link: link => {
        set text(fill: blue)
        underline(link)
    }

    // Grid and Table Settings
    set grid(gutter: 4%)
    set table(inset: 1em)

    // Title Section with Authors
    align(center, text(1.75em, strong(title)))
    stack(dir: ttb, spacing: 0.75em, ..authors.map(a => align(center)[#a]))

    // Status and Abstract block (called the start block)
    let start_block = block(
        width: 85%,
        inset: 10pt,
        stroke: 1pt,
    )[
        #set heading(outlined: false)
        #align(left)[
            // Status
            = Status of this Document
            #status

            // Abstract
            = Abstract
            #abstract
        ]
    ]

    // Center and Display start block
    align(center, start_block)
    pagebreak()

    // Heading Styles - go after status and abstract to ensure they are not numbered
    set heading(numbering: "1.1 ")
    show heading: set block(below: 1em)
    
    // Table of Contents
    outline()
    pagebreak()

    // Main Content
    set par(justify: true)
    body
})

// Utilities
#let color(color, body) = text(fill: color, body)

// Alerts
#let note = showybox.with(
    title: text(weight: "bold")[#emoji.lightbulb NOTE],
    title-style: (color: black),
    breakable: true,
    frame: (title-color: rgb("#00c6d7")),
)
#let warning = showybox.with(
    title: text(weight: "bold")[#emoji.warning WARNING],
    title-style: (color: black),
    breakable: true,
    frame: (title-color: rgb("#aaaa00")),
)
#let error = showybox.with(
    title: text(weight: "bold")[#emoji.explosion ERROR],
    breakable: true,
    frame: (title-color: rgb("#990000")),
)

// Auto-incrementing counter.
#let count(name, emoji, color, title, body) = context {
    let ex = counter(name)
    ex.step()
    showybox(
        title: text(weight: "bold")[#emoji #name #ex.display(): #title],
        breakable: true,
        frame: (title-color: color),
        body,
    )
}

#let exercise = count.with("Exercise", emoji.arm.muscle, rgb("#00c6d7"))
#let reading = count.with("Reading", emoji.books, rgb("#009933"))
