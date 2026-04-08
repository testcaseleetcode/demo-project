pipeline {
    agent any

    environment {
        IMAGE_NAME       = "springboot-app"
        IMAGE_TAG        = "latest"
        KUBECONFIG       = "/var/lib/jenkins/.kube/config"
        DOCKER_CERT_PATH = "/var/lib/jenkins/.minikube/certs"
    }

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

        stage('Build Docker Image inside Minikube') {
            steps {
                sh '''
                    # eval sets DOCKER_HOST and DOCKER_TLS_VERIFY from minikube
                    # but DOCKER_CERT_PATH is already overridden by the environment block above
                    eval $(minikube docker-env --shell bash)
                    export DOCKER_CERT_PATH=/var/lib/jenkins/.minikube/certs
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                '''
            }
        }

        stage('Verify Rollout') {
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
        success {
            echo "Deployment successful."
        }
        failure {
            sh 'kubectl describe pods -l app=springboot-app || true'
        }
    }
}