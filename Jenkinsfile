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
                             sh 'wget https://packages.chef.io/files/stable/chef-workstation/20.10.168/ubuntu/20.04/chef-workstation_20.10.168-1_amd64.deb'
                             sh 'sudo dpkg -i chef-workstation_20.10.168-1_amd64.deb'
                             sh 'sudo chef env --chef-license accept'
                        }

                }
                stage('three') {
                        steps{
                              echo "three"
                        }

                }

	}






}
