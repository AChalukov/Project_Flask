pipeline {
    agent any
    environment{
        // Use your specific URL from amazon ECR
        image_name=aws ecr describe-repositories --repository-names flask --query 'repositories[0].repositoryUri' --output text --region eu-central-1
        region="eu-central-1"
    }
    stages {
        stage("Build") {
            steps {
                sh '''
                aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin "$(aws ecr describe-repositories --region eu-central-1 --repository-names flask --query 'repositories[0].repositoryUri' --output text)"
                docker build -t $image_name:latest .
                '''
            }
        }
        stage("Push") {
            steps {
                sh '''
                docker push $image_name:latest
                '''
            }
        }
        stage("Deploy") {
            steps {
                sh '''
                helm upgrade flask helm/ --install --wait --atomic
                '''
            }
        }
    }
}
