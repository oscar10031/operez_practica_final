pipeline {
    agent any
    environment {
       DISABLE_AUTH = 'true'                               //can be used in whole pipeline
   }
    stages {
        stage('Creación de la red docker DEV') {
            when {
                branch 'dev'
            }
            agent { 
                label 'principal'
            }
            steps {
                sh "docker network create red-operez"
            }
                }

        stage('Creación de la red docker PRO') {
            when {
                branch 'main'
            }
            agent { 
                label 'nodoaws'
            }
            steps {
                sh "docker network create red-operez"
            }
                }
        stage('Levantando contenedor de postgres en PRE') {
            when {
                branch 'dev'
            }
            agent { 
                label 'principal'
            }
            steps {
                withCredentials([string(credentialsId: 'postgrespwd', variable: 'postgrespwd')]) {
                sh '''docker run --expose 8432 -d --network red-operez --network-alias postgres --name postgresql -e POSTGRES_PASSWORD="${postgrespwd}" \
	            -v /home/bootuser/operez_practica_final/postgres_data:/var/lib/postgresql/data \
	            postgres:11
                '''
                }
            }
        }
        stage('Levantando contenedor de postgres en PRO') {
            when {
                branch 'main'
            }
            agent { 
                label 'nodoaws'
            }
            steps {
                withCredentials([string(credentialsId: 'postgrespwd', variable: 'postgrespwd')]) {
                sh '''docker run -d --network red-operez --network-alias postgres --name postgresql -e POSTGRES_PASSWORD="${postgrespwd}" \
	            -v /home/ubuntu/workspace/postgres_data:/var/lib/postgresql/data \
	            postgres:11
                '''
                }
            }
        }
        stage('Levantando contenedor de phpPgAdmin en PRE') {
             when {
                branch 'dev'
            }
            agent { 
                label 'principal'
            }
            steps {
                sh '''docker run -d --name phppgadmin -p 80:8080 -p 443:8443 -e DATABASE_HOST=postgres\
                    --net red-operez \
                    bitnami/phppgadmin:latest
                '''
            }
                }

        stage('Levantando contenedor de phpPgAdmin en PRO') {
             when {
                branch 'main'
            }
            agent { 
                label 'nodoaws'
            }
            steps {
                sh '''docker run -d --name phppgadmin -p 80:8080 -p 443:8443 -e DATABASE_HOST=postgres\
                    --net red-operez \
                    bitnami/phppgadmin:latest
                '''
            }
                }
        stage('Importando datos a la base de datos en PRE') {
            when {
                branch 'dev'
            }
            agent { 
                label 'principal'
            }
            steps {
                sh 'sleep 7'
                sh 'docker exec -t postgresql psql -U postgres -c "CREATE DATABASE dvdrental;"'
                sh 'docker cp dvdrental.tar postgresql:/tmp/dvdrental.tar'
                sh 'docker exec -t postgresql pg_restore -U postgres -d dvdrental /tmp/dvdrental.tar'
            }
                }
        stage('Importando datos a la base de datos en PRO') {
            when {
                branch 'main'
            }
            agent { 
                label 'nodoaws'
            }
            steps {
                sh 'sleep 15'
                sh 'docker exec -t postgresql psql -U postgres -c "CREATE DATABASE dvdrental;"'
                sh 'docker cp dvdrental.tar postgresql:/tmp/dvdrental.tar'
                sh 'docker exec -t postgresql pg_restore -U postgres -d dvdrental /tmp/dvdrental.tar'
            }
                }


        }

}
