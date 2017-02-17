# provision.sh
PHP provisioner for production environments.

This script installs PHP 7.1, Apache, MariaDB and a some php extensions. It also installs other useful tools, such as memcached, beanstalkd and supervisor. It was created based on [this](https://github.com/laravel/settler/blob/master/scripts/provision.sh) laravel homestead script.

You can use it to quickly install everything that is needed to run a simple laravel application using a single server for app and database. You can tweak this script to make it suit your needs.

### Usage
```
wget https://raw.githubusercontent.com/ivmelo/provision.sh/master/provision.sh
chmod +x provision.sh
sudo ./provision.sh
```

Then you can follow the prompt on your screen.

