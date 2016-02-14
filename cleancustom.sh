while read line
do
	for i in $(find out/target/product/codina/ -name "$line")
	do
		rm -fr $i
	done
done < $1
