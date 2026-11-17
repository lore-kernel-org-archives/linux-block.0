Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.30.211.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958348;
	b=lAXOC7z18fZdoChxGFme0j/CprCxFGc6C+DKELboy6O++THqfMOmFPJlJtieQAkbCrWm
	 F/u6IXC7C4pC7o0Hrr8MLtLNPYOtzhnqbRSarI+w9JXczfNZ9x52AELGGGwyOV2qKNQ/C
	 CNiNBFzEe9ACANkxWLfXTk5xM7YK0oRoMVvvTsAuiJ6Q3UOb7qLGlezFKfH0GT9BCXEhM
	 d5ehpgh498BbmNWbFQ/3eVbIv7S7/kg91rgLHK/I5JQpUPqYZhLwZk0Jn8HWHStuddPze
	 eRmqFajt4n4DbdbOefpcgoE0W6AeqpONPwp1obJ+2Xix9njsrcSlTkjkw6HAfExPd4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958348;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OO21c8+tFDAgc9wUSPx8nRJ+SiN0bpj0Z/0tXmBXR1M=;
	b=EvjgqQ1Ei+EpCNWOuc4Or4n2Z6hU++6uacuVIHIvVkf9MoUXC8MDIWKZKhtWCCZy2x3q
	 ZdqulCvE7Wu/0+ACFBpiFWH4HQq9cGz9trWrxFSo+2GWk85DubLytK9HyOoyUIetCZZOQ
	 OQg2z0eej9uoA9B17FaUcprMQe5vey0AB4V1JjS9wSRmHIRWNI2xBgnIXY+eqc9MFYSuU
	 R6H9YIRNOe2QmOOVPCmTlP0wwm9xKP3opRz8QMim0q+pQivorCc2EYgi138HeltJHGwLb
	 tiQe8RW08IQAhIFHJRqiODmCtqCSx7ksLBWux+O0klbJ/UcMtghbbKwrddrjl8cMsJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=konsulko.se;
	spf=none smtp.mailfrom=konsulko.se;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=rsa-sha256 header.s=rsa2 header.b=SQgPFQPy;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=ed25519-sha256 header.s=ed2 header.b="30L/AY5c";
	arc=none smtp.remote-ip=46.30.211.244
Received: from mailrelay-egress5.pub.mailoutpod3-cph3.one.com (mailrelay-egress5.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09D606A88E
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 23:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C09D606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=konsulko.se header.i=@konsulko.se header.a=rsa-sha256 header.s=rsa2 header.b=SQgPFQPy;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=ed25519-sha256 header.s=ed2 header.b=30L/AY5c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794958340; x=1795563140;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=OO21c8+tFDAgc9wUSPx8nRJ+SiN0bpj0Z/0tXmBXR1M=;
	b=SQgPFQPyh61GzaqbYptSS2IKL/CO3ZPQKvsjQS+2THWjeK+9VV4Nr8Telv6XSxCsadCKKWrGitHC1
	 ZNu5VrqVuwHCrtoJSatFs/CjC88aenDkx13YqXb2wcBVKlhy1xFaGteunFMg0YfAIQSj9AFMZU2Vmy
	 zRHWRrBsl1dIXMXFoMlAoVIhSUeJMMgkd95guhG6Hfo5tQexZ59UYq/7Tvdd4XBhnXIPfMQf9iJ8m8
	 XmLq+4kR4GARqAYTxCiMBcqYsB1h2VMPgEdMzzj1KZQ1vQW8NiqGtJzLjoGwRVio+nbeQDlyses/Ew
	 LiBZ7Nw5F9+cOKa90jvI39wbjqfIzVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794958340; x=1795563140;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=OO21c8+tFDAgc9wUSPx8nRJ+SiN0bpj0Z/0tXmBXR1M=;
	b=30L/AY5ch5cimpu96astI6ZHEYoD3qaMPHSkdO3BUreeJezmkmEEhcgsWiT8H7sUtetZSgQQSO8gA
	 tRAiZY9DQ==
X-HalOne-ID: 2061b5f6-e2df-11f1-929f-49de817b90c1
Received: from slottsdator.home (unknown [2a02:1406:27d:15:2438:a644:c11e:a5ef])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 2061b5f6-e2df-11f1-929f-49de817b90c1;
	Tue, 17 Nov 2026 23:32:18 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Igor B <igor.b@beldev.am>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH 1/3] rust: block: add bio segment iteration and request accessors
