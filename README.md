Learning about the [Move programming language](https://move-book.com/) and the Sui blockchain.
Move is a language for writing smart contracts - programs that are stored and run on the blockchain.

Install Using Chocolatey (Windows)
You can install Sui using the [Chocolatey](https://chocolatey.org/install) package manager for Windows.

```bash
choco install sui
```

To check the sui version installed
```bash 
sui client --version
```
It should print the client version. E.g. sui-client 1.22.0-036299745.

Package
A package is published on the blockchain and is identified by an address. A published package can be interacted with by sending transactions calling its functions. It can also act as a dependency for other packages.

To create a new package, use the sui move new command. To learn more about the command, run sui move new --help.

Create a New Package
```bash
$ sui move new hello_world
```
The sui move command gives access to the Move CLI - a built-in compiler, test runner and a utility for all things Move. The new command followed by the name of the package will create a new package in a new folder. In our case, the folder name is "hello_world".

```bash 
$ ls -l hello_world
Move.toml
sources
tests
```

Directory Structure
Move CLI will create a scaffold of the application and pre-create the directory structure and all necessary files. Let's see what's inside.

```bash
hello_world
├── Move.toml
├── sources
│   └── hello_world.move
└── tests
    └── hello_world_tests.move
```



Package Manifest
The Move.toml is a manifest file that describes the package and its dependencies. It is written in TOML format and contains multiple sections, the most important of which are [package], [dependencies] and [addresses].


Address
Address is a unique identifier of a location on the blockchain. It is used to identify packages, accounts, and objects. Address has a fixed size of 32 bytes and is usually represented as a hexadecimal string prefixed with 0x. Addresses are case insensitive.
Here are some examples of reserved addresses:

0x1 - address of the Sui Standard Library (alias std)
0x2 - address of the Sui Framework (alias sui)
0x6 - address of the system Clock object

Account
An account is a way to identify a user. An account is generated from a private key, and is identified by an address. An account can own objects, and can send transactions. Every transaction has a sender, and the sender is identified by an address.

Sui supports multiple cryptographic algorithms for account generation. The two supported curves are ed25519, secp256k1, and there is also a special way of generating an account - zklogin. The cryptographic agility - the unique feature of Sui - allows for flexibility in the account generation.

Transaction
Transaction is a fundamental concept in the blockchain world. It is a way to interact with a blockchain. Transactions are used to change the state of the blockchain, and they are the only way to do so. In Move, transactions are used to call functions in a package, deploy new packages, and upgrade existing ones.

Transaction Structure
Every transaction explicitly specifies the objects it operates on!

Transactions consist of:

- a sender - the account that signs the transaction;
- a list (or a chain) of commands - the operations to be executed;
- command inputs - the arguments for the commands: either pure - simple values like numbers or strings, or object - objects that the transaction will access;
- a gas object - the Coin object used to pay for the transaction;
- gas price and budget - the cost of the transaction;

Transaction Effects
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

Module
A module is the base unit of code organization in Move. Modules are used to group and isolate code, and all members of the module are private to the module by default.

Module Declaration
Modules are declared using the module keyword followed by the package address, module name, semicolon, and the module body.The module name should be in snake_case - all lowercase letters with underscores between words. Modules names must be unique in the package.


If you need to declare more than one module in a file, you must use Module Block syntax.

```bash
// Module label.
module book::my_module;

// module body
```
