pipeline {
    agent any

    environment {
        IMAGE_NAME = "springboot-demo"
        CONTAINER_NAME = "springboot-container"
    }

    stages {

//         stage('Checkout Code') {
//             steps {
//                 checkout scm
//             }
//         }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p 7000:7000 --name $CONTAINER_NAME $IMAGE_NAME'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}