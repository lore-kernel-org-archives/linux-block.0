Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C336BA34;
	Sun, 22 Jun 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750597149; cv=none; b=h6kQwwnHQ8DEFJk/0woVfK9w+OwtD6K6yh3/oZPpuze2m7CHB/MdzAgLJ3OyO3z9bQ5lOaMubqKcjWMimWFBN1kiIdYpZ9/6NJwdd6tFRlRqn6PTKZ356Jby7nP46UnxSXwJpKO7dajUWmQW35w8T2uJccrmzmFbq1hF2EgjkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750597149; c=relaxed/simple;
	bh=CVzVcjv/dVsCjXVqz0Dv1hVrWg56ty5UCjDYUtYTFp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5MIxSOmXHib5YsoVSPWR9xmhpf0KmmTIjbE16FVCXJ3WXj8sxMbKX3Embg17WMbPRsXhGAhsKIFF3wU+UKF+H8WSHviB0Z7FKWcjAdqoIlh2pBSTfLpp1NhWTRKnnQh418rqW08+y48sZwDEPsqxoL0AUMw8XbrIhUBA8uz/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN6Lpd1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN6Lpd1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C457C4CEE3;
	Sun, 22 Jun 2025 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750597149;
	bh=CVzVcjv/dVsCjXVqz0Dv1hVrWg56ty5UCjDYUtYTFp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SN6Lpd1/kT0JKwi1SsioFqoG3JnTL0GFgmy8Zs6i6dPYv87MgdxsdTXp5y4qw/ls4
	 1CHHEtVJP8hPPkNyt7VqfwNngkjaLO6l1RIR/DTmvdDH7TJQHBw8iCl1bsNC61hQ5L
	 2R4etNpP7Id81WSa6ib8i6if2wnsjmesVGxN/CTlW5N3jGS5yDno1zSva9P009rtrj
	 OurkwoW1nuIfUL6y5atoiOJuwrEMm2GbFIEz1h7eUHgsr1Pb3LWdxOn22HLPCv9wZk
	 4192doaNkzXCk0xq9NyXM9FlMeWgzNRoAWUhtYRX7FkKoKncpCinl4mBLNlYocyilN
	 oFjpnrfPJmdtA==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Francesco Zardi <frazar00@gmail.com>,
	Antonio Hickey <contact@antoniohickey.com>
Cc: rust-for-linux@vger.kernel.org,
	David Gow <davidgow@google.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] rust: block: convert `block::mq` to use `Refcount`
Date: Sun, 22 Jun 2025 13:57:30 +0100
Message-ID: <20250622125802.3224264-5-gary@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622125802.3224264-1-gary@kernel.org>
References: <20250622125802.3224264-1-gary@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

