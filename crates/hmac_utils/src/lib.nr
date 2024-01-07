pub fn xor(a: [u8; 64], b: [u8; 64]) -> [u8; 64] {
    let mut result = [0; 64];
    for i in 0..64 {
        result[i] = a[i] ^ b[i];
    }
    result
}