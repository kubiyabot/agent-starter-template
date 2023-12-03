FROM kubiya/base-agent:latest

# Copy the use cases (actions directory)
# Copy Kubiya actions and config
COPY ./actions /tmp/workspace/.kubiya/

# Add your layers here..
# eg:
# # Install terraform
#RUN wget https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_amd64.zip && \
#    unzip terraform_1.6.2_linux_amd64.zip -d /usr/local/bin/
USER root
RUN chown appuser /usr/bin/jq
USER appuser
