FROM alpine:latest

RUN apk add --no-cache jq libxml2-utils bash curl git

ENV h1="Content-Type: application/json" h2="Accept: application/json" baseURL=https://api.boomi.com/api/rest/v1 SCRIPTS=/app/cli/scripts

#RUN git clone https://github.com/OfficialBoomi/boomicicd-cli.git app && chmod +x $HOME
RUN git clone https://github.com/OfficialBoomi/boomicicd-cli.git app
WORKDIR ${SCRIPTS}

COPY entrypoint.sh bin/
ENV PATH="${SCRIPTS}/bin:${PATH}"

ENTRYPOINT ["/bin/bash","env"]
#ENTRYPOINT ["env"]