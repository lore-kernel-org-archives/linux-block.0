Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9022EA463;
	Fri, 11 Jul 2025 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234261; cv=none; b=X3MADSiFNM3+yppTpV0Bkihf8N4ek6tXsxdJMo+C2liPnfCCrss8wE6tgZktiZJy/PDKuNKbwEB0Pq3xYjMoLmLPWLWa7GIaVHVtj8hU8wiGQFXECy/meNNTZP6205jzixWJBoOInK9CXXKnsNnp8sJeVuBghXVLNzPwmC5184g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234261; c=relaxed/simple;
	bh=8EIFORhiI91k51v/6Z1Q3xAZrwAWnbDgqdU03+cKtQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iVM5WpG2oFz48C8jZgCVzgYCbb/ymjSAz57w1RbH7IHn7C2+8jUfKTA/DN9kIrWLGt8F6dLVOwrhbJVbNj4YzSDtDOq7Y42gxQzMowY7CqexJ18hczxRVv1rlD+WF1DhRJhiuGIA9M0mniJVg//R+Hi4fYneeiiejgttuvPZgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRTR66LG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRTR66LG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C3BC4CEF4;
	Fri, 11 Jul 2025 11:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234261;
	bh=8EIFORhiI91k51v/6Z1Q3xAZrwAWnbDgqdU03+cKtQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GRTR66LGeIw1pQOogW+oWfnhyELRcFY+yjk7HUDxGdg/MKeDxTZvdgYD7IubnwCgI
	 VWzL164fr3lI2W5+q4n3F+lo7MRFCpuV/XGkEgf9LnsTSlw4JPfySv+J9Wi6ILIIVY
	 pfwGef1SbSM2oq7N4qKyjE+koawP6zbkOimRXzRz2NX9rU5DCFWe5BKDY2VDydsWNi
	 OkjBH7XHDpKFyILZRoTmwLFKRL03edsX7236U0JXJZ8L1E1jFWwhBriLlnQ2tPTAoI
	 g3R3n5rPIDGEhXGdTlhsCVm+nQMkbxrtvH2/ykAPhGTkUr36PMnbCCSzzt39lTF6uE
	 HvDKBrZbyHrQg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:14 +0200
Subject: [PATCH v3 13/16] rust: block: add `GenDisk` private data support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-13-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10555;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=8EIFORhiI91k51v/6Z1Q3xAZrwAWnbDgqdU03+cKtQI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjVt9ul3aKi8XBriFTHyx6qC0mFonSLdusJW
 IMtNoUaikKJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD41QAKCRDhuBo+eShj
 d5tBD/0UoubIR3NJ4xd2RrvxL2tZIKTKSQpq/X6fbRiYTOLR6zLJrM51HQXBbnxVTkwOBy1rS4m
 HJ89jeYaq/2r5PYPerMPwPumPQnVqfVrt4TkgZNq+AJhOK44C9eui9h45b4PNR0bJKn9hfAtSDM
 rf5kECy9w9yS+T1kDjSw0tPSq1BdfKegvaJmxsAv2ckODxy2EKibCg/qMiLO1MjpNkfHym1ueq6
 j9N0lDbnm7nyAzNeonphKLyolbUTBwpR3/5UgywOOKWD2KuYoASsjZwpeFjAUErnx2mR+f2ryMh
 itkcHoQUFSCujnMu2jIPYfFq8IhHN47Lvn0oLUjUc8oscrx0FAdGFr0CNlxSGAWiWHZPaCjkoy0
 a7FnZyXKQoK0SnXCPARdShKpY0YTOsFn+oU19eRpxsplfxFUiBTzzITSqQw2F62+kmkI6DzLIs/
 ivQVtQ8YDRyV1lBHKE2URaQ9wjSrFODyjEUQCUTpfMkJMdQcBRKQa68IMkTAMaGDJ1CQDXVOe83
 GrfH4EVqdy4wLUt67E0tdisBM55s77SLxmhpAljpvmfSxcWIpTNAkGgLlv0Dzg/aJKQJG+KF4Uh
 qShRCdQlHDbXDd1QK1YB37PO8nrPB1vOb7XT/0HbfFaEFSIRAqu/FHW4vGQS6LBEojdF7T/HIjw
 NPPzNcCGr3QRKlg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow users of the rust block device driver API to install private data in
