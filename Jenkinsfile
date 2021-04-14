pipeline {
    agent { label "agentfarm" } 
    stages{


        stage('Delete the workspace') {
            steps{
                cleanWs()
            }
        }
                stage('installing Chef workstation') {
                        steps{
                             sh 'sudo apt-get install -y wget tree unzip'
                             script{
                                     def exists = fileExists '/usr/bin/chef-client'
                                     if (exists == true) {
                                             echo "Skipping Chef Workstation install -  already installed"
                                     } else {
                                             sh 'wget https://packages.chef.io/files/stable/chef-workstation/20.10.168/ubuntu/20.04/chef-workstation_20.10.168-1_amd64.deb'
                                             sh 'sudo dpkg -i chef-workstation_20.10.168-1_amd64.deb'
                                             sh 'sudo chef env --chef-license accept'
                                     }
                                }
                        }

                }
                stage('download apache cookbook') {
                        steps {
                              git credentialsId: 'git-repo-creds', url: 'git@github.com:JMccProgress/apache.git'
                        }

                }
                /*
                stage('installing Kitchen Docker Gem') {
                        steps {
                                sh 'sudo apt-get install -y make gcc'
                                sh 'chef gem install kitchen-docker'
                             }

                }
                stage('Run kitchen destroy') {
                        steps {
                                sh 'kitchen destroy'
                             }

                }
                stage('Run kitchen create') {
                        steps {
                                sh 'kitchen create'
                             }

                }
                stage('Run kitchen converge') {
                        steps {
                                sh 'kitchen converge'
                             }

                }
                stage('Run kitchen verify') {
                        steps {
                                sh 'kitchen verify'
                             }

                }
                stage('Run kitchen destroy - tidy up') {
                        steps {
                                sh 'kitchen destroy'
                             }

                }
                stage('Send Slack Notification') {
                        steps {
                                echo 'hello'
                        slackSend color: 'warning', message: "please approve - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.JOB_URL} | Open>)"
                        }
                }
                stage('request input'){
                        steps{
                                input 'please approve or deny'
                        }
                 }
                 */
                stage('Upload to Chef Infra Server, Converge Nodes'){
                        steps{
                                withCredentials([zip(credentialsId: 'chef-starter-zip', variable: 'CHEFREPO')]) {
                                        sh "chef install $WORKSPACE/Policyfile.rb -c $CHEFREPO/chef-repo/.chef/config.rb"
                                        sh "chef push prod $WORKSPACE/Policyfile.lock.json -c $CHEFREPO/chef-repo/.chef/config.rb"
                                        withCredentials([sshUserPrivateKey(credentialsId: 'agent-key', keyFileVariable: 'agentKey')]){
                                                sh "knife ssh 'policy_name:apache' -x ubuntu -i $agentKey 'sudo chef-client' -c $CHEFREPO/chef-repo/.chef/config.rb"
                                        }

                                }
                        }
                 }
    }
    post{
            success{

                    slackSend color: 'warning', message: "SUCCESS! - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.JOB_URL} | Open>)"
                    

            }
            failure{
                    slackSend color: 'error', message: "FAILURE! - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.JOB_URL} | Open>)"

            }
    }





}
