#!/bin/bash
#change page count and destination link
for i in {1..184} 
do
	curl -Ss https://www.realtor.com/realestateagents/tampa_fl/photo-1/pg-${i} | grep -Eoi "<script id=\"__NEXT_DATA__\" type=\"application\/json\">(.+?)<\/script>" | cut -c "52-" | sed 's/.........$//' | jq -r '.props.pageProps.pageData.agents[] | select(.email != null) | {email, name} | [.[]] | @csv' >> ~/tempinfo
	r=$(($RANDOM%5+1));
	echo "crawl page $i, sleep $r";
	sleep $r;
done
echo "email,name" > ~/agentinfo.csv && cat ~/tempinfo >> ~/agentinfo.csv;
