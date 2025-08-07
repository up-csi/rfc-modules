#import "../template.typ": *

#show: project.with(
    "RFC-02: Web Development Tech Stack",
    authors: ("Eriene Galinato",),
    status: draft-status,
    abstract: "This document codifies and standardizes the tech stack to be adopted by CSI for web development, with the aim of standardizing ESLint rules, file organization, and content management, among others.",
)

= Preamble
The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in #link("https://www.rfc-editor.org/rfc/rfc2119")[RFC 2119].

The standards outlined in this document are to be adopted for use by the Engineering Committee. Per the purpose of an RFC, the directives herein are to be treated as _standard operating procedure_ for the committee.

= Repository Configuration
Due to its ease-of-use, SvelteKit, with TailwindCSS for styling, SHOULD be used for web development until a faster and more intuitive framework has _matured_.

Due to package maturity and stability, projects SHOULD use the Node.js runtime environment until #link(<need-pkg>)[necessary packages] in a more performant runtime environment have _matured_. Further, until a more performant package manager has _matured_ (i.e. v.1), `pnpm` SHOULD be used.

#note[
    This RFC is subject to change if better technologies mature and/or missing technologies and/or standards are added.
]

== Necessary Packages<need-pkg>
Alongside the standard `@sveltejs/kit` and `tailwindcss` Node.js packages and their dependencies, projects MUST include the following packages (specific packages subject to change)
- JSON validation for type-safety (`valibot`)
- codebase formatter (`prettier`)
- codebase linters (`svelte-check`, `eslint`)
- HTML sanitizer (`sanitize-html`), if using the `@html` keyword

Further, projects SHOULD include the following plugins
- An official SvelteKit adapter (`@sveltejs/adapter-<static/node/vercel/cloudflare/netlify>`)
- `@sveltejs/enhanced-img`: for optimization of local images. Note that this plugin does not work for dynamically-loaded images. See #link(<enhanced-img>)[`Enhanced Images`]

=== Dependencies vs devDependencies
`devDependencies` are the packages needed during development while `dependencies` are the packages that the project depends on when _running_.

Thus, if a package is needed during _runtime_ (i.e. imported in the frontend and/or backend), the package is a `dependency`. Else, this most probably means that the package isn't needed at runtime, but is needed during development (e.g. writing tests, formatting and linting code); as such, the package is a `devDependency`.

For more information, please see #link("https://github.com/up-csi/up-csi.github.io/pull/97#discussion_r1811336963")[this comment] on the CSI website.

== Scripts
The following scripts MUST be included:
- `dev` $=>$ `vite dev`: starts the local development server
- `build` $=>$ `vite build`: builds and optimizes the codebase into a `build` folder
- `preview` $=>$ `vite preview`: enables local build preview
- `prepare` $=>$ `svelte-kit sync`: creates the `.sveltekit` folder, `tsconfig.json`, and all generated types of the project
- Formatting scripts
    - `fmt` $=>$ `prettier --experimental-cli --check .`: checks for formatting issues in the codebase
    - `fmt:fix` $=>$ `prettier --experimental-cli --write .`: applies Prettier's suggestions
- `lint` $=>$ `pnpm --parallel /^lint:/`: lints the codebase.
    - `lint:eslint` $=>$ `eslint --cache .`
    - `lint:svelte` $=>$ `svelte-check --tsconfig ./tsconfig.json`

If default scripts differ from these, said defaults MUST be changed to match the scripts above.

These scripts are executed by adding `pnpm` or `pnpm run` before them (e.g. `pnpm prepare`, `pnpm run dev`).

#note[
    Some interesting things regarding `pnpm prepare` and `svelte-kit sync`:
    - `pnpm prepare` is run after `pnpm install` as a #link("https://docs.npmjs.com/cli/v10/using-npm/scripts#life-cycle-operation-order")[lifecycle script]
    - `svelte-kit sync` #link("https://svelte.dev/docs/kit/cli#svelte-kit-sync")[generates _inferred_ types] for variables and puts it in the `.svelte-kit` folder.

    Thus, `svelte-kit sync` MUST be run *in the same environment* as `.env` variables before using them (e.g. importing, linting) as generated types MUST be set-up before use. As such, on GitHub workflows, `.env` variable declaration may be seen in the installation step.
]

