 
![Kubiya](https://avatars.githubusercontent.com/u/87862858?s=200&v=4)
# Kubiya Agent Starter Template

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform Badge](https://img.shields.io/badge/Terraform-844FBA?logo=terraform&logoColor=fff&style=for-the-badge)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![GITHUB](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)
![JIRA](https://img.shields.io/badge/Jira-0052CC?style=for-the-badge&logo=jira&logoColor=white)

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![ARGOCD](https://img.shields.io/badge/ArgoCD-93C0D0?style=for-the-badge&logo=argocd&logoColor=white)
![JFrog](https://img.shields.io/badge/JFrog-43BF47?style=for-the-badge&logo=jfrog&logoColor=white)
![Slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white)
![Snyk Badge](https://img.shields.io/badge/Snyk-4C4A73?logo=snyk&logoColor=fff&style=for-the-badge)
![Helm](https://img.shields.io/badge/Helm-0F1689?logo=helm&logoColor=fff&style=for-the-badge)

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![Confluence Badge](https://img.shields.io/badge/Confluence-172B4D?logo=confluence&logoColor=fff&style=for-the-badge)
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
- [Contributing](#contributing)
- [License](#license)

## Introduction
Kubiya's Agent starter template is a Docker image that includes the [Kubiya Agent](https://docs.kubiya.ai/gen-2-docs/agents-experimental) with a collection of tools for managing your DevOps Stack through the power of LLM and AI.

It is designed to be used as a base image for creating custom Kubiya Agents with a collection of tools and configurations designed to simplify the management of environments such as Kubernetes clusters, AWS, GitHub repositories,JIRA projects and more.

## Prerequisites

Before using Kubiya, ensure you have the following :
- [Docker](https://www.docker.com/get-started/) installed on your machine.
- Access to the Kubiya's base ```latest``` image ([kubiya/base-agent](https://hub.docker.com/r/kubiya/base-agent/tags)):
  ```shell
  docker pull kubiya/base-agent:latest
  ```
  Should result in : 
  ```shell
  Status: Downloaded newer image for kubiya/base-agent:latest
  docker.io/kubiya/base-agent:latest
  ```

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
- Run the Docker container using the following command (replace ```username/image-name:tag``` with your own image name and tag):

  ```bash
  docker run -it --rm username/image-name:tag /bin/bash
  ```

## Configuration
In this section, you will learn how to configure and customize the Kubiya Agent starter template.

### Dockerfile
The [Dockerfile](Dockerfile) is responsible for building the Docker image for the custom Kubiya Agent.
You can customize the Dockerfile to include additional tools and configurations.

### Tools Installed
The Dockerfile includes the following tools:
- kubectl
- aws cli
- github cli
- terraform cli
- helm
- jira cli
- slack cli
- argocd cli
- jfrog cli
- snyk cli
- git
- python3
- google cloud cli
- jq
- gpg
- curl

### entry.sh Script
This [entry.sh](entry.sh) script is the entrypoint for the Docker container.
For more information about entrypoints, see the [Docker documentation](https://docs.docker.com/engine/reference/builder/#entrypoint).

### Contributing
We welcome contributions! Follow our contribution guidelines to get started.
## License
This project is licensed under the MIT License.
