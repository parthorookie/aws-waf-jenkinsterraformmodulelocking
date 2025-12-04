FROM hashicorp/terraform:1.7.0

WORKDIR /app

COPY terraform/ ./terraform

ENTRYPOINT ["/bin/sh"]