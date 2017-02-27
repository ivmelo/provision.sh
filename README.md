# provision.sh
Server provisioner for PHP production environments.

This script installs PHP 7.1, Apache, MariaDB and a some php extensions. It also installs other useful tools, such as memcached, beanstalkd and supervisor. It was created based on [this laravel homestead script](https://github.com/laravel/settler/blob/master/scripts/provision.sh).

You can use it to quickly install everything that is needed in order to run a laravel application using a single linux server for app and database. You can tweak this script to make it better suit your needs.

### Usage
```
wget https://raw.githubusercontent.com/ivmelo/provision.sh/master/provision.sh
chmod +x provision.sh
sudo ./provision.sh
```

Then you can follow the prompt on your screen.

### License

The MIT License (MIT)

Copyright (c) 2016 Ivanilson Melo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
