#autho bwkc bandara
#update 2018-01-10
#./verify-file-if-exit.sh jan
ext=(-38k.mp4 -130k.mp4 -268k.mp4 -512k.mp4)
channel=(grade-05 grade-06 grade-07 grade-08 grade-09 grade-10 grade-11 vocational-education higher-education)

#thumb missing
#arrlst=(sutta sinhala english)
thumext=(.jpg .d.jpg .m.jpg)
#thumb list missingfunction getThumb
function getThumb
{
lcol=${1%/*}
#col=$(sed 's/.*\///' <<< $lcol)
mlcol=${1##*/}
#match with array
#for al in ${arrlst[@]};do
#if [ "$col" ==  "$al" ];then

#imgline=$(sed "s/${al}/${al}\/thumb/" <<< $1)
imgline=$lcol/thumb/$mlcol
#echo $imgline
for thext in ${thumext[@]};do

if [ ! -f "$imgline$thext" ];then
echo "not found : " $imgline$thext >> $2-thumb-missing.tem
fi
done
#done
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
sedline=$(sed 's/[^\/]*\///;s/-512k.mp4//' <<< $line)
#find 4 file extenstion are exist
getThumb $sedline $flname
for i in ${ext[@]};do
if [ ! -f "$sedline${i}" ]
then
echo "not found : "$sedline${i} >> $flname-missing.tem
fi
done
done < $flname/$1-$index.m3u
((index++))
done
#log create only tem is exist
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

