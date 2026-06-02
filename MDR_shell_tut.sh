#!/bin/bash

echo
echo "#########################################################"
echo "#                                                       #"
echo "#            WELCOME TO MDR LINUX TRAINING              #"
echo "#                                                       #"
echo "#########################################################"
echo

echo "Hello, $USER!"
echo "You have successfully downloaded and executed your first Linux script."
echo

read -p "What is your favorite animal? " animal

echo
echo "You answered: $animal"
echo "Unfortunately, that answer is incorrect."
echo "The only acceptable answer in Linux is: Penguin 🐧"
echo

echo "Fun fact: Tux the Penguin has been the official Linux mascot since 1996."
echo

echo "Now I am making you wait to make you think I am doing something important"
sleep 2

echo
echo "##     ## ########  ########"
echo "###   ### ##     ## ##     ##"
echo "#### #### ##     ## ##     ##"
echo "## ### ## ##     ## ########"
echo "##     ## ##     ## ##   ##"
echo "##     ## ##     ## ##    ##"
echo "##     ## ########  ##     ##"
echo
echo "Displaying some cool things on the screen!"
echo

cat << EOF > linux_message.txt
=========================================
     OFFICIAL (fake) MDR LINUX CERTIFICATE
=========================================

User: $USER

Favorite Animal: $animal

Assessment Result:
The only correct answer was Penguin 🐧

Fun Fact:
Tux the Penguin has been the official Linux mascot since 1996.

Achievements Unlocked:
✓ Downloaded a script from GitHub
✓ Changed file permissions with chmod
✓ Executed a script
✓ Created a text file
✓ Joined the MDR Linux community

Inspirational Message:
"Much to learn, you still have."
                    - Yoda 

Welcome to MDR Linux Training!

=========================================
EOF

echo "A certificate has been created:"
echo

ls -lh linux_message.txt

echo
echo "Preview:"
echo "-----------------------------------------"
cat linux_message.txt
echo "-----------------------------------------"
echo

echo "Mission accomplished, $USER! 🚀"
echo
echo "Try these commands next:"
echo "  cat linux_message.txt"
echo "  head linux_message.txt"
echo "  tail linux_message.txt"
echo "  grep Penguin linux_message.txt"
echo "  wc -l linux_message.txt"
echo
