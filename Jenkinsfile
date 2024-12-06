pipeline {
    agent any
    stages {
        stage('Build and run docker image') {
            steps {
                sh 'sudo docker pull divasmahato/website:latest'
                sh 'sudo docker run -d -p 8082:80 divasmahato/website:latest'
            } 
        }


        stage('testing') {
            steps {
                sh 'curl -I 54.172.146.117:8082'
            }
        }

    
    }
}
