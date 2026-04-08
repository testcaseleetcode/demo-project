pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build JAR') {
            steps {
                sh '''
                    chmod +x mvnw
                    ./mvnw clean package -DskipTests
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    eval $(minikube docker-env)
                    docker build -t springboot-app:latest .
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    kubectl rollout status deployment/springboot-app --timeout=120s
                    kubectl get pods
                    kubectl get svc springboot-app-service
                '''
            }
        }
    }

    post {
        failure {
            sh 'kubectl describe pods -l app=springboot-app || true'
        }
    }
}