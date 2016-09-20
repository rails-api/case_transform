#[macro_use]
extern crate ruru;
extern crate inflector;

// // dash: kebab-case
// use inflector::cases::kebabcase::to_kebab_case;
// // underscore: snake_case
// use inflector::cases::snakecase::to_snake_case;
// // camel_lower: camelCase
// use inflector::cases::camelcase::to_camel_case;
// // camel: ClassCase (PascalCase)
// use inflector::cases::classcase::to_class_case;
use inflector::Inflector;

use ruru::{Class, Object, RString, Hash};

methods! (
    RString,
    itself,

    fn toSnakeCase() -> RString {
        RString::new(&itself.to_string().to_snake_case())
    }

    fn toCamelCase() -> RString {
        RString::new(&itself.to_string().to_camel_case())
    }

    fn toClassCase() -> RString {
        RString::new(&itself.to_string().to_class_case())
    }

    fn toKebabCase() -> RString {
        RString::new(&itself.to_string().to_kebab_case())
    }
);

// methods! (
//     Hash,
//     itself,
//
//     fn deepTransformKeys() -> Hash {
//         let result = Hash::new()
//         itself.each(|key, value| {
//             result.store(key, value)
//         });
//     }
// );

#[no_mangle]
pub extern fn initialize_case_transform() {
    Class::from_existing("String").define(|itself| {
        itself.def("to_snake_case", toSnakeCase);
        itself.def("to_camel_case", toCamelCase);
        itself.def("to_class_case", toClassCase);
        itself.def("to_kebab_case", toKebabCase);
    });
}