Date: Wed, 18 Nov 2026 00:32:09 +0100
Message-Id: <20261117233211.3137168-2-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
References: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Igor B <igor.b@beldev.am>

The Rust blk-mq abstractions only cover what the null block driver
needs: requests can be started and ended, but a driver cannot find out
what a request asks for or reach its data.

For a driver that actually transfers data we need:

- A `bio` module with a `Bio` wrapper, an iterator over the bios of a
  request and an iterator over the single-page segments of a bio, the
  equivalent of rq_for_each_segment(). Segments can be copied to and
  from a `Page` and zeroed, with bounds checks. Iteration goes through
  two new C helpers wrapping bio_iter_iovec() and
  bio_advance_iter_single(), so the multi-page bvec handling stays in
  C.

- `Request::command()`, `Request::sector()`, `Request::bytes()` and
  `Request::bio_iter()`, exposing the operation, start sector, length
  and bios of a request. REQ_OP_MASK is added as a constant helper,
  since bindgen cannot evaluate it.

- `GenDiskBuilder::max_hw_discard_sectors()` and
  `GenDiskBuilder::discard_granularity()`, so drivers can advertise
  discard support.

These are used by the rbrd driver added in forthcoming patch.

Signed-off-by: Igor Belousov <igor.b@beldev.am>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 rust/bindings/bindings_helper.h  |   1 +
 rust/helpers/blk.c               |  14 ++
 rust/kernel/block.rs             |   1 +
 rust/kernel/block/bio.rs         | 253 +++++++++++++++++++++++++++++++
 rust/kernel/block/mq.rs          |   5 +-
 rust/kernel/block/mq/gen_disk.rs |  25 +++
 rust/kernel/block/mq/request.rs  |  81 +++++++++-
 7 files changed, 378 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/block/bio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..99b25d35b80a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -124,6 +124,7 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
+const blk_opf_t RUST_CONST_HELPER_REQ_OP_MASK = REQ_OP_MASK;
 const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET = FOP_UNSIGNED_OFFSET;
 
 const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index 20c512e46a7a..f82cdb3b0875 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/bio.h>
 #include <linux/blk-mq.h>
 #include <linux/blkdev.h>
 
@@ -12,3 +13,16 @@ __rust_helper struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
 {
 	return blk_mq_rq_from_pdu(pdu);
 }
+
+__rust_helper struct bio_vec rust_helper_bio_iter_iovec(struct bio *bio,
+							 const struct bvec_iter *iter)
+{
+	return bio_iter_iovec(bio, *iter);
+}
+
+__rust_helper void rust_helper_bio_advance_iter_single(const struct bio *bio,
+							struct bvec_iter *iter,
+							unsigned int bytes)
+{
+	bio_advance_iter_single(bio, iter, bytes);
+}
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 32c8d865afb6..17de727bc104 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -2,6 +2,7 @@
 
 //! Types for working with the block layer.
 
+pub mod bio;
 pub mod mq;
 
 /// Bit mask for masking out [`SECTOR_SIZE`].
