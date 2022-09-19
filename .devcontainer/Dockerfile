# based on microsoft codespaces containers thank you!
# [Choice] Ubuntu version: bionic, focal

FROM vinnie357/f5-devops-base:latest

ENV USERNAME="f5-devops" \
    TERRAFORM_VERSION="1.0.5" \
    TERRAFORMDOCS_VERSION="0.15.0" \
    ANSIBLE_VERSION="2.10.5" \
    VESCTL_VERSION="0.2.15" \
    #NODE_VERSION="v14.16.0" \
    NODE_VERSION="lts/*" \
    NVM_DIR="/usr/local/share/nvm"

COPY scripts/* /tmp/scripts/
# switch back to root for installs
USER root

# pre-commit, go, docker, terraform, terraform-docs
RUN set -ex \
    && apt-get update \
    && bash /tmp/scripts/terraform-debian.sh "${TERRAFORM_VERSION}" \
    && bash /tmp/scripts/terraform-docs-debian.sh "${TERRAFORMDOCS_VERSION}" \
    && bash /tmp/scripts/ansible-debian.sh ${ANSIBLE_VERSION} \
    && bash /tmp/scripts/vesctl-debian.sh ${VESCTL_VERSION} \
    && bash /tmp/scripts/node-debian.sh ${NVM_DIR} ${NODE_VERSION} ${USERNAME}

# add extras
RUN set -ex \
    #https://github.com/vinnie357/devcontainers/tree/main/scripts-library/ubuntu
    # && bash /tmp/scripts/my-script.sh
    && pip install netaddr


# Clean up
RUN set -ex \
&& apt autoremove -y && apt clean -y

#change user
USER ${USERNAME}
