Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D704169EC;
	Tue,  9 Jun 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032577; cv=none; b=ksEVNbYOrpecxYQxV85T1GUVaVTCPjQw3K8u4pgylwV0FWuBtAuzlFyBx6liTSsGo4ILgVuXFDho/3iUXHhAwof7WrjpUE2cr1bqCFF4QTq5jFW/jDNiK1wXXOEXvkHnEW/wRtHP3B7UT/M+zup8oKZ5a7Q5FgzlXbUmpEO4FZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032577; c=relaxed/simple;
	bh=MD4KthFPqC9yqNG7lwJ7FKyEFdf1M3xtRHuNlziU+/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2+QqKptKQ2pSMVGaNfnV4JDGscUKaq6q8tanvLAOvhUcX4MD85A/C1jjakiSJ/sRTvJ002j28P5+8y4ccVd8Q/P46Ja4DOv1aF0K2U2tt1cezMeTJ+hDJDmxe4BUNhfpXjSzIH/PIBaHt+wrcqQne6cu90TUmpUH85fSW0NpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCcKjJ1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCcKjJ1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCC31F00893;
	Tue,  9 Jun 2026 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032575;
	bh=kvKtbMgKXL7TKURKnSmGyfkyvz09Oj1eTG63xB9PZNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RCcKjJ1HGChIO9qP+6RrfwQR2NL7Cna/HkYCocVsHaBqaPSdZC/+8eJWwOjX082dB
	 oRmKm5X63ENy3wecfZlQMF3Lg1ysUYkS2H+isv27Gs2ws4CCB7l+NvFlUyr3crLgF3
	 XKeaO1IBhr1E6vgID3JIpKdFHezYKaBUbN41YqB0bKNUZ5dgcSSUlxhQ15jaOqZ1Uj
	 5/+/unVAJ5rkmzq1MPLOYLegw8X2hzgwr05kXNHGkocIja6iFqbHMiipL7dagZhtZy
	 S+Vsy7uz+zFbv4AYeR77pKLMz1GSO9N3xbsmf59yipdP4fH9OGld9B/FOp/H0AzRrD
	 v3zbOFOnTX80A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:51 +0200
Subject: [PATCH v2 12/83] block: rust: introduce `kernel::block::bio`
 module
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-12-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=26863;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=MD4KthFPqC9yqNG7lwJ7FKyEFdf1M3xtRHuNlziU+/4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS/kV6kl5jr8mSNQOXdMEOoxVRwwlXVIyaFt
 gsw3kFYWdWJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkvwAKCRD6UCkIqsW9
 0BliD/kBO545tHG18FZOvXIBiLFK0Zxi2O6ZJR0ejyMz1UTO3dGfY/rVkQUcTUj+vZ/PLRR3iJB
 mvWHEgqpEzVwyKGWjZXcje+u+yofFdAQcugEI0CkpcoHbYvLikHQpxm9LheZXTKYC48DSBAiez/
 Ordtcz8Z8LdMYH+UUAWAUnRgs7V0B72qpJ+WsrKcqwwHLzbNOCN8C8q33ZEKr3PfRrxaKbZwzbi
 FDYnSS5Mpyp13JFUKmd1IF02dd5VmSK2ZyZBFFmtmL0iuczsQXQlNogPT5eR5zw8uD8LPaXWW5J
 qWzrv1s747H8TciOpt7pFU7WBTn9IeASfg57IRYFBUR1ZsK00UZYXLH8nNybIfaDPsnDJrSuouP
 a74NVTVDX3kRkfOASgexXaugjOTbfbKm5D4Dst8Ky7Ar3NXR2u5sYMEKKem9KWDu/JVucc4uqWh
 xg5LlXIvtIIFbgpBk6aw9zPIYehTmD2eOgykAtFZGZSpVq8M8usU6rh902TkW4MFuUvL9k2slOj
 vngU3+i4gn6ZNOfxfflyG46MDzAKQijByzt6VgP+rIqZwIrgLd0G5BcNpB2V+ntGsyRSOB0uoMY
 KUzf/Kimi4KjXRKi/XHLJQW7PDoIqrPMCTZJLI05/he6yY5Z6VSOOt80FYKUu1rdAyQoI2Hsn9V
 5gN1BjeJElPPsSw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add Rust abstractions for working with `struct bio`, the core IO command
