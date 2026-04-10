Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43D346E67;
	Fri, 10 Apr 2026 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848870; cv=none; b=tWMefEHlhj6gjK+4dUja6v5mTL9xeQ5951wGNMbQPkE53yyI3ruim/1ja3ICTQkgQrm2FtRi4I5Q2q9SW5cHhZdt/6/sBSXryVH/lz/wN4Vq63AAQlXwCkStyIkSHw/fxzNWco8E2nxitNKeAeXJhd+hMwoB+PAAdPAO24N4YjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848870; c=relaxed/simple;
	bh=1hq+8GSFPHgRPoUOowCLhGZiv7DB7pZO3570hbY+EoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edV2dzIJMpSEliQ96HWc0U1O+kLOL7IkSBWBnIQD7Ma9A8YFScYrTkNE1xl0CYd2KCM9oZ0R42mrRDTYj9fjno5oOVMwxfF8oWiBN11wS/v9XZiQFxNjswAkqDWtExbnhno4GXgRfYbyjlSdF2yrVpk413KIByq2OkmpBvaUVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=ZsKZgXJm; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="ZsKZgXJm"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a4a05111;
	Sat, 11 Apr 2026 03:15:50 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] rust: block: mq: safely abstract the poll callback
Date: Fri, 10 Apr 2026 15:15:43 -0400
Message-Id: <20260410191544.2203201-2-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410191544.2203201-1-wenzhaoliao@ruc.edu.cn>
References: <20260410191544.2203201-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d78d270ce03a2kunmcbf66d2fda421
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE0aVhlNS0odGENCSR1PHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=ZsKZgXJmbOxNH3h/Lb5HMp1bQo3CvQUQRkx5vC8ieHr9lQwsrTJj1bbflxebpHpa6f9mVraJ/oc5hRMezq9o2Sg7mwzCisHjOxgqmWfZU7sEmUKnnhnNHdBRh7usTNOLJ3/oPKpRU6XKwOxLDsWxjahWOJIAth8lxI7NvLLVDkw=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=mnpe/xnoYGqfDVgZYdLLxn2gYvWrfYYkZ+mS1cCVgWw=;
	h=date:mime-version:subject:message-id:from;

Add a minimal poll abstraction for Rust blk-mq drivers.

Model the hardware queue context as a shared HwCtx borrow and map the
optional io_comp_batch pointer to Option<&IoCompBatch>. This keeps the
callback on borrowed data owned by blk-mq and avoids exposing raw
pointers in driver implementations.

Use a typed PollResult to represent either a completion count or a
request to stop polling, and wire the callback into the blk-mq vtable
behind HAS_POLL so existing drivers keep poll: None.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/kernel/block/mq.rs            |   2 +-
 rust/kernel/block/mq/operations.rs | 143 +++++++++++++++++++++++++++--
 2 files changed, 138 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1fd0d54dd549..a66e27401571 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -98,6 +98,6 @@
 mod request;
 mod tag_set;
 
-pub use operations::Operations;
+pub use operations::{HwCtx, IoCompBatch, Operations, PollResult};
 pub use request::Request;
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 8ad46129a52c..31e1d61f107d 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,12 +10,120 @@
     error::{from_result, Result},
     prelude::*,
     sync::{aref::ARef, Refcount},
-    types::ForeignOwnable,
+    types::{ForeignOwnable, Opaque},
 };
 use core::marker::PhantomData;
 
 type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
 
