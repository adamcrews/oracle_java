# Oracle Java Puppet module

[![Puppet Forge Version](http://img.shields.io/puppetforge/v/adamcrews/oracle_java.svg)](https://forge.puppetlabs.com/adamcrews/oracle_java)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/adamcrews/oracle_java.svg)](https://forge.puppetlabs.com/adamcrews/oracle_java)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/f/adamcrews/oracle_java.svg)](https://forge.puppetlabs.com/adamcrews/oracle_java)
[![Build Status](https://travis-ci.org/adamcrews/oracle_java.svg)](https://travis-ci.org/adamcrews/oracle_java)


#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with oracle_java](#setup)
    * [What oracle_java affects](#what-oracle_java-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module will download, install, and configure the Oracle version
of Java.

## Module Description

You may optionally download the JDK or the JRE for Java 7 or Java 8.
You can manage multiple versions of java on a node.
You may download direct from Oracle, or supply your own download source.
If you are Downloading direct from Oracle, this module assumes you have accepted their license agreement.

## Setup

### What oracle_java affects

* By default the JRE is installed.
* The default install path is /usr/java.
* /etc/alternatives/java can be managed.
* Only the tar.gz packages are used.
* /usr/java/latest and /usr/java/default are not managed.

By using this module with the default `download_url`, you are accepting any license that Oracle places on their distribution of java.

## Usage

* Install the latest supported java:
```puppet
include ::oracle_java
```

* Install multiple versions of java:
```puppet
$jdks = ['7u80', '8u60']
oracle_java::install { $jdks:
  java_type => 'jdk',
}
```

* Manage /etc/alternatives/java:
```puppet
oracle_java::alternative { '8u60': }
```

## Reference

### Classes

`oracle_java`: Installs the latest oracle_java version that is supported by this module into /usr/java and update /etc/alternatives/java

Usage:
```puppet
class { oracle_java:
  $java_type      = 'jre',
  $java_versions  = [ '8u60' ],
}
```

### Defined Types

`oracle_java::install`: Install a specific version of jdk/jre.
* `java_dir`: Sets the base path to install java to, defaults to /usr/java
* `download_url`: The url to download java from. Defaults to Oracle's site.
* `java_type`: Install JRE or JDK, defaults to JRE.
* `arch`: Install the 32 or 64 bit version of java, defaults to match your host.
* `alternatives`: Add an entry to /etc/alteratives, defaults to true.

Example usage:
```puppet
oracle_java::install { '7u40':
  java_dir     => '/usr/java',
  download_url => 'http://download.oracle.com/otn-pub/java/jdk',
  java_type    => 'jre',
  arch         => $::architecture,
  alternatives => true,
}
```
When using the `download_url` parameter, do not include the filename to the java archive.  The file should exist at that url and match the same naming convention that Oracle uses.


`oracle_java::alternative`: Update /etc/alternatives/java
* `java_dir`: The base location of java.  Required parameter.
* `java_type`: Use JRE or JDK.  Required parameter.
* `priority`: The priority to use for /etc/alternatives/java.  Defaults to a number derived from the java version.

Example usage:
```puppet
oracle_java::alternative { '8u60':
  java_path => '/usr/java',
  java_type => 'jre',
}
```

## Limitations

Effort has been made to build a supported OS matrix so that if you try to install a version of java on a platform that Oracle does not support, the install should fail.  This functionality is poorly tested.  If you discover errors, please open a ticket.

The rpm packages of java try to manage /usr/java/default and /usr/java/latest.  Until very recently this the rpm packages would often do the wrong thing in creating these links.  This module makes no attempt to manage these links.

## Development

If you wish to contribute, please fork the module, make your changes, add tests, and then submit a PR.
