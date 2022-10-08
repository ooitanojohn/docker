FROM alpine:latest
RUN apk add apache2 && apk add curl
# RUN mkdir ph35/ && cd ph35 && mkdir htdocs/
# COPY ${pwd}/lamp/htdocs/ /usr/local/apache2/htdocs/
# CMD ["mkdir"," ph35"]