Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8230DEB9;
	Sun, 15 Feb 2026 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199057; cv=none; b=THxPRjHO4XQ+NOlWoP5lulDg0goJZxwVisPwGx2e4EZwU66jm9mIiLYyd0W1neuiw6DbmBI46W5+XnMVnreXJ4r9lUzcso3/UJTPUSjlcwQCj3tafIsPCeRpysMmAkAe98ieOVnGTOAfUkAdT6Tnhr3EItmwisL1sgk1NmCJf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199057; c=relaxed/simple;
	bh=xsuee6tClF6ul/R2hOJJBKg96Kg6jLAUBRXV2md3X00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUOS4yhUmGgo3yWVib0PTNowZAQUiV+fcCjobQCaKMoOokThHk46Q+Skglp+e8nkF2Ef8zv/4BdwQTsQdVGyJ6x50MX9Ok/TuMvB6WxQfFU//nDOlIM9HKP9qsmR1k7VrnISp/5fUup+Oqm2pNao2hbd1E89Rwh0oPf7Cc3r6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVURXEpM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVURXEpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E680C4CEF7;
	Sun, 15 Feb 2026 23:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199056;
	bh=xsuee6tClF6ul/R2hOJJBKg96Kg6jLAUBRXV2md3X00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hVURXEpMGTCXVTv4Qbca31zfmkrG1iMKdGHLBXWlmZn0eELWfU2kmGrJxfn7LmVs3
	 dhJZGDMrOPlnWyoGb87RZapywHqdffeccBVFLRyjYT2OybgqJ5pKrPOCIKbp566yk2
	 7XdTsdcCyJWN0BVB9KdLVAVjSTZyjIl8cFYUVKwtEwngqWYQrdgehuhgfUcYARzeuX
	 azF40DpUsFPaDDLvntX8NfM9EHqHn2Y9+sA7We7+90WcaxBfriS7mawIdjp6sepSIk
	 tF45wFln9tbI0fVOh9AGTrGRDlJbLPZp541Ymdbqi03FI7swQ1ZuCeaeWCj0DTOdSl
	 cpV7xkZPj90bg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:56 +0100
Subject: [PATCH 69/79] block: rust: add `TagSet::tag_to_rq`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-69-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4873; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xsuee6tClF6ul/R2hOJJBKg96Kg6jLAUBRXV2md3X00=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklha+tACecSgfGcA74oxyxwExIZbOFlH6RcN8
 vImZ0IJU9WJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYWgAKCRDhuBo+eShj
 d0inD/4kp0vvFFgboOoTGJtTryqDsVSVhkR4f4NyCAQSJe4Mv0PHDrewUkhuP7ETdRCQxOscW0p
 4bb/kt7j8g0NZ92mou8bo7g/hxtvcmOVweBwHlcuFJFsDAN4bSjtZyWsCLD9HB+7Q5RX7ULYHMG
 8oSrX89dqRNl3Lqg4HyVAbCASaeCkEsggONxCzQYGHxXKUCpJpPJhguYEFvqtasXM0WQvAEnd1y
 AF2Z4+u3LNrFW0t6BiwSKEz4Jonru68Kh0/PnrGRfu1OIj/d5at0S6ITzVNyNi0i/eEYpw3W3rC
 ePSEanV2UQCB7nQCiPlASeK4kdrKSsAF8ACEvO5KzIMLKSLBuAX30N925EkU9Dn5fVNtSbgtCHr
 8LTLhFp+kUDKn7J8kPbIiqesdRdONnb2n+cHp/fFLn/5sWUJMbSgLC4teV8eFiECYKyMCElw2wn
 Fx03k/syqs9gj/z1XxuCOWxn6cqdgUoNPU0t1HSR1+VIUBC7ccTbSnRYTF7FC1v1WeAszR08AVc
 JR3WcUk6WcunP7n9tFmA0uKDOU7POL53QK3WXt+i6ca68WOWRtQZco4AGPNdPoSoZORROiYbzd0
 d9C/ihn4wMeheqaU7IMEEGycGw71PxbdX/wmWdZDmCbnQ7LYBXlU9D1BRYjbIOh1m0bZdbtbrst
 +cDXK7WthYA8csA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a way for block device drivers to obtain a `Request` from a tag. This
