properties([disableConcurrentBuilds()])

pipeline {
    agent any
    stages {
        stage("docker login") {
            steps {
                echo "-----docker hub login-----"
                withCredentials([usernamePassword(credentialsId: 'dockerhublogin', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                }
            }
        }
        stage("create docker image") {
            steps {
                echo "-----building image-----"
                dir ('') {
                	sh 'docker build -t nyamtsu/react:v1 . '
                }
            }
        }
        stage("docker push") {
            steps {
                echo "-----pushing image-----"
                sh 'docker push nyamtsu/react:v1'
                
            }
        }
        stage("kubernetes deploy") {
            steps {
                echo "-----kubernetes deploy-----"
                withKubeConfig([credentialsId: 'kuber']) {
                    dir ('') {
                        sh 'kubectl replace --force -f ./deployment-front.yaml'
                    }
                }
            }
        }
                stage('delete docker image localy') {
                  steps {
                      echo "-----delete docker image localy-----"
                        sh 'docker rmi nyamtsu/react:tagname'
            }
        }
    }
}
