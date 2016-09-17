#[macro_use]
extern crate helix;
extern crate inflector;

// dash: kebab-case
use inflector::cases::kebabcase::to_kebab_case;
// underscore: snake_case
use inflector::cases::snakecase::to_snake_case;
// camel_lower: camelCase
use inflector::cases::camelcase::to_camel_case;
// camel: ClassCase (PascalCase)
use inflector::cases::classcase::to_class_case;

// let camel_case_string: String = "some_string".to_string().to_camel_case();

declare_types! {
    reopen class RubyString {
        def to_snake_case(self) -> String {
            to_snake_case(self.to_string());
        }

        def to_camel_case(self) -> String {
            to_camel_case(self.to_string());
        }

        def to_class_case(self) -> String {
            to_class_case(self.to_string());
        }

        def to_kebab_case(self) -> String {
            to_kebab_case(self.to_string());
        }
    }
}
