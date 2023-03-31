# jenkins-test      

## goal
1. demonstrate simple use-case for jenkins      
2. understand how to setup and run a jenkins server      
    a. configure master server as code      
    b. setup secure agent nodes     
    c. connect github repos to run build on commit for CI

## setup     
// run jenkins master server (initial setup)    
$ ./docker-run.sh   
// create rsa key in master (passphrase optional)
$ ssh-keygen -f ~/.ssh/jenkins_agent_key    
// add private key to credentials       
$ cat /.ssh/jenkins_agent_key           
// save public key for later            
$ cat /.ssh/jenkins_agent_key.pub       
> username: jenkins     
> private key (enter directly): <paste private key from keygen>  
> passphrase: <if the key was generated with one; else leave blank>

// add public key to docker-jenkins-agent.sh variable       
$ ./docker-jenkins-agent.sh     
// add pipeline to jenkins master       
> Definition: Pipeline script from SCM      
> SCM: git      
> repository url: https://github.com/dillonmarquard/jenkins-test.git        
> credentials: jenkins      