diff --git a/rust/kernel/block/bio.rs b/rust/kernel/block/bio.rs
new file mode 100644
index 000000000000..183f9ae6d48d
--- /dev/null
+++ b/rust/kernel/block/bio.rs
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with the C `struct bio`.
+//!
+//! C header: [`include/linux/bio.h`](srctree/include/linux/bio.h)
+//! C header: [`include/linux/blk_types.h`](srctree/include/linux/blk_types.h)
+
+use crate::{
+    bindings,
+    page::Page,
+    prelude::*,
+    types::Opaque, //
+};
+use core::{
+    marker::PhantomData,
+    ptr, //
+};
+
+/// A wrapper around a C [`struct bio`].
+///
+/// # Invariants
+///
+/// `self.0` is a valid `struct bio` that is part of a request owned by the
+/// driver. Neither the bio nor its data pages are released while a `&Bio` is
+/// alive.
+///
+/// [`struct bio`]: srctree/include/linux/blk_types.h
+#[repr(transparent)]
+pub struct Bio(Opaque<bindings::bio>);
+
+impl Bio {
+    /// Create a reference to a [`Bio`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a valid `struct bio` that stays valid, and is not
+    /// modified by anyone but the holder of the returned reference, for the
+    /// duration of `'a`.
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::bio) -> &'a Self {
+        // SAFETY: `Bio` is `repr(transparent)` over `bindings::bio`, and the
+        // safety requirements of this function make the reference valid.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    fn raw(&self) -> *mut bindings::bio {
+        self.0.get()
+    }
+
+    /// Return the start sector of the bio.
+    pub fn sector(&self) -> u64 {
+        // SAFETY: By the type invariant `self.raw()` is valid. Taking the field
+        // by value avoids creating a reference into the packed `bi_iter`.
+        let iter = unsafe { (*self.raw()).bi_iter };
+        iter.bi_sector
+    }
+
+    /// Return the remaining size of the bio in bytes.
+    pub fn size(&self) -> u32 {
+        // SAFETY: By the type invariant `self.raw()` is valid.
+        let iter = unsafe { (*self.raw()).bi_iter };
+        iter.bi_size
+    }
+
+    /// Return an iterator over the single-page segments of this bio.
+    ///
+    /// This is the equivalent of the C `bio_for_each_segment()` macro.
+    pub fn segment_iter(&self) -> SegmentIter<'_> {
+        SegmentIter {
+            bio: self,
+            // SAFETY: By the type invariant `self.raw()` is valid.
+            iter: unsafe { (*self.raw()).bi_iter },
+        }
+    }
+
+    /// Return the next bio in the chain, if any.
+    pub(crate) fn next(&self) -> Option<&Self> {
+        // SAFETY: By the type invariant `self.raw()` is valid.
+        let next = unsafe { (*self.raw()).bi_next };
+        if next.is_null() {
+            None
+        } else {
+            // SAFETY: Bios chained to a request owned by the driver are valid
+            // for as long as the request is owned by the driver, which by the
+            // type invariant outlives `&self`.
+            Some(unsafe { Self::from_raw(next) })
+        }
+    }
+}
+
+/// An iterator over the [`Bio`]s of a request.
+///
+/// Created by [`Request::bio_iter`](super::mq::Request::bio_iter).
+pub struct BioIter<'a> {
+    pub(crate) bio: Option<&'a Bio>,
+}
+
+impl<'a> Iterator for BioIter<'a> {
+    type Item = &'a Bio;
+
+    fn next(&mut self) -> Option<&'a Bio> {
+        let current = self.bio?;
+        self.bio = current.next();
+        Some(current)
+    }
+}
+
+/// An iterator over the single-page segments of a [`Bio`].
+pub struct SegmentIter<'a> {
+    bio: &'a Bio,
+    iter: bindings::bvec_iter,
+}
+
+impl<'a> Iterator for SegmentIter<'a> {
+    type Item = Segment<'a>;
+
+    fn next(&mut self) -> Option<Segment<'a>> {
+        if self.iter.bi_size == 0 {
+            return None;
+        }
+
+        let sector = self.iter.bi_sector;
+
+        // SAFETY: By the type invariant of `Bio`, `self.bio.raw()` is valid,
+        // and `self.iter` is a copy of its `bi_iter` that was only advanced
+        // through `bio_advance_iter_single`, so it is within bounds.
+        let bvec = unsafe { bindings::bio_iter_iovec(self.bio.raw(), &self.iter) };
+
+        // SAFETY: As above. `bvec.bv_len` is at most `self.iter.bi_size`.
+        unsafe { bindings::bio_advance_iter_single(self.bio.raw(), &mut self.iter, bvec.bv_len) };
+
+        // INVARIANT: `bio_iter_iovec` returns a segment that does not cross a
+        // page boundary and that lies within the data buffer of the bio.
+        Some(Segment {
+            bvec,
+            sector,
+            _p: PhantomData,
+        })
+    }
+}
+
+/// A single-page segment of the data buffer of a [`Bio`].
+///
+/// # Invariants
+///
+/// - `bvec.bv_page` is a valid page for the lifetime `'a`.
+/// - `bvec.bv_offset + bvec.bv_len <= PAGE_SIZE`.
+pub struct Segment<'a> {
+    bvec: bindings::bio_vec,
+    sector: u64,
+    _p: PhantomData<&'a Bio>,
+}
+
+impl Segment<'_> {
+    /// Return the length of the segment in bytes.
+    pub fn len(&self) -> usize {
+        self.bvec.bv_len as usize
+    }
+
+    /// Return `true` if the segment is empty.
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Return the device sector this segment starts at.
+    pub fn sector(&self) -> u64 {
+        self.sector
+    }
+
+    /// Map the segment and call `f` with a pointer to byte `off` of the
+    /// segment, after checking that `off..off + len` is within the segment.
+    fn with_mapped(&self, off: usize, len: usize, f: impl FnOnce(*mut u8) -> Result) -> Result {
+        match off.checked_add(len) {
+            Some(end) if end <= self.len() => {}
+            _ => return Err(EINVAL),
+        }
+
+        // SAFETY: By the type invariant, `bv_page` is a valid page.
+        let mapped = unsafe { bindings::kmap_local_page(self.bvec.bv_page) };
+        let addr = mapped.cast::<u8>();
+
+        // SAFETY: By the type invariant and the check above,
+        // `bv_offset + off + len <= PAGE_SIZE`, so the result is within the
+        // mapped page.
+        let res = f(unsafe { addr.add(self.bvec.bv_offset as usize + off) });
+
+        // SAFETY: `mapped` was returned by the `kmap_local_page` call above,
+        // and any mapping created by `f` has already been released, so
+        // mappings are released in reverse order.
+        unsafe { bindings::kunmap_local(mapped) };
+
+        res
+    }
+
+    /// Copy `len` bytes starting at byte `off` of this segment into `dst`
+    /// starting at `dst_off`.
+    ///
+    /// Returns [`EINVAL`] if either range is out of bounds.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that this call does not race with a read or
+    /// write of the same range of `dst`.
+    pub unsafe fn copy_to_page(
+        &self,
+        off: usize,
+        dst: &Page,
+        dst_off: usize,
+        len: usize,
+    ) -> Result {
+        self.with_mapped(off, len, |src| {
+            // SAFETY: `src` is valid for reading `len` bytes, and the caller
+            // guarantees there is no racing access to `dst`.
+            unsafe { dst.write_raw(src, dst_off, len) }
+        })
+    }
+
+    /// Copy `len` bytes from `src` starting at `src_off` into this segment
+    /// starting at byte `off`.
+    ///
+    /// Returns [`EINVAL`] if either range is out of bounds.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that this call does not race with a write to the
+    /// same range of `src`.
+    pub unsafe fn copy_from_page(
+        &self,
+        off: usize,
+        src: &Page,
+        src_off: usize,
+        len: usize,
+    ) -> Result {
+        self.with_mapped(off, len, |dst| {
+            // SAFETY: `dst` is valid for writing `len` bytes. The data buffer
+            // of the bio is owned by the driver while the request is in
+            // flight. The caller guarantees there is no racing write to `src`.
+            unsafe { src.read_raw(dst, src_off, len) }
+        })
+    }
+
+    /// Fill `len` bytes starting at byte `off` of this segment with zeroes.
+    ///
+    /// Returns [`EINVAL`] if the range is out of bounds.
+    pub fn zero(&self, off: usize, len: usize) -> Result {
+        self.with_mapped(off, len, |dst| {
+            // SAFETY: `dst` is valid for writing `len` bytes. The data buffer
+            // of the bio is owned by the driver while the request is in
+            // flight.
+            unsafe { ptr::write_bytes(dst, 0, len) };
+            Ok(())
+        })
+    }
+}
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1fd0d54dd549..cb5b699630d8 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -99,5 +99,8 @@
 mod tag_set;
 
 pub use operations::Operations;