Currently there's a custom reference counting in `block::mq`, which uses
`AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
architectures. We cannot just change it to use 32-bit atomics, because
doing so will make it vulnerable to refcount overflow. So switch it to
use the kernel refcount `kernel::sync::Refcount` instead.

There is an operation needed by `block::mq`, atomically decreasing
refcount from 2 to 0, which is not available through refcount.h, so
I exposed `Refcount::as_atomic` which allows accessing the refcount
directly.

Tested-by: David Gow <davidgow@google.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/block/mq/operations.rs |  7 ++--
 rust/kernel/block/mq/request.rs    | 63 ++++++++----------------------
 rust/kernel/sync/refcount.rs       | 14 +++++++
 3 files changed, 34 insertions(+), 50 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 864ff379dc91..c399dcaa6740 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,9 +10,10 @@
     block::mq::Request,
     error::{from_result, Result},
     prelude::*,
+    sync::Refcount,
     types::ARef,
 };
-use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+use core::marker::PhantomData;
 
 /// Implement this trait to interface blk-mq as block devices.
 ///
@@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
         let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
 
         // One refcount for the ARef, one for being in flight
-        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
+        request.wrapper_ref().refcount().set(2);
 
         // SAFETY:
         //  - We own a refcount that we took above. We pass that to `ARef`.
@@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
 
             // SAFETY: The refcount field is allocated but not initialized, so
             // it is valid for writes.
-            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
 
             Ok(0)
         })
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 4a5b7ec914ef..683b5f32c620 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,13 +8,10 @@
     bindings,
     block::mq::Operations,
     error::Result,
+    sync::Refcount,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{
-    marker::PhantomData,
-    ptr::NonNull,
-    sync::atomic::{AtomicU64, Ordering},
-};
+use core::{marker::PhantomData, ptr::NonNull, sync::atomic::Ordering};
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
@@ -37,6 +34,9 @@
 /// We need to track 3 and 4 to ensure that it is safe to end the request and hand
 /// back ownership to the block layer.
 ///
+/// Note that the driver can still obtain new `ARef` even if there is no `ARef`s in existence by
+/// using `tag_to_rq`, hence the need to distinguish B and C.
+///
 /// The states are tracked through the private `refcount` field of
 /// `RequestDataWrapper`. This structure lives in the private data area of the C
 /// [`struct request`].
@@ -98,8 +98,11 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
     ///
     /// [`struct request`]: srctree/include/linux/blk-mq.h
     fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
-        // We can race with `TagSet::tag_to_rq`
-        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
+        // To hand back the ownership, we need the current refcount to be 2.
+        // Since we can race with `TagSet::tag_to_rq`, this needs to atomically reduce
+        // refcount to 0. `Refcount` does not provide a way to do this, so use the underlying
+        // atomics directly.
+        if let Err(_old) = this.wrapper_ref().refcount().as_atomic().compare_exchange(
             2,
             0,
             Ordering::Relaxed,
@@ -168,13 +171,13 @@ pub(crate) struct RequestDataWrapper {
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no [`ARef`] references to it.
     /// - 2+: There are [`ARef`] references to the request.
-    refcount: AtomicU64,
+    refcount: Refcount,
 }
 
 impl RequestDataWrapper {
     /// Return a reference to the refcount of the request that is embedding
     /// `self`.
-    pub(crate) fn refcount(&self) -> &AtomicU64 {
+    pub(crate) fn refcount(&self) -> &Refcount {
         &self.refcount
     }
 
@@ -184,7 +187,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     /// # Safety
     ///
     /// - `this` must point to a live allocation of at least the size of `Self`.
-    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
         unsafe { &raw mut (*this).refcount }
@@ -200,47 +203,13 @@ unsafe impl<T: Operations> Send for Request<T> {}
 // mutate `self` are internally synchronized`
 unsafe impl<T: Operations> Sync for Request<T> {}
 
-/// Store the result of `op(target.load())` in target, returning new value of
-/// target.
-fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
-    let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
-
-    // SAFETY: Because the operation passed to `fetch_update` above always
-    // return `Some`, `old` will always be `Ok`.
-    let old = unsafe { old.unwrap_unchecked() };
-
-    op(old)
-}
-
-/// Store the result of `op(target.load)` in `target` if `target.load() !=
-/// pred`, returning [`true`] if the target was updated.
-fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
-    target
-        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
-            if x == pred {
-                None
-            } else {
-                Some(op(x))
-            }
-        })
-        .is_ok()
-}
-
 // SAFETY: All instances of `Request<T>` are reference counted. This
 // implementation of `AlwaysRefCounted` ensure that increments to the ref count
 // keeps the object alive in memory at least until a matching reference count
 // decrement is executed.
 unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
     fn inc_ref(&self) {
-        let refcount = &self.wrapper_ref().refcount();
-
-        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
-        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
-
-        #[cfg(CONFIG_DEBUG_MISC)]
-        if !updated {
-            panic!("Request refcount zero on clone")
-        }
+        self.wrapper_ref().refcount().inc();
     }
 
     unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
@@ -252,10 +221,10 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
         let refcount = unsafe { &*RequestDataWrapper::refcount_ptr(wrapper_ptr) };
 
         #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
-        let new_refcount = atomic_relaxed_op_return(refcount, |x| x - 1);
+        let is_zero = refcount.dec_and_test();
 
         #[cfg(CONFIG_DEBUG_MISC)]
-        if new_refcount == 0 {
+        if is_zero {
             panic!("Request reached refcount zero in Rust abstractions");
         }
     }
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
index 8e7b9b0c1979..bea063ef3fe3 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -4,6 +4,8 @@
 //!
 //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
 
+use core::sync::atomic::AtomicI32;
+
 use crate::types::Opaque;
 
 /// Atomic reference counter.
@@ -30,6 +32,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
         self.0.get()
     }
 
+    /// Get the underlying atomic counter that backs the refcount.
+    ///
+    /// NOTE: This will be changed to LKMM atomic in the future.
+    #[inline]
+    pub fn as_atomic(&self) -> &AtomicI32 {
+        let ptr = self.0.get().cast();
+        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, which is an atomic 32-bit
+        // integer that is layout-wise compatible with `AtomicI32`. All values are valid for
+        // `refcount_t`, despite some of the values being considered saturated and "bad".
+        unsafe { &*ptr }
+    }
+
     /// Set a refcount's value.
     #[inline]
     pub fn set(&self, value: i32) {
-- 
2.49.0