descriptor for the block layer.

The `Bio` type wraps `struct bio` and provides safe access to the IO
vector describing the data buffers associated with the IO command. The
data buffers are represented as a vector of `Segment`s, where each
segment is a contiguous region of physical memory backed by `Page`.

The `BioSegmentIterator` provides iteration over segments in a single
bio, while `BioIterator` allows traversing a chain of bios. The
`Segment` type offers methods for copying data to and from pages, as
well as zeroing page contents, which are the fundamental operations
needed by block device drivers to process IO requests.

The `Request` type is extended with methods to access the bio chain
associated with a request, allowing drivers to iterate over all data
buffers that need to be processed.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/helpers/blk.c              |   8 +
 rust/kernel/block.rs            |   1 +
 rust/kernel/block/bio.rs        | 147 ++++++++++++++
 rust/kernel/block/bio/vec.rs    | 411 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/block/mq/request.rs |  49 +++++
 rust/kernel/page.rs             |   2 +-
 6 files changed, 617 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index 20c512e46a7a..6a70e1306a3a 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/bio.h>
 #include <linux/blk-mq.h>
 #include <linux/blkdev.h>
 
@@ -12,3 +13,10 @@ __rust_helper struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
 {
 	return blk_mq_rq_from_pdu(pdu);
 }
+
+__rust_helper void rust_helper_bio_advance_iter_single(const struct bio *bio,
+						       struct bvec_iter *iter,
+						       unsigned int bytes)
+{
+	bio_advance_iter_single(bio, iter, bytes);
+}
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index b120e83d9425..eb512dad031b 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -2,6 +2,7 @@
 
 //! Types for working with the block layer.
 
+pub mod bio;
 pub mod mq;
 
 /// Bit mask for masking out the sector index in a page.
