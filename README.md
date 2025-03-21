# Noir Hmac Auth

[![Noir](https://img.shields.io/badge/Noir-0.16.0-blue.svg)](https://github.com/noir-lang/noir)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This project implements HMAC (Hash-Based Message Authentication Code) authentication using a generic interface for supported hash algorithm.

## Usage

In your `Nargo.toml` file, add the following dependency:

```toml
[dependencies]
hmac = { git = "https://github.com/0xnonso/noir-hmac-auth" }
```

Then use it in your Noir project like this:

```rust
use dep::hmac;

fn main(key: [u8; 40], message: [u8; 128], expected_mac_tag: [u8; 32]) {
    assert(expected_mac_tag == hmac::hmac_sha256(key, message));
}
```