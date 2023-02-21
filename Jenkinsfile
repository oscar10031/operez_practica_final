pipeline {
    agent any
    environment {
       DISABLE_AUTH = 'true'                               //can be used in whole pipeline
   }
    stages {
        stage('Creación de la red docker') {
            steps {
                sh "docker network create red-operez"
            }
                }
        stage('Levantando contenedor de postgres') {
            steps {
                sh '''docker run -d --network red-operez --name postgresql -e POSTGRES_PASSWORD=1234Abcd \
	            -v /home/bootuser/operez_practica_final/postgres_data:/var/lib/postgresql/data \
	            postgres:11
                '''
            }
        }
        stage('Levantando contenedor de phpPgAdmin') {
            steps {
                sh '''docker run -d --name phppgadmin -p 80:8080 -p 443:8443 \
                    --net red-operez \
                    bitnami/phppgadmin:latest
                '''
            }
                }
        stage('Importando datos a la base de datos') {
            steps {
                sh '''PGPASSWORD=1234Abcd psql -h postgresql -d postgres -U postgres
                    CREATE DATABASE dvdrental;
                '''
            }
                }


        }
}
