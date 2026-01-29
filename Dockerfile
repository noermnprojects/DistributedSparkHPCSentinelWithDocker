FROM python:3.11-slim-bullseye

# Installation de Java + procps (pour éviter l'erreur 'ps')
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk-headless \
    curl \
    procps \
    && apt-get clean

# Variables d'environnement Spark/Java
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV SPARK_HOME=/opt/spark
ENV PATH="${JAVA_HOME}/bin:${SPARK_HOME}/bin:${PATH}"

# Téléchargement et installation de Spark 3.5.0
RUN curl -sL "https://archive.apache.org/dist/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz" \
    | tar -xz -C /opt && mv /opt/spark-3.5.0-bin-hadoop3 $SPARK_HOME

# Installation des libs Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /home/jovyan