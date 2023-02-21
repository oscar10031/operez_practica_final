pipeline {
    agent any
    stages {
        stage('Limpieza de recursos') {
            steps {
                sh "docker network rm red-operez"
            }
                }
        stage('Creación de la red docker') {
            steps {
                sh "docker network create red-operez"
            }
                }
        stage('Levantando contenedor de postgres') {
            steps {
                sh '''docker run -d --network red-operez \
	            --name postgres \
	            -e POSTGRES_PASSWORD=1234Abcd \
	            e PGDATA=/var/lib/postgresql/data/pgdata \
	            -v /home/bootuser/operez_practica_final/postgres_data:/var/lib/postgresql/data \
	            postgres:11
                '''
            }
                }
            }

        }
