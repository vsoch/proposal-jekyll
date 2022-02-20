_For LLNL Open Source projects_

This is a [Special Projects](https://docs.google.com/document/d/1XCiU_pPe-LwDUUjzEafKc5aWIX04svZH2pH8M-HEIYI/edit#) proposal #1

As a main goal of the Special Project work is to enable running LLNL software easily in different environments, the first step to do that is to create automated builds for the LLNL open source ecosystem. For this project we will focus our work on making LLNL open source projects containerized and portable. This includes:

1. Creating a new repository on LLNL for site-wide automated builds
2. Developing workflows to build and deploy each repository
3. Exposing dispatch events (webhooks) to let LLNL GitHub projects choose when to trigger an automated build (e.g., on merge into main or develop, nightly, on release).
4. Working with code teams on both 2 and 3.

While some LLNL projects are embracing the set of [rse-ops docker images](https://rse-ops.github.io/docker-images), likely many are more hesitant. Along with providing us a set of scientific software containers to use for further development and examples for our projects, this first project will engage with code teams and show them they can easily trigger an automated build.


#### Use Cases

I am an LLNL developer, interested collaborator, or outside contributor that wants to build on top of LLNL software. Right now to get started with an LLNL project I need to download the source code, install complex dependencies, and build the project to get started. With pre-built containers, the development stack is ready to go, and I simply need to pull it to get started. Containers can also help with portability since I can develop my software for a known LLNL base container without worrying about my local HPC environment.


#### Lab Influence

Providing containers with automated builds for the lab is the first step to not just improving the developer experience or extending our software to different environments, but also making it easier for external collaborators to develop and try LLNL software. It’s also an opportunity for the Special Projects team to engage with code teams, demonstrating to them an easy way to link their repositories and our builds with an automated trigger. 


#### Deliverables

The deliverables for this proposal include:



* Automated builds and updates of LLNL software
* Documentation and tutorials for setting up these automated builds

Opportunities for extension include providing similar functionality for other CI services (e.g., Azure pipelines or GitLab)


#### Collaborations



* Workflow Enablement Group (WEG)
* Various Code Teams (Sonar, Spack…)


#### Needs

To allow the containers to be in the LLNL namespace (e.g., ghcr.io/llnl/&lt;package> we would request the creation of one repository on LLNL (https://github.com/llnl/containers) to develop the recipes and workflows on. Likely they will use base images from rse-ops/docker-image for faster builds. We will then create the automated builds, write up documentation for how to use them, and then engage with the code teams to show them a workflow step they can add to trigger a build and deploy for their project.

