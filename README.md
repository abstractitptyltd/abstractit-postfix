abstractitptyltd-postfix
====

####Table of Contents

1. [Overview - What is the postfix module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with postfix](#setup)
4. [Usage - The parameters available for configuration](#usage)
5. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)

Overview
--------

Puppet module for managing Postfix with puppet

Module Description
------------------



Setup
-----

**what postfix affects:**

* the postfix sericve
* configuration files for postfix

### Beginning with postfix

This will manage a basic setup for postfix.

    include postfix

Usage
-----


Implementation
--------------

Uses files based on templates to manage the postfix configuration files

Limitations
------------

There may be some. Don't hesitate to let me know if you find any.

Development
-----------

All development, testing and releasing is done by me at this stage.
If you wish to join in let me know.

Release Notes
-------------

Check CHANGELOG.md