the `GenDisk` structure.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       |  8 ++++---
 rust/kernel/block/mq.rs            |  7 +++---
 rust/kernel/block/mq/gen_disk.rs   | 32 ++++++++++++++++++++++----
 rust/kernel/block/mq/operations.rs | 46 ++++++++++++++++++++++++++++++--------
 4 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index d09bc77861e4..a012c59ecb3c 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -62,14 +62,16 @@ fn new(
             .logical_block_size(block_size)?
             .physical_block_size(block_size)?
             .rotational(rotational)
-            .build(fmt!("{}", name.to_str()?), tagset)
+            .build(fmt!("{}", name.to_str()?), tagset, ())
     }
 }
 
 #[vtable]
 impl Operations for NullBlkDevice {
+    type QueueData = ();
+
     #[inline(always)]
-    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+    fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
         mq::Request::end_ok(rq)
             .map_err(|_e| kernel::error::code::EIO)
             // We take no refcounts on the request, so we expect to be able to
@@ -80,5 +82,5 @@ fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
         Ok(())
     }
 
-    fn commit_rqs() {}
+    fn commit_rqs(_queue_data: ()) {}
 }
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index faa3ccb5a49a..34b7425fa94d 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -69,20 +69,21 @@
 //!
 //! #[vtable]
 //! impl Operations for MyBlkDevice {
+//!     type QueueData = ();
 //!
-//!     fn queue_rq(rq: ARef<Request<Self>>, _is_last: bool) -> Result {
+//!     fn queue_rq(_queue_data: (), rq: ARef<Request<Self>>, _is_last: bool) -> Result {
 //!         Request::end_ok(rq);
 //!         Ok(())
 //!     }
 //!
-//!     fn commit_rqs() {}
+//!     fn commit_rqs(_queue_data: ()) {}
 //! }
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(format_args!("myblk"), tagset)?;
+//!     .build(format_args!("myblk"), tagset, ())?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 7ab049ec591b..954bc64cfa59 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -12,6 +12,7 @@
     static_lock_class,
     str::NullTerminatedFormatter,
     sync::Arc,
+    types::{ForeignOwnable, ScopeGuard},
 };
 use core::fmt::{self, Write};
 
@@ -97,7 +98,14 @@ pub fn build<T: Operations>(
         self,
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
+        queue_data: T::QueueData,
     ) -> Result<GenDisk<T>> {
+        let data = queue_data.into_foreign();
+        let recover_data = ScopeGuard::new(|| {
+            // SAFETY: T::QueueData was created by the call to `into_foreign()` above
+            unsafe { T::QueueData::from_foreign(data) };
+        });
+
         // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
         let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
 
@@ -112,7 +120,7 @@ pub fn build<T: Operations>(
             bindings::__blk_mq_alloc_disk(
                 tagset.raw_tag_set(),
                 &mut lim,
-                core::ptr::null_mut(),
+                data.cast(),
                 static_lock_class!().as_ptr(),
             )
         })?;
@@ -166,8 +174,12 @@ pub fn build<T: Operations>(
             },
         )?;
 
