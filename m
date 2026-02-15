Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E32312803;
	Sun, 15 Feb 2026 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199200; cv=none; b=C/2B8l3zQT+x9Bceo+G9M++zTwrOSE+liB5ji0NyTWFZQlT8HE+FX6P67jBx0pd11nE//S01m0Uv6dLLxXUZ3S28LnhEZPEHAbJ1SsGAMho8UlsRWAizVT4RRFypPtuplAW/GOfXCXEwbHzhJEwIAxKX8nLUHJuhVrtITzVvJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199200; c=relaxed/simple;
	bh=V7NPmcHt489UPhx819RkTB11oJ7rpInWWLTHwSOdN0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PT3or5V3XEdjUipF2y3i00Kd3thd/4zTzhq6rBVGyfR8NjqudX6M1QGdTLT2dZRgYowBazP4l7oZ0NAzmvIbB3T3RtAfvReOTvfY4MTau5LuMEjxyh4iKwbhYCKEkeyMeYkOyGBP+mpnGI6TrIcQNdzLTfxfr9niMafk1k5LPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOAAWiOD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOAAWiOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7043DC4CEF7;
	Sun, 15 Feb 2026 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199200;
	bh=V7NPmcHt489UPhx819RkTB11oJ7rpInWWLTHwSOdN0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QOAAWiODki0/fVEd+vwj3qIdMPRlM/t1Wt0oN/BXImgWeFtx+e7pHGr/rrOldFWHW
	 Qq5WsoutXlj/lz9xAQ8S/osGEmSW1h5JM4OWOtGphjFd6aBOsyBlDshTGy+PJ9a6NS
	 sm9BwJt/4JxJD/aim4CEBeVdRT/IbTo5V4Oh3+iOen7SGETNd7v6e/icRmt+uNDqKt
	 dQhKsEQ+QiMqvb6q07pVlYQFDwSx2B92Wcq1aV5DQiU3MMedDVkgfjtKTjn7b/7hKW
	 j1fEcxeA1awXgYmE02RtIiYkeCzhdq1E/DBY3wtJ+WYVqFjNG1BzN724aDSYIjpz/B
	 nXXddZuJ2B0/w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:17 +0100
Subject: [PATCH 30/79] block: rust: add `hctx` private data support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-30-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11810;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=V7NPmcHt489UPhx819RkTB11oJ7rpInWWLTHwSOdN0k=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg2hepO/XMsV/RoMZ08ue9FZTE5Lj97prJGD
 j8WSlxnqgOJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYNgAKCRDhuBo+eShj
 d+EKD/9u8LB3MZ2sU5dzRt1fQ1mTyKDY3Y4tuS/8D47vQY5WL29VWojTttVXM62mDObm1xTLHde
 6y2lYsO4hRrH+mB2SJnSx4ygR13sIWFKhLjVtwB/Q6uOj/cS049/8c2wDvaIdj/rtvlttrDdKqL
 HvAmiykeVZukA9xzP8OAY7bENI49gLT0u10mccqkfMahAqAqRsS6RMBGsTZ4Nk4boXYXIoe/JjA
 2ANAoJmns8NzTtiHJAUsXL/zAge5zAn9kaNfEhSXVAriMC+5Xiaq832sUWMPeGnu3QW24aBc4dk
 BJ3fF10wT2+sC88QFzHc0aU5FaTDJONchPfXk2pVuglhVA3m5eF3cLHUSKXEdJraCvfRPxLFvS8
 AhQ/4D14KsSIUITCXytGv2RQL9AM4D1DhO5/dgckrJPRA8gCTUhe2o7NtrJyt5DS2IEmyiJAq38
 g4qycoOGZHQmxq2XCPzNDy++RkTIq3pJyOs7Odm65g2nrNPEO0OJJX6+11xOWSFDSEGkRNSqpcg
 naKWE/RVHDizTPOU1na0zdD8W2isxPUiE0lJdT1Gs4cSCci1bZLZd8XJURL4NPc7RGy3akPG1aF
 ulSl5POtOg9MQxfFF7qt/1QWFUJsE1P2gWtHiZ71LP8gpSw3vXsHTXdOtbv9wHNbymiikWE1i5U
 wgVtNsa9xbE/Fsw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

