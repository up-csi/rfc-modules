#import "template.typ": *

// Change parameters depending on the module metadata.
#show: project.with(
    "UP CSI Typst Layout",
    authors: ("Aaron Jude Tanael", "Sebastian Luis Ortiz"),
)

// Insert your document below this line

= Normal, Bold and Italicized Text
```typ
This is a normal text. _This is an italic text._ *This is a bold text.*
```
This is a normal text. _This is an italic text._ *This is a bold text.*

= Headings
#columns(2)[
    #set heading(numbering: none, outlined: false)
    ```typ
    = Heading
    Insert text here.

    == Subheading
    Another text here.

    === Subsubheading
    And so on.
    ```
    #colbreak()
    = 1  Heading
    Insert text here.
    == 1.1  Subheading
    Another text here.
    === 1.1.1  Subsubheading
    And so on.
]

= Images
```typ
#image(width: 70%, "path-to-image.svg")
```
#image(width: 70%, "res/image.svg")

#pagebreak()

```typ
#figure(
    image(width: 70%, "path-to-image.svg"), 
    caption: "This is a caption."
)
```
#figure(
    image(width: 70%, "res/image.svg"),
    caption: "This is a caption."
)

= Inline Source Code
```typ
`print("This is an inline code.")`
```
`print("This is an inline code.")`

````typ
```py print("This is an inline code with Python syntax highlighting.")```
````
```py print("This is an inline code with Python syntax highlighting.")```

= Source Code Block
#columns(2)[
    ````typ
    ```py
    def add(a, b):
        return a + b

    print(add(1, 2))
    print(add(3, 4))
    ```
    ````
    #colbreak()
    ```py
    def add(a, b):
        return a + b

    print(add(1, 2))
    print(add(3, 4))
    ```
]

#pagebreak()

= Exercises
```typ
#exercise("What a View!")[This is a numbered exercise with a title.]
```
#exercise("What a View!")[This is a numbered exercise with a title.]

= Notes
#columns(2)[
    ```typ
    #note[This is a note.]
    ```
    #colbreak()
    #note[This is a note.]
]

= Warnings
#columns(2)[
    ```typ
    #warning[This is a warning.]
    ```
    #colbreak()
    #warning[This is a warning.]
]

= Errors
#columns(2)[
    ```typ
    #error[This is an error.]
    ```
    #colbreak()
    #error[This is an error.]
]

= Pagebreak
```typ
#pagebreak()
```
#pagebreak()

= Linebreak
#columns(2)[
    ```typ
    First text.\
    Second text.
    ```
    #colbreak()
    First text.\
    Second text.
]

= Links
#grid(
    columns: (65%, auto),
    ```typ
    https://example.com \
    #link("https://example.com") \
    This is a #link("https://example.com")[link]
    ```,
    [
        https://example.com \
        #link("https://example.com") \
        This is a #link("https://example.com")[link]
    ],
)

= Two or More Columns
```typ
#columns(3)[
    First column. #lorem(10)
    #colbreak()
    Second column. #lorem(10)
    #colbreak()
    Third column. #lorem(10)
]
```
#columns(3)[
    First column. #lorem(10)
    #colbreak()
    Second column. #lorem(10)
    #colbreak()
    Third column. #lorem(10)
]

```typ
#columns(2)[
    #image("path-to-image.svg")
    #colbreak()
    Text column. #lorem(50)
]
```
#columns(2)[
    #image("res/image.svg")
    #colbreak()
    Text column. #lorem(50)
]

= Grids
```typ
#grid(
    columns: (25%, auto, 25%),
    lorem(10), lorem(25), lorem(10),
    lorem(10), lorem(25), lorem(10),
)
```
#grid(
    columns: (25%, auto, 25%),
    lorem(10), lorem(25), lorem(10),
    lorem(10), lorem(25), lorem(10),
)

= Tables
```typ
#table(
    columns: (25%, auto, 25%),
    lorem(10), lorem(25), lorem(10),
    lorem(10), lorem(25), lorem(10),
)
```
#table(
    columns: (25%, auto, 25%),
    lorem(10), lorem(25), lorem(10),
    lorem(10), lorem(25), lorem(10),
)

#pagebreak()

= Colored Text
```typ
#color(red)[This is a red-colored text.]
#color(green)[This is a green-colored text.]
#color(blue)[This is a blue-colored text.]
#color(rgb("#2596be"))[This is a `"#2596be"`-colored text.]
#color(rgb(37, 150, 190))[This is an `rgb(37, 150, 190)`-colored text.]
```
#color(red)[This is a red-colored text.]
#color(green)[This is a green-colored text.]
#color(blue)[This is a blue-colored text.]
#color(rgb("#2596be"))[This is a `"#2596be"`-colored text.]
#color(rgb(37, 150, 190))[This is an `rgb(37, 150, 190)`-colored text.]

= Bibliography Setup
```typ
Something happened, and it must be cited @alvarez_2019_socialization. \
Multiple sources #cite("alvarez_2019_socialization", "laplante_2014_consultasand", "jerrentrup_2018_teaching") said this instead.
```

```typ
Something happened, and it must be cited @alvarez_2019_socialization. \
Multiple sources #cite("alvarez_2019_socialization", "laplante_2014_consultasand", "jerrentrup_2018_teaching") said this instead.
```

```typ
#bibliography("ref.bib", style: "ieee")
```

