FROM python:3.10-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /code

COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-dev

COPY ./app /code/app

COPY ./model /code/model

ENV PATH="/code/.venv/bin:$PATH"

EXPOSE 80

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]