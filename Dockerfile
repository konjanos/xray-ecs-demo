FROM python:3.9-buster

COPY hello_world /app
WORKDIR /app
RUN cd /app && pip install -r requirements.txt

CMD flask --app hello run --host=0.0.0.0

EXPOSE 5000
