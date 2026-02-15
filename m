Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2BC2DC77A;
	Sun, 15 Feb 2026 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199036; cv=none; b=KTCH/EnwJke/npVad6bwCNNoWeYEIxG1s2KX0OTOout3+mu4EVNj9LTQf/oMS+x580Lx76MbacaCyI63BRKGbaaS4uv8PHLPNYdsBWSytMnWw4CBQEjtAGQtIIjbq/1KgLePMzmNvNU8V+fKeIuV2hByemVWYNVUxZ5bavUJsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199036; c=relaxed/simple;
	bh=bBQ8yAcFgCBTwCDBWmKONawvvu9tlBRUpgl5zlaS9nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhDICN7ijL/ZdqUgsU79ksO96kwoQaXnKari++X0mZDgUJP/UeenXro7f/yRmgLNP/ZqGndDO2+mQfsRkGjFNDQJFMsOORzhzxnFkspmGE5j2nU85/tAcwQN+D5n94u46CBNSdkVihSnNyp4cOJP4ikBgz1b4evHfiDLYdfPz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6UrUbRs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6UrUbRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5095FC4CEF7;
	Sun, 15 Feb 2026 23:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199036;
	bh=bBQ8yAcFgCBTwCDBWmKONawvvu9tlBRUpgl5zlaS9nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n6UrUbRsU/eilmTFtnqrnuOQKsNAklT+OH9G9flbdBGqPlLm0qv+OggfwWEMbrrMB
	 Yn74kcGGmJRJFyn2vrxb4WcIcs9u6tFPY2bo5plpoOLDqGJLuJeTtB3TGaEnVvM8xN
	 etiyNQyo1q3gwIqw/f10uNDPobs0FyEbgvEjP96Ju0L4jKqg5Vl/G6pjUwj/qRuQhf
	 RUhR8lXMzv+MUzYX1Olb2IbPgQkD/S2THEAz620BIdE3w13KFGw2Nc4sTnx7wPOHyC
	 qdRPkNLHooJYpEjaVvo1m4gCyQtT/enAIILBRIpkbbmDYFeJa7nNsFTIj/q1SW03h0
	 /8hJ9B2n3BpsQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:21 +0100
