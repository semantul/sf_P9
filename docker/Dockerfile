FROM python:3-alpine
RUN apk update --no-cache &&\
    apk add build-base postgresql-dev libpq --no-cache --virtual .build-deps &&\
    pip3 install --no-cache-dir flask &&\
    pip3 install --no-cache-dir configparser &&\
    pip3 install --no-cache-dir psycopg2 &&\
    apk del .build-deps &&\
    apk add postgresql-libs libpq --no-cache
WORKDIR /srv/app
CMD /usr/local/bin/python3 ./web.py
