
[![tic](https://github.com/mlampros/nmslibR/workflows/tic/badge.svg?branch=master)](https://github.com/mlampros/nmslibR/actions)
[![codecov.io](https://codecov.io/github/mlampros/nmslibR/coverage.svg?branch=master)](https://codecov.io/github/mlampros/nmslibR?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/nmslibR)](http://cran.r-project.org/package=nmslibR)
[![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/nmslibR?color=blue)](http://www.r-pkg.org/pkg/nmslibR)
<a href="https://www.buymeacoffee.com/VY0x8snyh" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" height="21px" ></a>
[![Dependencies](https://tinyverse.netlify.com/badge/nmslibR)](https://cran.r-project.org/package=nmslibR)


## nmslibR (Non Metric Space Library in R)
<br>


The **nmslibR** package is a wrapper of the [Non-Metric Space Library (NMSLIB)](https://github.com/nmslib/nmslib) *python* package. More details on the functionality of the *nmslibR* package can be found in the [blog-post](http://mlampros.github.io/2018/02/27/the_nmslibR_package/) and in the package Documentation.

<br>


**Reference:**

https://github.com/nmslib/nmslib

https://github.com/nmslib/nmslib/blob/master/manual/latex/manual.pdf


<br>

### **System Requirements**

<br>

* Python (>= 2.7)


<br>

All modules should be installed in the default python configuration (the configuration that the R-session displays as default), otherwise errors will occur during the *nmslibR* package installation (**reticulate::py_discover_config()** might be useful here). 

<br>

The installation notes for *Linux, Macintosh, Windows* are based on *Python 3*.

<br>

#### **Debian/Ubuntu**

<br>

Installation of the system requirements,

<br>

```R

sudo apt-get install python3-pip

sudo pip3 install --upgrade setuptools

sudo pip3 install -U numpy

sudo pip3 install --upgrade scipy

sudo apt-get install libboost-all-dev libgsl0-dev libeigen3-dev

sudo apt-get install cmake

pip3 install --upgrade pybind11

sudo pip3 install nmslib

```

<br>

#### **Fedora**

<br>

Installation of the system requirements,

<br>

```R

dnf install python3-pip

sudo pip3 install --upgrade setuptools

sudo pip3 install -U numpy

sudo pip3 install --upgrade scipy

yum install python3-devel

yum install boost-devel

yum install gsl-devel

yum install eigen3-devel

pip3 install --upgrade pybind11

sudo pip3 install nmslib

```

<br>

#### **Macintosh OSX**

<br>

Upgrade python to version 3 using, 


```R

brew upgrade python

```

<br>

Install the requirements,

<br>

```R

sudo pip3 install --upgrade pip setuptools wheel

sudo pip3 install -U numpy

sudo pip3 install --upgrade scipy

brew install boost

brew install eigen

brew install gsl

brew install cmake

brew link --overwrite cmake

pip3 install --upgrade pybind11

sudo pip3 install nmslib

```
<br>


After a successful installation of the requirements the user should open an R session and give the following *reticulate* command to change to the relevant (brew-python) directory (otherwise the *nmslibR* package won't work properly),

<br>

```R

reticulate::use_python('/usr/local/bin/python3')


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

C:\Python36;C:\Python36\Scripts


```

<br>

Install the [Build Tools for Visual Studio](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017)

<br>

Open the Command prompt (console) and install / upgrade the system requirements,

<br>

```R

pip3 install --upgrade pip setuptools wheel

pip3 install -U numpy

pip3 install --upgrade scipy

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

pip3 install --upgrade pybind11

pip3 install nmslib

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

and to download the latest version from Github use the *install_github* function of the *remotes* package,
<br><br>

```R

remotes::install_github(repo = 'mlampros/nmslibR')

```
<br>
Use the following link to report bugs/issues,
<br><br>

[https://github.com/mlampros/nmslibR/issues](https://github.com/mlampros/nmslibR/issues)

<br>

### **Citation:**

If you use the code of this repository in your paper or research please cite both **nmslibR** and the **original articles / software** [https://CRAN.R-project.org/package=nmslibR/citation.html](https://CRAN.R-project.org/package=nmslibR/citation.html):

<br>

```R
@Manual{,
  title = {{nmslibR}: Non Metric Space (Approximate) Library in R},
  author = {Lampros Mouselimis},
  year = {2021},
  note = {R package version 1.0.6},
  url = {https://CRAN.R-project.org/package=nmslibR},
}
```

<br>

