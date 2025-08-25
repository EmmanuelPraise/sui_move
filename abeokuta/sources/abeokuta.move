module abeokuta::sui;

use std::string::String;
use sui::url::Url;

public struct Workshop has key {
    id: UID,
    name: String,
    description: String,
    attendees: u8,
    link: Url, 
}

public fun new_workshop(name: String, description: String, attendees: u8, link: Url, ctx: &mut TxContext): Workshop {
    let day1 = Workshop {
        id: object::new(ctx),
        name,
        description,
        attendees,
        link,
    };

    day1

}