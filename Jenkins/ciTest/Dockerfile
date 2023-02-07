FROM test/django:latest
RUN pip3 install django
WORKDIR /usr/src/app
COPY . .
WORKDIR ./main
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000