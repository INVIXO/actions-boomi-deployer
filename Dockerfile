FROM alpine:latest

RUN apk add --no-cache jq libxml2-utils bash curl git

ENV h1="Content-Type: application/json" h2="Accept: application/json" baseURL=https://api.boomi.com/api/rest/v1 HOME=/app/cli/scripts/bin

#RUN git clone https://github.com/OfficialBoomi/boomicicd-cli.git app && chmod +x $HOME
RUN git clone https://github.com/OfficialBoomi/boomicicd-cli.git app
COPY entrypoint.sh ${HOME}

#ENTRYPOINT ["/bin/entrypoint.sh"]