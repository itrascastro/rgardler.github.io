# There is currently (5/31/2015) a bug in docker-machine/boot2docker that
# means shared folders do not work as expected. To work around this
# bug run the following script (after editing the last line) each time you 
# provsiion a hyper-v docker-machine.

read -p "What is the name of the Docker machine you want to configure?" DEV_MACHINE_NAME
echo
read -p "What is the username for your Windows user account?" USER_NAME
echo
read -s -p "What is the password for the user account '$USER_NAME'?" USER_PASSWORD
echo
read -p "What is the IP of your client machine?" CLIENT_IP
echo

echo "Configuring $DEV_MACHINE_NAME"

docker-machine ssh $DEV_MACHINE_NAME wget http://distro.ibiblio.org/tinycorelinux/5.x/x86/tcz/cifs-utils.tcz
docker-machine ssh $DEV_MACHINE_NAME -- tce-load -i cifs-utils.tcz
docker-machine ssh $DEV_MACHINE_NAME mkdir project

CLIENT_DIR=`echo $PWD | cut -c 3-`
echo "Mounting //$CLIENT_IP$CLIENT_DIR as $PWD"
docker-machine ssh $DEV_MACHINE_NAME -- "sudo mount -t cifs //$CLIENT_IP$CLIENT_DIR $PWD -o user=$USER_NAME,password=$USER_PASSWORD"

docker run --rm -v "/$PWD:/src" -p 4000:4000 --name jekyll grahamc/jekyll serve -H $CLIENT_IP --drafts --force_polling
