# UP CSI RFC Modules

The document template and repository for the UP CSI Engineering Committee Requests for Comments.

# Getting Started

1. Install [Typst](https://github.com/typst/typst#installation).
    * Windows: `winget install -e Typst.Typst`
    * macOS/Linux: `brew install typst`
    * Arch Linux: `pacman -S typst`
    * Void Linux: `xbps-install typst`
1. Install the following fonts:
    * [Fira Sans](https://github.com/mozilla/Fira)
    * [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
1. Clone the repository.
1. Create the `.typ` file inside the `src` folder (where the modules will be written).
1. Use the template below to bootstrap the code.

```typ
// Note that the import path is relative!
// Traverse parent directories when necessary.
#import "template.typ": *

// Change parameters depending on the module metadata.
// Note that all arguments are required!
#show: project.with(
    // The main content of the title section.
    title: "RFC-XX: Title",
    // List of authors who contributed to this RFC.
    authors: ("UP CSI",),
    // The status of the RFC
    status: #draft-status
    // A short summary of the RFC
    abstract: "This document standardizes ..."
)

// TODO: Your Content

#bibliography("rfc-xx.bib")
```

## Compilation

The `typst watch <file>.typ` command is recommended to enable "watch mode", which recompiles the file on save. Typst uses incremental compilation to achieve fast compilation speeds. Otherwise, one may also invoke the `typst compile <file>.typ` command for one-shot compilations.

See the [usage guide](https://github.com/typst/typst#usage) for more information.

## Working in Visual Studio Code

For those working in Visual Studio Code, you may install the [Typst LSP] extension for syntax highlighting, diagnostics, PDF preview support, and other features. Live previews of the document are supported via the [`vscode-pdf`] extension. Once installed, open the Command Palette (`Ctrl+Shift+P`) and search for the command `Typst: Show the compiled PDF...` (full name shortened for brevity).

[Typst LSP]: https://marketplace.visualstudio.com/items?itemName=nvarner.typst-lsp
[`vscode-pdf`]: https://marketplace.visualstudio.com/items?itemName=tomoki1207.pdf

## Fonts

Typst automatically recognizes system fonts. As a sanity check, run `typst fonts` to see if Typst recognizes newly installed fonts.

> [!IMPORTANT]
> When adding custom fonts, the `typst watch` command must be rerun for the new fonts to be detected.
