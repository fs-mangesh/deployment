import spur


# Login to Hypervisor

shell = spur.SshShell(hostname="172.16.2.88", username="root", password="FixStream123!")
result = shell.run(["echo", "-n", "hello"])


#Poweroff Machine 

poweroffNC = shell.run(["vim-cmd", "vmsvc/power.off", "37"])


poweroffDC1 = shell.run(["vim-cmd", "vmsvc/power.off", "39"])

poweroffDC2 = shell.run(["vim-cmd", "vmsvc/power.off", "40"])

poweroffDC3 = shell.run(["vim-cmd", "vmsvc/power.off", "66"])

poweroffDC4 = shell.run(["vim-cmd", "vmsvc/power.off", "65"])


#Revert Machine Snapshot

revertSnapNC = shell.run(["vim-cmd", "vmsvc/snapshot.revert", "37", "4", "0"])


revertSnapDC1 = shell.run(["vim-cmd", "vmsvc/snapshot.revert", "39", "4", "0"])

revertSnapDC2 = shell.run(["vim-cmd", "vmsvc/snapshot.revert", "40", "4", "0"])

revertSnapDC3 = shell.run(["vim-cmd", "vmsvc/snapshot.revert", "66", "4", "0"])

revertSnapDC4 = shell.run(["vim-cmd", "vmsvc/snapshot.revert", "65", "3", "0"])

#Power On Machine

powerONC = shell.run(["vim-cmd", "vmsvc/power.on", "37"])

powerONDC1 = shell.run(["vim-cmd", "vmsvc/power.on", "39"])

powerONDC2 = shell.run(["vim-cmd", "vmsvc/power.on", "40"])


powerONDC3 = shell.run(["vim-cmd", "vmsvc/power.on", "66"])

powerONDC4 = shell.run(["vim-cmd", "vmsvc/power.on", "65"])
