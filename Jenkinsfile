pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                git 'https://your-repo-url.git' // 코드 저장소 URL
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-node-app:latest')
                }
            }
        }
        stage('Push to Registry') {
            steps {
                script {
                    docker.withRegistry('https://your-registry-url', 'docker-credentials-id') {
                        docker.image('my-node-app:latest').push()
                    }
                }
            }
        }
    }
}
