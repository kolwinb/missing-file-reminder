#author bwkc bandara
#updated 2018-01-10
#./verify-file-if-exit.sh jan
ext=(-144p.mp4 -360p.mp4 -480p.mp4)
channel=(dharmavahini bhavana)
arrlst=(sutta sinhala english)
thumext=(-original-1.jpg -632x395-1.jpg -416x260-1.jpg -168x105-1.jpg)
#thumb list missingfunction getThumb
function getThumb
{
lcol=${1%/*}
col=$(sed 's/.*\///' <<< $lcol)

#match with array
for al in ${arrlst[@]};do
if [ "$col" ==  "$al" ];then

imgline=$(sed "s/${al}/${al}\/thumb/" <<< $1)
#echo $imgline
for thext in ${thumext[@]};do

if [ ! -f "$imgline$thext" ];then
echo "not found : " $imgline$thext >> $2-thumb-missing.tem
fi
done
fi
done
}


#explore
for fl in ${channel[@]};do
flname=${fl}
#remove exist log file
rm $flname-missing.log
rm $flname-thumb-missing.log
#loop through whole dates
index=1
while [ $index -lt 31 ];do
#read specific playlist
while read line;do
sedline=$(sed 's/[^\/]*\///;s/-480p.mp4//' <<< $line)
getThumb $sedline $flname
#find 4 file extenstion are exist
for i in ${ext[@]};do
if [ ! -f "$sedline${i}" ]
then
echo "not found : "$sedline${i} >> $flname-missing.tem
fi
done
done < $flname/$1-$index.m3u
((index++))
done

if [ -f "$flname-missing.tem" ]
then
sort $flname-missing.tem | uniq > $flname-missing.log
rm -f $flname-missing.tem
fi

if [ -f "$flname-thumb-missing.tem" ]
then
sort $flname-thumb-missing.tem | uniq > $flname-thumb-missing.log
rm -f $flname-thumb-missing.tem
fi

done
