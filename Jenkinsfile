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
                git url: 'https://github.com/divasmahato/2244_ica2.git', branch: 'develop', credentialsId: 'GIT'
            }
        }

        stage('Build and run docker image') {
            steps {
                sh 'sudo docker build -t divasmahato/website:latest .'
                sh "sudo docker tag divasmahato/website:latest divasmahato/website:develop-${env.BUILD_ID}" 
                sh 'sudo docker run -d -p 8081:80 divasmahato/website:latest'
            } 
        }


        stage('Build and Push') {
            steps {
                echo 'Building..'
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-auth', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh '''
                            sudo docker login -u ${USERNAME} -p ${PASSWORD}
                            sudo docker push divasmahato/website:latest
                        '''
                        sh "sudo docker push divasmahato/website:develop-${env.BUILD_ID}"
                    }
            }
        }

        stage('testing') {
            steps {
                sh 'curl -I 54.81.124.45:8081'
            }
        }

    
    }
}