-pub use request::Request;
+pub use request::{
+    Command,
+    Request, //
+};
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 0fe640f3aec6..57d543165430 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -37,6 +37,8 @@ pub struct GenDiskBuilder {
     logical_block_size: u32,
     physical_block_size: u32,
     capacity_sectors: u64,
+    max_hw_discard_sectors: u32,
+    discard_granularity: u32,
 }
 
 impl Default for GenDiskBuilder {
@@ -46,6 +48,8 @@ fn default() -> Self {
             logical_block_size: bindings::PAGE_SIZE as u32,
             physical_block_size: bindings::PAGE_SIZE as u32,
             capacity_sectors: 0,
+            max_hw_discard_sectors: 0,
+            discard_granularity: 0,
         }
     }
 }
@@ -106,6 +110,25 @@ pub fn capacity_sectors(mut self, capacity: u64) -> Self {
         self
     }
 
+    /// Set the maximum number of sectors (512 bytes) the device can discard in
+    /// a single request.
+    ///
+    /// Zero, the default, means that the device does not support discard.
+    pub fn max_hw_discard_sectors(mut self, sectors: u32) -> Self {
+        self.max_hw_discard_sectors = sectors;
+        self
+    }
+
+    /// Set the discard granularity of the device in bytes.
+    ///
+    /// This is the internal allocation unit of the device. Discards smaller
+    /// than this, or not aligned to it, may not free any storage. Zero, the
+    /// default, lets the block layer use the logical block size.
+    pub fn discard_granularity(mut self, granularity: u32) -> Self {
+        self.discard_granularity = granularity;
+        self
+    }
+
     /// Build a new `GenDisk` and add it to the VFS.
     pub fn build<T: Operations>(
         self,
@@ -123,6 +146,8 @@ pub fn build<T: Operations>(
 
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
+        lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
+        lim.discard_granularity = self.discard_granularity;
         if self.rotational {
             lim.features = bindings::BLK_FEAT_ROTATIONAL;
         }
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 6115f9aec228..aaaac88d8ae0 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -6,7 +6,13 @@
 
 use crate::{
     bindings,
-    block::mq::Operations,
+    block::{
+        bio::{
+            Bio,
+            BioIter, //
+        },
+        mq::Operations, //
+    },
     prelude::*,
     sync::{
         aref::{
@@ -165,6 +171,62 @@ pub fn complete(this: ARef<Self>) {
         }
     }
 
+    /// Return the operation requested by this request.
+    pub fn command(&self) -> Command {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`.
+        // `cmd_flags` is not modified while the request is owned by the driver.
+        let op = unsafe { (*self.0.get()).cmd_flags } & bindings::REQ_OP_MASK;
+
+        match op {
+            bindings::req_op_REQ_OP_READ => Command::Read,
+            bindings::req_op_REQ_OP_WRITE => Command::Write,
+            bindings::req_op_REQ_OP_FLUSH => Command::Flush,
+            bindings::req_op_REQ_OP_DISCARD => Command::Discard,
+            bindings::req_op_REQ_OP_WRITE_ZEROES => Command::WriteZeroes,
+            op => Command::Other(op),
+        }
+    }
+
+    /// Return the start sector of the request.
+    ///
+    /// This is the equivalent of the C `blk_rq_pos()` function.
+    pub fn sector(&self) -> u64 {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`.
+        // `__sector` is not modified by the block layer while the request is
+        // owned by the driver.
+        unsafe { (*self.0.get()).__sector }
+    }
+
+    /// Return the number of bytes remaining in the request.
+    ///
+    /// This is the equivalent of the C `blk_rq_bytes()` function.
+    pub fn bytes(&self) -> u32 {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`.
+        // `__data_len` is not modified by the block layer while the request is
+        // owned by the driver.
+        unsafe { (*self.0.get()).__data_len }
+    }
+
+    /// Return an iterator over the [`Bio`]s attached to the request.
+    ///
+    /// Use [`Bio::segment_iter`] on each to visit all data segments, which is
+    /// the equivalent of the C `rq_for_each_segment()` macro.
+    pub fn bio_iter(&self) -> BioIter<'_> {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`.
+        let bio = unsafe { (*self.0.get()).bio };
+
+        BioIter {
+            bio: if bio.is_null() {
+                None
+            } else {
+                // SAFETY: The existence of `&self` implies the request is
+                // owned by the driver, so its bios stay valid and are not
+                // modified by the block layer for the lifetime of `&self`.
+                Some(unsafe { Bio::from_raw(bio) })
+            },
+        }
+    }
+
     /// Return a pointer to the [`RequestDataWrapper`] stored in the private area
     /// of the request structure.
     ///
@@ -194,6 +256,23 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
     }
 }
 
+/// The operation of a [`Request`].
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum Command {
+    /// Read sectors from the device.
+    Read,
+    /// Write sectors to the device.
+    Write,
+    /// Flush the volatile write cache.
+    Flush,
+    /// Discard sectors.
+    Discard,
+    /// Write zeroes to a range of sectors.
+    WriteZeroes,
+    /// Any other operation, carrying the raw C `enum req_op` value.
+    Other(u32),
+}
+
 /// A wrapper around data stored in the private area of the C [`struct request`].
 ///
 /// [`struct request`]: srctree/include/linux/blk-mq.h
-- 
2.39.5

