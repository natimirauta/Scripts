node("master")
{

    echo "ceva"

    git credentialsId: 'SSH_cred', url: 'git@github.com:natimirauta/Stage_Project.git'

    sh 'git archive --remote=git@github.com:natimirauta/Scripts.git HEAD:Auto_connect_Jenkins_nodes 1_create_Jenkins_node.sh | tar -xf -'

}
