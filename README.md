# key_transform
Extraction of the key_transform abilities of ActiveModelSerializers

[![Gem Version](https://badge.fury.io/rb/case_transform.svg)](https://badge.fury.io/rb/case_transform)
[![Build Status](https://travis-ci.org/NullVoxPopuli/case_transform.svg?branch=master)](https://travis-ci.org/NullVoxPopuli/case_transform)
[![Code Climate](https://codeclimate.com/repos/57dafbcc628330006c001312/badges/5f190457aba7c5d5d78c/gpa.svg)](https://codeclimate.com/repos/57dafbcc628330006c001312/feed)
[![Test Coverage](https://codeclimate.com/repos/57dafbcc628330006c001312/badges/5f190457aba7c5d5d78c/coverage.svg)](https://codeclimate.com/repos/57dafbcc628330006c001312/coverage)
[![Dependency Status](https://gemnasium.com/NullVoxPopuli/case_transform.svg)](https://gemnasium.com/NullVoxPopuli/case_transform)

## Install

```ruby
gem 'key_transform'
```

or

```ruby
require 'key_transform'
```
## Usage

```ruby
CaseTransform.camel_lower(value)
```

### Transforms

| &nbsp; | Description |
| --- | --- |
| camel | PascalCase |
| camel_lower | camelCase |
| dash | dash-case |
| underscore | under_score |
| unaltered | pass through |
