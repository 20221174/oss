pipeline {
    agent any

    environment {
        DOCKER_IMAGE = '20221174/oss:latest'  // Docker 이미지 이름 및 태그
    }

    stages {
        stage('Checkout') {
            steps {
                echo "1. Git에서 소스 코드 가져오기"
                checkout scm  // Git 저장소에서 소스 코드 체크아웃
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "2. Node.js 의존성 설치"
                sh 'npm install'  // Node.js 의존성 설치
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "3. Docker 이미지 빌드"
                sh '''
                    docker build -t $DOCKER_IMAGE .
                '''  // Docker 이미지 빌드
            }
        }

        stage('Test Docker Image') {
            steps {
                echo "4. Docker 컨테이너로 애플리케이션 테스트"
                sh '''
                    docker run --rm $DOCKER_IMAGE node -v
                '''  // Docker 컨테이너에서 Node.js 버전 확인 (기본 테스트)
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                echo "5. Docker 이미지를 Docker Hub에 푸시"
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push $DOCKER_IMAGE
                    '''  // Docker Hub에 로그인 후 이미지 푸시
                }
            }
        }
    }

    post {
        always {
            echo "6. Docker 이미지 및 컨테이너 정리"
            sh 'docker system prune -f'  // Docker 이미지 및 컨테이너 정리
        }

        success {
            echo "7. 파이프라인 성공적으로 완료"
        }

        failure {
            echo "8. 파이프라인 실패"
        }
    }
}

