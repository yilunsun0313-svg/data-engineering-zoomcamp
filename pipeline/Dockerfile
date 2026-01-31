FROM python:3.13.11-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/

# RUN pip install pandas pyarrow # this is not needed anymore because  
# they are mentioned in pyproject.toml

WORKDIR /code

# Dockerfile environment configuration line
# ENV in a Dockerfile is used to set an environment variable inside the container.
# ENV VARIABLE_NAME=value

# This ensures that all commands use the virtual environment’s Python and packages automatically.
# $PATH appends the new path to the existing paths so that the executables in other
# paths can still be found if the new path does not contain them.
ENV PATH="/code/.venv/bin:$PATH"

COPY pyproject.toml .python-version uv.lock .

# Install dependencies from lock file (ensures reproducible builds)
RUN uv sync --locked  

# this entrypoint means when we run docker run the python file will be 
# executed directly 
COPY ingest_data.py .

# Entrypoint sets the default executable that runs when a container starts
# Similar to:
    # docker run my image -> python pipeline.py
ENTRYPOINT ["python", "ingest_data.py"] 