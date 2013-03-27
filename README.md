Contact Sample Data
===================

Sample data for [Contact](https://github.com/metadave/contact).

## Google Stock

To use this sample data:

0) Be sure that you have [Level DB](http://docs.basho.com/riak/latest/tutorials/choosing-a-backend/LevelDB/) enabled in 
Riak. Bitcask does not support secondary indexes.

1) Modify the first connect line in the file google.contact to reflect the IP + port of Riak.

2) Import the data using something like the following command:

	./contact.sh --infile ~/src/contact_sample_data/google/google.contact
	
	
All data will be stored in a bucket named "Google" as JSON. The key is the date of the stock value.

#### To change the default output of the stock data:

If you don't want to look at raw JSON output from Riak, you can create a custom fetch formatter.


```
set action postfetch with javascript 
~%~
if(riak_object != undefined) { 
    var v = riak_object.getValueAsString(); 
    var j = JSON.parse(v);
    out.println("Google data for " + j.date);
    out.println("  Low:" + j.low);
    out.println("  High:" + j.high);
    out.println("  Volume:" + j.volume);
}
~%~;

use bucket "Google";
fetch "2007-05-31";
```

Instead of JSON, this will display:

```
Google data for 2007-05-31
  Low:497.06
  High:508.78
  Volume:8924300
```

### 2i Query

```
use bucket "Google";
query2i with index "year_int" and value "2010";

[2010-04-05, 2010-03-30, 2010-02-18, 2010-01-21, 2010-01-20, 2010-01-06, 2010-01-04, 2010-04-12, 2010-03-22, 2010-03-12, 2010-03-09, 2010-02-24, 2010-02-08, 2010-02-03, 2010-02-01, 2010-04-28, 2010-03-25, 2010-03-24, 2010-01-12, 2010-03-26, 2010-02-05, 2010-01-25, 2010-04-22, 2010-04-21, 2010-04-15, 2010-02-25, 2010-02-16, 2010-01-15, 2010-04-14, 2010-04-06, 2010-03-04, 2010-04-09, 2010-03-08, 2010-05-04, 2010-02-26, 2010-02-23, 2010-02-10, 2010-02-04, 2010-04-26, 2010-04-23, 2010-04-16, 2010-03-19, 2010-02-12, 2010-01-29, 2010-05-05, 2010-04-19, 2010-03-03, 2010-02-17, 2010-03-18, 2010-03-11, 2010-03-23, 2010-01-08, 2010-05-03, 2010-04-13, 2010-03-16, 2010-02-02, 2010-01-05, 2010-04-30, 2010-04-08, 2010-03-29, 2010-03-02, 2010-03-01, 2010-02-22, 2010-01-07, 2010-01-13, 2010-04-29, 2010-04-07, 2010-03-10, 2010-01-28, 2010-03-17, 2010-03-15, 2010-03-05, 2010-01-27, 2010-01-26, 2010-03-31, 2010-02-19, 2010-02-11, 2010-01-22, 2010-01-14, 2010-01-11, 2010-04-20, 2010-04-27, 2010-04-01, 2010-02-09, 2010-01-19]


query2i and fetch with index "year_int" and value "2010";

Google data for 2010-04-09
  Low:564.00
  High:568.77
  Volume:2056600
Google data for 2010-04-05
  Low:569.00
  High:574.88
  Volume:1901500
Google data for 2010-03-30
  Low:560.28
  High:567.63
  Volume:1977900
Google data for 2010-03-08
  Low:561.01
  High:565.18
  Volume:2386400
Google data for 2010-02-18
  Low:536.14
  High:545.01
  Volume:2336900
Google data for 2010-01-21
  Low:572.25
  High:586.82
  Volume:6307700
Google data for 2010-01-20
  Low:575.29
  High:585.98
  Volume:3250700
  ...
```


#License
http://www.apache.org/licenses/LICENSE-2.0.html
