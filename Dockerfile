FROM kubiya/base-profile:latest

# Copy the use cases (actions directory)
# Copy Kubiya actions and config
COPY ./actions /tmp/workspace/.kubiya/

# Add your layers here..
# eg:
# # Install terraform
#RUN wget https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_amd64.zip && \
#    unzip terraform_1.6.2_linux_amd64.zip -d /usr/local/bin/
USER root
RUN apt update && apt install jq curl -y && curl -fL https://install-cli.jfrog.io | sh
#RUN apt remove curl -y
RUN chown appuser /usr/local/bin/jf
RUN chown appuser /usr/bin/jq
USER appuser
ENV JFROG_ACCESS_TOKEN=eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJXelBIaFVWbk4teXE4aXVFSlVMMWRNVXl1M2l2Y25nUFpRODgtMlQwZTV3In0.eyJzdWIiOiJqZmFjQDAxaGVxMWp3MnpkYjh3MHRkcmYweTAxMzFiL3VzZXJzL3NoYWtlZDU4QGdtYWlsLmNvbSIsInNjcCI6ImFwcGxpZWQtcGVybWlzc2lvbnMvYWRtaW4iLCJhdWQiOiIqQCoiLCJpc3MiOiJqZmZlQDAxaGVxMWp3MnpkYjh3MHRkcmYweTAxMzFiIiwiaWF0IjoxNjk5NDcwMTE1LCJqdGkiOiIwODU2NDZkYy1lNTBhLTRiZGEtOGM0MS02YTY3YzZmYjgwZjQifQ.k5dRa6-kLMUBEJc5RPSjerpt6-un-l3KaGpAXJ49jQNUbm7WUeJkSculB-MmbdKlyoGY_8emWkyjetYHRax7fIcrZ7Z3FCs1Mm8ej2_YmzfkU5RH6WLIbPVRZgv0OcHr1qH8Slr3d6rX4YH2SyfViT_BYS6V9jYvoGYdZZRn_VPt8y-Q4_kw7Q37R34UzAsawMSmfYOYLVgewVV5tC4xOxGOhN0RRREUwmZod545OEMGTNg5P7q6mOKx5LItfJ9bS-uk4dQ3V3-7z0GeSRpbQ4lxShVBFgY5_DqwWfPPLvWoriFD9VQ6XdEmhZ_R9Wl7JMxephdXQGxn2gbGrJbV2A
