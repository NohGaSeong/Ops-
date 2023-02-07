FROM python:3.8-alpine
RUN pip3 install django
WORKDIR /usr/src/app
COPY . .

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000