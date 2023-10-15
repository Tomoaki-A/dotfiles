cat ./extensions | while read line
do
  code-insiders --install-extension $line
done