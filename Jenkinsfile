def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]
pipeline{
    agent any 
    environment{
        // registryCredentials = 'ecr:us-east-1:cicdjenkins'     
        imagename = "998179695351.dkr.ecr.us-east-1.amazonaws.com/php-web-app"
        applicationRegistry = 'https://998179695351.dkr.ecr.us-east-1.amazonaws.com/php-web-app'
        PATH = "/usr/local/bin:${PATH+DOCKER}"
    }

    stages{

        stage("Build Docker Image"){
            steps{
                script{
                    dockerImage = docker.build(imagename + ":$BUILD_ID" + "_$BUILD_TIMESTAMP",".")
                }
            }
        }
        // stage("Upload Docker to ECR"){
        //     steps{
        //         script{
        //             docker.withRegistry (applicationRegistry,registryCredentials){
        //                 dockerImage.push("$BUILD_ID")
        //                 dockerImage.push("latest")
        //             }
        //         }
        //     }
        // }
        //
    }
    post {
    always {
        echo 'Slack Notifications.'
        slackSend channel: '#jenkins',
            color: COLOR_MAP[currentBuild.currentResult],
            message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
            }
    }
}
