#[macro_use]
extern crate helix;
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

declare_types! {
    reopen class RubyString {
        def to_snake_case(self) -> String {
            self.to_string().to_snake_case()
        }

        def to_camel_case(self) -> String {
            self.to_string().to_camel_case()
        }

        def to_class_case(self) -> String {
            self.to_string().to_class_case()
        }

        def to_kebab_case(self) -> String {
            self.to_string().to_kebab_case()
        }
    }
}


// TODO: Helix is eventually going to implement this
use helix::{UncheckedValue, ToRust};

impl ToString for RubyString {
    fn to_string(&self) -> String {
        let checked = self.0.to_checked().unwrap();
        checked.to_rust()
    }
}
