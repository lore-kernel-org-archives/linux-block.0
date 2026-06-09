Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343324D8DAE;
	Tue,  9 Jun 2026 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032353; cv=none; b=iIEoICehqxVcsKH7zfBh0UunxsMM6QEDXd7itnT6IiZlGrC0QxJJOhW1VsoypvUw7NYUGJvf2gwMNJsDkrGEy+FthxUH8KquvYSoyEcbeky2VUsAj39auatpBWAkWqe6K4AMcgNxNFHuuLsql8HrqHSeShih8OHJKZ/uth4AcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032353; c=relaxed/simple;
	bh=jvXphF1O+UsOfmqE9+2fr5qdFdUFp0Su15fp0KlmVtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJDqxBptsR4XKMiNFqAy70cr6z7BgcPRhxfJQMlEvvX0Mac9e8wTY1GSgMlsDKGwc+gho2xbvV8r7aTR8OOFEmIG4B0fEd/sFCxzGAeGisO9X/EOFVhth8zb/5fll2BaVioVaqyfsvpvYSdjkxwDX3PkkAtenRRA0gi7IvgG+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSy6Rg6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSy6Rg6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DA61F00898;
	Tue,  9 Jun 2026 19:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032351;
	bh=SUQEGk99smJ7Pbi43ZJOTsp1NaneMcUaITRFaSewA98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GSy6Rg6jO9B6Pu9mRJmo9lpMn4MHZaZXKvOsHJMJZqrl0/9cXG/yrrRVMOqQ7W87l
	 GiUWGJNvYjqngYMk72RS6nSLp3zONB0bG0jR3YWL5IxOjJiuvpUrmILbpH2uZppNTH
	 n3KArJ4YGmyNi+s4H0689MlC3U9DX3pew9vU6WpKAu6aBGu7Z8RQ3DyRB0rUfs0CPv
	 W5z/K2xDOQkn7e87vjgwEJe5fkIEIz//dz1kVWDPT2kxq4VEdLtGDuiLCFbB+kUE/T
	 PEs4w6x3n1slayCv0OduXPCEhcxWExt79xQU8JBTmtJdt8C2g4t11aA4iYqDvl4okt
	 s/JfVUmD/SZtw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:35 +0200
Subject: [PATCH v2 56/83] block: rust: add polled completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-56-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9061; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=jvXphF1O+UsOfmqE9+2fr5qdFdUFp0Su15fp0KlmVtk=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTnPCCkwXRZ7EM9IraNe3j7/IC/hd8SjG0uX
 8HAWb/QjDSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk5wAKCRD6UCkIqsW9
 0FghD/4oHjyv4trDJ9ykJMai09g225CGdRs7Dd98wURQnYWZKMmo9oed9LXHMjZVQW0cEf0PCzS
 HZ5MGb1R2DCg9UTe620dVw6qHYiu8lUMsmyPGaoisZXkbcAi+Q2OvJiz4qzMZxZlpj00uVtEXll
 QQ35Curz4haeD8eXkVtOMOedpf4ghknAgQv11Bg1hnvNjrm9xPXOjl0ivnVEZc69wc+Yzeii3EU
 iR5P5it8A1Tt1UYHzyfdRJo02wJ2WK99Q3jognRcqOItoD6H4k8MzC7O1OERHAwY75XEWHaZkce
 CX2KM16gjTlV1NrEZsJO2g/MwRN/kA25H5DY0dJcg0Q8GZ7O+nJrlSZHYoY2uE3ZB54AQvBSzyR
 OkriCEAIl5vmtij+j5EPP0svxA47FWs6cSqlVUCf0E+vxKHPWlpv/Fne8f847nuc6zDuUZ45W9y
 uBwTMp4kCLh/k071tJnNmoXP7PEeWTlQDIe3+l2z1if9u9axOfJCn3XZ4LRxXuh0Xi6AdIUewU8
 tRE6IXnI+3Ewdgy6zWkoAEGrY924o9lzO6kAhlEuG7ogID5bHePO9e8zmzmAssC0nm31AElbE0R
 +5ZqCoGRkQaIx1GjqWl65QS1LnDRFdtnCOjRmkBntX19JjqN8uysKkCmrhChvd4aV4KPxD7n/xm
 NLAhazSaBz+Lvvw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for polled I/O completion to the Rust block layer bindings.
