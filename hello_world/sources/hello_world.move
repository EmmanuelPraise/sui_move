/// Creating a `module` keyword followed by the package address, module name, semicolon.
/// Module: hello_world
module hello_world::hello_world; 

// Module body starts here

use std::string::String; // Importing the String type from the standard library
use sui::address; // Importing the address type from the sui library

public fun hello_world(): String {
    b"Hello, World!".to_string()
}

public fun learn() {

    // Pimitive data types in Move:
    // bool - boolean type, either true or false
    // Unsigned Integers - u8 (8-bit), u16 (16-bit), u32 (32-bit), u64 (64-bit), u128 (128-bit), 256 (256-bit)
    // address - 32-byte address type
    // String - a UTF-8 encoded string type


    // Variable declaration and initialization in Move
    // let <variable_name>[: <type>]  = <expression>; // immutable variable by default
    // let mut <variable_name>[: <type>] = <expression>; // mutable variable

    // Where:

    // <variable_name> - the name of the variable
    // <type> - the type of the variable, optional
    // <expression> - the value to be assigned to the variable

    // Boolean variables
    // bool - a boolean value, either true or false
    let is_true: bool = true;
    let is_integer: bool = false;

    // Unsigned Integer Variables
    let x: u8 = 2;
    let y: u16 = 4;
    let z: u32 = 6;
    let w: u64 = 8;

    // Type casting in Move
    //<expression> as <type>; // type casting expression
    let a: u8 = 42;
    let b: u16 = a as u16; // The "as" keyword is used for type casting in Move.
    let m = 2 * (x as u16); // ambiguous, requires parentheses

    // Arithmetic operations in Move
    // <expression1> <operator> <expression2>
    // Supported operators: +, -, *, %, /
    // Note: Division (/) is truncating division for integer types.

    let c = a + x; // Addition
    let d = a - x; // Subtraction
    let e = a * x; // Multiplication
    let f = a % x; // Modulus
    let g = a / x; // Truncating Division

    let h: u256 = (a as u256) + (b as u256) + (z as u256) + (w as u256);

    // address literal
    // address is a special type in Move to represent addresses. It is a 32-byte value that can represent any address on the blockchain. It starts with the @ symbol followed by a hexadecimal number or an identifier.
    let value: address = @0x1;

    // named address registered in Move.toml
    let value = @std;
    let other = @sui;

    // Conversion: Converting between address and other types
    // Example: Convert an address to a u256 type and back.
    let addr_as_u256: u256 = address::to_u256(@0x1);
    let addr = address::from_u256(addr_as_u256);


    // Example: Convert an address to a vector<u8> type and back.
    let addr_as_u8: vector<u8> = address::to_bytes(@0x1);
    let addr = address::from_bytes(addr_as_u8);

    // Example: Convert an address into a string.
    let addr_as_string: String = address::to_string(@0x1);

    // Blocks in Move
    // A block is a sequence of statements and expressions enclosed in curly braces `{}`.
    // Blocks can be used to group multiple statements together and can also be used as expressions that return a value.
    // block with an empty expression, however, the compiler will
    // insert an empty expression automatically: `let none = { () }`
    // let none = {};

    // block with let statements and an expression.
    let sum = {
        let a = 1;
        let b = 2;
        a + b // returned value of the block.
    };

    // block is an expression, so it can be used in an expression and
    // doesn't have to be assigned to a variable.
    {
        let a = 1;
        let b = 2;
        a + b; // not returned - it has a semicolon.
        // compiler automatically inserts an empty expression `()`
    };

}


// Functions in Move
// A function call is an expression that calls a function and returns the value of the last expression in the function body, provided the last expression does not have a terminating semi-colon.
fun add(a: u8, b: u8): u8 {
    a + b
}

#[test]
fun some_other() {
    let sum = add(1, 2); // not returned due to the semicolon.
    // compiler automatically inserts an empty expression `()` as return value of the block
}

// End of file