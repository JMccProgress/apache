pipeline {
	agent { label "agentfarm"}
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
                        steps{
                              git credentialsId: 'git-repo-creds', url: 'git@github.com:JMccProgress/apache.git'
                        }

                }
                stage('installing Kitchen Docker Gem') {
                        steps{
                                sh 'sudo apt-get install -y make gcc'
                                sh 'sudo chef gem install kitchen-docker'
           


                             }
                             
                             
                        }

                }

	}






}
