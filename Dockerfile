FROM alpine:latest

RUN apk add --no-cache jq libxml2-utils bash curl git

ENV h1="Content-Type: application/json"
ENV h2="Accept: application/json"
ENV baseURL=https://api.boomi.com/api/rest/v1
ADD cli/scripts/bin /bin
ADD cli/scripts/json /json

#Make the scripts executable
RUN ["chmod", "+x", "/bin/entrypoint.sh"]
ENTRYPOINT ["/bin/entrypoint.sh"]