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
                sh '''docker run -d --network red-operez --network-alias postgres --name postgresql -e POSTGRES_PASSWORD=1234Abcd \
	            -v /home/bootuser/operez_practica_final/postgres_data:/var/lib/postgresql/data \
	            postgres:11
                '''
            }
        }
        stage('Levantando contenedor de phpPgAdmin') {
            steps {
                sh '''docker run -d --name phppgadmin -p 80:8080 -p 443:8443 -e DATABASE_HOST=postgres\
                    --net red-operez \
                    bitnami/phppgadmin:latest
                '''
            }
                }
        stage('Importando datos a la base de datos') {
            steps {
                sh 'docker exec -t postgresql psql -U postgres -c "CREATE DATABASE dvdrental;"'
                sh 'docker cp /home/bootuser/operez_practica_final/repo/operez_practica_final/dvdrental.tar postgresql:/tmp/dvdrental.tar'
                sh 'docker exec -t postgresql psql -U postgres -c "pg_restore -U postgres -d dvdrental /tmp/dvdrental.tar"'
            }
                }


        }
}
