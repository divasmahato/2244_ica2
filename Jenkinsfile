pipeline {
    agent any
    stages {
        stage('Cleanup') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Git Repo') {
            steps {
                checkout scm
            }
        }
        stage('Clone from repository') {
            steps {
                git url: 'https://github.com/divasmahato/2244_ica2.git', branch: 'main', credentialsId: 'GIT'
            }
        }

        stage('Build and run docker image') {
            steps {
                sh 'sudo docker build -t divasmahato/website:v1 .'
                sh "sudo docker tag divasmahato/website:v1 divasmahato/website:develop-${env.BUILD_ID}" 
                sh 'sudo docker run -d -p 9006:80 divasmahato/website:v1'
            } 
        }


        stage('Build and Push') {
            steps {
                echo 'Building..'
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-auth', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh '''
                            sudo docker login -u ${USERNAME} -p ${PASSWORD}
                            sudo docker push divasmahato/website:v1
                        '''
                        sh "sudo docker push divasmahato/website:develop-${env.BUILD_ID}"
                    }
            }
        }

        stage('testing') {
            steps {
                sh 'curl -I http://54.81.124.45:8081'
            }
        }

    
    }
}
