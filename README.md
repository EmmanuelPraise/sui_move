# Sui Move Learning Guide

Learning about the [Move programming language](https://move-book.com/) and the Sui blockchain. Move is a language for writing smart contracts - programs that are stored and run on the blockchain.

## Table of Contents

- [Installation](#installation)
- [Package Management](#package-management)
- [Core Concepts](#core-concepts)
  - [Address](#address)
  - [Account](#account)
  - [Transaction](#transaction)
  - [Module](#module)
- [Move Language Fundamentals](#move-language-fundamentals)
  - [Variables and Assignment](#variables-and-assignment)
  - [Integer Types](#integer-types)
  - [Address Type](#address-type)
  - [Literals](#literals)
  - [Operators](#operators)
  - [Functions in Move](#functions-in-move)
  - [Control Flow Expressions](#control-flow-expressions)

## Installation

### Install Using Chocolatey (Windows)

You can install Sui using the [Chocolatey](https://chocolatey.org/install) package manager for Windows.

```bash
choco install sui
```

### Verify Installation

To check the sui version installed:

```bash
sui client --version
```

It should print the client version. E.g. `sui-client 1.22.0-036299745`.

## Package Management

### What is a Package?

A package is published on the blockchain and is identified by an address. A published package can be interacted with by sending transactions calling its functions. It can also act as a dependency for other packages.

To create a new package, use the `sui move new` command. To learn more about the command, run `sui move new --help`.

### Create a New Package

```bash
sui move new hello_world
```

The `sui move` command gives access to the Move CLI - a built-in compiler, test runner and a utility for all things Move. The `new` command followed by the name of the package will create a new package in a new folder. In our case, the folder name is "hello_world".

```bash
$ ls -l hello_world
Move.toml
sources
tests
```

### Directory Structure

Move CLI will create a scaffold of the application and pre-create the directory structure and all necessary files. Let's see what's inside.

```bash
hello_world
├── Move.toml
├── sources
│   └── hello_world.move
└── tests
    └── hello_world_tests.move
```

### Package Manifest

The `Move.toml` is a manifest file that describes the package and its dependencies. It is written in TOML format and contains multiple sections, the most important of which are `[package]`, `[dependencies]` and `[addresses]`.

## Core Concepts

### Address

Address is a unique identifier of a location on the blockchain. It is used to identify packages, accounts, and objects. Address has a fixed size of 32 bytes and is usually represented as a hexadecimal string prefixed with 0x. Addresses are case insensitive.

Here are some examples of reserved addresses:

- `0x1` - address of the Sui Standard Library (alias std)
- `0x2` - address of the Sui Framework (alias sui)
- `0x6` - address of the system Clock object

### Account

An account is a way to identify a user. An account is generated from a private key, and is identified by an address. An account can own objects, and can send transactions. Every transaction has a sender, and the sender is identified by an address.

Sui supports multiple cryptographic algorithms for account generation. The two supported curves are ed25519, secp256k1, and there is also a special way of generating an account - zklogin. The cryptographic agility - the unique feature of Sui - allows for flexibility in the account generation.

### Transaction

Transaction is a fundamental concept in the blockchain world. It is a way to interact with a blockchain. Transactions are used to change the state of the blockchain, and they are the only way to do so. In Move, transactions are used to call functions in a package, deploy new packages, and upgrade existing ones.

#### Transaction Structure

Every transaction explicitly specifies the objects it operates on!

Transactions consist of:

- a sender - the account that signs the transaction;
- a list (or a chain) of commands - the operations to be executed;
- command inputs - the arguments for the commands: either pure - simple values like numbers or strings, or object - objects that the transaction will access;
- a gas object - the Coin object used to pay for the transaction;
- gas price and budget - the cost of the transaction;

#### Transaction Effects

Transaction effects are the changes that a transaction makes to the blockchain state. More specifically, a transaction can change the state in the following ways:

- use the gas object to pay for the transaction;
- create, update, or delete objects;
- emit events;

The result of the executed transaction consists of different parts:

- Transaction Digest - the hash of the transaction which is used to identify the transaction;
- Transaction Data - the inputs, commands and gas object used in the transaction;
- Transaction Effects - the status and the "effects" of the transaction, more specifically: the status of the transaction, updates to objects and their new versions, the gas object used, the gas cost of the transaction, and the events emitted by the transaction;
- Events - the custom events emitted by the transaction;
- Object Changes - the changes made to the objects, including the change of ownership;
- Balance Changes - the changes made to the aggregate balances of the account involved in the transaction;

### Module

A module is the base unit of code organization in Move. Modules are used to group and isolate code, and all members of the module are private to the module by default.

#### Module Declaration

Modules are declared using the `module` keyword followed by the package address, module name, semicolon, and the module body. The module name should be in snake_case - all lowercase letters with underscores between words. Modules names must be unique in the package.

If you need to declare more than one module in a file, you must use Module Block syntax.

```move
// Module label.
module book::my_module;

// module body
```

## Move Language Fundamentals

### Variables and Assignment

Variables are declared using the `let` keyword. They are immutable by default, but can be made mutable by adding the `mut` keyword:

```move
let <variable_name>[: <type>] = <expression>;
let mut <variable_name>[: <type>] = <expression>;
```

Where:

- `<variable_name>` - the name of the variable
- `<type>` - the type of the variable (optional)
- `<expression>` - the value to be assigned to the variable

Example:

```move
let x: bool = true;
let mut y: u8 = 42;

// A mutable variable can be reassigned using the = operator
y = 43;
```

### Integer Types

Move supports unsigned integers of various sizes, from 8-bit to 256-bit. The integer types are:

- u8 - 8-bit
- u16 - 16-bit
- u32 - 32-bit
- u64 - 64-bit
- u128 - 128-bit
- u256 - 256-bit

```move
let x: u8 = 42;
let y: u16 = 42;
// ...
let z: u256 = 42;
```

#### Operations

Move supports the standard arithmetic operations for integers: addition, subtraction, multiplication, division, and modulus (remainder). The syntax for these operations is:

| Syntax | Operation | Aborts If |
| - | - | - |
| + |addition | Result is too large for the integer type |
| - |subtraction | Result is less than zero |
| * |multiplication | Result is too large for the integer type |
| % |modulus (remainder) | The divisor is 0 |
| / |truncating division | The divisor is 0 |

The types of the operands must match, or the compiler will raise an error. The result of the operation will be of the same type as the operands. To perform operations on different types, the operands need to be cast to the same type.

#### Casting with as

Move supports explicit casting between integer types. The syntax is as follows:

```move
//<expression> as <type>
```

Note that parentheses around the expression may be required to prevent ambiguity:

```move
let x: u8 = 42;
let y: u16 = x as u16;
let z = 2 * (x as u16); // ambiguous, requires parentheses
```

A more complex example, preventing overflow:

```move
let x: u8 = 255;
let y: u8 = 255;
let z: u16 = (x as u16) + ((y as u16) * 2);
```

### Address Type

Move uses a special type called `address` to represent addresses. It is a 32-byte value that can represent any address on the blockchain. Addresses can be written in two forms: hexadecimal addresses prefixed with `0x` and named addresses.

```move
// address literal
let value: address = @0x1;

// named address registered in Move.toml
let value = @std;
let other = @sui;
```

### Literals

Move has the following literals:

- Boolean values: `true` and `false`
- Integer values: `0`, `1`, `123123`
- Hexadecimal values: Numbers prefixed with `0x` to represent integers, such as `0x0`, `0x1`, `0x123`
- Byte vector values: Prefixed with `b`, such as `b"bytes_vector"`
- Byte values: Hexadecimal literals prefixed with `x`, such as `x"0A"`

```move
let b = true;     // true is a literal
let n = 1000;     // 1000 is a literal
let h = 0x0A;     // 0x0A is a literal
let v = b"hello"; // b"hello" is a byte vector literal
let x = x"0A";    // x"0A" is a byte vector literal
let c = vector[1, 2, 3]; // vector[] is a vector literal
```

### Operators

Arithmetic, logical, and bitwise operators are used to perform operations on values. Since these operations produce values, they are considered expressions.

```move
let sum = 1 + 2;   // 1 + 2 is an expression
let sum = (1 + 2); // the same expression with parentheses
let is_true = true && false; // true && false is an expression
let is_true = (true && false); // the same expression with parentheses
```

### Functions in Move

A function call is an expression that calls a function and returns the value of the last expression in the function body, provided the last expression does not have a terminating semicolon.

```move
fun add(a: u8, b: u8): u8 {
    a + b
}

#[test]
fun some_other() {
    let sum = add(1, 2); // not returned due to the semicolon.
    // compiler automatically inserts an empty expression `()` as return value of the block
}
```

### Control Flow Expressions

Control flow expressions are used to control the flow of the program. They are also expressions, so they return a value.

```move
// if is an expression, so it returns a value; if there are 2 branches,
// the types of the branches must match.
if (bool_expr) expr1 else expr2;

// while is an expression, but it returns `()`.
while (bool_expr) { expr; };

// loop is an expression, but returns `()` as well.
loop { expr; break };
```
