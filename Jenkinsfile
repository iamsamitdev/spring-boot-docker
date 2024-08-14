pipeline {
    agent any

    environment {
      MAVEN_ARGS = "-e clean install"
      dockerContainerName = "bookapi_${ENV}"
      dockerImageName = "bookapi_api_${ENV}"
      SPRING_PROFILES_ACTIVE = "${ENV}"
    }

    parameters {
      choice(name: 'ENV', choices: ['staging', 'production'], description: 'Select Environment (staging, production)')
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    if (!params.ENV) {
                        params.ENV = 'staging'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                withMaven(maven: 'MAVEN_HOME') {
                    sh "mvn ${MAVEN_ARGS}"
                }
            }
        }

        stage('Clean Container') {
            steps {
                sh 'docker ps -f name=${dockerContainerName} -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -f name=${dockerContainerName} -q | xargs -r docker container rm'
                sh 'docker images -q --filter=reference=${dockerImageName} | xargs --no-run-if-empty docker rmi -f'
            }
        }

        stage('Docker-Compose Start') {
            steps {
                sh """
                SPRING_PROFILES_ACTIVE=${SPRING_PROFILES_ACTIVE} docker-compose -f docker-compose-${ENV}.yml up -d --build
                """
            }
        }
    }
}
