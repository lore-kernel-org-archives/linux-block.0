Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D32F363D;
	Mon, 16 Jun 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080384; cv=none; b=XALtYd1x49SEYHeAxny0qPq5FXglJozvkIOd68aTQvaKuVGBY6m5JvRoXuc2Ra18llKaMVW+45CjVgVucvojNccxVZgeoNh9E69FuXBzbDcZ+tynArb8seakyQjx2rpg2JxqLDo2zoX5d2Q4OtfmPE2rBvuhZ5rFraCAIk9keWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080384; c=relaxed/simple;
	bh=Xy4pDJyFz8OGfWuNES6lZszWTLpneVMuG7SL/mculR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kr9kuAWfruVAAQZ8WhQizOYcLoZr7y+GLNlDehZr+5P9nXu6ctOzt0LX3fGzwo3dQNLLQH23vDGGTq5yUkB/10X8pXZbqFU8nOv2tCDNuWD0VOa+cP9feBXpoyWVnRLeh26nmU/lmrfC6Ng/9TrmcpmIzqAT4Uwi8/eKsIxyaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtBvcjrN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtBvcjrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8E2C4CEED;
	Mon, 16 Jun 2025 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750080383;
	bh=Xy4pDJyFz8OGfWuNES6lZszWTLpneVMuG7SL/mculR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VtBvcjrNBhyGSteNt40vjNLy/u3qSJpEeoBRQoSHYBkhNq5nbQ4CK9xSOPHZobf+D
	 xCdzmBbcRgpeHEqVicOx0F6DI4DLXJLwG+xjzv6iP+0ayYpPEURck9XG3XItNPhC+7
	 BHFfREfiwSFpP9XIteQ1OFHc6Jg2egXRZ8XTb/jemP7dOqHF2gQ+YazPh+qhh5d5+p
	 8O5GEarGLiqOq4mkQ76KWkFLGkvgfOGkuqN/P0sb+Ju80yU0R5h5ttJ9GUJMqKEs+G
	 LxbHzdkLJpiqams2ENXeGEoyaWF/p/HRZQKzRST8k7T8FFB2mKu14hVTpVYC4z9QQw
	 JXz8gM4+uDCig==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Jun 2025 15:23:53 +0200
