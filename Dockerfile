# Use the specified base image
FROM ghcr.io/kubiyabot/connection-agent-core:97fa3b68d3a21c6e6fadc65dc6cbe99d085a6410

USER root

# Copy entry.sh
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh && \
    chown appuser /entry.sh

RUN apt update && apt install -y \
    jq \
    curl \
    gpg \
    unzip \
    wget \
    binutils

# copy requirements file
COPY ./requirements.txt /requirements.txt

# Install python env libraries
RUN /usr/local/bin/pip install --no-cache-dir -r /requirements.txt

# Install tools
RUN \
    # Install kubectlx
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    # Install ArgoCD CLI
    curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 && \
    chmod +x /usr/local/bin/argocd && \
    # Install GitHub CLI
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |  dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
    chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |  tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install gh -y \
    && rm -rf /var/lib/apt/lists/* && \
    # Install Helm
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod +x get_helm.sh && \
    ./get_helm.sh && \
    rm -rf get_helm.sh && \
    # Install JIRA CLI
    curl -o jira https://kubiya-cli.s3.eu-west-1.amazonaws.com/jira/latest/amd64/jira && \
    chmod +x jira && \
    mv jira /usr/local/bin/jira && \
    # Install Slack CLI
    curl -o slack https://kubiya-cli.s3.eu-west-1.amazonaws.com/slack/latest/amd64/slack && \
    chmod +x slack && \
    mv slack /usr/local/bin/slack && \    
    # Install JFrog CLI
    curl -fL https://install-cli.jfrog.io | sh && \
    # Install Terraform
    wget https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_amd64.zip && \
    unzip -o terraform_1.6.2_linux_amd64.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/terraform && \
    rm -rf terraform_1.6.2_linux_amd64.zip


RUN chown appuser /usr/local/bin/argocd && \
    chown appuser /usr/local/bin/terraform && \
    chown appuser /usr/local/bin/kubectl && \
    chown appuser /usr/local/bin/slack && \
    chown appuser /usr/local/bin/helm && \
    chown appuser /usr/local/bin/jira && \
    chown appuser /usr/local/bin/jf && \
    chown appuser /usr/bin/jq && \
    chown appuser /usr/bin/gh

USER appuser
ENTRYPOINT /entry.sh
