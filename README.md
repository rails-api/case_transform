# case_transform
Extraction of the key_transform abilities of ActiveModelSerializers

[![Build Status](https://travis-ci.org/saiqulhaq/case_transform.svg?branch=master)](https://travis-ci.org/saiqulhaq/case_transform)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0050890b14e7f9165680/test_coverage)](https://codeclimate.com/github/saiqulhaq/case_transform/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/0050890b14e7f9165680/maintainability)](https://codeclimate.com/github/saiqulhaq/case_transform/maintainability)

<!-- vim-markdown-toc GFM -->

* [Install](#install)
* [Usage](#usage)
        * [Transforms](#transforms)

<!-- vim-markdown-toc -->

## Install

```ruby
gem 'case_transform'
```

or

```bash
gem install case_transform
```

And for faster performance, checkout [Case Transform with Native Extensions](https://github.com/NullVoxPopuli/case_transform-rust-extensions)
## Usage

```ruby
require 'case_transform'

CaseTransform.camel_lower(value)
```

`value` can be any of Array, Hash, Symbol, or String.
Any other object type will just be returned.

### Transforms

| &nbsp; | Description |
| --- | --- |
| camel | PascalCase |
| camel_lower | camelCase |
| dash | dash-case |
| underscore | under_score |
| unaltered | pass through |
