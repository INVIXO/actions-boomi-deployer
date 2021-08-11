FROM alpine:latest

RUN apk add --no-cache jq libxml2-utils bash curl git

ENV h1="Content-Type: application/json" h2="Accept: application/json" baseURL=https://api.boomi.com/api/rest/v1 HOME=/app/cli/scripts

#RUN git clone https://github.com/OfficialBoomi/boomicicd-cli.git app && chmod +x $HOME
RUN git clone https://github.com/OfficialBoomi/boomicicd-cli.git app
WORKDIR ${HOME}

COPY entrypoint.sh bin/
ENV PATH="${HOME}/bin:${PATH}"

ENTRYPOINT ["entrypoint.sh"]