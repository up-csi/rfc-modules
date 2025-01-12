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

- *Git* MUST be the version control system of choice for the Engineering Committee and be readily available on all development platforms to be used by its members.

- *Git Bash* SHOULD be installed with Git for Windows on Windows platforms.

- The latest version of Git upon writing this document is *2.48.0*, the Engineering Committee MUST NOT use any version older than this.
    - The Engineering Committee SHOULD NOT use any major version newer than *2*

= GitHub

= Git Configuration

= Git Usage Standards

== Conventional Commits