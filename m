Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD024DA54B;
	Tue,  9 Jun 2026 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032528; cv=none; b=U20jTQaG2MQ4QkyeXdFf1PBRVhRWFkA35/o5X9jpevQEAqm7Emv+5jO6Nq65g7yApJJpmAvqXFvRYyzOyzXGC4ycLKUVyTDCqFiNHhuESQR6ybS8+wGqCpHxN+B1wrsQU5JjZOOioQxvbvZBOD3MGnmCIOjWeJhRAmw2d8j1BUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032528; c=relaxed/simple;
	bh=3zWHoh8lTGLJ6X5+DtdbMgAgdt2Ms+a+4ebccRKtMVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUgNiwPuhRJ1zRVXKF7mXG0X8TfRsimE143sS7ZpuO8sUVeMczb+eZ0e262Iz0dw1czXb5m4ua/PJtzXvF8mKVcVjZ5ByMTHalfcsv6qTJ+SRLng38Bd0FGy1kvGnKA/yDlqHp2Y8fpPTYdHG24TlON7tfJ1nJC3QoUGxb5m7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFB0bEyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFB0bEyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599521F00898;
	Tue,  9 Jun 2026 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032527;
	bh=A7C6J/4qobSt2YJVzP9B516t3v7OvSeSUX63/tzsSD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KFB0bEyMs7EiTXFSctBJyJparalcPcsZroXU0a4EB0GdEUSVJQ1jmm52IMGG/3Vi3
	 615Mi+9jnabtiCfiUIdE0HHvBQzXk+eVl2kDCU2Jn829Q13GPFbwUvRWMMoyHJFhNe
	 WBFpvGMDMX/B/MAXYHe0J6rqBAqeEfhflFt0xgQGtQPwTKI3MjMHBRkHA1TuvCgaLe
	 aH+c8py+8ZbIskQkBfi6q6HuI648MgN4TaNNmfpQW2E+kv+WZr/ic68NDKSYK0vCSX
	 3yMAWKPPy6efyPU+hAgNzcs2cy0w2F0NLB5WEeBa8IYgwMg5JgnD7AF17aA6rtp/cf
	 /1lND+VxKezog==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:47 +0200
Subject: [PATCH v2 68/83] block: rust: add an abstraction for `struct
 rq_list`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-68-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6100; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3zWHoh8lTGLJ6X5+DtdbMgAgdt2Ms+a+4ebccRKtMVI=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTyrI+QXei6rTMP8iiiEZKr1484LBHMD95oG
 XNTJoWDgPKJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk8gAKCRD6UCkIqsW9
 0OPxD/9ibPYIYnDR73NPhBD6/PgXSyhfABFOOMxGgykL5SxPrfRMpIsel+KLRDMxOtTwfZgWPqm
 7x4eXk/w0qBS7J1T4uP1v997OT3s7wNqiANIuX6w4EjLVagJ4RIH5vG+KYhBRcB28QURFuvYNxN
 44u7vqyn29dU8ioYK6DSBn6xB3NQILfY0/W18UedMoGKU2AUmptQKhDOqAO5iy9VJUloWW0wZLe
 7nyeHWAix0ofNz46wCcan2obRujcatIVZx+V0+2E9VbiBlPc0C01r2ELIwXImeWG0MWoyAeFTPO
 LrZsuuMMITkKmD9Mdy4UsKtc/n7aFKgRVuRuUNqfh4tecyVBphzrmE3iETMC8PLo4BddR1MrDF9
 Cc06NF5KA1jiS9FM5FwCOrr99HLkOMNGfJCbiDgPPgvENDjTCdd5Iz7A5s2y9fCM6IUQ8ykUy7F
 bu0AOfVa3f+5Y8mrqunMsHHy5vEJDHjoGTvXeXcxBa0x/pjgmPWfrF6JQPQ+nDpsvUNn9GhczhO
 Weyrad1n73SqnseczMeKxYX08ZNWHG639XShzc+XdTlHq55IzqkojBqOo0gtCYRh/0h4RILIqys
 RgA1/8PhvFvL4e1N9lo2ifsQxargLpvuwK4YsnypCJ9HKZTXRapEGnZEhHX+7WTR5vFVqTz86rI
 kld1/DFJXWO1kXQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the `RequestList` type as a safe wrapper around the C `struct
rq_list`. This type provides methods to iterate over and manipulate
lists of block requests, which is needed for implementing the
`queue_rqs` callback.

