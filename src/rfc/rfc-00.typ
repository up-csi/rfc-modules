#import "../template.typ": *

#show: project.with(
    "RFC-00: Requests for Comments",
    authors: ("Victor Edwin Reyes",),
)

= Request for Comments

== The IETF RFC

#link("https://www.ietf.org/process/rfcs/")[Requests for Comments] are documents published by the Internet Engineering Task Force as their technical documentation. They serve as technical specifications for foundational concepts, systems, and protocols that underpin the internet. 

Such systems include the Hypertext Transfer Protocol (HTTP; #link("https://datatracker.ietf.org/doc/html/rfc7230")[RFC 7230] to #link("https://datatracker.ietf.org/doc/html/rfc7235")[RFC 7235]), WebSockets (#link("https://datatracker.ietf.org/doc/html/rfc6455")[RFC 6455]), Secure Shell (SSH; #link("https://datatracker.ietf.org/doc/html/rfc4251")[RFC 4251]), Secure Hash Algorithms (SHA; #link("https://www.rfc-editor.org/rfc/rfc4634")[RFC 4634]), and many, many others.

Each of the above listed technologies has an associated RFC which describes their specifications. Looking from the outside in, they effectively define interfaces that can be used to communicate with any systems that comply with their specifications. 

For example, anyone can build an Internet Relay Chat (IRC) system simply by complying with the specifications of #link("https://datatracker.ietf.org/doc/html/rfc1459")[RFC 1459] (and other RFCs). RFC 1459, in Section #link("https://datatracker.ietf.org/doc/html/rfc1459#section-4")[4] specifies the formats of messages any IRC application should be able to recognize.

== The Engineering Committee RFC

In accordance with the UP CSI Constitution of 2024, Article V, Section 3, the Engineering Committee is responsible for serving as technical consultants and quality assurers for the organization's projects.

As of the 2425A semester, this responsibility has extended to handling the technical education and training of the organization's developers.

Previous terms have resulted in the adoption of new technologies and standards such as SvelteKit and Git commit conventions. These have been included, and to some extent _codified_, in the committee's trademark Developer Training Program (DTP) and DevCamp (DC). 

However, educational materials are not made for the purpose of rigorously codifying and justifying standards. DTP and DC materials are not strictly reference materials, and would be difficult to specifically reference or use as a foundation for arguments. 

Similarly, codifying the Committee's smaller design or technical decisions becomes more difficult in the format of the training modules.

A format is needed that is not educational - that does not need to teach, but to assert. 

Thus, in order to define, preserve, and defend the _technical decisions, standards, and policies_ of the Engineering Committee, the *Engineering Committee Request for Comments* is defined herein.

=== The Purpose of the RFC

= Roles and Responsibilities

== The Director for Engineering

== The Engineering Committee Member

= Style Guide

== Parts of an RFC