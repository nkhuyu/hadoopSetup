#!/bin/bash

# pi example
hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar pi 2 5

# word count
if hadoop fs -test –d output;
then
    hadoop fs -rm -r output
fi

if hadoop fs -test -d input;
then
    hadoop fs -rm -r input
    hadoop fs -mkdir input
fi

hadoop fs -copyFromLocal input/* input/.

hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/sources/hadoop-mapreduce-examples-2.2.0-sources.jar org.apache.hadoop.examples.WordCount input output