diff --git a/rust/kernel/block/bio.rs b/rust/kernel/block/bio.rs
new file mode 100644
index 000000000000..af84f94a85fe
--- /dev/null
+++ b/rust/kernel/block/bio.rs
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with the bio layer.
+//!
+//! C header: [`include/linux/blk_types.h`](srctree/include/linux/blk_types.h)
+
+use crate::{
+    fmt,
+    types::Opaque, //
+};
+use core::{
+    marker::PhantomData,
+    pin::Pin,
+    ptr::NonNull, //
+};
+
+mod vec;
+
+pub use vec::{
+    BioSegmentIterator,
+    Segment, //
+};
+
+/// A block device IO descriptor (`struct bio`).
+///
+/// A `Bio` is the main unit of IO for the block layer. It describes an IO command and associated
+/// data buffers.
+///
+/// The data buffers associated with a `Bio` are represented by a vector of [`Segment`]s. These
+/// segments represent physically contiguous regions of memory. The memory is represented by
+/// [`Page`] descriptors internally.
+///
+/// The vector of [`Segment`]s can be iterated by obtaining a [`SegmentIterator`].
+#[repr(transparent)]
+pub struct Bio(Opaque<bindings::bio>);
+
+impl Bio {
+    /// Returns an iterator over segments in this `Bio`. Does not consider
+    /// segments of other bios in this bio chain.
+    #[inline(always)]
+    pub fn segment_iter(self: Pin<&mut Self>) -> BioSegmentIterator<'_> {
+        BioSegmentIterator::new(self)
+    }
+
+    /// Get the number of io vectors in this bio.
+    fn io_vec_count(&self) -> u16 {
+        // SAFETY: By the type invariant of `Bio` and existence of `&self`,
+        // `self.0` is valid for read.
+        unsafe { (*self.0.get()).bi_vcnt }
+    }
+
+    /// Get slice referencing the `bio_vec` array of this bio
+    #[inline(always)]
+    fn io_vec(&self) -> NonNull<bindings::bio_vec> {
+        let this = self.0.get();
+
+        // SAFETY: By the type invariant of `Bio` and existence of `&self`,
+        // `this` is valid for read.
+        let vec_ptr = unsafe { (*this).bi_io_vec };
+
+        // SAFETY: By C API contract, bi_io_vec is always set, even if bi_vcnt
+        // is zero.
+        unsafe { NonNull::new_unchecked(vec_ptr) }
+    }
+
+    /// Return a copy of the `bvec_iter` for this `Bio`. This iterator always
+    /// indexes to a valid `bio_vec` entry.
+    #[inline(always)]
+    fn raw_iter(&self) -> bindings::bvec_iter {
+        // SAFETY: By the type invariant of `Bio` and existence of `&self`,
+        // `self` is valid for read.
+        unsafe { (*self.0.get()).bi_iter }
+    }
+
+    /// Create an instance of `Bio` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that the `ptr` is valid for use as a reference to
+    /// `Bio` for the duration of `'a`.
+    #[inline(always)]
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::bio) -> Option<&'a Self> {
+        Some(
+            // SAFETY: by the safety requirement of this function, `ptr` is
+            // valid for read for the duration of the returned lifetime
+            unsafe { &*NonNull::new(ptr)?.as_ptr().cast::<Bio>() },
+        )
+    }
+
+    /// Create an instance of `Bio` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that the `ptr` is valid for use as a unique reference
+    /// to `Bio` for the duration of `'a`.
+    #[inline(always)]
+    pub(crate) unsafe fn from_raw_mut<'a>(ptr: *mut bindings::bio) -> Option<Pin<&'a mut Self>> {
+        // SAFETY: by the safety requirement of this function, `ptr` is
+        // valid for read for the duration of the returned lifetime.
+        let bio = unsafe { &mut *NonNull::new(ptr)?.as_ptr().cast::<Bio>() };
+
+        // SAFETY: `bindings::bio` is pinned.
+        Some(unsafe { Pin::new_unchecked(bio) })
+    }
+}
+
+impl fmt::Display for Bio {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let iter = self.raw_iter();
+        write!(
+            f,
+            "Bio({:?}, vcnt: {}, idx: {}, size: 0x{:x}, completed: 0x{:x})",
+            self.0.get(),
+            self.io_vec_count(),
+            iter.bi_idx,
+            iter.bi_size,
+            iter.bi_bvec_done
+        )
+    }
+}
+
+/// An iterator over `Bio` in a bio chain, yielding `&mut Bio`.
+///
+/// # Invariants
+///
+/// `bio` must be either `None` or be valid for use as a `&mut Bio`.
+pub struct BioIterator<'a> {
+    pub(crate) bio: Option<NonNull<Bio>>,
+    pub(crate) _p: PhantomData<&'a ()>,
+}
+
+impl<'a> core::iter::Iterator for BioIterator<'a> {
+    type Item = Pin<&'a mut Bio>;
+
+    #[inline(always)]
+    fn next(&mut self) -> Option<Pin<&'a mut Bio>> {
+        let mut current = self.bio.take()?;
+        // SAFETY: By the type invariant of `Bio` and type invariant on `Self`,
+        // `current` is valid for use as a unique reference.
+        let next = unsafe { (*current.as_ref().0.get()).bi_next };
+        self.bio = NonNull::new(next.cast());
+        // SAFETY:
+        // - By type invariant, `bio` is valid for use as a reference.
+        // - `bindings::bio` is pinned.
+        Some(unsafe { Pin::new_unchecked(current.as_mut()) })
+    }
+}
diff --git a/rust/kernel/block/bio/vec.rs b/rust/kernel/block/bio/vec.rs
new file mode 100644
index 000000000000..99ab164d4038
--- /dev/null
+++ b/rust/kernel/block/bio/vec.rs
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with `struct bio_vec` IO vectors
+//!
+//! C header: [`include/linux/bvec.h`](../../include/linux/bvec.h)
+
+use super::Bio;
+use crate::{
+    error::{
+        code,
+        Result, //
+    },
+    page::{
+        Page,
+        SafePage,
+        PAGE_SIZE, //
+    },
+    prelude::*, //
+};
+use core::{
+    fmt,
+    mem::ManuallyDrop, //
+};
+
+/// A segment of an IO request.
+///
+/// [`Segment`] represents a contiguous range of physical memory addresses of an IO request. A
+/// segment has a offset and a length, representing the amount of data that needs to be processed.
+/// Processing the data increases the offset and reduces the length.
+///
+/// The data buffer of a [`Segment`] is borrowed from a `Bio`.
+///
+/// # Implementation details
+///
+/// In the context of user driven block IO, the pages backing a [`Segment`] are often mapped to user
+/// space concurrently with the IO operation. Further, the page backing a `Segment` may be part of
+/// multiple IO operations, if user space decides to issue multiple concurrent IO operations
+/// involving the same page. Thus, the data represented by a [`Segment`] must always be assumed to
+/// be subject to racy writes.
+///
+/// A [`Segemnt`] is a wrapper around a `strutct bio_vec`.
+///
+/// # Invariants
+///
+/// `bio_vec` must always be initialized and valid for read and write
+pub struct Segment<'a> {
+    bio_vec: bindings::bio_vec,
+    _marker: core::marker::PhantomData<&'a ()>,
+}
+
+impl Segment<'_> {
+    /// Get he length of the segment in bytes.
+    #[inline(always)]
+    pub fn len(&self) -> u32 {
+        self.bio_vec.bv_len
+    }
+
+    /// Returns true if the length of the segment is 0.
+    #[inline(always)]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Get the offset field of the `bio_vec`.
+    #[inline(always)]
+    pub fn offset(&self) -> usize {
+        self.bio_vec.bv_offset as usize
+    }
+
+    /// Advance the offset of the segment.
+    ///
+    /// If `count` is greater than the remaining size of the segment, an error
+    /// is returned.
+    pub fn advance(&mut self, count: u32) -> Result {
+        if self.len() < count {
+            return Err(code::EINVAL);
+        }
+
+        self.bio_vec.bv_offset += count;
+        self.bio_vec.bv_len -= count;
+        Ok(())
+    }
+
+    /// Copy data of this segment into `dst_page`.
+    ///
+    /// Copies data from the current offset to the next page boundary. That is `PAGE_SIZE -
+    /// (self.offeset() % PAGE_SIZE)` bytes of data. Data is placed at offset `self.offset()` in the
+    /// target page. This call will advance offset and reduce length of `self`.
+    ///
+    /// Returns the number of bytes copied.
+    #[inline(always)]
+    pub fn copy_to_page(&mut self, dst_page: Pin<&mut SafePage>, dst_offset: usize) -> usize {
+        // SAFETY: We are not moving out of `dst_page`.
+        let dst_page = unsafe { Pin::into_inner_unchecked(dst_page) };
+        let src_offset = self.offset() % PAGE_SIZE;
+        debug_assert!(dst_offset <= PAGE_SIZE);
+        let length = (PAGE_SIZE - src_offset)
+            .min(self.len() as usize)
+            .min(PAGE_SIZE - dst_offset);
+        let page_idx = self.offset() / PAGE_SIZE;
+
+        // SAFETY: self.bio_vec is valid and thus bv_page must be a valid
+        // pointer to a `struct page` array.
+        let src_page = unsafe { Page::from_raw(self.bio_vec.bv_page.add(page_idx)) };
+
+        src_page
+            .with_pointer_into_page(src_offset, length, |src| {
+                // SAFETY:
+                // - If `with_pointer_into_page` calls this closure, it has performed bounds
+                //   checking and guarantees that `src` is valid for `length` bytes.
+                // - Any other operations to `src` are atomic or user space operations.
+                // - We have exclusive ownership of `dst_page` and thus this write will not race.
+                unsafe { dst_page.write_bytewise_atomic(src, dst_offset, length) }
+            })
+            .expect("Assertion failure, bounds check failed.");
+
+        self.advance(length as u32)
+            .expect("Assertion failure, bounds check failed.");
+
+        length
+    }
+
+    /// Copy data to the current page of this segment from `src_page`.
+    ///
+    /// Copies  `PAGE_SIZE - (self.offset() % PAGE_SIZE` bytes of data from `src_page` to this
+    /// segment starting at `self.offset()` from offset `self.offset() % PAGE_SIZE`. This call
+    /// will advance offset and reduce length of `self`.
+    ///
+    /// Returns the number of bytes copied.
+    pub fn copy_from_page(&mut self, src_page: &SafePage, src_offset: usize) -> usize {
+        let dst_offset = self.offset() % PAGE_SIZE;
+        debug_assert!(src_offset <= PAGE_SIZE);
+        let length = (PAGE_SIZE - dst_offset)
+            .min(self.len() as usize)
+            .min(PAGE_SIZE - src_offset);
+        let page_idx = self.offset() / PAGE_SIZE;
+
+        // SAFETY: self.bio_vec is valid and thus bv_page must be a valid
+        // pointer to a `struct page`.
+        let dst_page = unsafe { Page::from_raw(self.bio_vec.bv_page.add(page_idx)) };
+
+        dst_page
+            .with_pointer_into_page(dst_offset, length, |dst| {
+                // SAFETY:
+                // - If `with_pointer_into_page` calls this closure, then it has performed bounds
+                //   checks and guarantees that `dst` is valid for `length` bytes.
+                // - Any other operations to `dst` are atomic or user space operations.
+                // - Since we have a shared reference to `src_page`, the read cannot race with any
+                //   writes to `src_page`.
+                unsafe { src_page.read_bytewise_atomic(dst, src_offset, length) }
+            })
+            .expect("Assertion failure, bounds check failed.");
+
+        self.advance(length as u32)
+            .expect("Assertion failure, bounds check failed.");
+
+        length
+    }
+
+    /// Copy zeroes to the current page of this segment.
+    ///
+    /// Copies  `PAGE_SIZE - (self.offset() % PAGE_SIZE` bytes of data to this
+    /// segment starting at `self.offset()`. This call will advance offset and reduce length of
+    /// `self`.
+    ///
+    /// Returns the number of bytes written to this segment.
+    pub fn zero_page(&mut self) -> usize {
+        let offset = self.offset() % PAGE_SIZE;
+        let length = (PAGE_SIZE - offset).min(self.len() as usize);
+        let page_idx = self.offset() / PAGE_SIZE;
+
+        // SAFETY: self.bio_vec is valid and thus bv_page must be a valid
+        // pointer to a `struct page`. We do not own the page, but we prevent
+        // drop by wrapping the `Page` in `ManuallyDrop`.
+        let dst_page =
+            ManuallyDrop::new(unsafe { Page::from_raw(self.bio_vec.bv_page.add(page_idx)) });
+
+        // SAFETY: TODO: This might race with user space writes.
+        unsafe { dst_page.fill_zero_raw(offset, length) }
+            .expect("Assertion failure, bounds check failed.");
+
+        self.advance(length as u32)
+            .expect("Assertion failure, bounds check failed.");
+
+        length
+    }
+}
+
+impl core::fmt::Display for Segment<'_> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(
+            f,
+            "Segment {:?} len: {}, offset: {}",
+            self.bio_vec.bv_page, self.bio_vec.bv_len, self.bio_vec.bv_offset
+        )
+    }
+}
+
+/// An iterator over `Segment`
+///
+/// The iterator takes a copy of the bio's `bvec_iter` when it is created and
+/// advances that copy as it yields [`Segment`]s, leaving the `Bio` untouched. A
+/// `struct bvec_iter` is a standalone cursor into the bio's `bio_vec` array: as
+/// described in the kernel's [immutable biovecs] documentation, the `bio_vec`
+/// array is immutable once the bio is submitted and all of the position that
+/// changes while iterating is held in the `bvec_iter`, not in the array. Such an
+/// iterator can therefore be freely copied and moved, and advancing one copy
+/// affects neither the `Bio` nor any other copy of the iterator.
+///
+/// [immutable biovecs]: srctree/Documentation/block/biovecs.rst
+///
+/// # Invariants
+///
+/// If `iter.bi_size` > 0, `iter` must always index a valid `bio_vec` in `bio.io_vec()`.
+pub struct BioSegmentIterator<'a> {
+    bio: Pin<&'a mut Bio>,
+    iter: bindings::bvec_iter,
+}
+
+impl<'a> BioSegmentIterator<'a> {
+    /// Create a new segment iterator for iterating the segments of `bio`. The
+    /// iterator starts at the beginning of `bio`.
+    #[inline(always)]
+    pub(crate) fn new(bio: Pin<&'a mut Bio>) -> BioSegmentIterator<'a> {
+        let iter = bio.raw_iter();
+
+        // INVARIANT: `bio.raw_iter()` returns an index that indexes into a valid
+        // `bio_vec` in `bio.io_vec()`.
+        Self { bio, iter }
+    }
+
+    // The accessors in this implementation block are modelled after C side
+    // macros and static functions `bvec_iter_*` and `mp_bvec_iter_*` from
+    // bvec.h.
+
+    /// Construct a `bio_vec` from the current iterator state.
+    ///
+    /// This will return a `bio_vec`of size <= PAGE_SIZE
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    unsafe fn io_vec(&self) -> bindings::bio_vec {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe {
+            bindings::bio_vec {
+                bv_page: self.page(),
+                bv_len: self.len(),
+                bv_offset: self.offset(),
+            }
+        }
+    }
+
+    /// Get the currently indexed `bio_vec` entry.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn bvec(&self) -> &bindings::bio_vec {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By the safety requirement of this function and the type
+        // invariant of `Self`, `self.iter.bi_idx` indexes into a valid
+        // `bio_vec`
+        unsafe { self.bio.io_vec().offset(self.iter.bi_idx as isize).as_ref() }
+    }
+
+    /// Get the  as u32currently indexed page, indexing into pages of order >= 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn page(&self) -> *mut bindings::page {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By C API contract, the following offset cannot exceed pages
+        // allocated to this bio.
+        unsafe { self.mp_page().add(self.mp_page_idx()) }
+    }
+
+    /// Get the remaining bytes in the current page. Never more than PAGE_SIZE.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn len(&self) -> u32 {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe {
+            self.mp_len()
+                .min((bindings::PAGE_SIZE as u32) - self.offset())
+        }
+    }
+
+    /// Get the offset from the last page boundary in the currently indexed
+    /// `bio_vec` entry. Never more than PAGE_SIZE.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn offset(&self) -> u32 {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe { self.mp_offset() % (bindings::PAGE_SIZE as u32) }
+    }
+
+    /// Return the first page of the currently indexed `bio_vec` entry. This
+    /// might be a multi-page entry, meaning that page might have order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn mp_page(&self) -> *mut bindings::page {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe { self.bvec().bv_page }
+    }
+
+    /// Get the offset in whole pages into the currently indexed `bio_vec`. This
+    /// can be more than 0 is the page has order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn mp_page_idx(&self) -> usize {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        (unsafe { self.mp_offset() } / (bindings::PAGE_SIZE as u32)) as usize
+    }
+
+    /// Get the offset in the currently indexed `bio_vec` multi-page entry. This
+    /// can be more than `PAGE_SIZE` if the page has order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn mp_offset(&self) -> u32 {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        unsafe { self.bvec().bv_offset + self.iter.bi_bvec_done }
+    }
+
+    /// Get the number of remaining bytes for the currently indexed `bio_vec`
+    /// entry. Can be more than PAGE_SIZE for `bio_vec` entries with pages of
+    /// order > 0.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `self.iter.bi_size` > 0 before calling this
+    /// method.
+    #[inline(always)]
+    unsafe fn mp_len(&self) -> u32 {
+        debug_assert!(self.iter.bi_size > 0);
+        // SAFETY: By safety requirement of this function `self.iter.bi_size` is
+        // greater than 0.
+        self.iter
+            .bi_size
+            .min(unsafe { self.bvec().bv_len } - self.iter.bi_bvec_done)
+    }
+}
+
+impl<'a> core::iter::Iterator for BioSegmentIterator<'a> {
+    type Item = Segment<'a>;
+
+    #[inline(always)]
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.iter.bi_size == 0 {
+            return None;
+        }
+
+        // SAFETY: We checked that `self.iter.bi_size` > 0 above.
+        let bio_vec_ret = unsafe { self.io_vec() };
+
+        // SAFETY: By existence of reference `&bio`, `bio.0` contains a valid
+        // `struct bio`. By type invariant of `BioSegmentItarator` `self.iter`
+        // indexes into a valid `bio_vec` entry. By C API contracit, `bv_len`
+        // does not exceed the size of the bio.
+        unsafe {
+            bindings::bio_advance_iter_single(
+                self.bio.0.get(),
+                &raw mut self.iter,
+                bio_vec_ret.bv_len,
+            )
+        };
+
+        Some(Segment {
+            bio_vec: bio_vec_ret,
+            _marker: core::marker::PhantomData,
+        })
+    }
+}
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 0b14f584c9d9..98e54f0586d1 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -33,9 +33,15 @@
 use core::{
     ffi::c_void,
     marker::PhantomData,
+    pin::Pin,
     ptr::NonNull, //
 };
 
