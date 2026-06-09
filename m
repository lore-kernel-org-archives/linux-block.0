Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC14DA53A;
	Tue,  9 Jun 2026 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032391; cv=none; b=htVVlVcSH8LMWje3zW/j2TgsZ5+uLgm6tR+jkaEYhE1bDpwd32Q2jb1tc6kbwbfhuOE6uui4zs7KpOGCU/MKLareeWG00Mm7G71t5KiFLQlaqnQtV2y7ri1iQyx7p/fqP9TrrqUyiXe5yZ51FvoLV30SQn5ZFv5psdW4acbXlew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032391; c=relaxed/simple;
	bh=lKoE7hlYKrSKMR83Axydp/oZ8JxoEi389NiL+WfBOgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfmXWL6K90nzo/9tCJ4zgTLRfDdxQQ0M/HmqvFwHLXwuB0Ep8eOeTXMemguucTwYhtCMTneMSDvXMD+dqXVONx3R4AcYLcPg2PVsu63s9nxosnUbNGXgDWYia/0j8o4wIl8+3bIiFtvKGmQf0lA0hraqSk2AEu3Y9gj9OxeGiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtO4XsWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtO4XsWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD981F00893;
	Tue,  9 Jun 2026 19:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032390;
	bh=dn/nL+HhqyPcXgr06oBLyldQr9p2+VExm2qADQKL/c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QtO4XsWENZS24EnRtrb4kQ3MF43G5qGXqVTqEsOStmos6LyIm8rXYbjg3lMFCJUOU
	 ihtIQzB+NNni2RjRBE1Qfv/ob2U1TIWZPG8WOCFxX2DrSlzCwKd35Ca4aL7tuxREix
	 Y+b6m4mcolq3oWycMqsbHU6eHuuCBsLhNNHpoCHSnk4Pj+P4cjU1PF5GdJTD3uczsZ
	 lOBfFiuPyeTvOzqyqQUVZ0uSqO4pG6J06+G+Y70cH5//tRpiUDayhFDW7y9l4Ixip0
	 hT3WsVKSf45F6NNBgyaqg8pu3E9WQ1dSduQQ4e4y7o2vdbPF3dhdme52QfBBuiMu3+
	 XU1QjPGs0022w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:48 +0200
Subject: [PATCH v2 69/83] block: rust: add `queue_rqs` vtable hook
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-69-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5877; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=lKoE7hlYKrSKMR83Axydp/oZ8JxoEi389NiL+WfBOgg=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTz/hgE7XP0crSwcvBFBVmKr+7qEbSg5PbSp
 rkcv2WYM66JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk8wAKCRD6UCkIqsW9
 0B3mEACAadrp+g4DQkLAhdcEFJwFR75ItPB0hUabotPIhZK5V5Q5SvRq/T5bCACBqPPZNgOqfr1
 OhGSpXn865qPZ9ouSWUKid24gGCK2utocnxXKRHVVZRFGeODLCTrEd3NEO65tqy7Zdk6D26k8LW
 ssZ90yNJr6SfKJMu40r+lJB2EoGK8BpbP4GXxDgXT8X4/v/j7r4sbTioXpSlUjAaGiOghB+tv1A
 hy7jbRN0LrnJoL8IXRDQJVFaphqnlHbLp0y1naclIJC03+TTX/rutvScSOwmrsqs2um/YyWzlyh
 mwXnGv/uFB6wkAZ4ay2oIveL/WvYqGeaPmP3t896vdNch1iR4MeQRvu80BqffDTkHkDOgmlGuWA
 IF+aa+mGIR0ISuGBothqKGPTXPzBHDNXEljaorTHRLUtwDaUBUayTOjgZwPKxrpZ9mf83b57UCv
 orrVTck6xR9WbwJhGP3vEYWPsaUqPC6nR2XKnxJ8vIqQfoze5AGWccN36OwGk6ZcdOIYgnAg2d1
 pXxuMJvSmgonvpmN4xHw+HfdozFeUOWdVCjTY0keLijweNbKgC4HJvRA4WYpOxST3TxQvbRnwCD
 ypWTlnSYyEJ3Sfskk/teOGnrZ36Qd2jrpgncwNWShm4cuFdWoL5OR/zvJfd66LgDMBiSFRuofXW
 KCDInu/jCoWWJYw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for the `queue_rqs` callback to the Rust block layer
bindings. This callback allows drivers to receive multiple requests in
a single call, enabling batch processing optimizations.

