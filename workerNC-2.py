import spur
import os


shell = spur.SshShell(hostname="172.16.5.203", username="root", password="FixStream")


Wget = shell.run(["wget","http://172.17.254.71/webmail/cluster/meridian-deploy"])

wgetURL= shell.run(["wget","http://172.17.254.71/webmail/cluster/deployNC"])

deploy = shell.run(["sh","/root/deployNC"])


print deploy.output