+use crate::block::bio::{
+    Bio,
+    BioIterator, //
+};
+
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
 /// # Lifetime
@@ -127,6 +133,49 @@ pub fn complete(this: ARef<Self>) {
         }
     }
 
+    /// Get a reference to the first [`Bio`] in this request.
+    #[inline(always)]
+    pub fn bio(&self) -> Option<&Bio> {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and the deref
+        // is safe.
+        let ptr = unsafe { (*self.0.get()).bio };
+        // SAFETY: By C API contract, if `bio` is not null it will have a
+        // positive refcount at least for the duration of the lifetime of
+        // `&self`.
+        unsafe { Bio::from_raw(ptr) }
+    }
+
+    /// Get a mutable reference to the first [`Bio`] in this request.
+    #[inline(always)]
+    pub fn bio_mut(self: Pin<&mut Self>) -> Option<Pin<&mut Bio>> {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and the deref
+        // is safe.
+        let ptr = unsafe { (*self.0.get()).bio };
+        // SAFETY: By C API contract, if `bio` is not null it will have a
+        // positive refcount at least for the duration of the lifetime of
+        // `&mut self`.
+        unsafe { Bio::from_raw_mut(ptr) }
+    }
+
+    /// Get an iterator over all bio structures in this request.
+    #[inline(always)]
+    pub fn bio_iter_mut<'a>(self: &'a mut Owned<Self>) -> BioIterator<'a> {
+        // INVARIANT: By C API contract, if the bio pointer is not null, it is a valid `struct bio`.
+        // `NonNull::new` will return `None` if the pointer is null.
+        BioIterator {
+            // SAFETY: By type invariant `self.0` is a valid `struct request`.
+            bio: NonNull::new(unsafe { (*self.0.get()).bio.cast() }),
+            _p: PhantomData,
+        }
+    }
+
+    /// Get the target sector for the request.
+    #[inline(always)]
+    pub fn sector(&self) -> usize {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
+        unsafe { (*self.0.get()).__sector as usize }
+    }
+
     /// Return a pointer to the [`RequestDataWrapper`] stored in the private area
     /// of the request structure.
     ///
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index e4585e1dba0c..a3473dabf587 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -282,7 +282,7 @@ fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {
     /// different addresses. However, even if the addresses are different, the underlying memory is
     /// still the same for these purposes (e.g., it's still a data race if they both write to the
     /// same underlying byte at the same time).
-    fn with_pointer_into_page<T>(
+    pub(crate) fn with_pointer_into_page<T>(
         &self,
         off: usize,
         len: usize,

-- 
2.51.2


