FROM alpine:latest

RUN apk add --no-cache jq libxml2-utils bash curl git

ENV h1="Content-Type: application/json" h2="Accept: application/json" baseURL=https://api.boomi.com/api/rest/v1
COPY --chmod=755 cli/scripts/bin /bin
COPY cli/scripts/json /json

ENTRYPOINT ["/bin/entrypoint.sh"]