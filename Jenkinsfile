pipeline {
    agent any
    stages {
        stage('Creación de la red docker') {
                sh "docker network create red-operez"
                }
            }
            steps {
                sh 'gradle --version'
            }
        }
