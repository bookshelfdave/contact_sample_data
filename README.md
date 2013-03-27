Contact Sample Data
===================

Sample data for [Contact](https://github.com/metadave/contact).

## Google Stock

To use this sample data:

	./contact.sh --infile ~/src/contact_sample_data/google/google.contact
	
	
All data will be stored in a bucket named "Google" as JSON. The key is the date of the stock value.

#### To render the stock data:

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
  High:null
  Volume:8924300
```


#License
http://www.apache.org/licenses/LICENSE-2.0.html
