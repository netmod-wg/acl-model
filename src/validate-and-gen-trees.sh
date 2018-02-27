#!/bin/sh

for i in yang/*\@$(date +%Y-%m-%d).yang
do
    name=$(echo $i | cut -f 1 -d '.')
    echo "Validating $name.yang"
    if test "${name#^example}" = "$name"; then
        response=`pyang --lint --strict --canonical -p ../ -f tree --max-line-length=72 --tree-line-length=69 $name.yang > $name-tree.txt.tmp`
    else            
        response=`pyang --ietf --strict --canonical -p ../ -f tree --max-line-length=72 --tree-line-length=69 $name.yang > $name-tree.txt.tmp`
    fi
    if [ $? -ne 0 ]; then
        printf "$name.yang failed pyang validation\n"
        printf "$response\n\n"
        echo
        exit 1
    fi
    fold -w 71 $name-tree.txt.tmp > $name-tree.txt
    response=`yanglint -p ../../ $name.yang`
    if [ $? -ne 0 ]; then
        printf "$name.yang failed yanglint validation\n"
        printf "$response\n\n"
        echo
        exit 1
    fi
done
rm yang/*-tree.txt.tmp

echo "Validating examples"

echo "Validating Section 4.3"
response=`yanglint -s -p ../../ yang/ietf-access-control-list\@$(date +%Y-%m-%d).yang ../src/yang/example-acl-configuration-4.3.xml`
if [ $? -ne 0 ]; then
  printf "failed (error code: $?)\n"
  printf "$response\n\n"
  echo
  exit 1
fi

echo "Validating Section 4.4.1"
response=`yanglint -s -p ../../ yang/ietf-access-control-list\@$(date +%Y-%m-%d).yang ../src/yang/example-acl-configuration-4.4.1.xml`
if [ $? -ne 0 ]; then
  printf "failed (error code: $?)\n"
  printf "$response\n\n"
  echo
  exit 1
fi

echo "Validating Section 4.4.2"
response=`yanglint -s -p ../../ yang/ietf-access-control-list\@$(date +%Y-%m-%d).yang ../src/yang/example-acl-configuration-4.4.2.xml`
if [ $? -ne 0 ]; then
  printf "failed (error code: $?)\n"
  printf "$response\n\n"
  echo
  exit 1
fi

echo "Validating Section 4.4.3"
response=`yanglint -s -p ../../ yang/ietf-access-control-list\@$(date +%Y-%m-%d).yang ../src/yang/example-acl-configuration-4.4.3.xml`
if [ $? -ne 0 ]; then
  printf "failed (error code: $?)\n"
  printf "$response\n\n"
  echo
  exit 1
fi

echo "Validating Section 4.4.4"
response=`yanglint -s -p ../../ yang/ietf-access-control-list\@$(date +%Y-%m-%d).yang ../src/yang/example-acl-configuration-4.4.4.xml`
if [ $? -ne 0 ]; then
  printf "failed (error code: $?)\n"
  printf "$response\n\n"
  echo
  exit 1
fi
