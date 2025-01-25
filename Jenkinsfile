pipeline {
    agent any
    tools {
        nodejs '20.16.0'
    }
    environment {
        DOCKER_IMAGE = "project-devops:latest"
        // For pushing to Docker Hub, you might do:
        // DOCKER_HUB_REPO = "<your_dockerhub_username>/my-nest-app"
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Pull the code from your repository
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                // Install project dependencies
                sh 'npm install'
            }
        }
        
        stage('Check Node.js Version') {
            steps {
                // Check the version of Node.js in the Jenkins environment (if it was installed correctly)
                sh 'node -v'
            }
        }
        
        stage('Check Node.js Version in Docker') {
            steps {
                script {
                    // Check the version of Node.js inside the Docker container (which uses node:16-alpine)
                    sh "docker run --rm ${DOCKER_IMAGE} node -v"
                }
            }
        }

        stage('Build') {
            steps {
                // Build the project using npm
                sh 'npm run build'
            }
        }
        
        stage('Test') {
            steps {
                // Run tests using npm
                sh 'npm run test'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    sh "docker build -f Dockerfile -t ${DOCKER_IMAGE} ."
                }
            }
        }

        // Uncomment and configure the following sections if pushing to Docker Hub and deploying to Minikube is needed.
        // stage('Push Docker Image') {
        //     steps {
        //         script {
        //             // Example to push Docker image to Docker Hub
        //             echo "Skipping push for local demonstration."
        //         }
        //     }
        // }

        // stage('Deploy to Minikube') {
        //     steps {
        //         script {
        //             // Example for deploying to Minikube
        //             echo "Deploying to Minikube..."
        //             sh "kubectl apply -f k8s/deployment.yaml"
        //             sh "kubectl apply -f k8s/service.yaml"
        //         }
        //     }
        // }
    }
}
