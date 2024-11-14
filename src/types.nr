use dep::std::hash;
use crate::hmac::hmac;

global OutputSizeSha256: u32 = 32;
global BlockSizeSha256: u32 = 64;
global OutputSizeSha512: u32 = 64;
global BlockSizeSha512: u32 = 128;

pub struct HmacSha256<let OutputSizeSha256: u32, let BlockSizeSha256: u32> {}
pub struct HmacSha512<let OutputSizeSha512: u32, let BlockSizeSha512: u32> {}

pub type HSha256 = HmacSha256<OutputSizeSha256, BlockSizeSha256>;
pub type HSha512 = HmacSha512<OutputSizeSha512, BlockSizeSha512>;

pub trait Hmac<let OutputSize: u32, let BlockSize: u32>{
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSize];
    fn hmac<let KeySize: u32, let InputSize: u32>(self, key: [u8; KeySize], msg: [u8; InputSize]) -> [u8; OutputSize];
}

impl Hmac<OutputSizeSha256, BlockSizeSha256> for HmacSha256<OutputSizeSha256, BlockSizeSha256> {
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSizeSha256]{
        hash::sha256(msg)
    }
    fn hmac<let KeySize: u32, let InputSize: u32>(self,  key: [u8; KeySize], msg: [u8; InputSize]) -> [u8; OutputSizeSha256]{
        hmac(self, key, msg)
    }
}

impl Hmac<OutputSizeSha512, BlockSizeSha512> for HmacSha512<OutputSizeSha512, BlockSizeSha512> {
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSizeSha512]{
        hash::sha512::digest(msg)
    }
    fn hmac<let KeySize: u32, let InputSize: u32>(self,  key: [u8; KeySize], msg: [u8; InputSize]) -> [u8; OutputSizeSha512]{
        hmac(self, key, msg)
    }
}