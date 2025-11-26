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
Alongside the standard #link("https://svelte.dev/docs/kit/@sveltejs-kit")[`@sveltejs/kit`] and #link("https://tailwindcss.com/")[`tailwindcss`] Node.js packages and their dependencies, projects MUST include the following packages (specific packages subject to change)
- JSON validation for type-safety (#link("https://valibot.dev/")[`valibot`]), if using external data
- codebase formatter (#link("https://prettier.io/")[`prettier`])
- codebase linters (#link("https://svelte.dev/docs/cli/sv-check")[`svelte-check`], #link("https://eslint.org/")[`eslint`])
- HTML sanitizer (#link("https://www.npmjs.com/package/sanitize-html")[`sanitize-html`]), if using the `@html` keyword

Further, projects SHOULD include the following plugins
- An official SvelteKit adapter (#link("https://svelte.dev/docs/kit/adapters")[`@sveltejs/adapter-<static/node/vercel/cloudflare/netlify>`])
- #link("https://svelte.dev/docs/kit/images#sveltejs-enhanced-img")[`@sveltejs/enhanced-img`]: for optimization of local images. Note that this plugin does not work for dynamically-loaded images. See #link(<enhanced-img>)[`Enhanced Images`].

=== Dependencies vs devDependencies
`devDependencies` are the packages needed during development while `dependencies` are the packages that the project depends on when _running_.

Thus, if a package is needed during _runtime_ (i.e. imported in the frontend and/or backend), the package is a `dependency`. Else, this most probably means that the package isn't needed at runtime, but is needed during development (e.g. writing tests, formatting and linting code); as such, the package is a `devDependency`.

For more information, please see #link("https://github.com/up-csi/up-csi.github.io/pull/97#discussion_r1811336963")[this comment] on the CSI website.

== Scripts<scripts>
Aside from the following automatically generated scripts:
- `dev` $=>$ `vite dev`: starts the local development server
- `build` $=>$ `vite build`: builds and optimizes the codebase into a `build` folder
- `preview` $=>$ `vite preview`: enables local build preview
- `prepare` $=>$ `svelte-kit sync || echo ''`: creates the `.sveltekit` folder, `tsconfig.json`, and all generated types of the project

the following scripts MUST be included:
- Formatting scripts (note the '`.`'s at the end)
    - `fmt` $=>$ `prettier --experimental-cli --check .`: checks for formatting issues in the current working directory
    - `fmt:fix` $=>$ `prettier --experimental-cli --write .`: applies Prettier's suggestions in the current working directory
- `lint` $=>$ `pnpm --parallel /^lint:/`: lints the codebase.
    - `lint:es` $=>$ `eslint --cache .`
        - `es:fix` $=>$ `eslint --cache --fix .`
    - `lint:sv` $=>$ `svelte-check --tsconfig ./tsconfig.json`

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

See #link(<es-rules>)[ESLint Rules] for the full list of RECOMMENDED rules to be overridden or added.

#warning[
    The magic comment, \
    `// eslint-disable-next-line` \
    SHOULD NOT be used unless it has been shown to project maintainers that it is *absolutely* necessary.
]

== Custom Themes with TailwindCSS
The official project theme/palette, as set by the designated UI/UX designer, MUST be stored as theme variables in a `.css` file. Aside from following TailwindCSS syntax, the color values assigned to the theme variables MUST adhere to the format set by the Branding and Creatives Committee (i.e. HEX/RGB/HSL format).

=== Applying a Theme Variant
To maintain a cleaner codebase, the use of any theme _variant_ directive (i.e., the `dark:` directive for the dark mode variant of a theme), SHOULD be *limited*. Tailwind defines CSS layers on import to `app.css`; thus, colors that will _change_ with the theme variant (e.g. background and foreground colors) MUST be defined in the `base` CSS layer in `app.css`, via `:root[data-theme='<theme>']`:

```css
@layer base {
    :root {
        /* default variant of a theme (e.g. light mode) */
    }

    :root[data-theme='dark'] {
        /* dark mode */
    }
}
```

#note[
    While the `tailwind.config.js` file is only still _officially_ supported due to backwards compatibility, it is actually _necessary_ to make this non-theme-variant-directive magic work. It is in `tailwind.config.js` that the utility class names can actually be set for the color variables that were not defined in `@theme`. 
]

= Development Proper
== File Organization<file-org>
All files inside the `src/routes` folder MUST only be
+ `+` files (e.g. `+page.svelte`), and
+ *page-specific UI* components, stored in a `(ui)` folder in the parent route folder.

Everything else in the `src` folder that can be put in a sub folder of `src` and MUST NOT be in the `src/routes` folder SHALL be put in the `src/lib` folder (aliased as `$lib`). See #link(<lib-folder>)[The `$lib` Folder] for a recommended file organization for `$lib`.

== Import-sorting Madness
Import-sorting is quite helpful for seeing what's already imported and from which packages. However, since time immemorial (start of the CSI website development), the `sort-imports` ESLint rule has been Public Enemy \#1 for new contributors due to its complexity. Errors from this rule usually result in hours of debugging and wacky solutions. Thus, it is RECOMMENDED to use #link("https://www.npmjs.com/package/@bastidood/eslint-plugin-imsort")[`@bastidood/eslint-plugin-imsort`] for automatically sorting imports (via #link(<scripts>)[`eslint --fix`]).

#warning[
    As per the `README`,
    - this plugin conflicts with the ESLint `sort-imports` rule. As such, `sort-imports` MUST be turned off when using this.
    - #link(<scripts>)[`eslint --fix`] MUST be run before Prettier to sort imports before formatting code as per #link("https://www.npmjs.com/package/@bastidood/eslint-plugin-imsort#integration-with-prettier")[the package instructions].
]

== Enhanced Images<enhanced-img>
*For local images*, the `<enhanced:img />` tag SHOULD be preferred over the `<img />` tag. As such,
- images SHOULD be in the `.webp` format.
- the `EnhancedImgAttributes` type SHOULD be imported from `@sveltejs/enhanced-img` for type validation
    ```html
    <script lang="ts">
        import type { EnhancedImgAttributes } from '@sveltejs/enhanced-img';

        type Props = Pick<EnhancedImgAttributes, 'src'>;
        const { src }: Props = $props();
    </script>

    <enhanced:img {src} />
    ```

== Miscellaneous Conventions
- *JavaScript vs TypeScript*: If type inference is _enough_ or type construction and/or annotations are _not necessary_, JavaScript SHOULD be preferred over TypeScript.

    TypeScript is a superset of JavaScript and is usually just used for its ease-of-use when it comes to handling types. Moreover, #link("https://www.typescriptlang.org/play/?target=1&e=4#example/objects-and-arrays")[types are _stripped_ away when TypeScript code is transpiled to JavaScript]. Thus, it's overkill if plain JavaScript is put in a TypeScript file.
- *Single- vs Double-quotes*: Single-quotes SHOULD be preferred for JavaScript and TypeScript files, while double-quotes SHOULD be preferred for HTML files.
- *Naming Convention*: Based on the #link("https://google.github.io/styleguide/tsguide.html#naming")[Google TypeScript Style Guide] and #link("https://dev.to/somedood/a-grammar-based-naming-convention-13jf")[this Basticle], the following conventions SHALL be used: \
    #table(
        columns: 4,

        table.header([*Type*], [*Case*], [*Grammar*], [*Examples*]),
        [Arrays], [camelCase], [plural or collective noun], [`events`, `committee`, `teams`],
        [Booleans], [camelCase], ["yes-or-no question"], [`isDone`, `isExec`, `hasGraduated`],
        [Classes, Schemas, and Types], [PascalCase], [singular noun], [`Member`, `Officer`, `Committee`],
        [Class Methods and Functions],
        [camelCase],
        ["transitive verb + direct object" in the imperative mood],
        [`getTeam`, `setCommittee`, `attackTitan`],

        [Constants], [UPPER_SNAKE_CASE], [whatever they're supposed to be called], [mathematical constants like `PI`],
        [Everything Else], [camelCase], [singular noun], [`count`, `color`, `memName`],
    )
    In addition, please name _appropriately_. For clarity and readability, *clear and verbose* is strongly RECOMMENDED over *clever and terse*. For instance: prefer `response` over `res` (which is ambiguous to `result`), `error` over `err`, `event` over `e` or `evt`, `userData` over `data`, etc.

It is RECOMMENDED to refer to the #link("https://google.github.io/styleguide/tsguide.html")[Google TypeScript Style Guide] if there are style considerations not covered in this RFC.

= Before Merging to `main`
Contributors and maintainers MUST strive to keep the `main` branch of remote repositories at a *green* state at *all times*. Thus, automated workflows SHOULD be used to run and check formatters, linters, and builders on each pull requested feature branch prior to pushing to `main`.

On local,
```bash
# the formatters,
pnpm fmt
# then, if there are formatting issues,
pnpm fmt:fix

# then the linters,
pnpm lint

# then, if there are no errors, the builders
pnpm build
# then, to preview the built app
pnpm preview
```
MUST be run and any issues MUST be corrected prior to making a pull request to the remote repository.

= Content Management
== Type Validation
For projects that deal with local JSON or dynamically loaded content, it is a MUST to type validate incoming JSON to prevent type errors and other undefined and unexpected behavior. Thus, schemas and types for these JSON MUST be declared and these JSON MUST be parsed through the appropriate schema to validate the JSON.

Moreover, #link("https://www.typescriptlang.org/play/?target=1&e=4#example/objects-and-arrays")[types are _stripped_ away when TypeScript code is transpiled to JavaScript]. Thus, TypeScript doesn't _exist_ at runtime.

Thus, it is a MUST to use a schema-declaration and validation library which ensures type checks at _runtime_. The RECOMMENDED library for this is `valibot`.

== Database
#link("https://www.postgresql.org/")[PostgreSQL] is the RECOMMENDED option for a database due to familiarity, scalability, and extensibility.

== Content Management System
Some of the most popular content management systems (CMSs) today pack the content management with the content presentation. To avoid the pitfalls of such systems (e.g. lack of freedom and flexibility, slower performance with higher volumes of content, and security issues), it is highly RECOMMENDED to _decouple_ the frontend from the backend and use a _headless CMS_ instead.

Further, due to its ease-of-use, PostgreSQL integration, and free self-hosting (provided the organization's *revenue is under 5 million US dollars*), #link("https://directus.io/")[Directus] is highly RECOMMENDED to be used in projects where CMSs are needed.

= Appendix
== ESLint Rules<es-rules>
For simplicity and stability, only the rules in the recommended configurations SHOULD be used. However, some of these rules are RECOMMENDED to be overridden and some other rules are RECOMMENDED to be added as follows:

#note[
    Majority of the rules listed here come from #link("https://github.com/BastiDood/sveltekit-tailwind-template/blob/main/eslint.config.js")[BastiDood/sveltekit-tailwind-template].
]

```js
// @html-eslint/eslint-plugin
rules: {
    '@html-eslint/indent': 'off',
    '@html-eslint/no-duplicate-class': 'error',
    '@html-eslint/no-nested-interactive': 'error',
    '@html-eslint/no-target-blank': 'error',
    '@html-eslint/prefer-https': 'error',
    '@html-eslint/require-button-type': 'error',
    '@html-eslint/require-closing-tags': 'off',
    '@html-eslint/require-explicit-size': 'error',
    '@html-eslint/require-meta-charset': 'error',
    '@html-eslint/sort-attrs': 'error',
    '@html-eslint/no-abstract-roles': 'error',
    '@html-eslint/no-accesskey-attrs': 'error',
    '@html-eslint/no-aria-hidden-body': 'error',
    '@html-eslint/no-heading-inside-button': 'error',
    '@html-eslint/no-invalid-role': 'error',
    '@html-eslint/no-non-scalable-viewport': 'error',
    '@html-eslint/no-positive-tabindex': 'error',
    '@html-eslint/no-skip-heading-levels': 'error',
    '@html-eslint/require-form-method': 'error',
    '@html-eslint/require-frame-title': 'error',
    '@html-eslint/require-input-label': 'error',
    '@html-eslint/require-meta-viewport': 'error',
}
```

```js
// @eslint/css
rules: {
    'css/no-invalid-at-rules': 'off',
}
```

#warning[
    Turning off the `css/no-invalid-at-rules` is a *temporary* measure due to `@eslint/css` failing on bespoke Tailwind at-rules (e.g., `@plugin`, `@theme`).
]

```js
// @eslint/js, typescript-eslint
rules: {
    '@typescript-eslint/class-methods-use-this': 'error',
    '@typescript-eslint/default-param-last': 'error',
    '@typescript-eslint/init-declarations': 'error',
    '@typescript-eslint/method-signature-style': 'error',
    '@typescript-eslint/no-import-type-side-effects': 'error',
    '@typescript-eslint/no-loop-func': 'error',
    '@typescript-eslint/no-unnecessary-parameter-property-assignment': 'error',
    '@typescript-eslint/no-unused-vars': [
    'error',
    { varsIgnorePattern: '^_', argsIgnorePattern: '^_' },
    ],
    '@typescript-eslint/no-use-before-define': 'error',
    '@typescript-eslint/no-useless-empty-export': 'error',
    '@typescript-eslint/parameter-properties': ['error', { prefer: 'parameter-property' }],
    '@typescript-eslint/prefer-enum-initializers': 'error',
    'array-callback-return': ['error', { checkForEach: true }],
    'block-scoped-var': 'error',
    'class-methods-use-this': 'off',
    'consistent-this': ['error', 'self'],
    curly: ['error', 'multi', 'consistent'],
    'default-case': 'error',
    'default-param-last': 'off',
    'dot-notation': 'error',
    eqeqeq: 'error',
    'func-style': ['error', 'declaration'],
    'grouped-accessor-pairs': ['error', 'getBeforeSet'],
    'guard-for-in': 'error',
    'init-declarations': 'off',
    'logical-assignment-operators': 'error',
    'new-cap': 'error',
    'no-alert': 'error',
    'no-array-constructor': 'error',
    'no-caller': 'error',
    'no-constructor-return': 'error',
    'no-div-regex': 'error',
    'no-duplicate-imports': 'error',
    'no-else-return': 'error',
    'no-empty-function': 'error',
    'no-empty-static-block': 'error',
    'no-eq-null': 'error',
    'no-eval': 'error',
    'no-extra-bind': 'error',
    'no-extra-label': 'error',
    'no-extend-native': 'error',
    'no-implicit-coercion': 'error',
    'no-implicit-globals': 'error',
    'no-implied-eval': 'error',
    'no-invalid-this': 'off',
    'no-iterator': 'error',
    'no-label-var': 'error',
    'no-lone-blocks': 'error',
    'no-lonely-if': 'error',
    'no-loop-func': 'off',
    'no-multi-assign': 'error',
    'no-negated-condition': 'error',
    'no-nested-ternary': 'error',
    'no-new': 'error',
    'no-new-func': 'error',
    'no-new-wrappers': 'error',
    'no-octal-escape': 'error',
    'no-param-reassign': 'error',
    'no-promise-executor-return': 'error',
    'no-proto': 'error',
    'no-return-assign': 'error',
    'no-script-url': 'error',
    'no-sequences': 'error',
    'no-throw-literal': 'error',
    'no-undef-init': 'error',
    'no-undefined': 'error',
    'no-underscore-dangle': 'error',
    'no-unmodified-loop-condition': 'error',
    'no-unneeded-ternary': 'error',
    'no-unused-expressions': 'error',
    'no-useless-assignment': 'error',
    'no-useless-call': 'error',
    'no-useless-computed-key': 'error',
    'no-useless-concat': 'error',
    'no-useless-constructor': 'error',
    'no-useless-rename': 'error',
    'no-useless-return': 'error',
    'no-self-compare': 'error',
    'no-template-curly-in-string': 'error',
    'no-unreachable-loop': 'error',
    'no-use-before-define': 'off',
    'no-var': 'error',
    'object-shorthand': ['error', 'always', { avoidExplicitReturnArrows: true }],
    'one-var': ['error', 'never'],
    'operator-assignment': 'error',
    'prefer-arrow-callback': 'error',
    'prefer-const': 'error',
    'prefer-destructuring': 'error',
    'prefer-exponentiation-operator': 'error',
    'prefer-named-capture-group': 'error',
    'prefer-numeric-literals': 'error',
    'prefer-object-has-own': 'error',
    'prefer-object-spread': 'error',
    'prefer-promise-reject-errors': 'error',
    'prefer-regex-literals': 'error',
    'prefer-rest-params': 'error',
    'prefer-spread': 'error',
    'prefer-template': 'error',
    radix: 'error',
    'require-atomic-updates': 'error',
    'require-await': 'error',
    'require-unicode-regexp': 'error',
    'symbol-description': 'error',
    yoda: ['warn', 'never', { exceptRange: true }],
}
```

```js
// eslint-plugin-svelte
rules: {
    'svelte/no-at-html-tags': 'warn',
},
```

#warning[
    The `svelte/no-at-html-tags` rule is meant to guard against cross-site scripting vulnerabilities. As such, there MUST be an HTML sanitizer in the project before setting the rule to `warn`.
]

== The `$lib` Folder<lib-folder>
A RECOMMENDED file organization for the `$lib` folder, based on feature-sliced design (#link("https://dev.to/somedood/youre-slicing-your-architecture-wrong-4ob9")[this Basticle sums it up quite nicely]), is as follows:
+ `brand`: for all branding-related files (e.g. the theme files). An exception is the favicon file, which stays in the `static` folder.
+ `ui`: for all UI components that aren't tailor-made for the current application and can be reused across projects (e.g. those from component libraries like `shadcn-svelte`).
+ `feature`: for all features (i.e. UI components, functions) that are tailor-made for the current application that are _not_ page-specific UI components. All features must be bundled in their own subfolders.
+ `assets`: for all images shared by multiple UI components that don't belong anywhere else.
