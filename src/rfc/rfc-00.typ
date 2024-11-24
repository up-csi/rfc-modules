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

Such systems include the Hypertext Transfer Protocol (HTTP; #link("https://datatracker.ietf.org/doc/html/rfc7230")[RFC 7230] to #link("https://datatracker.ietf.org/doc/html/rfc7235")[RFC 7235]), WebSockets (#link("https://datatracker.ietf.org/doc/html/rfc6455")[RFC 6455]), Secure Shell (SSH; #link("https://datatracker.ietf.org/doc/html/rfc4251")[RFC 4251]), Secure Hash Algorithms (SHA; #link("https://www.rfc-editor.org/rfc/rfc4634")[RFC 4634]), and many, many others.

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

= Roles and Responsibilities

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

= Style Guide

== Parts of an RFC