## Sequence 

SequenceFile is a flat file consisting of binary key/value pairs. It is extensively used in MapReduce as input/output formats. It is also worth noting that, internally, the temporary outputs of maps are stored using SequenceFile.
It can be:
  1. Uncompressed
  2. Record Compressed
  3. Block Compressed

# Avro

Avro is an Apache™ open source project that provides data serialization and data exchange services for Hadoop®. 
Avro stores both the data definition and the data together in one message.
Avro stores the data definition in JSON format making it easy to read and interpret, the data itself is stored in binary format making it compact and efficient.
Avro files include markers that can be used to splitting large data sets into subsets 
Some data exchange services use a code generator to interpret the data definition and produce code to access the data. Avro doesn't require this step, making it ideal for scripting languages.
Avro supports a rich set of primitive data types including: numeric, binary data and strings; and a number of complex types including arrays, maps, enumerations and records.
A sort order can also be defined for the data.
Data stored using Avro can easily be passed from a program written in one language to a program written in another language, even from a complied language like C to a scripting language like Pig

[Video of Avro](https://youtu.be/3BOkW1iVQOQ)


# Parquet

Using Parquet at Twitter, we experienced a reduction in size by one third on our large datasets.
There are several advantages to columnar formats.
Organizing by column allows for better compression, as data is more homogenous. The space savings are very noticeable at the scale of a Hadoop cluster.
I/O will be reduced as we can efficiently scan only a subset of the columns while reading the data. Better compression also reduces the bandwidth required to read the input.