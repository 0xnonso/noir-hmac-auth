global OutputSizeSha256: u32 = 32;
global BlockSizeSha256: u32 = 64;

pub struct Hasher<let OutputSize: u32, let BlockSize: u32> {}

pub type Sha256Hasher = Hasher<OutputSizeSha256, BlockSizeSha256>;

pub trait HmacHasher<let OutputSize: u32, let BlockSize: u32> {
    unconstrained fn hash_unconstrained<let InputSize: u32>(
        self,
        msg: [u8; InputSize],
    ) -> [u8; OutputSize];
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSize];
}

impl HmacHasher<OutputSizeSha256, BlockSizeSha256> for Hasher<OutputSizeSha256, BlockSizeSha256> {
    unconstrained fn hash_unconstrained<let InputSize: u32>(
        self,
        msg: [u8; InputSize],
    ) -> [u8; OutputSizeSha256] {
        std::hash::sha256_var(msg, InputSize as u64)
    }
    fn hash<let InputSize: u32>(self, msg: [u8; InputSize]) -> [u8; OutputSizeSha256] {
        std::hash::sha256_var(msg, InputSize as u64)
    }
}
