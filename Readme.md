# Web Scraping Audible

If you like me, listen to audiobooks frequently, you may find yourself listening to multiple series.
But what happens when you're all caught up?  The all too infrequent email updates when a new book had arrived by my favorite author often led me to missing one for weeks, sometimes even months.  
Thus this project was born.

## Getting Started

These instructions will get you started on running the webscraper on your very own, letting you too be notified when your favorite book series has a new book.

### Prerequisites

You will need at least Powershell V4.0.  As we're using Invoke-WebRequest, you'll need to ensure you're atleast running Powershell 4.0.  This is provided in the .NET 4.0 Package, so please, update before trying!

### Installing

So there are 3 main parts to getting this functioning for you.

```
1. Download the check-for-newbook.ps1 and save it to c:\scripts
```
There is no location restriction for the powershell script, and as such, it can be stored anywhere.

```
2. Download the Audible-search.csv to: c:\users\%username%\documents\
```
The %username% should be your windows username.  The ps1 file will look for it in this specific locaiton, so if you're going to change the location it is saved, please change the coresponding line of code.


## Running the Script

To run the script on your system, open powershell, then type: 
```
& "c:\scripts\check-for-newbook.ps1"
```

If you have restrictions set on your machine to not run scripts, you'll need to first set the restriction policy to something that will allow the script to be run.  This is easily done from powershell as part of a one-liner, as opposed to setting it permanently.
```
 & "C:\Users\murbano\Documents\Check-For-New-Book.ps1" -ExecutionPolicy Bypass
```
### Modifying the CSV File

The CSV file has two basic needs, a Title of a Book, and a url to search.
Adding the title: "Book 4" can be exactly the solution you need, but you can get as indepth as you like.
The URL should always be the series you're searching in question.  If you sort by the author, you may end up with mixed results if you don't give a detailed book title.

### Seeing it in action

If you wish to see the script in action, change the csv to contain the title of a book already released, then run the script again.  You should see a popup telling you that a book has been released.

### TODO

My Laundry list of todo items;
```
Read from wishlist
Enable Deletion of CSV upon prompting user that there is a new book (option to delete)
Option to add book to cart?
```

## Authors

* **Matt Urbano** - [burn56](https://github.com/burn56)
