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
            }

        }
