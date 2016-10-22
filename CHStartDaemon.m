/*
 * CHStartDaemon.m
 * 
 * Created by: Lee Walsh on 06/10/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHStartDaemon.h"

static void startCyberhoseDaemon(){
	syslog(LOG_NOTICE,"Starting cyberHose daemon");
	
	pid_t pid;
	
	pid = fork();
	//Error
	if(pid < 0){
		exit(1);
	}
	//Success: parent can terminate
	if (pid > 0){
		exit(0);
	}
	
	//Change the file mode mask
	umask(0);
	
	//Open a log file
	openlog("cyberhose.main",LOG_NOWAIT|LOG_PID, LOG_USER);
	
	
	//Create a SID for the child process
	if(setsid() < 0){
		exit(1);
	}
	
	//change the working directory
	if((chdir("/")) < 0){
		exit(1);
	}
	
	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	close(STDERR_FILENO);
	
	syslog(LOG_NOTICE, "Sucessfully started cyberhosed");
}