This includes the `poll` callback in `Operations` and the
`IoCompletionBatch` type for batched completions.

The `poll` callback is invoked by the block layer when polling for
completed requests on poll queues. Drivers can use `IoCompletionBatch`
to batch multiple completions efficiently.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       |   1 +
 rust/helpers/blk.c                 |   7 +++
 rust/kernel/block/mq.rs            |   8 ++-
 rust/kernel/block/mq/operations.rs | 104 +++++++++++++++++++++++++++++++++++--
 rust/kernel/block/mq/request.rs    |   5 ++
 5 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 6fb307e33263..076493f92516 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -777,6 +777,7 @@ fn queue_rq(
         this: ArcBorrow<'_, Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
+        _is_poll: bool,
     ) -> BlkResult {
         if this.bandwidth_limit != 0 {
             if !this.bandwidth_timer.active() {
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index 6a70e1306a3a..500e3c6fd951 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -20,3 +20,10 @@ __rust_helper void rust_helper_bio_advance_iter_single(const struct bio *bio,
 {
 	bio_advance_iter_single(bio, iter, bytes);
 }
+
+bool rust_helper_blk_mq_add_to_batch(struct request *req,
+				     struct io_comp_batch *iob, bool is_error,
+				     void (*complete)(struct io_comp_batch *))
+{
+	return blk_mq_add_to_batch(req, iob, is_error, complete);
+}
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index e9bea19d684b..23bf95136bc1 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -89,7 +89,8 @@
 //!         _hw_data: (),
 //!         _queue_data: (),
 //!         rq: Owned<IdleRequest<Self>>,
-//!         _is_last: bool
+//!         _is_last: bool,
+//!         is_poll: bool
 //!     ) -> BlkResult {
 //!         rq.start().end_ok();
 //!         Ok(())
@@ -130,7 +131,10 @@
 mod request_queue;
 pub mod tag_set;
 
-pub use operations::Operations;
+pub use operations::{
+    IoCompletionBatch,
+    Operations, //
+};
 pub use request::{
     Command,
     IdleRequest,
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 06faf5647aaa..1be4695ca944 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -91,6 +91,7 @@ fn queue_rq(
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
         rq: Owned<IdleRequest<Self>>,
         is_last: bool,
+        is_poll: bool,
     ) -> BlkResult;
 
     /// Called by the kernel to indicate that queued requests should be submitted.
@@ -110,7 +111,15 @@ fn init_hctx(
 
     /// Called by the kernel to poll the device for completed requests. Only
     /// used for poll queues.
-    fn poll(_hw_data: ForeignBorrowed<'_, Self::HwData>) -> bool {
+    ///
+    /// Should return `Ok(true)` if any requests were completed during the call,
+    /// `Ok(false)` if no requests were completed, and `Err(e)` to signal an
+    /// error condition.
+    fn poll(
+        _hw_data: ForeignBorrowed<'_, Self::HwData>,
+        _queue_data: ForeignBorrowed<'_, Self::QueueData>,
+        _batch: &mut IoCompletionBatch<Self>,
+    ) -> Result<bool> {
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
 
@@ -194,6 +203,11 @@ impl<T: Operations> OperationsVTable<T> {
         // `into_foreign` in `Self::init_hctx_callback`.
         let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
 
+        let is_poll = u32::from(
+            // SAFETY: `hctx` is valid as required by this function.
+            unsafe { (*hctx).type_ },
+        ) == bindings::hctx_type_HCTX_TYPE_POLL;
+
         // SAFETY: `hctx` is valid as required by this function.
         let queue_data = unsafe { (*(*hctx).queue).queuedata };
 
@@ -210,6 +224,7 @@ impl<T: Operations> OperationsVTable<T> {
             // SAFETY: `bd` is valid as required by the safety requirement for
             // this function.
             unsafe { (*bd).last },
+            is_poll,
         );
 
         if let Err(e) = ret {
@@ -268,13 +283,32 @@ impl<T: Operations> OperationsVTable<T> {
     /// previously initialized by a call to `init_hctx_callback`.
     unsafe extern "C" fn poll_callback(
         hctx: *mut bindings::blk_mq_hw_ctx,
-        _iob: *mut bindings::io_comp_batch,
+        iob: *mut bindings::io_comp_batch,
     ) -> crate::ffi::c_int {
         // SAFETY: By function safety requirement, `hctx` was initialized by
         // `init_hctx_callback` and thus `driver_data` came from a call to
         // `into_foreign`.
         let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
-        T::poll(hw_data).into()
+
+        // SAFETY: `hctx` is valid as required by this function.
+        let queue_data = unsafe { (*(*hctx).queue).queuedata };
+
+        // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
+        // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
+        // `ForeignOwnable::from_foreign` is only called when the tagset is
+        // dropped, which happens after we are dropped.
+        let queue_data = unsafe { T::QueueData::borrow(queue_data) };
+
+        let mut batch = IoCompletionBatch {
+            inner: iob,
+            _p: PhantomData,
+        };
+
+        let ret = T::poll(hw_data, queue_data, &mut batch);
+        match ret {
+            Ok(val) => val.into(),
+            Err(e) => e.to_errno(),
+        }
     }
 
     /// This function is called by the C kernel. A pointer to this function is
@@ -473,3 +507,67 @@ pub(crate) const fn build() -> &'static bindings::blk_mq_ops {
         &Self::VTABLE
     }
 }
+
+/// A batch of I/O completions for polled I/O.
+///
+/// This struct wraps the C `struct io_comp_batch` and is used to batch
+/// multiple request completions together for improved efficiency during polled
+/// I/O operations.
+///
+/// When the kernel polls for completed requests via [`Operations::poll`], it
+/// passes an `IoCompletionBatch` to collect completed requests. The driver can
+/// add completed requests to the batch using [`add_request`], allowing the
+/// kernel to process multiple completions together rather than one at a time.
+///
+/// # Invariants
+///
+/// - `inner` must point to a valid `io_comp_batch`.
+///
+/// [`add_request`]: IoCompletionBatch::add_request
+#[repr(transparent)]
+pub struct IoCompletionBatch<T> {
+    inner: *mut bindings::io_comp_batch,
+    _p: PhantomData<T>,
+}
+
+impl<T: Operations> IoCompletionBatch<T> {
+    /// Attempt to add a completed request to this batch.
+    ///
+    /// This method tries to add `rq` to the batch for deferred completion. If
+    /// the request is successfully added, ownership is transferred to the batch
+    /// and the request will be completed later when the batch is processed.
+    ///
+    /// # Arguments
+    ///
+    /// - `rq`: The completed request to add to the batch.
+    /// - `error`: Set to `true` if the request completed with an error.
+    ///
+    /// # Return
+    ///
+    /// When this method returns `Err`, the caller is responsible for completing
+    /// the request through other means, such as calling
+    /// [`Request::complete`](super::Request::complete).
+    pub fn add_request(
+        &mut self,
+        rq: Owned<Request<T>>,
+        error: bool,
+    ) -> Result<(), Owned<Request<T>>> {
+        // SAFETY: By type invariant, `self.inner` is a valid `io_comp_batch`.
+        let ret = unsafe {
+            bindings::blk_mq_add_to_batch(
+                rq.as_raw(),
+                self.inner,
+                error,
+                Some(bindings::blk_mq_end_request_batch),
+            )
+        };
+
+        match ret {
+            true => {
+                core::mem::forget(rq);
+                Ok(())
+            }
+            false => Err(rq),
+        }
+    }
+}
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 66ef2493c448..dbe657a80324 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -156,6 +156,11 @@ pub fn queue(&self) -> &RequestQueue<T> {
         // SAFETY: By type invariant, self.0 is guaranteed to be valid.
         unsafe { RequestQueue::from_raw((*self.0.get()).q) }
     }
+
+    /// Return a raw pointer to the underlying C structure.
+    pub fn as_raw(&self) -> *mut bindings::request {
+        self.0.get()
+    }
 }
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.

-- 
2.51.2


