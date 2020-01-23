var=${1:1:-1} 	# to del a char => $text//,
var2=${var//,/' '}
array=($var2)
echo ${array}
