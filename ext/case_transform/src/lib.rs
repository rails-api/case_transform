#[macro_use]
extern crate ruru;
extern crate inflector;

use inflector::cases::{camelcase, classcase, kebabcase, snakecase};

use ruru::{Class, Object, VerifiedObject, RString, Hash, Array, Symbol, AnyObject};
use ruru::types::ValueType;
use ruru::result::Error as RuruError;

trait Transform: Object {
    fn transform(&self, transform_function: &Fn(String) -> String) -> AnyObject;
}

impl Transform for AnyObject {
    fn transform(&self, _transform_function: &Fn(String) -> String) -> AnyObject {
        self.clone()
    }
}

impl Transform for RString {
    fn transform(&self, transform_function: &Fn(String) -> String) -> AnyObject {
        let result = transform_function(self.to_string();

        RString::new(&result)).to_any_object()
    }
}

impl Transform for Symbol {
    fn transform(&self, transform_function: &Fn(String) -> String) -> AnyObject {
        let result = transform_function(self.to_string());

        Symbol::new(&result).to_any_object()
    }
}

impl Transform for Hash {
    fn transform(&self, transform_function: &Fn(String) -> String) -> AnyObject {
        let mut result = Hash::new();

        self.each(|key, value| {
            let new_key = transform(key, transform_function);
            let new_value = match value.ty() {
                ValueType::Hash => transform(value, transform_function),
                _ => value,
            };

            result.store(new_key, new_value);
        });

        result.to_any_object()
    }
}

impl Transform for Array {
    fn transform(&self, transform_function: &Fn(String) -> String) -> AnyObject {
        // Temp hack to consume &self for iterator
        let result = unsafe { self.to_any_object().to::<Array>() };

        result.into_iter()
            .map(|item| transform(item, transform_function))
            .collect::<Array>()
            .to_any_object()
    }
}

trait TryTransform: Object {
    fn try_transform<T>(&self,
                        transform_function: &Fn(String) -> String)
                        -> Result<AnyObject, RuruError>
        where T: VerifiedObject + Transform
    {
        self.try_convert_to::<T>().map(|object| object.transform(transform_function))
    }
}

impl TryTransform for AnyObject {}

fn transform(object: AnyObject, key_transform: &Fn(String) -> String) -> AnyObject {
    let result = object.try_transform::<RString>(key_transform)
        .or_else(|_| object.try_transform::<Symbol>(key_transform))
        .or_else(|_| object.try_transform::<Array>(key_transform))
        .or_else(|_| object.try_transform::<Hash>(key_transform))
        .or_else(|_| object.try_transform::<AnyObject>(key_transform));

    result.unwrap()
}

fn to_pascal_case(key: String) -> String {
    classcase::to_class_case(snakecase::to_snake_case(key))
}

fn to_camel_case(key: String) -> String {
    camelcase::to_camel_case(snakecase::to_snake_case(key))
}

fn to_dashed_case(key: String) -> String {
    kebabcase::to_kebab_case(snakecase::to_snake_case(key))
}

fn to_snake_case(key: String) -> String {
    snakecase::to_snake_case(key)
}

class!(CaseTransform);

methods! (
    CaseTransform,
    _itself,

    fn camel(object: AnyObject) -> AnyObject { transform(value.unwrap(), &to_pascal_case) }
    fn camel_lower(object: AnyObject) -> AnyObject { transform(object.unwrap(), &to_camel_case) }
    fn dash(object: AnyObject) -> AnyObject { transform(object.unwrap(), &to_dashed_case) }
    fn underscore(object: AnyObject) -> AnyObject { transform(object.unwrap(), &to_snake_case) }
    fn unaltered(object: AnyObject) -> AnyObject { object.unwrap() }
);

#[no_mangle]
pub extern "C" fn initialize_case_transform() {
    Class::from_existing("CaseTransform").define(|itself| {
        itself.def_self("camel", camel);
        itself.def_self("camel_lower", camel_lower);
        itself.def_self("dash", dash);
        itself.def_self("underscore", underscore);
        itself.def_self("unaltered", unaltered);
    });
}
