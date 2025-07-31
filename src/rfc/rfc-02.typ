#import "../template.typ": *

#show: project.with(
    "RFC-02: Web Application Tech Stack",
    authors: ("Eriene Galinato", ),
    status: draft-status,
    abstract: "This document codifies and standardizes the tech stack to be adopted by CSI for creating web applications, with the aim of standardizing ESLint rules, file organization, and content management, among others."
)

= Preamble
The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in #link("https://www.rfc-editor.org/rfc/rfc2119")[RFC 2119].

The standards outlined in this document are to be adopted for use by the Engineering Committee. Per the purpose of an RFC, the directives herein are to be treated as _standard operating procedure_ for the committee.

= Repository Configuration
== Necessary Packages
=== Dependencies vs devDependencies
== Scripts

= Dependency-Related Configurations
== Linters and formatters
=== Svelte-specific Rules
=== ESLint Rules
== Custom Themes with TailwindCSS
The official project theme/palette, as set by the designated UI/UX designer, MUST be stored in a `.css` file, hereby known as a _theme file_. If there are multiple themes, then there must be multiple theme files. The #link(<file-org>)[File Organization] section specifies where the theme files SHALL be located. 

Aside from following TailwindCSS syntax, the colors in the theme file MUST adhere to the format set by the Branding and Creatives Committee (i.e. HEX/RGB/HSL format).

=== Applying a Theme
To maintain a cleaner codebase, the use of the `dark:` directive, or any theme directive for that matter, SHOULD be *limited*. Colors that will _change_ with the theme (e.g. background and foreground colors) MUST be defined in the TailwindCSS configuration file (`tailwind.config.ts`) and SHALL refer to a CSS variable in a theme file.

= Development Proper
== File Organization<file-org>
=== The `$routes` folder
=== The `$lib` folder
== `sort-imports` Madness
Since time immemorial (start of the CSI website development), the `sort-imports` ESLint rule has been Public Enemy \#1 for new contributors. Errors from this rule usually result in hours of debugging and wacky solutions. Thus, this section standardizes import conventions to minimize and avoid errors from `sort-imports`.

#note[
    The magic comment, \
    `// eslint-disable-next-line` \
    SHOULD NOT be used unless you have shown the project maintainer that it is *absolutely* necessary.
]

The following import conventions SHALL be followed:
+ *`.env` imports* before everything else
+ *dependency/external* imports before *internal* imports
+ *type, model, and function* imports before *component* imports
    - *type-and-model-only* imports before *imports with functions*
+ *images* _after_ everything else

Each of these SHALL have their own blocks of code, and each block of code MUST be separated by an empty line. Specifically,

```html
<script lang="ts">
    // .env imports
    import { PUBLIC_API_URL } from '$env/static/public';

    // dependency/external type-and-model-only imports
    import type { EnhancedImgAttributes } from '@sveltejs/enhanced-img';

    // dependency/external imports with functions
    import { type InferOutput, array, object, pipe, string, transform } from 'valibot';

    // dependency/external component imports
    import Icon from '@iconify/svelte';
    import Moon from '@iconify/icons-heroicons/moon-solid';

    // internal type-and-model-only imports
    import { type Officer, Officer as OfficerSchema } from '$lib/models/officer';

    // internal imports with functions
    import { getExec } from '$lib/data/exec';

    // internal component imports
    import ThemeButton from '$lib/components/controls/ThemeButton.svelte';

    // images
    import lino from '$lib/assets/lino/lino-sablay.svg';
</script>
```

Additional reminders for the `sort-imports` rule:
+ *Multiple* imports MUST come before *singular* imports
    ```ts
    import { type Officer, Officer as OfficerSchema } from '$lib/models/officer';
    import { type Position, Position as PositionSchema } from '$lib/models/position';
    import type { Board } from '$lib/types/board';
    import type { BoardOfficer } from '$lib/types/board_officer';
    ```
+ Imports MUST be sorted *alphabetically*
    ```ts
    import create from '$lib/assets/cartoons/create.svg';
    import develop from '$lib/assets/cartoons/develop.svg';
    import establish from '$lib/assets/cartoons/establish.svg';
    import improve from '$lib/assets/cartoons/improve.svg';
    import innovate from '$lib/assets/cartoons/innovate.svg';
    import learn from '$lib/assets/cartoons/learn.svg';
    ```

== Enhanced Images
*For local images*, the `<enhanced:img />` tag SHOULD be preferred over the `<img />` tag. As such,
- images SHOULD be in the `.webp` format.
- the `EnhancedImgAttributes` type SHOULD be imported from `@sveltejs/enhanced-img` for type validation
    ```html
    <script lang="ts">
        import type { EnhancedImgAttributes } from '@sveltejs/enhanced-img';

        const src: EnhancedImgAttributes['src'];
    </script>

    <enhanced:img {src} />
    ```

== Miscellaneous Conventions
- *JavaScript vs TypeScript*: If TypeScript is not necessary for type-checking *and* type-checking is at a minimum, JavaScript SHOULD be preferred over TypeScript as TypeScript files tend to slow down the build process.
- *Single- vs Double-quotes*: Single-quotes SHOULD be preferred for JavaScript and TypeScript files, while double-quotes SHOULD be preferred for HTML and JSON files.
- *Naming Conventions*: The following conventions SHALL be used
    - camelCase for variables, attributes, and functions
    - PascalCase for types, models, and classes
    - UPPER_CASE for constants

= Before Merging to `main`


= Content Management
== Type Validation
== Database
== Content Management System

= Future