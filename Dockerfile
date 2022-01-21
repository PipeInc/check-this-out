FROM alpine:3.15

ENV WORKDIR /pre-commit
ENV PIP_NO_CACHE_DIR=1
ENV TF_VERSION 1.1.4
ENV TFDOCS_VERSION v0.11.2
ENV TFLINT_VERSION v0.34.0
ENV TFSEC_VERSION v0.63.1


RUN apk add --update --no-cache go bash git python3 py3-pip curl unzip && \
    pip3 install --no-cache-dir pre-commit

RUN curl -sL https://github.com/terraform-docs/terraform-docs/releases/download/${TFDOCS_VERSION}/terraform-docs-${TFDOCS_VERSION}-linux-amd64.tar.gz  > terraform-docs.tgz && \
    curl -sL https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip > tflint.zip && \
    curl -sL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip > terraform.zip && \
    curl -sL https://github.com/tfsec/tfsec/releases/download/${TFSEC_VERSION}/tfsec-linux-amd64 > /usr/bin/tfsec && \
    unzip terraform.zip && \
    rm terraform.zip && \
    mv terraform /usr/bin && \
    unzip tflint.zip && \
    rm tflint.zip && \
    mv tflint /usr/bin/ && \
    tar xzf terraform-docs.tgz && \
    rm terraform-docs.tgz && \
    chmod +x terraform-docs && \
    mv terraform-docs /usr/bin/ && \
    chmod +x /usr/bin/tfsec /usr/bin/terraform-docs /usr/bin/tflint /usr/bin/terraform && \
    mkdir ${WORKDIR}

COPY . ${WORKDIR}

WORKDIR ${WORKDIR}
RUN pre-commit install \
    && pre-commit install-hooks \
    && tflint --init \
    && pre-commit run --all-files

CMD ["echo", "CI docker image"]