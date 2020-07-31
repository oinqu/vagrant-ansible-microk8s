FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-alpine3.10

LABEL maintainer="Stanislav Grebennik <stanislav.grebennik@gmail.com>" \
      version="1.0"

WORKDIR /app
COPY ./app /app

RUN set -eux && \
    addgroup -S appuser &&\
    adduser -h /app -SDHG appuser appuser &&\
    chown -R appuser:appuser .

EXPOSE 8080
USER appuser

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
