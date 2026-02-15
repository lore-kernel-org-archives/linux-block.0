Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B50F2DEA62;
	Sun, 15 Feb 2026 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198973; cv=none; b=Z5/oUGuoJZoyEKD7HjJQH/hWiJjV/oQrN4JeZCLx233mKPMysLo5v/nokxgtxtipdsMiuo0ujzm84NX6Q3jlTiUIcg4bVl5H7+VPEf1obVzATyQe+nLlpE8zXBA0JLtNgdNT11sBTZGD9ATOmsprvTQqAAdgEFF22OXvaTB8/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198973; c=relaxed/simple;
	bh=ybh9nCCqsUVynbqxeVyqYZphZTsFNB8zOBEw2xwvxWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSXrxWPdKz98qWn2PGthJnCfNetaYFJyla5ctjyI9CbjivD4N91hKaQnPm37xaoNhuZwbZhkrei+/QX3PdXQhejlWrsEpUoOtsbidQ3vc91koWmzm/E9V98VGCrOx7tV+IpoqtAkWMxQeD3JVU59XKt8W6XS3A5lEkrEwhP5tIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rteou1Of; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rteou1Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23672C4CEF7;
	Sun, 15 Feb 2026 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198973;
	bh=ybh9nCCqsUVynbqxeVyqYZphZTsFNB8zOBEw2xwvxWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rteou1OfjI7DKLZqSkBe8PPB/IualqGflbnnBUsS9qsXSD1luGbY3im1XZdknHpCh
	 ObspwCI6zYj8eQvVnxJaOrnI8naEoqRQGGQdi3WfhjZIJIGQMQlVjdk7B2stZz1gJK
	 ch0xXIGkwAtBB/E4wPNKPKMCvVonP+3A2qHyZfyXZAkJz4obksknG9EioW6Ibv4AYi
	 bJe079aEZpDebE/eorwXj6dZO4h6zvF7yOnLRz9u+uWDLVkFkzL8sQR38QBGCwdECZ
	 1ZsbAjWZn1CuPwdZ0I9OpgeOVqpLAbH09MZV/pP0NBdDW5uYre/tnRtCx3ugieDPjO
	 Zr25lEJigzPDQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:38 +0100
Subject: [PATCH 51/79] block: rust: add polled completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-51-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9024; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ybh9nCCqsUVynbqxeVyqYZphZTsFNB8zOBEw2xwvxWs=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhJUt9ZG6dMGHexv9X0pUqQqoVvjeHvSSbTC
 N7CBGOKzqqJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYSQAKCRDhuBo+eShj
 d0YkD/wM2YmefoyIOH2Avc5M4h+sj8E49GBIT9pw/3UvtWozdRDkLczeYLr9jQGFz0SP2jpZ9zh
 TJhoqSB97nBs8R5KwAZfCsB6Ox2tM5z1dqFGBfzFwhIlU3YrKjAYKELexy1poD/IXocYw1FFfJu
 VLH4+RaAg16WK5srruKHjDylJCuj7ATBAIr8Vxtuvwk/8TvtO2NAFN3nQd01MMMj4mt2H+NGdvG
 EM4SVRCwqUzqhbk22R9jrF7CRPiT7Et3cRX36c2YULLiktSl9hcjVbuLNdQtMbGlf4uyuKDLR5r
 1fSBAM1Kjx6SwvgegBSYTCmDDsyCP9Jg17eemC9xeZTUYdIJdeHBl+bKtgvePqqUxRuNM+nxYvv
 Ke2FOITFh2i6hjr5s2RXeJjxR8sTk1mzvGCQ6qL2P56mKQDzcKuXJSwjxyRGLUN00v5WgKWWuHz
 l3mee429Irt+8c2fJD/NPYQTI8jLiLHPwqGsNOG+jpo0NTsDj5G13IAugg4terPzoirj1KZygt+
 YMR9a+9YRItbUV/BEJjS3NCmGfU2daUz24JpewoCuWjSginBmwyx8Y20jpGTTyiIxBl+4Pkx9Ar
 A/PXt41xofUhYuAr/OrFFSSrb3lpkh9X21FdITS7I36WQd5oChWpOZM1zLA8ECX2LFAorKHcX42
 XOS3K4rjwbL/o0A==
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
 rust/kernel/block/mq.rs            |   4 +-
 rust/kernel/block/mq/operations.rs | 104 +++++++++++++++++++++++++++++++++++--
 rust/kernel/block/mq/request.rs    |   5 ++
 5 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 48b2bd598304c..765bbc8101d10 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -733,6 +733,7 @@ fn queue_rq(
         this: ArcBorrow<'_, Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
+        _is_poll: bool,
     ) -> BlkResult {
         if this.bandwidth_limit != 0 {
             if !this.bandwidth_timer.active() {
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index 53beba8c7782d..91b72131a04cd 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -20,3 +20,10 @@ void rust_helper_bio_advance_iter_single(const struct bio *bio,
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
index cd0bfbcbf317a..1d58eea971bd7 100644
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
@@ -130,6 +131,7 @@
 mod request_queue;
 pub mod tag_set;
 
+pub use operations::IoCompletionBatch;
 pub use operations::Operations;
 pub use request::Command;
 pub use request::IdleRequest;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 28dd4b28d203f..bccc1903a0d10 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -65,6 +65,7 @@ fn queue_rq(
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
         rq: Owned<IdleRequest<Self>>,
         is_last: bool,
+        is_poll: bool,
     ) -> BlkResult;
 
     /// Called by the kernel to indicate that queued requests should be submitted.
@@ -84,7 +85,15 @@ fn init_hctx(
 
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
 
@@ -168,6 +177,11 @@ impl<T: Operations> OperationsVTable<T> {
         // `into_foreign` in `Self::init_hctx_callback`.
         let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
 
+        let is_poll = u32::from(
+            // SAFETY: `hctx` is valid as required by this function.
+            unsafe { (*hctx).type_ },
+        ) == bindings::hctx_type_HCTX_TYPE_POLL;
+
         // SAFETY: `hctx` is valid as required by this function.
         let queue_data = unsafe { (*(*hctx).queue).queuedata };
 
@@ -184,6 +198,7 @@ impl<T: Operations> OperationsVTable<T> {
             // SAFETY: `bd` is valid as required by the safety requirement for
             // this function.
             unsafe { (*bd).last },
+            is_poll,
         );
 
         if let Err(e) = ret {
@@ -242,13 +257,32 @@ impl<T: Operations> OperationsVTable<T> {
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
@@ -448,3 +482,67 @@ pub(crate) const fn build() -> &'static bindings::blk_mq_ops {
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
index 4e7adb10929f0..b4f5a98a97b16 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -135,6 +135,11 @@ pub fn queue(&self) -> &RequestQueue<T> {
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


