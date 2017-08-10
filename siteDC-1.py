import spur
import os


shell = spur.SshShell(hostname="172.16.5.204", username="root", password="FixStream")

package = shell.run(["yum", "install", "libaio-devel", "-y"])

Wget = shell.run(["wget","http://172.17.254.71/webmail/cluster/meridian-deploy"])

wgetURL= shell.run(["wget","http://172.17.254.71/webmail/cluster/deployDC-1"])

deploy = shell.run(["sh","/root/deployDC-1"])


print deploy.output





