# game-gl-demo-deploy

This is a binary package to be deployed on GameLift for an iFun Engine test drive.

First, you need an AWS credential to deploy this stuff to GameLift.
Please refer to the ``Access Keys`` section of this link: http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html

## To set up a Zookeeper and a MySQL

* Get an Ubuntu 16.04 (Xenial) from EC2.
* Install MySQL and run it using ``sudo apt-get install mysql-server`` and ``sudo service mysql start``
* Install Zookeeper and run it using ``sudo apt-get install zookeeper zookeeperd`` and ``sudo service zookeeper start``
* Create a mysql user named ``funapi`` with a password ``funapi``.
* Create a mysql database named ``funapi`` and grant all privileges on the database to the ``funapi`` user.
* Remember the public IP of the VM instance.


## To deploy the field server and the instance world server (to GameLift)

* Get an Amazon Linux instance from EC2. This VM instance will invoke the ``aws`` command line tool for deployment.
* Copy the content of ``field_and_instance`` subdirectory to the VM instance.
* Apply the credential to the default user of the VM instance (i.e., ``ec2-user``) using ``aws configure``. Please see http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html
* Locate ``~/.aws/config`` and ``~/.aws/credentials``. Copy the files to the ``field_and_instance`` subdirectory.
* Create 3 aliases for field, field2, and instance world

  * ``aws gamelift create-alias --name "Field alias" --routing-strategy "Type=TERMINAL,Message=field"``
  * ``aws gamelift create-alias --name "Field 2 alias" --routing-strategy "Type=TERMINAL,Message=field2"``
  * ``aws gamelift create-alias --name "Instance alias" --routing-strategy "Type=TERMINAL,Message=instance"``

* Open up ``MANIFEST/field/MANIFEST.json`` and locate ``field_alias``, ``field2_alias``, and ``instance_alias`` in the file. Fill the generated alias values here.
* Also, locate ``db_mysql_server_address`` and ``zookeeper_nodes``. In these field, fill in the public IP address of the EC2 instance we just installed MySQL.
* Open up ``MANIFEST/instance/MANIFEST.json`` and repeat the steps.

* Upload the content to GameLift using ``aws gamelift upload-build --operating-system AMAZON_LINUX --build-root . --name "GameLift demo build" --build-version "0.0.1"``
* The command above will emit a build ID. Copy the value.
* Create game lift fleets using these commands and the build ID:

  * Create a fleet for the first field server: ``aws gamelift create-fleet --name "Field fleet" --build-id "${YOUR_BUILD_ID}" --ec2-instance-type "t2.medium" --runtime-configuration "ServerProcesses=[{LaunchPath=/local/game/launcher_field.sh,ConcurrentExecutions=1}]" --new-game-session-protection-policy "NoProtection" --ec2-inbound-permissions "FromPort=8000,ToPort=9000,IpRange=0.0.0.0/0,Protocol=TCP"``
  * Create a fleet for the second field server: ``aws gamelift create-fleet --name "Field 2 fleet" --build-id "${YOUR_BUILD_ID}" --ec2-instance-type "t2.medium" --runtime-configuration "ServerProcesses=[{LaunchPath=/local/game/launcher_field.sh,ConcurrentExecutions=1}]" --new-game-session-protection-policy "NoProtection" --ec2-inbound-permissions "FromPort=8000,ToPort=9000,IpRange=0.0.0.0/0,Protocol=TCP"``
  * Create a fleet for the instance world server: ``aws gamelift create-fleet --name "Instance fleet" --build-id "${YOUR_BUILD_ID}" --ec2-instance-type "t2.medium" --runtime-configuration "ServerProcesses=[{LaunchPath=/local/game/launcher_instance.sh,ConcurrentExecutions=1}]" --new-game-session-protection-policy "NoProtection" --ec2-inbound-permissions "FromPort=8000,ToPort=9000,IpRange=0.0.0.0/0,Protocol=TCP"``

* Go to the GameLift dashboard and update an alias for each fleet type. Also, change the alias type to ``SIMPLE``.
* Increase the capacity of the fleet of the instance world server: ``aws gamelift update-fleet-capacity --fleet_id "${YOUR_INSTANCE_FLEET_ID}" --desired-instances 5 --max-size 5``


## To deploy the login server and the chatting server (to EC2)

* Get an Amazon Linux instance from EC2.
* Copy the content of ``login_and_chat`` subdirectory to the VM instance.
* Please make sure you apply the AWS credential to the default user of the VM instance (i.e., ``ec2-user``)
* As with the field server and the instnace world server, fill aliases in ``MANIFEST/login/MANIFEST.json`` and fill the public IP of the database VM.
* Run ``install.sh``
* After the installation script finishes, run ``sudo start gamelift_demo.login`` and ``sudo start gamelift_demo.chat``.

