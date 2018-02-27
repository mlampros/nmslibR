
## nmslibR (Non Metric Space Library in R)
<br>


The **nmslibR** package is a wrapper of the [Non-Metric Space Library (NMSLIB)](https://github.com/searchivarius/nmslib) *python* package. More details on the functionality of the *nmslibR* package can be found in the package Documentation and Vignette.


<br>

**Reference:**

https://github.com/searchivarius/nmslib

https://github.com/searchivarius/nmslib/blob/master/manual/manual.pdf


<br>

### **System Requirements**

<br>

* Python (>= 2.7)


<br>

All modules should be installed in the default python configuration (the configuration that the R-session displays as default), otherwise errors will occur during the *nmslibR* package installation (**reticulate::py_discover_config()** might be useful here). 

<br>

The installation notes for *Linux, Macintosh, Windows* are based on *Python 2.7*.

<br>

#### **Debian/Ubuntu** 

<br>

Installation of the system requirements,

<br>

```R

sudo pip install --upgrade pip setuptools

sudo pip install -U numpy

sudo pip install --upgrade scipy

sudo apt-get install libboost-all-dev libgsl0-dev libeigen3-dev

sudo apt-get install cmake

sudo pip install nmslib

```

<br>

#### **Fedora** 

<br>

Installation of the system requirements,

<br>

```R

sudo pip install --upgrade pip setuptools

sudo pip install -U numpy

sudo pip install --upgrade scipy

yum install python2-devel

yum install boost-devel

yum install gsl-devel

yum install eigen3-devel

```

<br>

#### **Macintosh OSX** 

<br>


First do a fresh install of python using brew  [ normally the brew-python will appear as python2, because python comes by default in Macintosh OS ]

<br>

```R
brew install python

brew link --overwrite python
```
<br>

Then update the *.bash_profile* file in home directory with the following paths

<br>

```R
export PATH=/usr/local/bin:/usr/bin:$PATH

export PATH="/usr/local/opt/python/libexec/bin:$PATH"
```
<br>

Installation of the system requirements,

<br>

```R

sudo pip2 install --upgrade pip setuptools

sudo pip2 install -U numpy

sudo pip2 install --upgrade scipy

brew install boost

brew install eigen

brew install gsl

brew install cmake

brew link --overwrite cmake

sudo pip2 install nmslib
```
<br>


After a successful installation of the system requirements the user should open an R session and give the following *reticulate* command to change to the relevant (brew-python) directory (otherwise the *nmslibR* package won't work properly),

<br>

```R

reticulate::use_python('/usr/local/bin/python2')


```

<br>

and then,

<br>


```R

reticulate::py_discover_config()


```

<br>

to validate that a user is in the python version where *nmslibR* is installed. 

<br><br>



#### **Windows OS**

<br>

First download of [get-pip.py](https://bootstrap.pypa.io/get-pip.py) for windows

<br>

Update the Environment variables ( Control Panel >> System and Security >> System >> Advanced system settings >> Environment variables >> System variables >> Path >> Edit ) by adding ( for instance in case of python 2.7 ),

<br>

```R

C:\Python27;C:\Python27\Scripts


```

<br>

Install the [Visual C++ 2015 Build Tools](http://landinghub.visualstudio.com/visual-cpp-build-tools)

<br>

Open the Command prompt (console) and install / upgrade the system requirements,

<br>

```R

pip install --upgrade pip setuptools

pip install -U numpy

pip install --upgrade scipy

```

<br>

**Installation of cmake**

<br>

First download cmake for Windows, [win64-x64 Installer](https://cmake.org/download/).
Once the file is downloaded run the **.exe** file and during installation make sure to **add CMake to the system PATH for all users**.

<br>


Then install the *nmslib* library,

<br>

```R

pip install nmslib


```

<br>



### **Installation of the nmslibR package**

<br>

To install the package from CRAN use, 

<br>

```R

install.packages('nmslibR')


```
<br>
