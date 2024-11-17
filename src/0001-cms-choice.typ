#import "template.typ": *

// Change parameters depending on the module metadata.
#show: project.with(
    "[RFC] Content Management System of Choice for DCS Website Project",
    authors: ("Charlize Sim",),
    status: "Draft as of 09/17/2024",
    abstract: "To document the decision-making process and rationale behind choosing the CMS for the DCS website project."
)

// Insert your document below this line

= Context and Background
The DCS website needs a capable CMS to manage content, with the following proposals:

- *Backend Database*: Content will be stored in a backend database, with PostgreSQL as the preferred option. This preference stems from its robust utilities and the development team's familiarity with it.

- *Headless CMS*: A CMS to manage content in the database, provide an admin dashboard for easy content management, and expose content via API endpoints for frontend use.

- *Presentation Layer (Website Frontend)*: Built using SvelteKit, the website frontend will serve as the presentation layer of the DCS website.

*Why Headless CMS over Traditional CMS (e.g., WordPress):*

1. *Backend and Frontend Decoupling*

  A headless CMS gives us the freedom to handle content and presentation separately. Unlike WordPress, which binds frontend and backend tightly together, a headless CMS lets us use SvelteKit and avoids dealing with WordPress themes or plugins.  

2. *API-First Setup*

  Headless CMS platforms provide content via APIs, which makes life easier when delivering content across multiple platforms (web, mobile, etc.). This API-first approach works well with SvelteKit, ensuring faster page loads.

3. *Performance and Scaling*

  WordPress can be slow, especially as content grows. With a headless CMS, we can fine-tune the backend without worrying about performance dragging down the site.

4. *Security and Flexibility*

  Decoupling frontend and backend improves security (since the CMS admin and APIs can be locked away from public access) and lets us choose our own security measures.

5. *Developer-Friendly*

  Modern headless CMS options are built with developer tools that make setup and customization easier. We can also have the option to self-host, keeping the costs low and giving us full control.

In short, a headless CMS gives us the flexibility and scalability a traditional CMS doesn’t offer, so it’s the right choice for this project.

= Problem Statement
Our goal is to identify a headless CMS that:

- Provides a manageable admin dashboard.

- Supports a self-hosting option for cost management.

- Integrates smoothly with our preferred frontend (SvelteKit) and backend (PostgreSQL).

- Accommodates our clients’ needs for hierarchical permissions and ease of use.

= CMS Options Explored
The team evaluated several CMS platforms, focusing primarily on Directus, Payload, and Prismic. Key findings are summarized below.

== CloudCannon
CloudCannon is a cloud-based CMS that emphasizes developer-friendly tools and collaborative workflows.

*Pros*:

- *Svelte Component Support*: CloudCannon allows direct use of Svelte components, which is a significant advantage for projects like ours that use SvelteKit. This means developers can easily integrate components into the CMS workflow without requiring extensive modifications.

- *Collaboration Tools*: The platform supports features like real-time content collaboration, which could enhance productivity for teams working on the website.

- *Enterprise Endorsement*: Used by well-known companies like Netflix and Twitch, CloudCannon presents itself as a scalable and reliable platform for high-profile projects.

*Cons*:

- *Cost*: CloudCannon is a premium solution with no free or self-hosted option. This makes it less attractive for budget-sensitive projects.

- *Control Limitations*: As a fully managed solution, CloudCannon does not offer self-hosting, which can be a drawback for organizations that prioritize control over their infrastructure.

- *Unclear Use Cases*: While Netflix and Twitch reportedly use it, it’s unclear if they rely on CloudCannon for main platforms or smaller auxiliary projects, leaving scalability and reliability questions unanswered.

== KeystoneJS
KeystoneJS is an open-source, developer-focused CMS designed for flexibility and programmability.

*Pros*:

- *Self-Hosting*: KeystoneJS is fully open-source and can be self-hosted, giving the team complete control over the deployment environment.

- *PostgreSQL Support*: It integrates well with PostgreSQL, aligning with our technical stack and leveraging the database’s robust features.

- *Developer-Centric Design*: KeystoneJS focuses on providing powerful tools for developers, such as a programmable API and built-in GraphQL, making it ideal for projects that require heavy customization.

*Cons*:

- *Self-Hosting*: KeystoneJS is fully open-source and can be self-hosted, giving the team complete control over the deployment environment.

- *PostgreSQL Support*: It integrates well with PostgreSQL, aligning with our technical stack and leveraging the database’s robust features.

- *Developer-Centric Design*: KeystoneJS focuses on providing powerful tools for developers, such as a programmable API and built-in GraphQL, making it ideal for projects that require heavy customization.

== Directus
Directus is a composable data platform that functions as a headless CMS, backend-as-a-service (BaaS), and more.

