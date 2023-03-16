
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#  _ __ ___   ___   __| |_   _| | __ _ _ __   _ __ __ _| |_
# | '_ ` _ \ / _ \ / _` | | | | |/ _` | '__| | '__/ _` | __|
# | | | | | | (_) | (_| | |_| | | (_| | |    | | | (_| | |_
# |_| |_| |_|\___/ \__,_|\__,_|_|\__,_|_|    |_|  \__,_|\__|
# 
# Created by : he$einb3rg
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# Architecture

![alt text](https://github.com/b3rg01/ModularRat/blob/main/architecture.drawio.png?raw=true)

# How It Works

The attacker is connected to the command and control server through ssh. The command and control server contains all the modules that will be uploaded on the victim machine. In my case my command and control server represents my raspberrypi that runs an uploadserver given to me by python, so i can expose and download the files from the machine to another or I can upload file from a remote machine to my command and control center. Your command and control server could be an amazon instance, or a vm, or another machine. There is an initial program that will be executed on the victim machine, you can use any means necessary to get the program to execute himself on the victim

# How To Use
There is an initial program that will be executed on the victim machine, you can use any means necessary to get the program to execute himself on the victim. Afterwards, all the modules will get downloaded on the victim machine et you well get a reverse shell connection back to the C2 and from there you will be able to execute the modules.

## Steps
  - Make an ssh connection to your command and control center
  - Start your uploadserver on you c2 : python -m uploadserver
  - Find a way to execute the phase1.cmd program on the victim machine
    - Spear Phishing
    - Social Engineering
  - Start a second ssh connection to your command and control center
  - Start a netcat listener
  - Enjoy...;)


# References

- https://www.netspi.com/blog/technical/network-penetration-testing/15-ways-to-bypass-the-powershell-execution-policy/
- https://www.howtogeek.com/789655/how-to-open-powershell-with-admin-privileges-from-cmd/
- Important to note that i set the execution policy to remoteSigned to facilitate the demo
- https://www.nextofwindows.com/creating-a-simple-keylogger-using-powershell-download
- https://pypi.org/project/uploadserver/
- https://github.com/besimorhino/powercat
- https://stackoverflow.com/questions/36268925/powershell-invoke-restmethod-multipart-form-data
- https://stackoverflow.com/questions/2224350/powershell-start-job-working-directory
