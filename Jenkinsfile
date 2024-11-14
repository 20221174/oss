pipeline {
    agent any

    environment {
        DOCKER_IMAGE = '20221174/oss:latest'  // Docker 이미지 이름 및 태그
    }

    stages {
        stage('Checkout') {
            steps {
                // Git 저장소에서 소스 코드 체크아웃
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Docker 이미지를 빌드
                    echo "Building Docker image..."
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Docker 컨테이너를 실행하여 애플리케이션 테스트
                    echo "Running tests in Docker container..."
                    sh 'docker run --rm $DOCKER_IMAGE node -v'  // Node.js 버전 확인 (기본적인 테스트)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Docker Hub에 로그인 (Jenkins에서 Docker Hub 자격 증명 사용)
                    echo "Logging in to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }

                    // Docker Hub에 이미지 푸시
                    echo "Pushing Docker image to Docker Hub..."
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
    }

    post {
        always {
            // 빌드 후 Docker 컨테이너 정리
            echo "Cleaning up Docker containers and images..."
            sh 'docker system prune -f'
        }

        success {
            // 성공 시 알림 또는 추가 작업
            echo "Jenkins pipeline completed successfully!"
        }

        failure {
            // 실패 시 알림 또는 추가 작업
            echo "Jenkins pipeline failed."
        }
    }
}

