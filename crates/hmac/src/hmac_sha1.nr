use dep::sha1::sha1;
use dep::hmac_utils::xor;

pub fn hmac_sha1<K, M>(key: [u8; K], message: [u8; M]) -> [u8; 20] {
    let mut _key = [0; 64];
    let key_len = key.len() as u16;
    let mut key_hash = [0; 20];
    
    if key_len == 64 {
        for i in 0..64 {
            _key[i] = key[i];
        }
    } else if key_len > 64 {
        key_hash = sha1(key, key_len);
        for i in 0..20 {
            _key[i] = key_hash[i];
        }
    } else {
        for i in 0..key_len {
            _key[i] = key[i];
        }
    }

    let i_pad = [0x36; 64];
    let o_pad = [0x5c; 64];

    let i_key_pad = xor(_key, i_pad);
    let o_key_pad = xor(_key, o_pad);

    let mut i_key_pad_msg_slice = i_key_pad.as_slice();

    for i in 0..message.len() {
        i_key_pad_msg_slice = i_key_pad_msg_slice.push_back(message[i]);
    }

    let inner_hash = sha1(i_key_pad_msg_slice, i_key_pad_msg_slice.len() as u16);

    let mut o_key_pad_msg_slice = o_key_pad.as_slice();

    for i in 0..20 {
        o_key_pad_msg_slice = o_key_pad_msg_slice.push_back(inner_hash[i]);
    }

    let hmac_result = sha1(o_key_pad_msg_slice, o_key_pad_msg_slice.len() as u16);
    hmac_result
}

#[test]
fn hmac_sha1_test() {
    let key = "secret".as_bytes();
    let message = "Hello, World!".as_bytes();
    let expected_mac_tag = [0xdb, 0x4b, 0xfc, 0xdb, 0x9e, 0x03, 0x76, 0x0c, 0x3e, 0x4c, 0x35, 0x1d, 0xfd, 0xe8, 0xb4, 0xc2, 0xf5, 0xc6, 0xa2, 0x91];
    let mac_tag = hmac_sha1(key, message);
    assert(mac_tag == expected_mac_tag);
}