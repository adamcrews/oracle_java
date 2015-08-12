#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with oracle_java](#setup)
    * [What oracle_java affects](#what-oracle_java-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with oracle_java](#beginning-with-oracle_java)
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
* The default install path is /usr/java
* The latest version installed will be linked as /usr/java/default
* /etc/alternatives/java will be updated to look at the default install


### TODO: fix from here down!!!
### Beginning with oracle_java

The very basic steps needed for a user to get the module up and running. 

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
