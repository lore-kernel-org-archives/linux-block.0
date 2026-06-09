Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F83E44E6;
	Tue,  9 Jun 2026 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032534; cv=none; b=N7fBR5l+ndlD4QFmhO4OcC/CoJCarvqejzWAufgztq3P+MLENM0hXSVZr0zCC/Hdxk7ZdXLq355jZZpK7lGBgZnWYTaDwtAez6YpmkF1ZNV8LofUq+4W4aQ8e5PPX/BHCgwvf6CcpPCpPzx3LcLkon/INpm2ZFNV2BDPjj9fYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032534; c=relaxed/simple;
	bh=e88GUFL7aWGGbG4bgQFnEUpaUQZNG/CxzSPfdvkzNv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCWCan4RktIU7/MTSGTp1J/1SuFiFpo/jyrKKu749+dqrqPaiv6UWJGgCavhVSI9L1rDGfwatcOkErVAxpgA6fplKZMfQju5FPenOCdb40oFAxWXB5kXkCOYHurid6YQndEQRtVREnQJMVg64mvloDBk1n1Q/uASgbKcXL27wHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l88p8bP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l88p8bP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61991F00893;
	Tue,  9 Jun 2026 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032532;
	bh=uM6bRZfyW/+v1bt/o770rG+SNBq/AlbWF2/41XM/k+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l88p8bP6SypH1B3G9l7zVj9b/Pcn5qkGcYpYy46zP4wfP8aE311oYvWFaRV4RO94S
	 oHmeW5e/OcBjzKZ4ITwXpOFOkXKiELIvdD9/6UubvXMlI1Hc36Z/XtHvo7V418iSRM
	 +LFo1uWgrYARxP6CHGO4I9MOsTIjrOPJq+EDIg5+GQE4u7CVyQe63cGa7E53/G4hH7
	 cZluIg6rJosMrDFE8puMXRQt6FswTjEzufiFSaL2/1whSv9zpw06WX/3EhmFbQtJmF
	 Lmdy6b4gbeYjt+NaHpxf/30qFl8rkMv0qKdZ0hQs+K9Nbaq5EBhGu/7pyT5P26nXIb
	 Nmw2PAcqkkE4A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:17 +0200
