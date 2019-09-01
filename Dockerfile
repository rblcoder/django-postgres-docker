# pull official base image
FROM python:3.7.4-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


# install psycopg2
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev \
    && pip install psycopg2 \
    && apk del build-deps

# install dependencies
RUN pip install --upgrade pip

#COPY ./Pipfile /usr/src/app/Pipfile
#RUN pipenv install --skip-lock --system --dev
# COPY ./Pipfile /usr/src/app/Pipfile
# RUN pipenv install --skip-lock --system --dev
COPY ./requirements.txt /usr/src/requirements.txt
# RUN pipenv install -r /usr/src/requirements.txt --skip-lock --dev
# RUN . $(pipenv --venv)/bin/activate
RUN pip install -r /usr/src/requirements.txt

# copy project
COPY ./app /usr/src/app/

# copy entrypoint.sh
COPY ./entrypoint.sh /usr/src/entrypoint.sh

# run entrypoint.sh
ENTRYPOINT ["/usr/src/entrypoint.sh"]
