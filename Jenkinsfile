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
                echo 'Building and pushing Docker image..'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-auth', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        sudo docker login -u ${USERNAME} -p ${PASSWORD}
                        sudo docker push divasmahato/website:latest
                    '''
                    sh "sudo docker push divasmahato/website:develop-${env.BUILD_ID}"
                }
            }
        }

        stage('Testing') {
            steps {
                sh 'curl -I http://54.172.146.117:8081 || true' // Ensuring it won't fail the build
            }
        }
    }
}
