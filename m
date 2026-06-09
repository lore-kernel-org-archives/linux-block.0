Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB641FC57;
	Tue,  9 Jun 2026 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032684; cv=none; b=uUi4zKDlM4D30tTsHp6FNcgZpIqNy8O+uzw2s1JBB375Ys9MsXkXIVTaEOp+0QAiChjFu4gua2CmTbijgD4va8BbcKiRKNwzws3YyBfwvbKzCIVuBCCZG0RsOtmbb0bBFWjYVy3RbPrGf17Hbx+FmFeaaZhX9lqslBhcWcU/LNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032684; c=relaxed/simple;
	bh=97jxH/QmtmH/CWohF6JLit6bM5t2zk5/a3nktYO+2ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cx1jPRNp6S+gculzT/FSUy03o9o96U/HrGDFL7dMWLjgxVDM8+VXLsshVeKOz5qR29sZRdbH764EJf0lmIFOHhnM7IwCJgM0a0cjrwUPFlTIgQA7pU0F1g53cbr1yGvdRNKBUbiHVI+rNiQ2vgQxaQk15Ggfy47IMx+9oJDjRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6rVcgBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6rVcgBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF811F00893;
	Tue,  9 Jun 2026 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032683;
	bh=OomWwZ2E/uUmvbXfccoW6uFSslUSkDomnKFoGy4lNf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=X6rVcgBbqqcy6A9FVMlgU1UJoH0xU01VsG5i8Ygg4IsKChRY/9VOAsjBR3iUedsxo
	 Brp/4f7kIscPxi3a1CuvX4BzmBWghtHS229HEPJSstGiaeSS/JiR9mi98eyr+FeDXT
	 3z3F3KO77EcCY+EKLfnozl19/RjLbZ1WwF8FfcIHw0fYtgYnuQz6mDa8LQY+mLQrxO
	 FdUHyNX5GzlF8CTW0PVbwtZUtBT4YaHZOWx9VCiBjIHTZW8yTt1n2nNwgpOH5nHVh5
	 s/u6t9qIAdIawLWUS3Pw15SYD6Ar1e9qz2td99E6lHfJ7i8iL+fmVF7nFhX+MqfMQi
	 yNelwjegkjg9g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:55 +0200
Subject: [PATCH v2 76/83] block: rust: add `request_timeout` hook
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-76-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6548; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=97jxH/QmtmH/CWohF6JLit6bM5t2zk5/a3nktYO+2ZM=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT5RrlseORLgOiPT447AgxzjasPLzO3FtBsB
 GDuy3HwtJ2JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk+QAKCRD6UCkIqsW9
 0FU6D/4w74QvjVjFXSovnx/Stq9wkAc4CPI43xP8x1Grj/P5qSz0FJqXX1dizqKmTuaLX3ClnB+
 pR5tp9eY0sOz0ri5A9awMYIcBqbQvFR9cdXUhDeLczI4iIMaG3/hG86CGS0tlsRXpv8ixwhgUa5
 LXSBEwLccPUHos62AEBrJqmi428crWlgbNHmWRun4/vFduQi2pNd9CrtV+2BmcKXmT43/9toGJS
 1w4lvTIqkwkCvSq7lKF4yMDtko4L8peJuF8y9zUaMmsA9io/FqVpXvjNGAXyoxwUHiSnx6ZdWDW
 Q+6IBUXA6DqGRZyRaqg+rtyVPeA6EmPNdqH5Et1iGA+AlBulTUMSGmaqxvCGnAmaF9ApiuoPO4J
 UQ9wyk21GdV8G/q5F55DXkpIzswLIfZkn4aTca+A9ktr+lCosJf9N8XGeHEJWC+oZOSOHI67Bqd
 tJyUzCSqWpUxusCek7oAup3sgT7AqqMPS0rxVPxIuZtwStw2NCoSvPtFZNtMbCjyj5PJeJe6wrg
 SzouRr+/KKNuQsBEXIxx+0KRfhu3qmnZ5Bb0rCJ4qrPX7/twL8eksXNu9+4cSI/rkrWd6NZAl51
 mBgbi4cUrutsWQQ+ZznN2lQJvrApVfnqUeDgtDLP7aqMUV5wSXdb+g5UgQfYLy81cBY8/FoJRMM
 fCuMkCEyeqmZKAg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a hook for the request timeout feature. This allows the kernel to call
