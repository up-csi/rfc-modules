#import "../template.typ": *

#show: project.with(
    "RFC-00: Requests for Comments",
    authors: ("Victor Edwin Reyes",),
    status: draft-status,
    abstract: "The Engineering Committee needs a document format to record its decisions. This document provides a rationale for the RFC, defines its purpose, specifies the roles of stakeholders, and provides a style guide."
)

= Request for Comments

== The IETF RFC

#link("https://www.ietf.org/process/rfcs/")[Requests for Comments] are documents published by the Internet Engineering Task Force as their technical documentation. They serve as technical specifications for foundational concepts, systems, and protocols that underpin the internet. 

Such systems include the Hypertext Transfer Protocol (HTTP; #link("https://datatracker.ietf.org/doc/html/rfc7230")[RFC 7230] #cite(<RFC7230>) to #link("https://datatracker.ietf.org/doc/html/rfc7235")[RFC 7235]) #cite(<RFC7235>), WebSockets (#link("https://datatracker.ietf.org/doc/html/rfc6455")[RFC 6455]) #cite(<RFC6455>), Secure Shell (SSH; #link("https://datatracker.ietf.org/doc/html/rfc4251")[RFC 4251]) #cite(<RFC4251>), Secure Hash Algorithms (SHA; #link("https://www.rfc-editor.org/rfc/rfc4634")[RFC 4634]) #cite(<RFC4634>), and many, many others.

Each of the above listed technologies has an associated RFC which describes their specifications. Looking from the outside in, they effectively define interfaces that can be used to communicate with any systems that comply with their specifications. 

For example, anyone can build an Internet Relay Chat (IRC) system simply by complying with the specifications of #link("https://datatracker.ietf.org/doc/html/rfc1459")[RFC 1459] (and other RFCs). RFC 1459, in Section #link("https://datatracker.ietf.org/doc/html/rfc1459#section-4")[4] specifies the formats of messages any IRC application should be able to recognize.

== The Engineering Committee RFC

In accordance with the UP CSI Constitution of 2024, Article V, Section 3, the Engineering Committee is responsible for serving as technical consultants and quality assurers for the organization's projects.

As of the 2425A semester, this responsibility has extended to handling the technical education and training of the organization's developers.

Previous terms have resulted in the adoption of new technologies and standards such as SvelteKit and Git commit conventions. These have been included, and to some extent _codified_, in the committee's trademark Developer Training Program (DTP) and DevCamp (DC). 

However, educational materials are not made for the purpose of rigorously codifying and justifying standards. DTP and DC materials are not strictly reference materials, and would be difficult to specifically reference or use as a foundation for arguments. Not to mention, educational materials are not strictly made to be questioned.

Similarly, codifying the Committee's smaller design or technical decisions becomes more difficult in the format of the training modules.

A format is needed that is not educational - that does not need to teach, but to assert and to be freely challenged. 

Thus, in order to define, preserve, and defend the _technical decisions, standards, and policies_ of the Engineering Committee, the *Engineering Committee Request for Comments* is defined herein.

=== The Purpose of the RFC

The *Request for Comments* is made with three purposes:
- To *record* the decisions of the Engineering Committee

    The RFC must be able to serve as the Committee's memory and as its voice. Any RFC adopted as a standard carries the opinion of the Committee to its readers inside and outside the organization and forward into the future.

- To *define*, rigorously, the technical points and implications of these decisions

    The RFC must be able to serve as a manual for anyone who wants to adopt these same standards. The same way an _IETF RFC_ defines a protocol that can be adopted to interface with other adopters, so must implementations of an _Engineering RFC_ be intercompatible.

- To *justify* these decisions and their implications, with the intent of soliciting _comments_

    The RFC is a standard and a record, but not a lone source of truth. It must be able to challenge its readers to take on the standard for justifiable reasons. Similarly; however, it can be challenged. _It must be challenged_.

= Roles and Responsibilities <roles-and-resp>

This section defines the roles that stakeholders within the Engineering Committee are supposed to play within the process of drafting, publishing, and approving RFCs.

== The Director for Engineering

The Director for Engineering, as head of the committee, reserves the right to the following:
+ To modify the format of RFCs or to otherwise modify this standard
+ To designate *RFC numbers*
+ To accept or reject RFC drafts, elevating them to the status of #adopted-status

With this, the Director is expected to hold the following responsibilities with regard to RFCs:
+ To ensure that members of the committee are aware of and adhere to the provisions of each adopted RFC
+ To ensure that RFCs continue to be written and published by the committee for the benefit of its members and its readers
+ To ensure that all RFCs adhere to the writing standards outlined within this document

== The Engineering Committee Member

Members of the Engineering Committee reserve the right to the following:
+ To propose RFCs with status #draft-status, indicating that they are standards in the process of being written
+ To propose RFCs with status #proposed-status, indicating that they are standards that have been raised for the Director's approval
+ To endorse RFCs of either status written by non-members and receive recognition as co-authors, provided that due credit is given to the original authors
+ To comment on proposed RFCs

With this, members are expected to hold the following responsibilities with regard to RFCs:
+ To be aware of and advise others on the provisions contained within the RFCs
+ To abide by and make use of the provisions of adopted RFCs
+ To ensure that all standards, proposed and adopted, are technically sound
+ To question and critique all standards on grounds of technical soundness, alignment with our values, and relevance

= Style Guide

All RFCs will abide by the following points of style, guided in part by the #link("https://www.rfc-editor.org/rfc/rfc7322")[IETF RFC 7322] #cite(<RFC7322>).

== Style conventions

=== RFC Numbering

- RFCs will be identified by at least two digits ("RFC-XX") and shall be assigned consecutively. 

- Individual RFCs, once published as an #adopted-status, are not to be amended except for typographical, grammatical, or stylistic changes. 

- Obsolete RFCs are to be replaced with a new RFC and indicated by the status #obsoleted-status("RFC-XX").

=== File Format

- RFCs must be written in the Typst markdown language using the prescribed template.

- The source files for RFCs must be stored in the RFC repository under the `src/rfc` directory as files named `rfc-xx.typ`

=== Punctuation

- No overstriking or underlining is allowed

- A comma is used before the last item of a series

- When quoting literal text, punctuation marks belong outside of the quotation marks unless they are part of the original quote

=== Capitalization

- Capitalization must be consistent within the document, and ideally with related RFCs

- The major words in RFC headers and titles should be capitalized (similar to "title case")
    - RFC headers and titles in sentence-form may deviate from this specification

=== Citation <citation>

- The bibliography file for an RFC will be stored in the same folder as the RFC source code in the `.bib` format as `rfc-xx.bib`.

- RFCs shall use the IEEE format.

=== Writing Style

- Leeway is given to authors as to the style and tone of an RFC, but for the sake of consistency, a uniform style must be enforced.

- An RFC must be professional, from tone to grammar and word choice.

- An RFC must be informational in tone and assumes that the reader intends to or must follow the directives stated.
    - Additional information, such as the context behind or consequences of certain decisions is encouraged, but is not the main point of an RFC

- An RFC must be written in the third person. 

- The grammar of an RFC does not need to strictly adhere to any variant of English, so long as it is universally understandable.
    - If a reference variant must be specified, preference should be given to American English.

- RFCs shall encode the following information:
    - *Imperative directives* outlining Engineering Committee policies and best practices, and
    - *Narratives or information* briefly discussing the reasoning for the best practices

- RFCs must exhibit a clear delineation between both

- RFCs must make it especially easy to locate and identify _directives_ for rapid referencing

- In the event of a dispute regarding writing style or tone, the *Director for Engineering* shall be the final arbiter.

== Structure

- An RFC must contain the sections enumerated herein. Unless otherwise prohibited by this standard; however, the addition of new sections is allowed.

=== Preamble

- The preamble of an RFC shall serve as an informative introduction to the contents of an RFC

- The preamble shall comprise the first page of an RFC

- The preamble shall be made up of the following elements, in order:

==== Title

- An RFC shall be titled according to the format: "RFC-XX: [SUBTITLE]"

- The subtitle of an RFC must be related to the topic and discusses and refer specifically to the item(s) it lays down standards for (e.g. "Git Standards" instead of "On Git Standards" or "On the usage of Git")

==== Author

- An RFC's authors shall include all persons who directly contributed to _both_ its writing and formulation, including non-Engineering Committee members

- The main author of an RFC (that is, the author identified as having provided the most material contributions to the document) shall be placed at the top of the authors' list. All others thereafter shall be included alphabetically.

- The authors of obsoleted RFCs need not be included in succeeding RFCs, unless they have directly contributed to the new document.

==== Status

- An RFC may have one of four statuses:
    - #draft-status (encoded as `#draft-status` in Typst)
    - #proposed-status (encoded as `#proposed-status` in Typst)
    - #adopted-status (encoded as `#adopted-status` in Typst)
    - #obsoleted-status("RFC-XX") (encoded as `#obsoleted-status("RFC-XX")` in Typst)

- The usage of these statuses shall abide by the provisions in #ref(<roles-and-resp>)

==== Abstract

- An RFC shall have an abstract to provide a concise and comprehensive overview of its contents.

- An abstract shall not exceed 150 words in length.

- The abstract shall ideally begin with the words "This document..." or "This standard..."

=== Bibliography

- A bibliography shall be included at the end of the document, titled "Bibliography" and shall be in the style specified in #ref(<citation>)

#bibliography("rfc-00.bib")