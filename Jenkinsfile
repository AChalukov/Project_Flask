pipeline {
    agent any
    environment{
        // Use your specific URL from amazon ECR
        image_name=aws ecr describe-repositories --repository-names flask --query 'repositories[0].repositoryUri' --output text --region eu-central-1
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                ls
                aws sts get-caller-identity
                
                '''            
            }
        }
    }
}