*Pros*:

- *Cost-Effective*: Directus is free for self-hosting under the BSL license, provided the organization’s revenue is below \$5M. This aligns well with our project’s budget constraints.

- *PostgreSQL Integration*: Directus supports PostgreSQL natively, ensuring compatibility with our preferred database.

- *User-Friendly*: It offers a customizable admin panel, allowing non-technical users to manage content easily. Customization with Vue.js is particularly beneficial for our team, as Vue is similar to Svelte.

- *Granular Permissions*: Directus allows rule-based access control, enabling the implementation of complex content hierarchies and user roles.

- *Self-Hosting Options*: Self-hosting via Docker is straightforward and efficient, providing flexibility in how the CMS is deployed.

*Cons*:

- *Licensing Concerns*: Directus recently switched to a BSL license, raising questions about future costs or limitations for certain features.

- *Cloud Service Bugs*: Although we plan to self-host, the cloud service has received mixed reviews, which may reflect on the organization’s overall stability.

- *No MongoDB Support*: Directus only supports SQL databases, which could limit flexibility in scenarios where NoSQL is preferred.

== Payload 
Payload is a modern CMS built with TypeScript, React, and Node.js, aiming to provide a flexible and developer-friendly platform.

*Pros*:

- *Database Compatibility*: Payload supports both PostgreSQL and MongoDB, giving it an edge in flexibility for database setups.

- *Modern Tools*: Built with TypeScript and React, Payload aligns with current web development standards, making it appealing to cutting-edge development teams.

- *Powerful Admin Panel*: Payload’s admin panel is highly customizable, offering advanced tools for managing complex workflows.

*Cons*:

- *React Dependency*: Customizing the admin interface requires React, which is unfamiliar to our team. This could increase the learning curve and add development overhead.

- *Frontend Limitations*: Payload is optimized for React/Next.js frontends, meaning integrating it with SvelteKit could lead to redundant frameworks and increased complexity.

- *Smaller Community*: As a newer CMS, Payload lacks the robust community and support ecosystem of platforms like Directus or KeystoneJS.


== Prismic
Prismic is a cloud-based CMS emphasizing ease of use and collaboration between developers and marketers.

*Pros*:

- *User-Focused Design*: Prismic is designed with non-technical users in mind, making it easy for editors and marketers to manage content.

- *Fast Deployment*: It offers tools for quick setup and content updates, ideal for teams needing rapid iteration.

- *Collaboration Features*: Prismic excels in supporting collaborative workflows between developers and content managers.

*Cons*:

- *Cloud-Only*: Prismic does not support self-hosting, which locks organizations into recurring subscription fees.

- *Flexibility Issues*: Developers have reported limitations when scaling Prismic to handle complex workflows or custom setups.

- *Community Feedback*: While some users appreciate its simplicity, others note that it lacks the power and flexibility of alternatives like Directus or KeystoneJS.

= Evaluation Criteria 
The following criteria were used to assess each CMS:

- *Ease of Use*: Intuitiveness for non-developer end-users and the flexibility to assign hierarchical permissions.

- *Self-Hosting Capability*: Ability to deploy on our own servers.

- *Technology Compatibility*: Support for PostgreSQL and ease of integration with SvelteKit.

- *Customizability*: Ability to modify and extend functionalities.

- *Future-Proofing*: Licensing model and long-term viability of the CMS.

= Decisions

After weighing the pros and cons, *Directus* is our current choice, with *Payload* as a close second. Directus’s PostgreSQL compatibility, flexible permissions, and Vue.js customization options make it a good fit for us. We’ll revisit this choice in the post-mortem after the project to see if it really was the best pick.

= Implementation Plan 
1. *Set Up Directus*: We’ll self-host it using Docker as outlined in Directus’s quickstart guide.

2. *Database Config*: Directus will be set up with PostgreSQL.

3. *Frontend Integration*: SvelteKit will fetch content from Directus’s API.

4. *Permissions*: Set up role-based permissions as needed to handle content access.

= Future Considerations and Post-Mortem Plan

In the post-mortem, we’ll review:

- *User Experience*: Was it easy enough for non-technical users?

- *Flexibility and Performance:* Did it handle our scalability and speed needs?

- *Cost Concerns*: Did the BSL license present any unexpected issues or costs?

We’ll also consider whether something like Payload or Prismic might have been a better choice based on how the project turned out.

= Appendices
- #link("https://cloudcannon.com/documentation/")[CloudCannon Documentation]

- #link("https://keystonejs.com/docs")[KeystoneJS Documentation]

- #link("https://docs.directus.io/")[Directus Documentation]

- #link("https://payloadcms.com/docs/getting-started/what-is-payload")[Payload Documentation]

- #link("https://prismic.io/docs")[Prismic Documentation]