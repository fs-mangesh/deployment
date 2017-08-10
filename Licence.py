import spur
import os


shell = spur.SshShell(hostname="172.16.5.201", username="root", password="FixStream")




Wget = shell.run(["wget","http://172.17.254.71/webmail/cluster/License"])



deploy = shell.run(["sh","/root/License"])


print deploy.output