+        recover_data.dismiss();
+
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
+        // INVARIANT: `gendisk.queue.queue_data` is set to `data` in the call to
+        // `__blk_mq_alloc_disk` above.
         Ok(GenDisk {
             _tagset: tagset,
             gendisk,
@@ -179,9 +191,10 @@ pub fn build<T: Operations>(
 ///
 /// # Invariants
 ///
-/// - `gendisk` must always point to an initialized and valid `struct gendisk`.
-/// - `gendisk` was added to the VFS through a call to
-///   `bindings::device_add_disk`.
+///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
+///  - `gendisk` was added to the VFS through a call to
+///    `bindings::device_add_disk`.
+///  - `self.gendisk.queue.queuedata` is initialized by a call to `ForeignOwnable::into_foreign`.
 pub struct GenDisk<T: Operations> {
     _tagset: Arc<TagSet<T>>,
     gendisk: *mut bindings::gendisk,
@@ -193,9 +206,20 @@ unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
 
 impl<T: Operations> Drop for GenDisk<T> {
     fn drop(&mut self) {
+        // SAFETY: By type invariant of `Self`, `self.gendisk` points to a valid
+        // and initialized instance of `struct gendisk`, and, `queuedata` was
+        // initialized with the result of a call to
+        // `ForeignOwnable::into_foreign`.
+        let queue_data = unsafe { (*(*self.gendisk).queue).queuedata };
+
         // SAFETY: By type invariant, `self.gendisk` points to a valid and
         // initialized instance of `struct gendisk`, and it was previously added
         // to the VFS.
         unsafe { bindings::del_gendisk(self.gendisk) };
+
+        // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
+        // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
+        // `ForeignOwnable::from_foreign` is only called here.
+        let _queue_data = unsafe { T::QueueData::from_foreign(queue_data.cast()) };
     }
 }
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 864ff379dc91..c50959d5517b 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -6,14 +6,15 @@
 
 use crate::{
     bindings,
-    block::mq::request::RequestDataWrapper,
-    block::mq::Request,
+    block::mq::{request::RequestDataWrapper, Request},
     error::{from_result, Result},
     prelude::*,
-    types::ARef,
+    types::{ARef, ForeignOwnable},
 };
 use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
 
+type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
+
 /// Implement this trait to interface blk-mq as block devices.
 ///
 /// To implement a block device driver, implement this trait as described in the
@@ -26,12 +27,20 @@
 /// [module level documentation]: kernel::block::mq
 #[macros::vtable]
 pub trait Operations: Sized {
+    /// Data associated with the `struct request_queue` that is allocated for
+    /// the `GenDisk` associated with this `Operations` implementation.
+    type QueueData: ForeignOwnable;
+
     /// Called by the kernel to queue a request with the driver. If `is_last` is
     /// `false`, the driver is allowed to defer committing the request.
-    fn queue_rq(rq: ARef<Request<Self>>, is_last: bool) -> Result;
+    fn queue_rq(
+        queue_data: ForeignBorrowed<'_, Self::QueueData>,
+        rq: ARef<Request<Self>>,
+        is_last: bool,
+    ) -> Result;
 
     /// Called by the kernel to indicate that queued requests should be submitted.
-    fn commit_rqs();
+    fn commit_rqs(queue_data: ForeignBorrowed<'_, Self::QueueData>);
 
     /// Called by the kernel to poll the device for completed requests. Only
     /// used for poll queues.
@@ -70,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
     ///   promise to not access the request until the driver calls
     ///   `bindings::blk_mq_end_request` for the request.
     unsafe extern "C" fn queue_rq_callback(
-        _hctx: *mut bindings::blk_mq_hw_ctx,
+        hctx: *mut bindings::blk_mq_hw_ctx,
         bd: *const bindings::blk_mq_queue_data,
     ) -> bindings::blk_status_t {
         // SAFETY: `bd.rq` is valid as required by the safety requirement for
@@ -88,10 +97,20 @@ impl<T: Operations> OperationsVTable<T> {
         //    reference counted by `ARef` until then.
         let rq = unsafe { Request::aref_from_raw((*bd).rq) };
 
+        // SAFETY: `hctx` is valid as required by this function.
+        let queue_data = unsafe { (*(*hctx).queue).queuedata };
+
+        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
+        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
+        // `ForeignOwnable::from_foreign()` is only called when the tagset is
+        // dropped, which happens after we are dropped.
+        let queue_data = unsafe { T::QueueData::borrow(queue_data.cast()) };
+
         // SAFETY: We have exclusive access and we just set the refcount above.
         unsafe { Request::start_unchecked(&rq) };
 
         let ret = T::queue_rq(
+            queue_data,
             rq,
             // SAFETY: `bd` is valid as required by the safety requirement for
             // this function.
@@ -110,9 +129,18 @@ impl<T: Operations> OperationsVTable<T> {
     ///
     /// # Safety
     ///
-    /// This function may only be called by blk-mq C infrastructure.
-    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_mq_hw_ctx) {
-        T::commit_rqs()
+    /// This function may only be called by blk-mq C infrastructure. The caller
+    /// must ensure that `hctx` is valid.
+    unsafe extern "C" fn commit_rqs_callback(hctx: *mut bindings::blk_mq_hw_ctx) {
+        // SAFETY: `hctx` is valid as required by this function.
+        let queue_data = unsafe { (*(*hctx).queue).queuedata };
+
+        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
+        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
+        // `ForeignOwnable::from_foreign()` is only called when the tagset is
+        // dropped, which happens after we are dropped.
+        let queue_data = unsafe { T::QueueData::borrow(queue_data.cast()) };
+        T::commit_rqs(queue_data)
     }
 
     /// This function is called by the C kernel. It is not currently

-- 
2.47.2


