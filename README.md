# key_transform
Extraction of the key_transform abilities of ActiveModelSerializers

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
