<!-- vim-markdown-toc GFM -->

+ [case_transform2](#case_transform2)
        * [Why](#why)
        * [Install](#install)
        * [Usage](#usage)
        * [Transforms](#transforms)
        * [NOTE](#note)

<!-- vim-markdown-toc -->

# case_transform2

[![Build Status](https://travis-ci.org/saiqulhaq/case_transform.svg?branch=master)](https://travis-ci.org/saiqulhaq/case_transform)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0050890b14e7f9165680/test_coverage)](https://codeclimate.com/github/saiqulhaq/case_transform/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/0050890b14e7f9165680/maintainability)](https://codeclimate.com/github/saiqulhaq/case_transform/maintainability)


Transforms string letter case to camel, snake, dash and underscore without activesupport dependencies.  
Forked from [Rails API CaseTransform gem](https://github.com/rails-api/case_transform)

## Why

We want a simple string method without polluting String class and lightweight.  
If you want to use this into Rails application or any Ruby application with activesupport dependencies, 
you might want to consider [the original one instead.](https://github.com/rails-api/case_transform)

## Install

```ruby
gem 'case_transform2'
```

or

```bash
gem install case_transform2
```

## Usage

```ruby
require 'case_transform2'

value = "hello_world"
CaseTransform.camel_lower(value) # => helloWorld

value = "hello_world"
CaseTransform.camel(value) # => HelloWorld

value = "hello_world"
CaseTransform.dash(value) # => hello-world

value = "helloWorld"
CaseTransform.underscore(value) # => hello_world
```

`value` can be any of Array, Hash, Symbol, or String.
Any other object type will just be returned.

## Transforms

| &nbsp; | Description |
| --- | --- |
| camel | PascalCase |
| camel_lower | camelCase |
| dash | dash-case |
| underscore | under_score |

## NOTE

There is no `CaseTransform.unaltered` method like the original gem has

License MIT
