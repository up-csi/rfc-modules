#import "../template.typ": *

#show: project.with(
    "RFC-01: Engineering Git Standards",
    authors: ("Victor Edwin Reyes", "Zachary Romualdez"),
    status: draft-status,
    abstract: "This document defines a standard operating procedure on the use of Git and GitHub in production, with the aim of enhacing velocity, creating a clean commit log, and enhancing development team operations."
)

= Preamble

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and "OPTIONAL" in this document are to be interpreted as described in #link("https://www.rfc-editor.org/rfc/rfc2119")[RFC 2119].

The standards outlined in this document are to be adopted for use by the Engineering Committee. It is further directed that all new committee members configure their Git instances to align with this standard. Per the purpose of an RFC, the directives herein are to be treated as _standard operating procedure_ for the committee.

= Git

- *Git* MUST be the version control system of choice for the Engineering Committee and MUST be readily available on all development platforms to be used by its members.

- *Git Bash* SHOULD be installed with Git for Windows on Windows platforms.

- The latest version of Git upon writing this document is *2.48.0*, the Engineering Committee MUST NOT use any version older than this.
    - The Engineering Committee SHOULD NOT use any major version newer than *2*

= GitHub

- *GitHub* MUST be the distributed version control provider of choice for the Engineering Committee, except in circumstances such as projects or scenarios where GitHub cannot be used.

- *UP CSI* MUST have a GitHub organization for use as a version control provider and project management platform for the organization
    - The current *Director for Engineering* MUST have administrator privilieges on the UP CSI GitHub organization
    - *UP CSI* SHOULD have a GitHub organization for storing training materials such as assignment templates and individual assignments, to which the Director for Engineering SHOULD have administrator priviliges

= Git Configuration

For the purposes of ensuring consistent operation and procedures in version control, the following configuration settings shall be set as standard:

== Authentication

== #link("https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#:~:text=long%20they%20are.-,user.signingkey,-If%20you%E2%80%99re%20making")[`user.signingkey`]

== #link("https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#:~:text=documentation%20mentioned%20above.-,core.editor,-By%20default%2C%20Git")[`core.editor`]

The default text editor that Git uses might vary across different operating systems and users. Ubuntu users, for example, use `nano` by default and Windows users have the option to use even Notepad as a text editor. To standardize this, the following directive is enforced:

- Git SHOULD be configured to use `vim` by default.

```sh
git config --global core.editor vim
```

== #link("https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#:~:text=with%20these%20issues.-,core.autocrlf,-If%20you%E2%80%99re%20programming")[`core.autocrlf`]

Developers on the committee use different operating systems, with different end-of-line behavior which Git tries to adjust for. Unfortunately, the end-of-line behavior enforced by Git has #link("https://github.com/up-csi/up-csi.github.io/pull/84#issuecomment-2388406206")[caused issues on previous projects]. To remedy this, the following directive is enforced:

- Git MUST be configured to ignore line endings and leave them as is.

```sh
git config --global core.autocrlf false
```

= Git Usage Standards

== Conventional Commits