The callback receives a `RequestList` containing the requests to be
processed. Drivers should remove successfully processed requests from
the list; any remaining requests will be requeued individually.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/operations.rs | 61 +++++++++++++++++++++++++++++++++++++-
 rust/kernel/block/mq/request.rs    | 26 ++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 1be4695ca944..505e7d2b2253 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -38,6 +38,8 @@
 };
 use pin_init::PinInit;
 
+use super::request_list::RequestList;
+
 type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
 
 /// Implement this trait to interface blk-mq as block devices.
@@ -94,6 +96,15 @@ fn queue_rq(
         is_poll: bool,
     ) -> BlkResult;
 
+    /// Called by the kernel to queue a list of requests with the driver.
+    fn queue_rqs(
+        _hw_data: ForeignBorrowed<'_, Self::HwData>,
+        _queue_data: ForeignBorrowed<'_, Self::QueueData>,
+        _requests: &mut RequestList<Self>,
+    ) {
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
     /// Called by the kernel to indicate that queued requests should be submitted.
     fn commit_rqs(
         hw_data: ForeignBorrowed<'_, Self::HwData>,
@@ -234,6 +245,50 @@ impl<T: Operations> OperationsVTable<T> {
         }
     }
 
+    /// This function is called by the C kernel to queue a list of new requests.
+    ///
+    /// Driver is guaranteed that each request belongs to the same queue. If the
+    /// driver doesn't empty the `rqlist` completely, then the rest will be
+    /// queued individually by the block layer upon return.
+    ///
+    /// # SAFETY
+    ///
+    /// - `requests` must satisfy the safety requirements of `RequestList<T>`
+    /// - All requests in `requests` must belong to the same hardware context.
+    unsafe extern "C" fn queue_rqs_callback(requests: *mut bindings::rq_list) {
+        // SAFETY:
+        // - By the safety requirements of this function, `requests` is valid for use as a
+        // `RequestList`.
+        // - We have exclusive access to `requests` for the duration of this function.
+        let requests = unsafe { RequestList::from_raw(requests) };
+
+        let rq_ptr = requests.peek_raw();
+
+        if rq_ptr.is_null() {
+            return;
+        }
+
+        // SAFETY: By function safety requirements, rq_ptr is pointing to a
+        // valid request.
+        let hctx = unsafe { (*rq_ptr).mq_hctx };
+
+        // SAFETY: The safety requirement for this function ensure that `hctx`
+        // is valid and that `driver_data` was produced by a call to
+        // `into_foreign` in `Self::init_hctx_callback`.
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
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
+        T::queue_rqs(hw_data, queue_data, requests);
+    }
+
     /// This function is called by the C kernel. A pointer to this function is
     /// installed in the `blk_mq_ops` vtable for the driver.
     ///
@@ -475,7 +530,11 @@ impl<T: Operations> OperationsVTable<T> {
 
     const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
         queue_rq: Some(Self::queue_rq_callback),
-        queue_rqs: None,
+        queue_rqs: if T::HAS_QUEUE_RQS {
+            Some(Self::queue_rqs_callback)
+        } else {
+            None
+        },
         commit_rqs: Some(Self::commit_rqs_callback),
         get_budget: None,
         put_budget: None,
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 84f8b2c17f85..9c451583e75d 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -173,6 +173,32 @@ pub fn queue(&self) -> &RequestQueue<T> {
     pub fn as_raw(&self) -> *mut bindings::request {
         self.0.get()
     }
+
+    // Return a valid hctx pointer.
+    fn hctx_raw(&self) -> *mut bindings::blk_mq_hw_ctx {
+        // SAFETY: The requests is guaranteed to be associated with a hardware
+        // context while we have access to it.
+        unsafe { (*self.0.get()).mq_hctx }
+    }
+
+    /// Get a reference to the [`T::HwData`] for the hardware context that this
+    /// request is associated with.
+    pub fn hw_data(&self) -> <T::HwData as ForeignOwnable>::Borrowed<'_> {
+        let hctx = self.hctx_raw();
+
+        // SAFETY: `hctx` is valid and `driver_data` was produced by a call to
+        // `into_foreign` in `Operations::init_hctx_callback`.
+        unsafe { T::HwData::borrow((*hctx).driver_data) }
+    }
+
+    pub fn is_poll(&self) -> bool {
+        let hctx = self.hctx_raw();
+
+        u32::from(
+            // SAFETY: `hctx_raw` returns a valid pointer.
+            unsafe { (*hctx).type_ },
+        ) == bindings::hctx_type_HCTX_TYPE_POLL
+    }
 }
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.

-- 
2.51.2


