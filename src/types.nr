use dep::std::hash::{sha256, sha512};

global OutputSizeSha256: u32 = 32;
global BlockSizeSha256: u32 = 64;

global OutputSizeSha512: u32 = 64;
global BlockSizeSha512: u32 = 128;

pub struct Hasher<let OutputSize: u32, let BlockSize: u32> {}

pub type Sha256Hasher = Hasher<OutputSizeSha256, BlockSizeSha256>;
pub type Sha512Hasher = Hasher<OutputSizeSha512, BlockSizeSha512>;

pub trait HmacHasher<let OutputSize: u32, let BlockSize: u32> {
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSize];
}

impl HmacHasher<OutputSizeSha256, BlockSizeSha256> for Hasher<OutputSizeSha256, BlockSizeSha256> {
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSizeSha256] {
        sha256(msg)
    }
}

impl HmacHasher<OutputSizeSha512, BlockSizeSha512> for Hasher<OutputSizeSha512, BlockSizeSha512> {
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSizeSha512] {
        sha512::digest(msg)
    }
}
