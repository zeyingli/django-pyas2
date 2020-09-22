FROM python:3.8.5-alpine

LABEL MAINTAINER Sam<sam@cenports.com>

WORKDIR /app
ENV PYTHONUNBUFFERED 1

COPY ./ /app

RUN apk update; \
    apk add --no-cache openssl-dev gcc libffi-dev musl-dev mariadb-connector-c-dev; \
    apk add --no-cache --virtual .build-deps build-base mariadb-dev

RUN pip install -r requirements/base.txt; \
    pip install django-pyas2
RUN apk del .build-deps

CMD ["/usr/local/bin/python", "/app/manage.py", "runserver", "0.0.0.0:8000"]

EXPOSE 8000