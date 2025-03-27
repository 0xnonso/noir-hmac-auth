use crate::types::HmacHasher;

pub fn xor<let N: u32>(a: [u8; N], b: [u8; N]) -> [u8; N] {
    let mut result = [0; N];
    for i in 0..N {
        result[i] = a[i] ^ b[i];
    }
    result
}

pub unconstrained fn __xor<let N: u32>(a: [u8; N], b: [u8; N]) -> [u8; N] {
    let mut result = [0; N];
    for i in 0..N {
        result[i] = a[i] ^ b[i];
    }
    result
}

pub unconstrained fn __compute_blocked_key<let KeySize: u32, let OutputSize: u32, let BlockSize: u32, T>(
    hasher: T,
    key: [u8; KeySize],
) -> [u8; BlockSize]
where
    T: HmacHasher<OutputSize, BlockSize>,
{
    let mut blocked_key: [u8; BlockSize] = [0; BlockSize];
    if KeySize > BlockSize {
        let key_hash: [u8; OutputSize] = hasher.hash(key);
        for i in 0..OutputSize {
            blocked_key[i] = key_hash[i];
        }
    } else {
        for i in 0..KeySize {
            blocked_key[i] = key[i];
        }
    }
    blocked_key
}

pub unconstrained fn __compute_key_pad_ext<let N: u32, let BlockSize: u32>(
    PAD: u8,
    blocked_key: [u8; BlockSize],
    input: [u8; N],
) -> [u8; BlockSize + N] {
    let inner_pad: [u8; BlockSize] = [PAD; BlockSize];
    let inner_key_pad: [u8; BlockSize] = __xor(inner_pad, blocked_key);
    let mut inner_key_pad_extended: [u8; BlockSize + N] = [0; BlockSize + N];
    for i in 0..BlockSize {
        inner_key_pad_extended[i] = inner_key_pad[i];
    }
    for i in BlockSize..BlockSize + N {
        inner_key_pad_extended[i] = input[i - BlockSize];
    }
    inner_key_pad_extended
}

pub fn constrain_xor(a: u8, b: u8, c: u8) {
    let _a = a as Field;
    let _b = b as Field;
    let _d: [u1; 8] = _a.to_be_bits();
    let _e: [u1; 8] = _b.to_be_bits();
    let mut _f = 0;
    for i in 0..8 {
        _f += (_d[i] as u8 + _e[i] as u8) % 2 * 2.pow_32(7 - i as Field) as u8;
    }
    assert(_f == c);
}
