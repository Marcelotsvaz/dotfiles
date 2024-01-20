function ec2-ssh --description 'Connect to an EC2 instance by pushing a SSH key using EC2 Instance Connect.'
	argparse --min-args 1 --ignore-unknown 'J/jump-host=?' -- $argv
	or return
	
	set instanceId $argv[1] && set --erase argv[1]
	set jumpInstanceId $_flag_jump_host
	
	set publicKey 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH7gGmj7aRlkjoPKKM35M+dG6gMkgD9IEZl2UVp6JYPs VAZ Projects SSH Key'
	set user ec2-user
	
	set -x AWS_DEFAULT_OUTPUT text
	
	# Use a jump host.
	if set -q _flag_jump_host
		aws ec2-instance-connect send-ssh-public-key --instance-id $jumpInstanceId --instance-os-user $user --ssh-public-key $publicKey > /dev/null
		set jumpIp $(aws ec2 describe-instances --instance-ids $jumpInstanceId --query 'Reservations[0].Instances[0].PublicIpAddress')
		set jumpHost "-J $user@$jumpIp"
		
		set ipField PrivateIpAddress
	else
		set ipField PublicIpAddress
	end
	
	
	aws ec2-instance-connect send-ssh-public-key --instance-id $instanceId --instance-os-user $user --ssh-public-key $publicKey > /dev/null
	set ip $(aws ec2 describe-instances --instance-ids $instanceId --query "Reservations[0].Instances[0].$ipField")
	set host $user@$ip
	
	
	ssh $jumpHost $host $argv
end