Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89723DFC97;
	Fri, 10 Apr 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839955; cv=none; b=FJhLN5ZUWTAcdaFrwydM2KE3URjVFWbg9v1eUyb5HRZvpv23V8ZQKqsr8/rmQwTyc1jfvCvsqgW6DA6a6T09HxpqLsHiIhNJipFwCcgfwnFG2sDcyjnkhGlcWFNrR2Qo8oc19D37ci/aJV+B199tbKXt/n9f3g3IBgIOdqo4qpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839955; c=relaxed/simple;
	bh=VGWd1vxUiHQ5WAz5ljocvstzwlKyJVOrm2GDbgojw0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FPWTDAJO6rtMgXs25Z48m1byFiAKDm0ehXrIbLKL3bOfC4POyiFVljwhDm8nUQ5UvJW0ShvDZ54dj+Hjt8VbMJY2mvQ1mF+2HL4qIUiz2JtAutvTT6zewZdfdN8/Uorex8JuI8/xDYwoJ9CMw13iWCGcQ4vHTy8uXOOkgJrr+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=GU6vuqpg; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="GU6vuqpg"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a484aad7;
	Sat, 11 Apr 2026 00:47:10 +0800 (GMT+08:00)
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
Subject: [RFC PATCH 1/2] rust: block: mq: safely abstract the timeout callback
Date: Fri, 10 Apr 2026 12:47:03 -0400
Message-Id: <20260410164704.1986859-2-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410164704.1986859-1-wenzhaoliao@ruc.edu.cn>
References: <20260410164704.1986859-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d784a54db03a2kunmb238a8d6d33a3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUtOVksaGUhIS0gZHU9OTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GU6vuqpgqbKaE17vwHi/JPCe2Bnm3IbRUm2XV09mdycr0Kzw3DTFc83FZWnxG5QFaKeOIyi38VXBBVMKgAWq7tkGs4zwi0JabHfbtjmNigJ8+TeOQXlTOqf0g7l3a8jm3zTsc+HZEo6j8CzKc3LurH+9uQLQxKq48yBG1W1shsI=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=unRWvjMeGracTqCGRtmIT4PHdeK4bqIu1kI/eulO8xo=;
	h=date:mime-version:subject:message-id:from;

Add a typed TimeoutReturn enum for blk-mq timeout handlers and
extend the Operations trait with an optional timeout callback.

The new callback borrows Request instead of taking an ARef because
timeout is a synchronous notification from blk-mq and does not
transfer request ownership to the driver.

Wire the callback into OperationsVTable and keep drivers that do not
implement timeout on the existing timeout: None path.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/kernel/block/mq.rs            |  2 +-
 rust/kernel/block/mq/operations.rs | 40 +++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1fd0d54dd549..cfcfcd99addc 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -98,6 +98,6 @@
 mod request;
 mod tag_set;
 
-pub use operations::Operations;
+pub use operations::{Operations, TimeoutReturn};
 pub use request::Request;
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 8ad46129a52c..a8ff5eb8dd31 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -16,6 +16,16 @@
 
 type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
 
+/// Return value for blk-mq timeout handlers.
+#[repr(u32)]
+pub enum TimeoutReturn {
+    /// The driver completed the request or will complete it later.
+    Done = bindings::blk_eh_timer_return_BLK_EH_DONE,
+
+    /// Reset the request timer and keep waiting for completion.
+    ResetTimer = bindings::blk_eh_timer_return_BLK_EH_RESET_TIMER,
+}
+
 /// Implement this trait to interface blk-mq as block devices.
 ///
 /// To implement a block device driver, implement this trait as described in the
@@ -46,6 +56,11 @@ fn queue_rq(
     /// Called by the kernel when the request is completed.
     fn complete(rq: ARef<Request<Self>>);
 
+    /// Called by the kernel when a request times out.
+    fn timeout(_rq: &Request<Self>) -> TimeoutReturn {
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+
     /// Called by the kernel to poll the device for completed requests. Only
     /// used for poll queues.
     fn poll() -> bool {
@@ -163,6 +178,25 @@ impl<T: Operations> OperationsVTable<T> {
         T::complete(aref);
     }
 
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `rq` must
+    /// point to a valid request that is still live for the duration of this
+    /// callback.
+    unsafe extern "C" fn timeout_callback(
+        rq: *mut bindings::request,
+    ) -> bindings::blk_eh_timer_return {
+        // SAFETY: `rq` is valid as required by the safety requirements for
+        // this function, and the private data is initialized while the request
+        // is live.
+        let rq = unsafe { &*rq.cast::<Request<T>>() };
+
+        T::timeout(rq) as bindings::blk_eh_timer_return
+    }
+
     /// This function is called by the C kernel. A pointer to this function is
     /// installed in the `blk_mq_ops` vtable for the driver.
     ///
@@ -262,7 +296,11 @@ impl<T: Operations> OperationsVTable<T> {
         put_budget: None,
         set_rq_budget_token: None,
         get_rq_budget_token: None,
-        timeout: None,
+        timeout: if T::HAS_TIMEOUT {
+            Some(Self::timeout_callback)
+        } else {
+            None
+        },
         poll: if T::HAS_POLL {
             Some(Self::poll_callback)
         } else {
-- 
2.34.1

