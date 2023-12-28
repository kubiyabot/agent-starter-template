FROM ghcr.io/kubiyabot/connections-agent-core:stable
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

# Install tools
RUN \
    # Install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \

    # Install ArgoCD CLI
    curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 && \
    chmod +x /usr/local/bin/argocd && \

    # Install GitHub CLI
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |  dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    &&  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
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
    curl -fsSL -o jira_1.4.0_linux_x86_64.tar.gz https://github.com/ankitpokhrel/jira-cli/releases/download/v1.4.0/jira_1.4.0_linux_x86_64.tar.gz && \
    tar -xvf jira_1.4.0_linux_x86_64.tar.gz && \
    mv jira_1.4.0_linux_x86_64/bin/jira /usr/local/bin/jira && \
    rm -rf jira_1.4.0_linux_x86_64.tar.gz && \

    # Slack CLI (Bash)
    curl -fsSL -o slack https://raw.githubusercontent.com/rockymadden/slack-cli/master/src/slack && \
    chmod +x slack && \
    mv slack /usr/local/bin/slack && \

    # Install JFrog CLI
    curl -fL https://install-cli.jfrog.io | sh && \

    # Install terraform
    wget https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_amd64.zip && \
    unzip -o terraform_1.6.2_linux_amd64.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/terraform && \
    rm -rf terraform_1.6.2_linux_amd64.zip && \

    # Snyk CLI
    curl --compressed https://static.snyk.io/cli/latest/snyk-linux -o snyk && \
    chmod +x ./snyk && \
    mv ./snyk /usr/local/bin/ && \

    # Install Google Cloud SDK
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list &&  \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    apt update -y && \
    apt install google-cloud-sdk -y


RUN chown appuser /usr/local/bin/argocd && \
    chown appuser /usr/local/bin/terraform && \
    chown appuser /usr/local/bin/kubectl && \
    chown appuser /usr/local/bin/slack && \
    chown appuser /usr/local/bin/helm && \
    chown appuser /usr/local/bin/jira && \
    chown appuser /usr/local/bin/jf && \
    chown appuser /usr/bin/jq && \
    chown appuser /usr/bin/gh && \
    chown appuser /usr/bin/gcloud && \
    chown appuser /usr/local/bin/snyk

USER appuser
ENTRYPOINT /entry.sh
