pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/20221174/oss' // GitHub 저장소 URL과 브랜치
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t 20221174/oss:1.0 .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh 'docker push 20221174/oss:latest'
                }
            }
        }
    }
}

