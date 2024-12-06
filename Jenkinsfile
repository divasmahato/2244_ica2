pipeline {
    agent any
    stages {
        stage('Cleanup') {
            steps {
                cleanWs()
            }
        }

        stage('Clone from repository') {
            steps {
                git url: 'https://github.com/divasmahato/2244_ica2.git', branch: 'develop', credentialsId: 'GIT'
            }
        }

        stage('Build and run docker image') {
            steps {
                sh 'sudo docker build -t divasmahato/website .'
                sh "sudo docker tag divasmahato/website:latest divasmahato/website:develop-${env.BUILD_ID}" 
                sh 'sudo docker run -d -p 8081:80 divasmahato/website:latest'
            } 
        }


        stage('Build and Push') {
            steps {
                echo 'Building and pushing docker images..'
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-auth', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh '''
                            docker login -u ${USERNAME} -p ${PASSWORD}
                            docker push divasmahato/website:latest
                        '''
                        sh " docker push divasmahato/website:develop-${env.BUILD_ID}"
                    }
            }
        }

        stage('testing') {
            steps {
                sh 'curl -I http://54.172.146.117:8081 || true'
            }
        }
    }
}
