import spur
import os


shell = spur.SshShell(hostname="172.16.5.205", username="root", password="FixStream")

package = shell.run(["yum", "install", "libaio-devel", "-y"])

Wget = shell.run(["wget","http://172.17.254.71/webmail/cluster/meridian-deploy"])

wgetURL= shell.run(["wget","http://172.17.254.71/webmail/cluster/deployDC-2"])

deploy = shell.run(["sh","/root/deployDC-2"])


print deploy.output