Subject: [PATCH v2 38/83] block: rust: introduce an idle type state for
 `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-38-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13481;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=e88GUFL7aWGGbG4bgQFnEUpaUQZNG/CxzSPfdvkzNv0=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTXV79hhxFxeQyl4m6URu3O1sAL2/W5HbrDn
 t0kpZ/CGCuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk1wAKCRD6UCkIqsW9
 0LRcD/9DzJC8KbV9dHlUFIVG30iAFMsShgJ3JYDCft8sbI3kFYTWZ8dDgxFoIb3LNqW0f0+buvy
 SQBiqEjWo5N/X1z8pt8GEISdjmlx65DCP6YzlyOaligEtYRTWb+WsuzpH1QNoZXb/cjZCv1SH5h
 0VnQs+O+bCv0E2hPnmRs/AszUWrqGhE1zUL45q8RFEP3cr74XC3CD3yYeA/s+3DnaThsgxoB5+e
 tsU+LyHu5aobYPzpXceJq3YMnGyBmMkZEA15DRM6xsCWQaQfeMcmsiY6FLBZZpmSpAHd1zELrqD
 iuB0rADphtTBR48h7NgpLjdZunRG/Ml60tZq0J4lJgIpp2sh4hoefPyLGCRsR9bkmgth7awc3dY
 49FF42wxvUXgEjVdJK2e+2I13aSxEKnR6Jp1V1DGiUfY/QTjDVSARLVR5JkwuVUyt2k2FkdaHhP
 L9f3jEqZm+tKqFGAXXykd4xPz69V2I4C3MY9gupyaqVxx73oXBxF7lrdYoJkCw68V2+nd4/nC2D
 nc9YMrk2n2+p1Y5Jl0bgmO/2iyHVef+PCJQlMmpNFaxXFZtrT5NFlZkfKiZd3CgccNlAKy6pRmv
 MHEyHDR/euz69oewTesoEzGe4wCb238AKO2qcjUTGdThaoOTAkVUTSONhUyNj/RbQwxcmaQcvKf
 q9CI1PkB0P4i7ww==
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
 rust/kernel/block/mq/operations.rs |  15 ++--
 rust/kernel/block/mq/request.rs    | 149 +++++++++++++++++++++++++++++++------
 4 files changed, 137 insertions(+), 35 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index fd9b770965a6..bb8c4df08218 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -593,9 +593,10 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
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
index b095cc7f51ce..77e3593e8626 100644
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
@@ -131,6 +131,7 @@
 
 pub use operations::Operations;
 pub use request::{
+    IdleRequest,
     Request,
     RequestTimerHandle, //
 };
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 1b20df25d6df..01917ef213d1 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -8,6 +8,7 @@
     bindings,
     block::mq::{
         request::RequestDataWrapper,
+        IdleRequest,
         Request, //
     },
     error::{
@@ -25,10 +26,7 @@
         Owned, //
     },
 };
-use core::{
-    marker::PhantomData,
-    ptr::NonNull, //
-};
+use core::marker::PhantomData;
 use pin_init::PinInit;
 
 type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
@@ -82,7 +80,7 @@ pub trait Operations: Sized {
     fn queue_rq(
         hw_data: ForeignBorrowed<'_, Self::HwData>,
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
-        rq: Owned<Request<Self>>,
+        rq: Owned<IdleRequest<Self>>,
         is_last: bool,
     ) -> Result;
 
@@ -154,14 +152,14 @@ impl<T: Operations> OperationsVTable<T> {
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
@@ -177,9 +175,6 @@ impl<T: Operations> OperationsVTable<T> {
         // dropped, which happens after we are dropped.
         let queue_data = unsafe { T::QueueData::borrow(queue_data) };
 
-        // SAFETY: We have exclusive access and we just set the refcount above.
-        unsafe { rq.start_unchecked() };
-
         let ret = T::queue_rq(
             hw_data,
             queue_data,
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index c06907dfe5b5..f94e9c2181d0 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -24,6 +24,7 @@
         HrTimerPointer, //
     },
     types::{
+        ForeignOwnable,
         Opaque,
         Ownable,
         OwnableRefCounted,
@@ -33,6 +34,7 @@
 use core::{
     ffi::c_void,
     marker::PhantomData,
+    ops::Deref,
     pin::Pin,
     ptr::NonNull, //
 };
@@ -42,6 +44,104 @@
     BioIterator, //
 };
 
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
+impl<T: Operations> Ownable for IdleRequest<T> {
+    // The `release` implementation leaks the `IdleRequest`, which is a valid state for a
+    // [`Request`] with refcount 0.
+    unsafe fn release(&mut self) {}
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
 /// # Lifetime
@@ -96,9 +196,28 @@
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
@@ -120,7 +239,7 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
     pub fn command(&self) -> u32 {
         use core::ops::BitAnd;
         // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
-        unsafe { (*self.0.get()).cmd_flags }.bitand((1u32 << bindings::REQ_OP_BITS) - 1)
+        unsafe { (*self.0 .0.get()).cmd_flags }.bitand((1u32 << bindings::REQ_OP_BITS) - 1)
     }
 
     /// Complete the request by scheduling `Operations::complete` for
@@ -145,7 +264,7 @@ pub fn complete(this: ARef<Self>) {
     pub fn bio(&self) -> Option<&Bio> {
         // SAFETY: By type invariant of `Self`, `self.0` is valid and the deref
         // is safe.
-        let ptr = unsafe { (*self.0.get()).bio };
+        let ptr = unsafe { (*self.0 .0.get()).bio };
         // SAFETY: By C API contract, if `bio` is not null it will have a
         // positive refcount at least for the duration of the lifetime of
         // `&self`.
@@ -157,7 +276,7 @@ pub fn bio(&self) -> Option<&Bio> {
     pub fn bio_mut(self: Pin<&mut Self>) -> Option<Pin<&mut Bio>> {
         // SAFETY: By type invariant of `Self`, `self.0` is valid and the deref
         // is safe.
-        let ptr = unsafe { (*self.0.get()).bio };
+        let ptr = unsafe { (*self.0 .0.get()).bio };
         // SAFETY: By C API contract, if `bio` is not null it will have a
         // positive refcount at least for the duration of the lifetime of
         // `&mut self`.
@@ -171,25 +290,11 @@ pub fn bio_iter_mut<'a>(self: &'a mut Owned<Self>) -> BioIterator<'a> {
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
@@ -328,10 +433,10 @@ impl<T: Operations> Owned<Request<T>> {
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
@@ -341,7 +446,7 @@ pub fn end_ok(self) {
 
     /// Notify the block layer that the request has been completed.
     pub fn end(self, status: u8) {
-        let request_ptr = self.0.get().cast();
+        let request_ptr = self.0 .0.get().cast();
         core::mem::forget(self);
         // SAFETY: By type invariant, `this.0` was a valid `struct request`. The
         // existence of `self` guarantees that there are no `ARef`s pointing to

-- 
2.51.2


