pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin "$(aws ecr describe-repositories --region eu-central-1 --repository-names flask --query 'repositories[0].repositoryUri' --output text)"
                '''
            }
        }
    }
}
