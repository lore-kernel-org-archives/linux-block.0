Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5912DE6FF;
	Sun, 15 Feb 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199140; cv=none; b=YacP+ZvUU7gSUuFH87wojQgaOGdfiEwZYQReU0g9ugNzlhIUrUxNBGhfvtyg6JZnnkdoDFZKVvgkkO3lijJCCsno13btq3lcRGeN1w5bWJPXVDd7Rv68dR74Y7u8xdMu3DqZrF5u6KMzvD0qPi1aUETX04fVzsQyU7S/EzkCSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199140; c=relaxed/simple;
	bh=iHJebs10G3KEuSKPd64YYQzEozbVohCdh4WUvdT+gdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=us5GFfLItM3NjuyzRq1UrzkoGEoIyD/z2zJYY7fIK/JTehxk5043IO6/UVOq1RopiKd3T+ZY4l6aI1jBF5tEWxOMLbmqzEdixtv3cyG7+r7GDLqc2rkBIhyppKy8ZkM6vwsqgV/rEWgBb4Ar5xcCVs3hM+XZubU31KXeCw+ssjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWNqkVSp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWNqkVSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6497AC4CEF7;
	Sun, 15 Feb 2026 23:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199140;
	bh=iHJebs10G3KEuSKPd64YYQzEozbVohCdh4WUvdT+gdA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OWNqkVSpuHPfeqJ1obG9KjUAge7I1l0KH3Bd4vcO7D26r2YjI5dQDpC664biAVsof
	 LFGcoc+uoSB3f4UWDWN86wMaA+4RLjrMK04KxYVHi3HbR/g1M2+q6dJsxzwsAmUXf0
	 MkdCMQfCPZCXbesYKg53FrD3gFepV53oCsnpLSVUlJj1CppafFHN3uj7GrdOBt7HWz
	 gnz5pKgtMyrqfBnP12nE/1Iul/ci552vsJvYYQAyjIFfwPXI2JLXzPhnxLqcng+qQB
	 mvptHf9cmJkdD+nYS69XoZtNMyqtb+EQ73fqh0HFSZdctdRHsTaTiX549NW1gItkDz
	 A8JUVDBoPx4Rg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:51 +0100
Subject: [PATCH 64/79] block: rust: add an abstraction for `struct rq_list`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-64-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6135; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=iHJebs10G3KEuSKPd64YYQzEozbVohCdh4WUvdT+gdA=;
 b=kA0DAAoB4bgaPnkoY3cByyZiAGmSWFWjeowTsFEiINSqulAD21O5tLcZBRTLEu7+cvl0taWOq
 YkCMwQAAQoAHRYhBBLB+UdWv3wqFdbAEuG4Gj55KGN3BQJpklhVAAoJEOG4Gj55KGN3uDQQAK5S
 TJnyt6251s9+e3u70mSgIM2EB4xbkhZPSh2nxTo3lEp8w82guHRW0t/howvgJ3nj9a6w4XCwEb+
 AV1gxbGx40380Hc0c3wU9N+z4qG5PXCNGGOHSd+OEnl5gVXZnZZtbbVSveZ79khqvzcTJ3gz7d0
 7UIWol335/lElOkzzPm/gSQKxUSKOcIt2H+VozTRfqpok96aJx89/jI9g7tI4goDwEh00tbcchK
 PpHQ0APkpbh09Kb81cZ0I/SXBMWttrK3oF3P8eio0mjOLmq7Eh2Dhvs1kB1OZd3LbsUHXb0xDCa
 WJEanZ2sRkFI8QAVA5/6loJIUgo1joWAaMu2oUIbvIp5FAlKy2p/crJIYU+hdKE7pm8O+VNmqps
 rW7N1XxuiUFlFp2SQwlKbxmnshbAz7OvnLl1LvvYfdfv7BQMCIzjBRfdExGQl28u6kCiN2o8YDS
 dDkxJ+d/dydjryyzj7Mr444ULi3Cl73k+OAm09roYSf9gxMKYBkO2gExZsIg4B0WqdUA5GUkYXi
 cJn5wgLNpae6d8gxQ7y8KXFpa87YWXO2bxdWn3efgB/cERasAm6EG5izcBgz/WEFLSksxZJsS79
 0TL1iD3sJOhx1/dvbZBCVV3oHa/xp6OnRG/JFWt31mFFA0+/9upKGkRAW0okHMgaq2tWDEcgTy1
 Cv3+C
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
 rust/kernel/block/mq/request_list.rs | 113 +++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index 91b72131a04cd..0db567dfc5d53 100644
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
index b36112f7b22b9..786c32f2cb56c 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -129,6 +129,7 @@
 pub mod gen_disk;
 mod operations;
 mod request;
+mod request_list;
 mod request_queue;
 pub mod tag_set;
 
@@ -141,6 +142,7 @@
 pub use request::IdleRequest;
 pub use request::Request;
 pub use request::RequestTimerHandle;
+pub use request_list::RequestList;
 pub use request_queue::RequestQueue;
 pub use tag_set::QueueType;
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/request_list.rs b/rust/kernel/block/mq/request_list.rs
new file mode 100644
index 0000000000000..60284d9ef6c9c
--- /dev/null
+++ b/rust/kernel/block/mq/request_list.rs
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::marker::PhantomData;
+
+use crate::{owned::Owned, types::Opaque};
+
+use super::{IdleRequest, Operations};
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


