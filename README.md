 
![Kubiya](https://avatars.githubusercontent.com/u/87862858?s=200&v=4)
# Kubiya Agent Starter Template


## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
    - [Building the Docker Image](#building-the-docker-image)
    - [Running the Container](#running-the-container)
- [Configuration](#configuration)
    - [Dockerfile](#dockerfile)
    - [entry.sh Script](#entrysh-script)
    - [Tools Installed](#tools-installed)
    - [Customizing the Agent](#customizing-the-agent)
- [Contributing](#contributing)
- [License](#license)

## Introduction
Kubiya's Agent starter template is a Docker image that includes the [Kubiya Agent](https://docs.kubiya.ai/gen-2-docs/agents-experimental) with a collection of tools for managing your DevOps Stack through the power of LLM and AI.

It is designed to be used as a base image for creating custom Kubiya Agents with a collection of tools and configurations designed to simplify the management of environments such as Kubernetes clusters, AWS, GitHub repositories, JIRA projects and more.


## Prerequisites

Before using the agent, ensure you have the following :
- [Docker](https://www.docker.com/get-started/) installed on your machine.
- Access to the Kubiya's [ghcr.io/kubiyabot/connection-agent-core](https://github.com/kubiyabot/connections/pkgs/container/connection-agent-core) image:
  ```shell
  docker pull ghcr.io/kubiyabot/connection-agent-core:934f77177849e576cc049580ee62bcfd806fae4e
  ```
  Should result in : 
  ```shell
  Status: Downloaded newer image for ghcr.io/kubiyabot/connection-agent-core:934f77177849e576cc049580ee62bcfd806fae4e
  ghcr.io/kubiyabot/connection-agent-core:934f77177849e576cc049580ee62bcfd806fae4e
  ```
- Kubiya runner installed on your cluster.   
For more information, see the [Kubiya runner documentation](https://docs.kubiya.ai/gen-2-docs/connectors/custom-connections/action-runners).

## Getting Started

Follow these steps to set up and run Kubiya locally.

### Building the Docker Image
- Clone this repository to your local machine and navigate to the directory:
  ```shell
  git clone https://github.com/kubiyabot/agent-starter-template
  cd agent-starter-template
  ```

- Build the Docker image using the following command (replace ```username/image-name:tag``` with your own image name and tag):
    ```shell
    docker build -t username/image-name:tag .
    ```
  
### Running the Container
- If you want to inspect the agent's Docker container , use the following command (replace ```username/image-name:tag``` with your own image name and tag):

  ```bash
  docker run -it --rm username/image-name:tag /bin/bash
  ```

## Configuration
In this section, you will learn how to configure and customize the Kubiya Agent starter template.

### Dockerfile
The [Dockerfile](Dockerfile) is responsible for building the Docker image for the custom Kubiya Agent.
You can customize the Dockerfile to include additional layers and configurations.

### entry.sh Script
This [entry.sh](entry.sh) script is the entrypoint for the Docker container.
For more information about entrypoints, see the [Docker documentation](https://docs.docker.com/engine/reference/builder/#entrypoint).

### Tools Installed
The Agent's Dockerfile includes the following tools:

| Tool               | Description          | Setup in entry.sh script                                                |
|--------------------|----------------------|------------------------------------------------------------------------|
| [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) | Kubernetes CLI       | Configures kubectl with cluster and credentials using environment variables in entry.sh |
| [aws cli](https://aws.amazon.com/cli/) | AWS CLI              | -                                                                      |
| [github cli](https://cli.github.com/) | GitHub CLI           | -                                                                      |
| [terraform cli](https://www.terraform.io/docs/cli/index.html) | Terraform CLI        | -                                                                      |
| [helm](https://helm.sh/docs/intro/quickstart/) | Kubernetes Helm      | -                                                                      |
| [jira cli](https://developer.atlassian.com/server/jira/platform/cli/) | Jira CLI             | -                                                                      |
| [slack cli](https://github.com/rockymadden/slack-cli) | Slack CLI            | -                                                                      |
| [argocd cli](https://argoproj.github.io/argo-cd/cli_installation/) | ArgoCD CLI           | Logs into Argo CD with in-cluster access using `argocd login --core`    |
| [jfrog cli](https://www.jfrog.com/confluence/display/JFROG/CLI+for+JFrog+Artifactory) | JFrog CLI            | -                                                                      |
| [snyk cli](https://support.snyk.io/hc/en-us/articles/360004008258-Install-the-Snyk-CLI) | Snyk CLI             | Logs into Snyk using `snyk config set api=${SNYK_TOKEN}`                |
| [git](https://git-scm.com/doc) | Git                  | -                                                                      |
| [python3](https://docs.python.org/3/) | Python 3             | -                                                                      |
| [google cloud cli](https://cloud.google.com/sdk/docs/quickstarts) | Google Cloud CLI     | -                                                                      |
| [jq](https://stedolan.github.io/jq/manual/) | JSON processor       | -                                                                      |
| [gpg](https://www.gnupg.org/documentation/manuals/gnupg/) | GnuPG                | -                                                                      |
| [curl](https://curl.se/docs/) | Command-line tool    | -                                                                      |


### Customizing the Agent
You can customize the agent by adding your own tools and configurations to the Dockerfile and entry.sh script.

For example, for terraform you can add the following layers to the Dockerfile:
```Dockerfile 
# Install terraform

RUN wget https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_amd64.zip && \
unzip -o terraform_1.6.2_linux_amd64.zip -d /usr/local/bin/ && \

#Set permissions
chmod +x /usr/local/bin/terraform && \

#Clean up
rm -rf terraform_1.6.2_linux_amd64.zip

# appuser is the user that will run the terraform commands
RUN chown appuser /usr/local/bin/terraform && \
```
You can also add your own scripts to the entry.sh script:
```bash
# check if terraform state file exists

if [ ! -f "/code/dist/main/terraform.tfstate" ]; then
    echo "Error: Terraform state file not found."
    exit 1
else 
    echo "Terraform state file found."
fi
```

## Contributing
We welcome contributions! Follow our contribution guidelines to get started.
## License
This project is licensed under the MIT License.