The abstraction includes methods for popping requests from the list,
checking if the list is empty, and peeking at the head request.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/helpers/blk.c                   |  26 ++++++++
 rust/kernel/block/mq.rs              |   2 +
 rust/kernel/block/mq/request_list.rs | 119 +++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index 500e3c6fd951..422289d617ae 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -27,3 +27,29 @@ bool rust_helper_blk_mq_add_to_batch(struct request *req,
 {
 	return blk_mq_add_to_batch(req, iob, is_error, complete);
 }
+
+__rust_helper struct request *rust_helper_rq_list_pop(struct rq_list *rl)
+{
+	return rq_list_pop(rl);
+}
+
+__rust_helper int rust_helper_rq_list_empty(const struct rq_list *rl)
+{
+	return rq_list_empty(rl);
+}
+
+__rust_helper void rust_helper_rq_list_add_tail(struct rq_list *rl,
+						struct request *rq)
+{
+	rq_list_add_tail(rl, rq);
+}
+
+__rust_helper void rust_helper_rq_list_init(struct rq_list *rl)
+{
+	rq_list_init(rl);
+}
+
+__rust_helper struct request *rust_helper_rq_list_peek(struct rq_list *rl)
+{
+	return rq_list_peek(rl);
+}
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 7c346be843e1..e8f0d03f2ff7 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -129,6 +129,7 @@
 pub mod gen_disk;
 mod operations;
 mod request;
+mod request_list;
 mod request_queue;
 pub mod tag_set;
 
@@ -148,6 +149,7 @@
     Request,
     RequestTimerHandle, //
 };
+pub use request_list::RequestList;
 pub use request_queue::RequestQueue;
 pub use tag_set::{
     QueueType,
diff --git a/rust/kernel/block/mq/request_list.rs b/rust/kernel/block/mq/request_list.rs
new file mode 100644
index 000000000000..82e6005126f7
--- /dev/null
+++ b/rust/kernel/block/mq/request_list.rs
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::marker::PhantomData;
+
+use crate::{
+    owned::Owned,
+    types::Opaque, //
+};
+
+use super::{
+    IdleRequest,
+    Operations, //
+};
+
+/// A list of [`Request`].
+///
+/// # INVARIANTS
+///
+/// - `self.inner` is always a valid list, meaning the `next` and `prev`
+///   pointers point to valid requests, or are both null.
+/// - All requests in the list are valid for use as `IdleRequest<T>`.
+#[repr(transparent)]
+pub struct RequestList<T: Operations> {
+    inner: Opaque<bindings::rq_list>,
+    _p: PhantomData<T>,
+}
+
+impl<T: Operations> RequestList<T> {
+    /// Create a new [`RequestList`].
+    pub fn new() -> Self {
+        let this = Self {
+            inner: Opaque::zeroed(),
+            _p: PhantomData,
+        };
+
+        // NOTE: We are actually good to go, but we call the C initializer for forward
+        // compatibility.
+        // SAFETY: `this.inner` is a valid allocation for use as `bindings::rq_list!.
+        unsafe { bindings::rq_list_init(this.inner.get()) }
+
+        //INVARIANT: `self.inner` was initialized above and is empty.
+        this
+    }
+
+    /// Create a mutable reference to a [`RequestList`] from a raw pointer.
+    ///
+    /// # SAFETY
+    /// - The list pointed to by `ptr` must satisfy the invariants of `Self`.
+    /// - The list pointed to by `ptr` must remain valid for use as a mutable reference for the
+    ///   duration of `'a`.
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::rq_list) -> &'a mut Self {
+        // SAFETY:
+        // - RequestList is transparent.
+        // - By function safety requirements, `ptr` is valid for us as a mutable reference.
+        unsafe { &mut (*ptr.cast()) }
+    }
+
+    /// Check if the list is empty.
+    pub fn empty(&self) -> bool {
+        // SAFETY: By type invariant, self.inner is valid.
+        let ret = unsafe { bindings::rq_list_empty(self.inner.get()) };
+        ret != 0
+    }
+
+    /// Pop a request from the list.
+    ///
+    /// Returns [`None`] if the list is empty.
+    pub fn pop(&mut self) -> Option<Owned<IdleRequest<T>>> {
+        // SAFETY: By type invariant `self.inner` is a valid list.
+        let ptr = unsafe { bindings::rq_list_pop(self.inner.get()) };
+
+        if !ptr.is_null() {
+            // SAFETY: If `rq_list_pop` returns a non-null pointer, it points to a valid request. By
+            // type invariant all requests in this list are valid for use as `IdleRequest`.
+            Some(unsafe { IdleRequest::from_raw(ptr) })
+        } else {
+            None
+        }
+    }
+
+    /// Push a request on the tail of the list.
+    pub fn push_tail(&mut self, rq: Owned<IdleRequest<T>>) {
+        let ptr = rq.as_raw();
+        core::mem::forget(rq);
+        // INVARIANT: rq is an `IdleRequest<T>`.
+        // SAFETY: By type invariant, `self.inner` is a valid list.
+        unsafe { bindings::rq_list_add_tail(self.inner.get(), ptr) };
+    }
+
+    /// Peek at the head of the list.
+    ///
+    /// Returns a null pointer if the list is empty.
+    pub fn peek_raw(&self) -> *mut bindings::request {
+        // SAFETY: By type invariant, `self.inner` is a valid list.
+        unsafe { bindings::rq_list_peek(self.inner.get()) }
+    }
+}
+
+impl<T: Operations> Default for RequestList<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: Operations> Drop for RequestList<T> {
+    fn drop(&mut self) {
+        while let Some(rq) = self.pop() {
+            drop(rq)
+        }
+    }
+}
+
+impl<T: Operations> Iterator for &mut RequestList<T> {
+    type Item = Owned<IdleRequest<T>>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.pop()
+    }
+}

-- 
2.51.2


