#!groovy
// Run docker build
properties([disableConcurrentBuilds()])

pipeline {
    agent any
    triggers { pollSCM('* * * * *') }
    stages {
        stage("docker login") {
            steps {
                echo "docker login"
                withCredentials([usernamePassword(credentialsId: 'dockerhublogin', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                }
            }
        }
        stage("create docker image") {
            steps {
                echo "start building image"
                dir ('') {
                	sh 'docker build -t nyamtsu/react:v1 . '
                }
            }
        }
        stage("docker push") {
            steps {
                echo "start pushing image"
                sh 'docker push nyamtsu/react:v1'
                
            }
        }
        stage("kubernetes deploy") {
            withKubeConfig([credentialsId: 'kubernetes'])
            }
            steps {
                echo "kubernetes deploy"
                    dir ('') {
                        sh 'kubectl apply -f ./front.yaml'
                    }
            }
        }
    }
