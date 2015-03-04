for f in $(find . \( ! -regex '.*/\..*' \) -type f -name "*.js" ! -name "*bootstrap.js*")
do
 js2coffee "$f" > "${f%.*}.coffee"
 rm "$f"
done