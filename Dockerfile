FROM alpine:latest

RUN apk add --no-cache jq libxml2-utils bash

ADD cli/scripts/bin /bin
ADD cli/scripts/json /json
#ENTRYPOINT ["/bin/entrypoint.sh"]