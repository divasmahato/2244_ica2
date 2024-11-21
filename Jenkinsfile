pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'divasmahato/website'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Container Image') {
            steps {
                script {
                    sh 'docker build -t ${website}:v1 .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh 'docker run -d --name test-container -p 8081:80 ${website}:v1'
                }
            }
        }

        stage('Test Website Accessibility') {
            steps {
                script {
                    sh 'curl -I localhost:8081'
                }
            }
        }

        stage('Tag and Push Image') {
            steps {
                script {
                    def branchTag = "develop-${env.BUILD_ID}"
                    sh """
                        docker tag ${website}:latest ${website}:${v1}
                        docker push ${website}:latest
                        docker push ${website}:${v1}
                    """
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker stop test-container || true && docker rm test-container || true'
            }
        }
    }
}
