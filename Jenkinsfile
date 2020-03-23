node("master") {

	SUCCESS = "success"
	FAIL    = "fail"
	
	RESULT = SUCCESS

    echo "Running on master"

	SCRIPTS_PATH = "Scripts/Auto_connect_Jenkins_nodes"

	cleanWs()

	dir("Scripts") {
		git credentialsId: 'SSH_cred', url: 'git@github.com:natimirauta/Scripts.git'
    }
    
    try{

        stage("Initialize environment") {

            NEW_NODE_NAME = "${JOB_NAME}" + "_" + "${BUILD_NUMBER}"
            JENKINS_LINK  = "http://192.168.1.9:8080/"
            
            dir(SCRIPTS_PATH) {
				sh "./1_create_Jenkins_node.sh ${NEW_NODE_NAME} ${JENKINS_LINK} ${JOB_NAME} ${BUILD_NUMBER}"
            }
            
        }    

    } catch (e) {

		RESULT = FAIL
		echo "Failed to initialize environment"
		
	}

	try {
	
		stage("Cleanup after Docker") {
		
			SERVICE_NAME = "${JOB_NAME}" + "-" + "${BUILD_NUMBER}"
			
			dir(SCRIPTS_PATH) {
			
				sh "./5_cleanup_after_Docker.sh ${NEW_NODE_NAME} ${JENKINS_LINK} ${SERVICE_NAME}"
			
			}
		
		}
	
	} catch(e) {
	
		RESULT = FAIL
		echo "Failed to clean after Docker"
	
	}

}