C block device drivers can attach private data to a hardware context
(`struct blk_mq_hw_ctx`). Add support for this feature for Rust block
device drivers via the `Operations::HwData` associated type.

The private data is created in the `init_hctx` callback and stored in
the `driver_data` field of `blk_mq_hw_ctx`. It is passed to `queue_rq`,
`commit_rqs`, and `poll` callbacks, and is released in `exit_hctx`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       |  8 +++-
 rust/kernel/block/mq.rs            | 23 ++++++++++-
 rust/kernel/block/mq/operations.rs | 85 +++++++++++++++++++++++++++++++-------
 3 files changed, 97 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 9e8d085924040..4e226186d2f36 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -506,6 +506,7 @@ impl Operations for NullBlkDevice {
     type QueueData = Pin<KBox<QueueData>>;
     type RequestData = Pdu;
     type TagSetData = ();
+    type HwData = ();
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
@@ -516,6 +517,7 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
 
     #[inline(always)]
     fn queue_rq(
+        _hw_data: (),
         queue_data: Pin<&QueueData>,
         mut rq: Owned<mq::Request<Self>>,
         _is_last: bool,
@@ -546,7 +548,11 @@ fn queue_rq(
         Ok(())
     }
 
-    fn commit_rqs(_queue_data: Pin<&QueueData>) {}
+    fn commit_rqs(_hw_data: (), _queue_data: Pin<&QueueData>) {}
+
+    fn init_hctx(_tagset_data: (), _hctx_idx: u32) -> Result {
+        Ok(())
+    }
 
     fn complete(rq: ARef<mq::Request<Self>>) {
         Self::end_request(
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 415be31e9a777..3eab3ca8f5480 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -17,6 +17,12 @@
 //! - The [`GenDisk`] type that abstracts the C type `struct gendisk`.
 //! - The [`Request`] type that abstracts the C type `struct request`.
 //!
+//! Many of the C types that this module abstracts allow a driver to carry
+//! private data, either embedded in the struct directly, or as a C `void*`. In
+//! these abstractions, this data is typed. The types of the data is defined by
+//! associated types in `Operations`, see [`Operations::RequestData`] for an
+//! example.
+//!
 //! The kernel will interface with the block device driver by calling the method
 //! implementations of the `Operations` trait.
 //!
@@ -71,6 +77,7 @@
 //! impl Operations for MyBlkDevice {
 //!     type RequestData = ();
 //!     type QueueData = ();
+//!     type HwData = ();
 //!     type TagSetData = ();
 //!
 //!     fn new_request_data(
@@ -78,12 +85,17 @@
 //!         pin_init::zeroed::<()>()
 //!     }
 //!
-//!     fn queue_rq(_queue_data: (), rq: Owned<Request<Self>>, _is_last: bool) -> Result {
+//!     fn queue_rq(
+//!         _hw_data: (),
+//!         _queue_data: (),
+//!         rq: Owned<Request<Self>>,
+//!         _is_last: bool
+//!     ) -> Result {
 //!         rq.end_ok();
 //!         Ok(())
 //!     }
 //!
-//!     fn commit_rqs(_queue_data: ()) {}
+//!     fn commit_rqs(_hw_data: (), _queue_data: ()) {}
 //!
 //!     fn complete(rq: ARef<Request<Self>>) {
 //!         OwnableRefCounted::try_from_shared(rq)
@@ -91,6 +103,13 @@
 //!             .expect("Fatal error - expected to be able to end request")
 //!             .end_ok();
 //!     }
+//!
+//!     fn init_hctx(
+//!         _tagset_data: (),
+//!         _hctx_idx: u32,
+//!     ) -> Result<Self::HwData> {
+//!         Ok(())
+//!     }
 //! }
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 9aab6240428cc..6641c340d87f4 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -44,6 +44,10 @@ pub trait Operations: Sized {
     /// the `GenDisk` associated with this `Operations` implementation.
     type QueueData: ForeignOwnable;
 
+    /// Data associated with a dispatch queue. This is stored as a pointer in
+    /// the C `struct blk_mq_hw_ctx` that represents a hardware queue.
+    type HwData: ForeignOwnable;
+
     /// Data associated with a `TagSet`. This is stored as a pointer in `struct
     /// blk_mq_tag_set`.
     type TagSetData: ForeignOwnable;
@@ -54,20 +58,30 @@ pub trait Operations: Sized {
     /// Called by the kernel to queue a request with the driver. If `is_last` is
     /// `false`, the driver is allowed to defer committing the request.
     fn queue_rq(
+        hw_data: ForeignBorrowed<'_, Self::HwData>,
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
         rq: Owned<Request<Self>>,
         is_last: bool,
     ) -> Result;
 
     /// Called by the kernel to indicate that queued requests should be submitted.
-    fn commit_rqs(queue_data: ForeignBorrowed<'_, Self::QueueData>);
+    fn commit_rqs(
+        hw_data: ForeignBorrowed<'_, Self::HwData>,
+        queue_data: ForeignBorrowed<'_, Self::QueueData>,
+    );
+
+    /// Called by the kernel to allocate and initialize a driver specific hardware context data.
+    fn init_hctx(
+        tagset_data: ForeignBorrowed<'_, Self::TagSetData>,
+        hctx_idx: u32,
+    ) -> Result<Self::HwData>;
 
     /// Called by the kernel when the request is completed.
     fn complete(rq: ARef<Request<Self>>);
 
     /// Called by the kernel to poll the device for completed requests. Only
     /// used for poll queues.
-    fn poll() -> bool {
+    fn poll(_hw_data: ForeignBorrowed<'_, Self::HwData>) -> bool {
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
 }
@@ -127,6 +141,11 @@ impl<T: Operations> OperationsVTable<T> {
         let mut rq =
             unsafe { Owned::from_raw(NonNull::<Request<T>>::new_unchecked((*bd).rq.cast())) };
 
+        // SAFETY: The safety requirement for this function ensure that `hctx`
+        // is valid and that `driver_data` was produced by a call to
+        // `into_foreign` in `Self::init_hctx_callback`.
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+
         // SAFETY: `hctx` is valid as required by this function.
         let queue_data = unsafe { (*(*hctx).queue).queuedata };
 
@@ -140,6 +159,7 @@ impl<T: Operations> OperationsVTable<T> {
         unsafe { rq.start_unchecked() };
 
         let ret = T::queue_rq(
+            hw_data,
             queue_data,
             rq,
             // SAFETY: `bd` is valid as required by the safety requirement for
@@ -162,6 +182,10 @@ impl<T: Operations> OperationsVTable<T> {
     /// This function may only be called by blk-mq C infrastructure. The caller
     /// must ensure that `hctx` is valid.
     unsafe extern "C" fn commit_rqs_callback(hctx: *mut bindings::blk_mq_hw_ctx) {
+        // SAFETY: `driver_data` was installed by us in `init_hctx_callback` as
+        // the result of a call to `into_foreign`.
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+
         // SAFETY: `hctx` is valid as required by this function.
         let queue_data = unsafe { (*(*hctx).queue).queuedata };
 
@@ -170,7 +194,7 @@ impl<T: Operations> OperationsVTable<T> {
         // `ForeignOwnable::from_foreign()` is only called when the tagset is
         // dropped, which happens after we are dropped.
         let queue_data = unsafe { T::QueueData::borrow(queue_data) };
-        T::commit_rqs(queue_data)
+        T::commit_rqs(hw_data, queue_data)
     }
 
     /// This function is called by the C kernel. A pointer to this function is
@@ -194,12 +218,18 @@ impl<T: Operations> OperationsVTable<T> {
     ///
     /// # Safety
     ///
-    /// This function may only be called by blk-mq C infrastructure.
+    /// This function may only be called by blk-mq C infrastructure. `hctx` must
+    /// be a pointer to a valid and aligned `struct blk_mq_hw_ctx` that was
+    /// previously initialized by a call to `init_hctx_callback`.
     unsafe extern "C" fn poll_callback(
-        _hctx: *mut bindings::blk_mq_hw_ctx,
+        hctx: *mut bindings::blk_mq_hw_ctx,
         _iob: *mut bindings::io_comp_batch,
     ) -> crate::ffi::c_int {
-        T::poll().into()
+        // SAFETY: By function safety requirement, `hctx` was initialized by
+        // `init_hctx_callback` and thus `driver_data` came from a call to
+        // `into_foreign`.
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+        T::poll(hw_data).into()
     }
 
     /// This function is called by the C kernel. A pointer to this function is
@@ -207,15 +237,29 @@ impl<T: Operations> OperationsVTable<T> {
     ///
     /// # Safety
     ///
-    /// This function may only be called by blk-mq C infrastructure. This
-    /// function may only be called once before `exit_hctx_callback` is called
-    /// for the same context.
+    /// This function may only be called by blk-mq C infrastructure.
+    /// `tagset_data` must be initialized by the initializer returned by
+    /// `TagSet::try_new` as part of tag set initialization. `hctx` must be a
+    /// pointer to a valid `blk_mq_hw_ctx` where the `driver_data` field was not
+    /// yet initialized. This function may only be called onece before
+    /// `exit_hctx_callback` is called for the same context.
     unsafe extern "C" fn init_hctx_callback(
-        _hctx: *mut bindings::blk_mq_hw_ctx,
-        _tagset_data: *mut crate::ffi::c_void,
-        _hctx_idx: crate::ffi::c_uint,
-    ) -> crate::ffi::c_int {
-        from_result(|| Ok(0))
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        tagset_data: *mut core::ffi::c_void,
+        hctx_idx: crate::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: By the safety requirements of this function,
+            // `tagset_data` came from a call to `into_foreign` when the
+            // `TagSet` was initialized.
+            let tagset_data = unsafe { T::TagSetData::borrow(tagset_data) };
+            let data = T::init_hctx(tagset_data, hctx_idx)?;
+
+            // SAFETY: by the safety requirments of this function, `hctx` is
+            // valid for write
+            unsafe { (*hctx).driver_data = data.into_foreign().cast() };
+            Ok(0)
+        })
     }
 
     /// This function is called by the C kernel. A pointer to this function is
@@ -223,11 +267,20 @@ impl<T: Operations> OperationsVTable<T> {
     ///
     /// # Safety
     ///
-    /// This function may only be called by blk-mq C infrastructure.
+    /// This function may only be called by blk-mq C infrastructure. `hctx` must
+    /// be a valid pointer that was previously initialized by a call to
+    /// `init_hctx_callback`. This function may be called only once after
+    /// `init_hctx_callback` was called.
     unsafe extern "C" fn exit_hctx_callback(
-        _hctx: *mut bindings::blk_mq_hw_ctx,
+        hctx: *mut bindings::blk_mq_hw_ctx,
         _hctx_idx: crate::ffi::c_uint,
     ) {
+        // SAFETY: By the safety requirements of this function, `hctx` is valid for read.
+        let ptr = unsafe { (*hctx).driver_data };
+
+        // SAFETY: By the safety requirements of this function, `ptr` came from
+        // a call to `into_foreign` in `init_hctx_callback`
+        unsafe { T::HwData::from_foreign(ptr) };
     }
 
     /// This function is called by the C kernel. A pointer to this function is

-- 
2.51.2