= Dependency-Related Configurations
== Linters and Formatters
All linters and formatters SHOULD use their respective recommended and/or standard configurations. Further, project maintainers MUST be on the lookout for package conflicts and special Svelte[Kit]- and TailwindCSS-related configurations with said linters and formatters.

#note[
    If using `typescript-eslint`, it is also RECOMMENDED to use its stylistic configuration.
]

== Custom Themes with TailwindCSS
The official project theme/palette, as set by the designated UI/UX designer, MUST be stored in a `.css` file, hereby known as a _theme file_. If there are multiple themes, then there must be multiple theme files. The #link(<file-org>)[File Organization] section specifies where the theme files SHALL be located.

Aside from following TailwindCSS syntax, the colors in the theme file MUST adhere to the format set by the Branding and Creatives Committee (i.e. HEX/RGB/HSL format).

=== Applying a Theme
To maintain a cleaner codebase, the use of the `dark:` directive, or any theme directive for that matter, SHOULD be *limited*. Colors that will _change_ with the theme (e.g. background and foreground colors) MUST be defined in the TailwindCSS configuration file (`tailwind.config.ts`) and SHALL refer to a CSS variable in a theme file.

= Development Proper
== File Organization<file-org>
To keep project repositories organized, feature-sliced design SHALL be implemented. The #link("https://github.com/BastiDood/plus-minus")[`plus-minus`] repository of former Director of Engineering Basti Ortiz is an example implementation. Specifically,

=== The `$routes` folder
All files inside the `$routes` folder MUST only be
+ `+` files (e.g. `+page.svelte`), and
+ *page-specific UI* components, stored in a `(ui)` folder in the parent route folder.

=== The `$lib` folder
Everything else in the `src` folder that can be put in a sub folder of `src` and MUST NOT be in the `$routes` folder SHALL be put in the `$lib` folder. To keep the `$lib` folder organized as well, the following folders MUST be maintained:
+ `db`: for all database-related files. Files that MUST be found here are
    + exported `json` files from the Pseudodatabase and their corresponding images,
    + helper functions (i.e. the files that parse the JSON according to `valibot` schema), and
    + type and model files.
+ `brand`: for all branding-related files (e.g. the theme files). An exception is the favicon file, which stays in the `static` folder.
+ `ui`: for all shared UI components (i.e. templated buttons, tables, cards).
+ `feature`: for all feature\*-specific files (i.e. UI, functions). All features must be bundled in their own folders. If any logic can be generalized,
    + it MUST go in the `ui` folder _if_ the logic is *UI-only*;
    + else, it MUST go in the `feature` folder, once again bundled in its own folder.
+ `assets`: for all images shared by multiple pages that don't belong anywhere else.

#note[
    What counts as a _feature_?

    A _feature_ is defined in this RFC as something that enables the information in stored cookies, local/remote storage, or databases to be updated. Thus, everything else is simply _UI logic_ for the purposes of this RFC.
]

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

== Enhanced Images<enhanced-img>
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
Contributors and maintainers MUST strive to keep the `main` branch of remote repositories at a *green* state at *all times*. Thus, automated workflows SHOULD be used to run and check formatters, linters, and builders on each pull requested feature branch prior to pushing to `main`.

On local,
```bash
# the formatters,
pnpm fmt
# then, if there are formatting issues,
pnpm fmt:fix

# the linters,
pnpm lint

# and the builders
pnpm build
# then, to preview the built app
pnpm preview
```
MUST be run and any issues MUST be corrected prior to making a pull request to the remote repository.

= Content Management
== Type Validation
For projects that deal with local JSON or dynamically loaded content, it is a MUST to type validate incoming JSON to prevent errors and other undefined and unexpected behavior. Thus, schemas and types for these JSON MUST be defined.

The RECOMMENDED schema library for this is `valibot`.

== Database
PostgreSQL is the RECOMMENDED option for a database due to familiarity, scalability, and extensibility.

== Content Management System
Some of the most popular content management systems (CMSs) today pack the content management with the content presentation. To avoid the pitfalls of such systems (e.g. lack of freedom and flexibility, slower performance with higher volumes of content, and security issues), it is highly RECOMMENDED to _decouple_ the frontend from the backend and use a _headless CMS_ instead.

Further, due to its ease-of-use, PostgreSQL integration, and free self-hosting (provided the organization's revenue is under \$5M), Directus is highly RECOMMENDED to be used in projects where CMSs are needed.
