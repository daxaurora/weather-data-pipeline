FROM python:3.11.3

COPY requirements.txt .

# Install dependencies
RUN python -m pip install --upgrade pip && \
    python -m pip install -r /requirements.txt
