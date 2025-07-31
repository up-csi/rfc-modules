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
=== Applying a Theme

= Development Proper
== File Organization
=== The `$routes` folder
=== The `$lib` folder
== `sort-imports` Madness
== Enhanced Images
== Miscellaneous Conventions

= Before Merging to `main`
== Version Control
=== Commit Messages
== Automated GitHub Workflows

= Content Management
== Type Validation
== Database
== Content Management System

= Future