Subject: [PATCH 34/79] block: rust: introduce an idle type state for
 `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-34-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13824;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=bBQ8yAcFgCBTwCDBWmKONawvvu9tlBRUpgl5zlaS9nw=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg6eftWJsbtc7ccT5eFMt9qD5FJDBCfQB9cw
 qVSpUuNqMaJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYOgAKCRDhuBo+eShj
 dxT7EACC2jKTAH6h3LBY12TZ2SyfT6bjGFjPmw/FiOhMk2oeO+YHkqt2kEUTxtWXY1Fyz+kYQVA
 BwIALV/KI5VtSHgnVABoOv1g9N1To0X/DMhJCQ7v8LjjJ8/Gb+MDgl0RD5m8/4vfZMq49uUmztX
 PqTGCObV+CZrYmzh3OY0dIjcKu8YSZMJweQ7dKm93/40dwFUVCGRiqYsATIX0+1DKkY8T99xH+s
 PpbgKRo4U2pjbUOnGc4VEeanV7F/gbwxiU62W3YktWG9uoa4eEH7w4FcqIxRmhqUv+5Q2Ag7qxX
 ap8tS2XW9hVLV1cwgA+dbatAF1Ta9yZioFY7mJ2Q7vnmDvDZ9vIFbQEI5j4Cg9EwBzvnctdUUem
 sxSClSrn2/p9JsYZ/Qgd+FNa+xrOIQ4pSIOoLj0X2nYZ6QqIqRkQSSFc+UkTfjUeOuUctrPnuAD
 x5Fa9OrI+wqK8m0JCSI3olhEdJ/ZXcJe1WCVklaAGFa4rsxjXpoUMRwE+mJxcok6Uxcyt1bRPbp
 dcC0iTrmW+oWBaXXgawIZmfpBLeUg7RE588FHzeYIn3B10XoMH40boiJrq8OHDrG3/2pt7w+KKb
 p24ynnpY1kOiqse2xzxQDSijN0+GrNHZH+mYDVjZXUEmM/kxDNqArE53275wlEorov82Im7fgwa
 uRkoFc1wpUn0LPA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Block device drivers need to invoke `blk_mq_start_request` on a request to
indicate that they have started processing the request. This function may
only be called once after a request has been issued to a driver. For Rust
block device drivers, the Rust abstractions handle this call. However, in
some situations a driver may want to control when a request is started.
Thus, expose the start method to Rust block device drivers.

To ensure the method is not called more than once, introduce a type state
for `Request`. Requests are issued as `IdleRequest` and transition to
`Request` when the `start` method is called.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       |   3 +-
 rust/kernel/block/mq.rs            |   5 +-
 rust/kernel/block/mq/operations.rs |  13 ++--
 rust/kernel/block/mq/request.rs    | 155 ++++++++++++++++++++++++++++++-------
 4 files changed, 136 insertions(+), 40 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index aa59ede72e495..034ddc06eabf9 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -575,9 +575,10 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
     fn queue_rq(
         hw_data: Pin<&SpinLock<HwQueueContext>>,
         this: Pin<&Self>,
-        mut rq: Owned<mq::Request<Self>>,
+        rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
     ) -> Result {
+        let mut rq = rq.start();
         let mut sectors = rq.sectors();
 
         Self::handle_bad_blocks(this.get_ref(), &mut rq, &mut sectors)?;
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 3eab3ca8f5480..ab493bd91af4c 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -88,10 +88,10 @@
 //!     fn queue_rq(
 //!         _hw_data: (),
 //!         _queue_data: (),
-//!         rq: Owned<Request<Self>>,
+//!         rq: Owned<IdleRequest<Self>>,
 //!         _is_last: bool
 //!     ) -> Result {
-//!         rq.end_ok();
+//!         rq.start().end_ok();
 //!         Ok(())
 //!     }
 //!
@@ -130,6 +130,7 @@
 pub mod tag_set;
 
 pub use operations::Operations;
+pub use request::IdleRequest;
 pub use request::Request;
 pub use request::RequestTimerHandle;
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 6641c340d87f4..fb75d65f67071 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -6,13 +6,13 @@
 
 use crate::{
     bindings,
-    block::mq::{request::RequestDataWrapper, Request},
+    block::mq::{request::RequestDataWrapper, IdleRequest, Request},
     error::{from_result, Result},
     prelude::*,
     sync::{aref::ARef, atomic::ordering, Refcount},
     types::{ForeignOwnable, Owned},
 };
-use core::{marker::PhantomData, ptr::NonNull};
+use core::marker::PhantomData;
 use pin_init::PinInit;
 
 type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
@@ -60,7 +60,7 @@ pub trait Operations: Sized {
     fn queue_rq(
         hw_data: ForeignBorrowed<'_, Self::HwData>,
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
-        rq: Owned<Request<Self>>,
+        rq: Owned<IdleRequest<Self>>,
         is_last: bool,
     ) -> Result;
 
@@ -132,14 +132,14 @@ impl<T: Operations> OperationsVTable<T> {
                 == 0
         );
 
+        // INVARIANT: By C API contract, `bd.rq` has not been started yet.
         // SAFETY:
         //  - By API contract, we own the request.
         //  - By the safety requirements of this function, `request` is a valid
         //    `struct request` and the private data is properly initialized.
         //  - `rq` will be alive until `blk_mq_end_request` is called and is
         //    reference counted by until then.
-        let mut rq =
-            unsafe { Owned::from_raw(NonNull::<Request<T>>::new_unchecked((*bd).rq.cast())) };
+        let rq = unsafe { IdleRequest::from_raw((*bd).rq) };
 
         // SAFETY: The safety requirement for this function ensure that `hctx`
         // is valid and that `driver_data` was produced by a call to
@@ -155,9 +155,6 @@ impl<T: Operations> OperationsVTable<T> {
         // dropped, which happens after we are dropped.
         let queue_data = unsafe { T::QueueData::borrow(queue_data) };
 
-        // SAFETY: We have exclusive access and we just set the refcount above.
-        unsafe { rq.start_unchecked() };
-
         let ret = T::queue_rq(
             hw_data,
             queue_data,
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 38289b9f966fa..f6addd20624a9 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -15,13 +15,111 @@
     time::hrtimer::{
         HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, HrTimerMode, HrTimerPointer,
     },
-    types::{Opaque, Ownable, OwnableRefCounted, Owned},
+    types::{ForeignOwnable, Opaque, Ownable, OwnableRefCounted, Owned},
 };
-use core::{ffi::c_void, marker::PhantomData, ptr::NonNull};
+use core::{ffi::c_void, marker::PhantomData, ops::Deref, ptr::NonNull};
 
 use crate::block::bio::Bio;
 use crate::block::bio::BioIterator;
 
+/// A [`Request`] that a driver has not yet begun to process.
+///
+/// A driver can convert an `IdleRequest` to a [`Request`] by calling [`IdleRequest::start`].
+///
+/// # Invariants
+///
+/// - This request has not been started yet.
+#[repr(transparent)]
+pub struct IdleRequest<T>(RequestInner<T>);
+
+impl<T: Operations> IdleRequest<T> {
+    /// Mark the request as processing.
+    ///
+    /// This converts the [`IdleRequest`] into a [`Request`].
+    pub fn start(self: Owned<Self>) -> Owned<Request<T>> {
+        // SAFETY: By type invariant `self.0.0` is a valid request. Because we have an `Owned<_>`,
+        // the refcount is zero.
+        let mut request = unsafe { Request::from_raw(self.0 .0.get()) };
+
+        debug_assert!(
+            request
+                .wrapper_ref()
+                .refcount()
+                .as_atomic()
+                .load(ordering::Acquire)
+                == 0
+        );
+
+        // SAFETY: We have exclusive access and the refcount is 0. By type invariant `request` was
+        // not started yet.
+        unsafe { request.start_unchecked() };
+
+        request
+    }
+
+    /// Create a [`Self`] from a raw request pointer.
+    ///
+    /// # Safety
+    ///
+    /// - The request pointed to by `ptr` must satisfythe invariants of both [`Request`] and
+    ///   [`Self`].
+    /// - The refcount of the request pointed to by `ptr` must be 0.
+    pub(crate) unsafe fn from_raw(ptr: *mut bindings::request) -> Owned<Self> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as an `IdleRequest`.
+        unsafe { Owned::from_raw(NonNull::<Self>::new_unchecked(ptr.cast())) }
+    }
+}
+
+// SAFETY: The `release` implementation leaks the `IdleRequest`, which is a valid state for a
+// [`Request`] with refcount 0.
+unsafe impl<T: Operations> Ownable for IdleRequest<T> {
+    unsafe fn release(_this: NonNull<Self>) {}
+}
+
+impl<T: Operations> Deref for IdleRequest<T> {
+    type Target = RequestInner<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+pub struct RequestInner<T>(Opaque<bindings::request>, PhantomData<T>);
+
+impl<T: Operations> RequestInner<T> {
+    /// Get the command identifier for the request
+    pub fn command(&self) -> u32 {
+        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
+        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BITS) - 1) }
+    }
+
+    /// Get the target sector for the request.
+    #[inline(always)]
+    pub fn sector(&self) -> u64 {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
+        unsafe { (*self.0.get()).__sector }
+    }
+
+    /// Get the size of the request in number of sectors.
+    #[inline(always)]
+    pub fn sectors(&self) -> u32 {
+        self.bytes() >> crate::block::SECTOR_SHIFT
+    }
+
+    /// Get the size of the request in bytes.
+    #[inline(always)]
+    pub fn bytes(&self) -> u32 {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
+        unsafe { (*self.0.get()).__data_len }
+    }
+
+    /// Borrow the queue data from the request queue associated with this request.
+    pub fn queue_data(&self) -> <T::QueueData as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: By type invariants of `Request`, `self.0` is a valid request.
+        unsafe { T::QueueData::borrow((*(*self.0.get()).q).queuedata) }
+    }
+}
+
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
 /// # Implementation details
@@ -58,9 +156,28 @@
 /// [`struct request`]: srctree/include/linux/blk-mq.h
 ///
 #[repr(transparent)]
-pub struct Request<T>(Opaque<bindings::request>, PhantomData<T>);
+pub struct Request<T>(RequestInner<T>);
+
+impl<T: Operations> Deref for Request<T> {
+    type Target = RequestInner<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
 
 impl<T: Operations> Request<T> {
+    /// Create a `Owned<Request>` from a request pointer.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` must satisfy invariants of `Request`.
+    /// - The refcount of the request pointed to by `ptr` must be 0.
+    pub(crate) unsafe fn from_raw(ptr: *mut bindings::request) -> Owned<Self> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as `Owned<Request>`.
+        unsafe { Owned::from_raw(NonNull::<Self>::new_unchecked(ptr.cast())) }
+    }
+
     /// Create an [`ARef<Request>`] from a [`struct request`] pointer.
     ///
     /// # Safety
