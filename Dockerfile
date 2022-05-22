FROM python:3.10-alpine

ENV PLANTUML_VERSION 1.2022.5
ENV LANG en_US.UTF-8
ENV PATH=$PATH:/root/.poetry/bin/

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache openjdk8-jre graphviz ttf-droid ttf-droid-nonlatin git curl \
    && apk add --no-cache --virtual .build gcc musl-dev \
    && mkdir /app /doc \
    && curl -L https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download -o /app/plantuml.jar \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - \
    && poetry config virtualenvs.create false \
    && apk del .build gcc musl-dev \
    && rm -rf /tmp/*

COPY plantuml /app/plantuml

WORKDIR /docs

COPY pyproject.toml pyproject.toml

RUN poetry install

ENTRYPOINT [ "mkdocs" ]
CMD [ "serve", "--dev-addr=0.0.0.0:8000" ]
