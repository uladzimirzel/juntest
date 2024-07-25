import json

with open('/var/jenkins_home/workspace/Install_Terraform/terraform/terraform.tfstate', 'r', encoding='utf-8') as file:
    test_dict = json.load(file)

inventory = open("inventory.ini", "w+")
inventory.write('[webservers]' + '\n')

count = 0

while count < 2:
    name = test_dict['resources'][count]['instances'][0]['attributes']['name']
    ip_address = test_dict['resources'][count]['instances'][0]['attributes']['network_interface'][0]['nat_ip_address']
    inventory.write('\n' + name + ' ansible_host=' + ip_address)
    count += 1