is backed by the C `blk_mq_tag_to_rq` but with added checks to ensure
memory safety.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/helpers/blk.c              |  6 ++++
 rust/kernel/block/mq/tag_set.rs | 72 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index 0db567dfc5d53..bb77af6dca9c8 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -53,3 +53,9 @@ __rust_helper struct request *rust_helper_rq_list_peek(struct rq_list *rl)
 {
 	return rq_list_peek(rl);
 }
+
+__rust_helper struct request *
+rust_helper_blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
+{
+	return blk_mq_tag_to_rq(tags, tag);
+}
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 47a162360e628..e7d7217da8922 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -5,12 +5,12 @@
 //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
 
 use crate::{
-    bindings,
     block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
     error::{self, Result},
-    prelude::*,
-    try_pin_init,
-    types::{ForeignOwnable, Opaque},
+    pr_warn,
+    prelude::{ENOMEM, *},
+    sync::atomic::ordering,
+    types::{ARef, ForeignOwnable, Opaque},
 };
 use core::{convert::TryInto, marker::PhantomData, pin::Pin};
 use pin_init::{pin_data, pinned_drop, PinInit};
@@ -19,6 +19,8 @@
 pub use flags::Flag;
 pub use flags::Flags;
 
+use super::Request;
+
 /// A wrapper for the C `struct blk_mq_tag_set`.
 ///
 /// `struct blk_mq_tag_set` contains a `struct list_head` and so must be pinned.
@@ -166,6 +168,68 @@ pub fn data(&self) -> <T::TagSetData as ForeignOwnable>::Borrowed<'_> {
         // converted back with `from_foreign` while `&self` is live.
         unsafe { T::TagSetData::borrow(ptr) }
     }
+
+    /// Obtain a shared reference to a request.
+    ///
+    /// This method will hang if the request is not owned by the driver, or if
+    /// the driver holds an [`Ownable<Request>`] reference to the request.
+    pub fn tag_to_rq(&self, qid: u32, tag: u32) -> Option<ARef<Request<T>>> {
+        if qid >= self.hw_queue_count() {
+            // TODO: Use pr_warn_once!
+            pr_warn!("Invalid queue id: {qid}\n");
+            return None;
+        }
+
+        // SAFETY: We checked that `qid` is within bounds.
+        let tags = unsafe { *(*self.inner.get()).tags.add(qid as usize) };
+
+        // SAFETY: We checked `qid` for overflow above, so `tags` is valid.
+        let rq_ptr = unsafe { bindings::blk_mq_tag_to_rq(tags, tag) };
+        if rq_ptr.is_null() {
+            None
+        } else {
+            // SAFETY: if `rq_ptr`is not null, it is a valid request pointer.
+            let refcount_ptr = unsafe {
+                RequestDataWrapper::refcount_ptr(
+                    Request::wrapper_ptr(rq_ptr.cast::<Request<T>>()).as_ptr(),
+                )
+            };
+
+            // SAFETY: The refcount was initialized in `init_request_callback` and is never
+            // referenced mutably.
+            let refcount_ref = unsafe { &*refcount_ptr };
+
+            let atomic_ref = refcount_ref.as_atomic();
+
+            // It is possible for an interrupt to arrive faster than the last
+            // change to the refcount, so retry if the refcount is not what we
+            // think it should be.
+            loop {
+                // Load acquire to sync with store release of `Owned<Request>`
+                // being destroyed (prevent mutable access overlapping shared
+                // access).
+                let prev = atomic_ref.load(ordering::Acquire);
+
+                if prev >= 1 {
+                    // Store relaxed as no other operations need to happen strictly
+                    // before or after the increment.
+                    match atomic_ref.cmpxchg(prev, prev + 1, ordering::Relaxed) {
+                        Ok(_) => break,
+                        // NOTE: We cannot use the load part of a failed cmpxchg as it is always
+                        // relaxed.
+                        Err(_) => continue,
+                    }
+                } else {
+                    // We are probably waiting to observe a refcount increment.
+                    core::hint::spin_loop();
+                    continue;
+                };
+            }
+
+            // SAFETY: We checked above that `rq_ptr` is valid for use as an `ARef`.
+            Some(unsafe { Request::aref_from_raw(rq_ptr) })
+        }
+    }
 }
 
 #[pinned_drop]

-- 
2.51.2


