pipeline {
    agent any
    stages {
        stage("Deploy") {
            steps {
                sh '''
                helm upgrade flask helm/ --install --wait --atomic
                '''
            }
        }
    }
}