+/// A borrowed blk-mq hardware queue context.
+///
+/// # Invariants
+///
+/// [`HwCtx`] is a transparent wrapper around a live `bindings::blk_mq_hw_ctx`.
+#[repr(transparent)]
+pub struct HwCtx(Opaque<bindings::blk_mq_hw_ctx>);
+
+impl HwCtx {
+    /// Creates a reference to an [`HwCtx`] from a valid raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points to a live
+    /// `bindings::blk_mq_hw_ctx` for the duration of `'a`.
+    ///
+    /// The caller must also ensure that the returned reference is the only
+    /// Rust view used to access the underlying hardware context for the
+    /// duration of `'a`.
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::blk_mq_hw_ctx) -> &'a Self {
+        // SAFETY: `Self` is a transparent wrapper around `bindings::blk_mq_hw_ctx`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns a raw pointer to the underlying `struct blk_mq_hw_ctx`.
+    pub fn as_ptr(&self) -> *mut bindings::blk_mq_hw_ctx {
+        self as *const Self as *mut bindings::blk_mq_hw_ctx
+    }
+
+    /// Returns the index of this hardware queue.
+    pub fn queue_num(&self) -> u32 {
+        // SAFETY: By the type invariant, `self` wraps a live hardware context.
+        unsafe { (*self.as_ptr()).queue_num }
+    }
+}
+
+/// A borrowed blk-mq completion batching context.
+///
+/// # Invariants
+///
+/// [`IoCompBatch`] is a transparent wrapper around a live
+/// `bindings::io_comp_batch`.
+#[repr(transparent)]
+pub struct IoCompBatch(Opaque<bindings::io_comp_batch>);
+
+impl IoCompBatch {
+    /// Creates an optional reference to an [`IoCompBatch`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// If `ptr` is non-null, the caller must ensure that it points to a live
+    /// `bindings::io_comp_batch` for the duration of `'a`.
+    ///
+    /// The caller must also ensure that the returned reference is the only
+    /// Rust view used to access the underlying completion batch for the
+    /// duration of `'a`.
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::io_comp_batch) -> Option<&'a Self> {
+        if ptr.is_null() {
+            None
+        } else {
+            // SAFETY: `Self` is a transparent wrapper around `bindings::io_comp_batch`.
+            Some(unsafe { &*ptr.cast() })
+        }
+    }
+
+    /// Returns a raw pointer to the underlying `struct io_comp_batch`.
+    pub fn as_ptr(&self) -> *mut bindings::io_comp_batch {
+        self as *const Self as *mut bindings::io_comp_batch
+    }
+}
+
+/// Result returned from blk-mq poll callbacks.
+#[derive(Clone, Copy, Debug, Eq, PartialEq)]
+pub enum PollResult {
+    /// The driver completed the given number of requests.
+    Completed(u32),
+
+    /// The driver cannot make progress and blk-mq should stop polling.
+    Stop,
+}
+
+impl PollResult {
+    /// Returns a result indicating that no requests were completed.
+    pub const fn none() -> Self {
+        Self::Completed(0)
+    }
+
+    /// Returns a result indicating that `completed` requests were completed.
+    pub const fn completed(completed: u32) -> Self {
+        Self::Completed(completed)
+    }
+
+    /// Returns a result indicating that blk-mq should stop polling for now.
+    pub const fn stop() -> Self {
+        Self::Stop
+    }
+
+    fn as_raw(self) -> crate::ffi::c_int {
+        match self {
+            Self::Completed(completed) => {
+                debug_assert!(completed <= crate::ffi::c_int::MAX as u32);
+                completed as crate::ffi::c_int
+            }
+            Self::Stop => -1,
+        }
+    }
+}
+
 /// Implement this trait to interface blk-mq as block devices.
 ///
 /// To implement a block device driver, implement this trait as described in the
@@ -48,7 +156,11 @@ fn queue_rq(
 
     /// Called by the kernel to poll the device for completed requests. Only
     /// used for poll queues.
-    fn poll() -> bool {
+    fn poll(
+        _queue_data: ForeignBorrowed<'_, Self::QueueData>,
+        _hctx: &HwCtx,
+        _iob: Option<&IoCompBatch>,
+    ) -> PollResult {
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
 }
@@ -168,12 +280,31 @@ impl<T: Operations> OperationsVTable<T> {
     ///
     /// # Safety
     ///
-    /// This function may only be called by blk-mq C infrastructure.
+    /// This function may only be called by blk-mq C infrastructure. The caller
+    /// must ensure that `hctx` is valid. If non-null, `iob` must point to a
+    /// live completion batch for the duration of this callback.
     unsafe extern "C" fn poll_callback(
-        _hctx: *mut bindings::blk_mq_hw_ctx,
-        _iob: *mut bindings::io_comp_batch,
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        iob: *mut bindings::io_comp_batch,
     ) -> crate::ffi::c_int {
-        T::poll().into()
+        // SAFETY: `hctx` is valid as required by this function.
+        let hctx = unsafe { HwCtx::from_raw(hctx) };
+
+        // SAFETY: `hctx` is live as required by this function, so the request
+        // queue and its `queuedata` are also live for the duration of this
+        // callback.
+        let queue_data = unsafe { (*(*hctx.as_ptr()).queue).queuedata };
+
+        // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build`
+        // with a call to `ForeignOwnable::into_foreign` to create
+        // `queuedata`. `ForeignOwnable::from_foreign` is only called when the
+        // tagset is dropped, which happens after we are dropped.
+        let queue_data = unsafe { T::QueueData::borrow(queue_data) };
+
+        // SAFETY: If non-null, `iob` is valid as required by this function.
+        let iob = unsafe { IoCompBatch::from_raw(iob) };
+
+        T::poll(queue_data, hctx, iob).as_raw()
     }
 
     /// This function is called by the C kernel. A pointer to this function is
-- 
2.34.1