into a block device driver when it decides a request has timed out. Rust
block device drivers can now implement `Operations::request_timeout` to
respond to request timeouts.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block.rs               |  1 +
 rust/kernel/block/mq.rs            |  3 +-
 rust/kernel/block/mq/operations.rs | 78 +++++++++++++++++++++++++++++++++++++-
 rust/kernel/block/mq/tag_set.rs    |  1 -
 4 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index b3578f28871a..23795dbe08c3 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -42,6 +42,7 @@ macro_rules! declare_err {
         declare_err!(BLK_STS_NOTSUPP, "Operation not supported.");
         declare_err!(BLK_STS_IOERR, "Generic IO error.");
         declare_err!(BLK_STS_DEV_RESOURCE, "Device resource busy. Retry later.");
+        declare_err!(BLK_STS_TIMEOUT, "Operation timed out.");
     }
 
     /// A wrapper around a 1 byte block layer error code.
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 47e1f860c6ba..a306181d88ce 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -138,7 +138,8 @@
 };
 pub use operations::{
     IoCompletionBatch,
-    Operations, //
+    Operations,
+    RequestTimeoutStatus, //
 };
 pub use request::{
     Command,
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index d28af9a5e006..2b340675f976 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -151,6 +151,51 @@ fn report_zones(
     fn map_queues(_tag_set: Pin<&mut TagSet<Self>>) {
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
+
+    /// Called by the kernel when a request has been queued with the driver for too long.
+    ///
+    /// We identify the request by `queue_id` and `tag` as we cannot pass
+    /// `Owned<Request>` or `ARef<Request>`. The driver may hold either of these
+    /// already.
+    ///
+    /// A driver can use [`TagSet::tag_to_rq`] to try to obtain a request reference.
+    ///
+    /// A driver must return [`RequestTimeoutStatus::Completed`] if the request
+    /// was completed during the call. Otherwise
+    /// [`RequestTimeoutStatus::RetryLater`] must be returned, and the kernel
+    /// will retry the call later.
+    fn request_timeout(_tag_set: &TagSet<Self>, _queue_id: u32, _tag: u32) -> RequestTimeoutStatus {
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Return value for [`Operations::request_timeout`].
+#[repr(u32)]
+pub enum RequestTimeoutStatus {
+    /// The request was completed.
+    Completed = bindings::blk_eh_timer_return_BLK_EH_DONE,
+
+    /// The request is still processing, retry later.
+    RetryLater = bindings::blk_eh_timer_return_BLK_EH_RESET_TIMER,
+}
+
+impl RequestTimeoutStatus {
+    /// Create a [`RequestTimeoutStatus`] from an integer.
+    ///
+    /// # SAFETY
+    ///
+    /// - `value` must be one of the enum values declared for [`bindings::blk_eh_timer_return`].
+    pub unsafe fn from_raw(value: u32) -> Self {
+        // SAFETY: By function safety requirements, value is usable as `Self`.
+        unsafe { core::mem::transmute(value) }
+    }
+}
+
+impl From<RequestTimeoutStatus> for u32 {
+    fn from(value: RequestTimeoutStatus) -> Self {
+        // SAFETY: All `RequestTimeoutStatus` representations are valid as `u32`.
+        unsafe { core::mem::transmute(value) }
+    }
 }
 
 /// A vtable for blk-mq to interact with a block device driver.
@@ -521,6 +566,33 @@ impl<T: Operations> OperationsVTable<T> {
         T::map_queues(tag_set);
     }
 
+    /// This function is called by the block layer when a request has been
+    /// queued with the driver for too long.
+    ///
+    /// # Safety
+    ///
+    /// - This function may only be called by blk-mq C infrastructure.
+    /// - `rq` must point to an initialized and valid `Request`.
+    unsafe extern "C" fn request_timeout_callback(
+        rq: *mut bindings::request,
+    ) -> bindings::blk_eh_timer_return {
+        // SAFETY: `rq` is valid and initialized.
+        let hctx = unsafe { (*rq).mq_hctx };
+        // SAFETY: `rq` is valid and initialized, so `hctx` is also valid and initialized.
+        let qid = unsafe { (*hctx).queue_num };
+        // SAFETY: `rq` is valid and initialized.
+        let tag = unsafe { (*rq).tag } as u32;
+        // SAFETY: `rq` is valid and initialized, so `hctx` is also valid and initialized.
+        let queue = unsafe { (*hctx).queue };
+        // SAFETY: `rq` is valid and initialized, so is `queue`.
+        let tag_set = unsafe { (*queue).tag_set };
+        // SAFETY: As `rq` is valid, so is `tag_set`. We never create mutable references to a
+        // `TagSet` without proper locking.
+        let tag_set: &TagSet<T> = unsafe { TagSet::from_ptr(tag_set) };
+
+        T::request_timeout(tag_set, qid, tag).into()
+    }
+
     const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
         queue_rq: Some(Self::queue_rq_callback),
         queue_rqs: if T::HAS_QUEUE_RQS {
@@ -533,7 +605,11 @@ impl<T: Operations> OperationsVTable<T> {
         put_budget: None,
         set_rq_budget_token: None,
         get_rq_budget_token: None,
-        timeout: None,
+        timeout: if T::HAS_REQUEST_TIMEOUT {
+            Some(Self::request_timeout_callback)
+        } else {
+            None
+        },
         poll: if T::HAS_POLL {
             Some(Self::poll_callback)
         } else {
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 66b6a30a9e66..6d3882c01d9d 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -126,7 +126,6 @@ pub fn flags(&self) -> Flags {
     /// `ptr` must be a pointer to a valid and initialized `TagSet<T>`. There
     /// may be no other mutable references to the tag set. The pointee must be
     /// live and valid at least for the duration of the returned lifetime `'a`.
-    #[expect(dead_code)]
     pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::blk_mq_tag_set) -> &'a Self {
         // SAFETY: By the safety requirements of this function, `ptr` is valid
         // for use as a reference for the duration of `'a`.

-- 
2.51.2


