#!/bin/bash
<<doc
name:shreyas Rai k 
Date:03/10/2022
Description:
sample i/p:
sample o/p:
doc
b=y
while [ $b = "y" ]
do
    echo "1.sign up"
    echo "2.sign in"
    echo "3.exit"
    read -p "enter the choice:-" choice
    case $choice in
	1)
	    flag=0
	    while [ $flag -eq 0 ]
	    do
		flag=1
		read -p "USER NAME:-" name
		array=(`cat user.csv`)
		for i in ${array[*]}
		do
		    if [ $name = $i ] 
		    then
			echo "Sorry username exists try another"
			flag=0
		    fi
		done
	    done
	    if [ $flag -eq 1 ]
	    then
		echo "$name">>user.csv
		while [ $flag -eq 1 ]
		do
		    echo "enter the password";read -s password
		    count=0
		    while [ $flag -eq 1 ]
		    do
			echo "reconfirm the password";read -s  confirm
			if [ $password = $confirm ]
			then
			    echo "$password">>password.csv
			    echo "password set successfully"
			    flag=0
			else
			    echo "password doesn't matches"
			    count=$(($count + 1))
			    if [ $count -eq 2 ]
			    then
				flag=0

			    fi
			fi
		    done
		done
	    fi
		;;
	2)
	    variable=0
	    while [ $variable -eq 0 ]
	    do
		flag=0
		read -p "USERNAME" username
		user=(`cat user.csv`)
		count=0
		for i in ${user[*]}
		do
		    if [ $username = $i ]
		    then
			flag=1
			variable=$(($variable+1))
			break
			fi
			count=$((count + 1))
		done
		if [ $flag -eq 0 ]
		then
		    echo "Error : Username doesnot found"
		fi
	    done
	    flag2=0
	    while [ $variable -eq 1  -a $flag2 -lt 2 ]
	    do
		echo "enter the password";read -s password
		new=(`cat password.csv`)
		if [ $password = ${new[$count]} ]
		then
		    echo " logged in successfully "
		    flag3=1
		    variable=$(($variable +1))
		else
		    flag2=$(($flag2 +1))
		    flag3=0
		    echo "enter the password correctly"
		fi
	    done

	    if [ $flag3 -eq 1 ]
	    then
	    echo "1.take the test"
	    echo "2.exit "
	    read -p "enter the choice " choice
	    fi

	    case $choice in
		1)
		    #echo -n "" > userans.txt
		    totallines=`cat question.txt |wc -l`
		    #echo "$totallines"
		    for i in  `seq 5 5 $totallines`
		    do

			head -$i question.txt | tail -5


			for i in `seq 5 -1 1`
			do
			    flag=0
			    echo  -ne "\rselect the option : $i \c"
			    read -t 1  option
			    if [ -n "$option" ]
			    then
				flag=1
				echo "$option">>userans.txt
				break
			    fi


			done
			if [ $flag -eq 0 ]
			then
			    echo "e" >>userans.txt
			fi
		    done
	    

		    echo "--------------------answers---------------"
		    correct=(`cat correctans.txt |tr "\n" " "`)
		    ans=(`cat userans.txt |tr "\n" " "`)
		    j=0
		    count=0
		    for i in `seq 5 5 $totallines`
		    do
			head -$i question.txt | tail -5

			if [ ${ans[j]} = ${correct[j]} ]
			then
			    echo -e "\e[92mcorrect answer"
			    echo -e "\e[92myour answer:${ans[j]}"
			    echo -e  "\e[92mcorrect answer:${correct[j]}"
			    echo -e "\e[39m"

			    count=$(($count+1))
			elif [ ${ans[j]} = "e" ]
			then
			    echo -e "\e[91mtimed out question"
                            echo -e  "\e[92mcorrect answer:${correct[j]}"
			    echo -e "\e[39m"
			else
                            echo -e "\e[91mwrong answer"
			    echo -e "\e[91myour answer:${ans[j]}"
			    echo -e  "\e[92mcorrect answer:${correct[j]}"
			    echo -e "\e[39m"
			fi
			j=$(($j+1))
		    done
		    echo "marks awarded is $count out of 5"
	    

		    ;;
		2)
		    b=n
		    ;;
	    esac


	    ;;
	3)
	    b=n
	    ;;
	*)
	    echo "enter the correct option"
	    ;;
    esac
done
