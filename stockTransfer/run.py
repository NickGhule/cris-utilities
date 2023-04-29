import logging
import time
import paramiko


client = paramiko.SSHClient()
logging.getLogger("paramiko").setLevel(logging.ERROR)
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect('bytecode-centos', username='nickghule', password='Nikhil@2000')

# invoke a shell and execute the command 'ls'
channel = client.invoke_shell()
# while channel ready to receive data

time.sleep(1)
while channel.recv_ready():
    # print the output
    print(channel.recv(1024).decode('utf-8'))
    # send the command
channel.send('ls\n')
# while channel ready to receive data
time.sleep(1)
while channel.recv_ready():
    # print the output
    print(channel.recv(1024).decode('utf-8'))
    # send the command

channel.send('su test\n')
channel.send('su nickghule\n')
time.sleep(1)
output = ''
if channel.recv_ready():
    output += channel.recv(1024).decode('utf-8')

print(output)
if "Password:" in output:
    channel.send('Nikhil@2000\n')
    time.sleep(1)

channel.send('pwd\n')

time.sleep(1)
while channel.recv_ready():
    # print the output
    print(channel.recv(1024).decode('utf-8'))
    # send the command


channel.send('exit\n')
