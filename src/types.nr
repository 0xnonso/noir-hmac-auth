use dep::std::hash;

global OutputSizeSha256: u32 = 32;
global BlockSizeSha256: u32 = 64;
global OutputSizeSha512: u32 = 64;
global BlockSizeSha512: u32 = 128;

pub struct HmacHasherSha256<let OutputSizeSha256: u32, let BlockSizeSha256: u32> {}
pub struct HmacHasherSha512<let OutputSizeSha512: u32, let BlockSizeSha512: u32> {}

pub type HHSha256 = HmacHasherSha256<OutputSizeSha256, BlockSizeSha256>;
pub type HHSha512 = HmacHasherSha512<OutputSizeSha512, BlockSizeSha512>;

pub trait HmacHasher<let OutputSize: u32, let BlockSize: u32>{
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSize];
}

impl HmacHasher<OutputSizeSha256, BlockSizeSha256> for HmacHasherSha256<OutputSizeSha256, BlockSizeSha256> {
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSizeSha256]{
        hash::sha256(msg)
    }
}

impl HmacHasher<OutputSizeSha512, BlockSizeSha512> for HmacHasherSha512<OutputSizeSha512, BlockSizeSha512> {
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSizeSha512]{
        hash::sha512::digest(msg)
    }
}