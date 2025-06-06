#!/bin/bash
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Eliminar contenedor previo si existe
docker rm -f samplerunning 2>/dev/null || true

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile

echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile

echo "EXPOSE 5050" >> tempdir/Dockerfile

echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile


cd tempdir
docker build -t sampleapp .

docker run -t -d -p 5050:5050 --name samplerunning sampleapp

#sudo para no tener que crear un usuario de Docker
#sudo docker build -t sampleapp .
#sudo docker run -t -d -p 5050:5050 --name samplerunning sampleapp
#sudo docker ps -a