@@ -78,12 +195,6 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
         unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
     }
 
-    /// Get the command identifier for the request
-    pub fn command(&self) -> u32 {
-        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
-        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BITS) - 1) }
-    }
-
     /// Complete the request by scheduling `Operations::complete` for
     /// execution.
     ///
@@ -106,7 +217,7 @@ pub fn complete(this: ARef<Self>) {
     pub fn bio(&self) -> Option<&Bio> {
         // SAFETY: By type invariant of `Self`, `self.0` is valid and the deref
         // is safe.
-        let ptr = unsafe { (*self.0.get()).bio };
+        let ptr = unsafe { (*self.0 .0.get()).bio };
         // SAFETY: By C API contract, if `bio` is not null it will have a
         // positive refcount at least for the duration of the lifetime of
         // `&self`.
@@ -118,7 +229,7 @@ pub fn bio(&self) -> Option<&Bio> {
     pub fn bio_mut(&mut self) -> Option<&mut Bio> {
         // SAFETY: By type invariant of `Self`, `self.0` is valid and the deref
         // is safe.
-        let ptr = unsafe { (*self.0.get()).bio };
+        let ptr = unsafe { (*self.0 .0.get()).bio };
         // SAFETY: By C API contract, if `bio` is not null it will have a
         // positive refcount at least for the duration of the lifetime of
         // `&self`.
@@ -132,25 +243,11 @@ pub fn bio_iter_mut<'a>(self: &'a mut Owned<Self>) -> BioIterator<'a> {
         // `NonNull::new` will return `None` if the pointer is null.
         BioIterator {
             // SAFETY: By type invariant `self.0` is a valid `struct request`.
-            bio: NonNull::new(unsafe { (*self.0.get()).bio.cast() }),
+            bio: NonNull::new(unsafe { (*self.0 .0.get()).bio.cast() }),
             _p: PhantomData,
         }
     }
 
-    /// Get the target sector for the request.
-    #[inline(always)]
-    pub fn sector(&self) -> u64 {
-        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
-        unsafe { (*self.0.get()).__sector }
-    }
-
-    /// Get the size of the request in number of sectors.
-    #[inline(always)]
-    pub fn sectors(&self) -> u32 {
-        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
-        (unsafe { (*self.0.get()).__data_len }) >> crate::block::SECTOR_SHIFT
-    }
-
     /// Return a pointer to the [`RequestDataWrapper`] stored in the private area
     /// of the request structure.
     ///
@@ -289,10 +386,10 @@ impl<T: Operations> Owned<Request<T>> {
     /// `self.wrapper_ref().refcount() == 0`.
     ///
     /// This can only be called once in the request life cycle.
-    pub(crate) unsafe fn start_unchecked(&mut self) {
+    pub unsafe fn start_unchecked(&mut self) {
         // SAFETY: By type invariant, `self.0` is a valid `struct request` and
         // we have exclusive access.
-        unsafe { bindings::blk_mq_start_request(self.0.get()) };
+        unsafe { bindings::blk_mq_start_request(self.0 .0.get()) };
     }
 
     /// Notify the block layer that the request has been completed without errors.
@@ -302,7 +399,7 @@ pub fn end_ok(self) {
 
     /// Notify the block layer that the request has been completed.
     pub fn end(self, status: u8) {
-        let request_ptr = self.0.get().cast();
+        let request_ptr = self.0 .0.get().cast();
         core::mem::forget(self);
         // SAFETY: By type invariant, `this.0` was a valid `struct request`. The
         // existence of `self` guarantees that there are no `ARef`s pointing to

-- 
2.51.2