Subject: [PATCH 3/9] rust: block,core: rename `RawWriter` to `BufferWriter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rnull-up-v6-16-v1-3-a4168b8e76b2@kernel.org>
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
In-Reply-To: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4734; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Xy4pDJyFz8OGfWuNES6lZszWTLpneVMuG7SL/mculR4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoUBsMfSsfIU2x8vir85/W36Zd1c9jT2rWnH4/s
 3CWw5F33KqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaFAbDAAKCRDhuBo+eShj
 d7EtD/9fnPiUMZOU1FZDKFyILpEcOaP7FCJ7kn1RrBH8mhYofXPV+7f2z71RnHB0h/bM26cNTZz
 g3U6tGu0o6MHuSDqGOHXcWyWl45svJqLep7VQ0zVvWYvjhZtvOjvNa243eBZB2BccOsN3AC5e1I
 qfrsFWbowH8c0lUMbg4ey/S8Hlg/sLbUHZoDVfrUZe6hl12jRRhZ+8hT8X+FXS1x15o8bE0ct/Q
 JR84tq/w9JaKf3jXseI25yGe+It95ZQQoBn+HzPPJQivjcQlUqM7k7Pw23bO8KM1HwKIZhg0FyI
 BN2/7WN1mrzwAvAFUoTQx1v87jSAf6hRAnUPp1fbBHF2n373gPOGpHvw8t3jUGGZ6Kv7NDbXitK
 vdPoJXjhaRdqlhSXN8MT0ORTm6Nf8HkaLxjkW50viGxFxVOLsN3MODxAvanREzNpzPn2T+pBJo8
 g1gNEfeYwvKxM6ON17gTwRJ2z22WZcpfn9QBYzQJlwqctSIUv1yuVXHg6E/XbOoPe9an/4tvfRk
 d24ZJya1C2Al0QGtexJsO6Sl55K0oojp2jowaRJnB8j2noU4kiDxlseEy57u9pMC4LI4ToAD2+h
 6TmrM0Zj0A6wpm+95yAvIiR6pKLt+d4X2WMZzMvZSat1yJof2pbowMkyvfKFs+YNFMqEHYUIv4W
 xSEODMIUN0a2cCg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Rename the `RawWriter` to `BufferWriter`, wihich is a more suitable name.
Also move the module from `block` to `str`.

The ability to format a string to a byte buffer is something that is not
specific to `block`, so there is no reason this code should live in
`block`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

---

`BufferWriter` is used in `rnull` for interacting with `configfs`.
---
 rust/kernel/block/mq.rs                                 |  1 -
 rust/kernel/block/mq/gen_disk.rs                        |  9 +++++----
 rust/kernel/str.rs                                      |  3 +++
 .../{block/mq/raw_writer.rs => str/buffer_writer.rs}    | 17 +++++++++++------
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index fb0f393c1cea..faa3ccb5a49a 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -89,7 +89,6 @@
 
 pub mod gen_disk;
 mod operations;
-mod raw_writer;
 mod request;
 mod tag_set;
 
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea88..a04b709514ac 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -5,10 +5,11 @@
 //! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
 //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
 
-use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::block::mq::{Operations, TagSet};
 use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
 use crate::{error, static_lock_class};
 use core::fmt::{self, Write};
+use kernel::str::BufferWriter;
 
 /// A builder for [`GenDisk`].
 ///
@@ -139,14 +140,14 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
-        let mut raw_writer = RawWriter::from_array(
+        let mut writer = BufferWriter::from_array(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
             // yet.
             unsafe { &mut (*gendisk).disk_name },
         )?;
-        raw_writer.write_fmt(name)?;
-        raw_writer.write_char('\0')?;
+        writer.write_fmt(name)?;
+        writer.write_char('\0')?;
 
         // SAFETY: `gendisk` points to a valid and initialized instance of
         // `struct gendisk`. `set_capacity` takes a lock to synchronize this
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a927db8e079c..050793fb7d3a 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -936,3 +936,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 macro_rules! fmt {
     ($($f:tt)*) => ( ::core::format_args!($($f)*) )
 }
+
+mod buffer_writer;
+pub use buffer_writer::BufferWriter;
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/str/buffer_writer.rs
similarity index 77%
rename from rust/kernel/block/mq/raw_writer.rs
rename to rust/kernel/str/buffer_writer.rs
index 7e2159e4f6a6..364842a6cff8 100644
--- a/rust/kernel/block/mq/raw_writer.rs
+++ b/rust/kernel/str/buffer_writer.rs
@@ -10,14 +10,14 @@
 /// # Invariants
 ///
 /// `buffer` is always null terminated.
-pub(crate) struct RawWriter<'a> {
+pub struct BufferWriter<'a> {
     buffer: &'a mut [u8],
     pos: usize,
 }
 
-impl<'a> RawWriter<'a> {
-    /// Create a new `RawWriter` instance.
-    fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
+impl<'a> BufferWriter<'a> {
+    /// Create a new [`Self`] instance.
+    pub fn new(buffer: &'a mut [u8]) -> Result<BufferWriter<'a>> {
         *(buffer.last_mut().ok_or(EINVAL)?) = 0;
 
         // INVARIANT: We null terminated the buffer above.
@@ -26,16 +26,21 @@ fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
 
     pub(crate) fn from_array<const N: usize>(
         a: &'a mut [crate::ffi::c_char; N],
-    ) -> Result<RawWriter<'a>> {
+    ) -> Result<BufferWriter<'a>> {
         Self::new(
             // SAFETY: the buffer of `a` is valid for read and write as `u8` for
             // at least `N` bytes.
             unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
         )
     }
+
+    /// Return the position of the write pointer in the underlying buffer.
+    pub fn pos(&self) -> usize {
+        self.pos
+    }
 }
 
-impl Write for RawWriter<'_> {
+impl Write for BufferWriter<'_> {
     fn write_str(&mut self, s: &str) -> fmt::Result {
         let bytes = s.as_bytes();
         let len = bytes.len();

-- 
2.47.2


