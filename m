Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DEB67F;
	Thu, 29 May 2025 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748506242; cv=none; b=bOmICQ4Urr91EcfmqvHa5XXVcIoanHtsjf1E7pTntvF3QA7xBmBdJhetqgJ0QQPnOLYVd7lVmXjCXrN9PviJSQXQg5IaFKeKccY2ZpwLneBJN2KsGOo4tBUBioFpkDmY9q1zub9rOp7jpHvu9BwePMcBylqlIzHOmVGQ/NL3rsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748506242; c=relaxed/simple;
	bh=6qlx5+iEC4eVDc2SViL9z2IxlgxtZi/p07OUwRKmvwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOP6uYJvLja9T0PpjxWXCBdWsojlbofRdtN9di4tXRSB454qdgduIoC4N8FCpYz5Qi1XpwvPxgJT77Mw3dfN75AnlrD7+dcrrHE6nSDqdCuiqziRfw0Y2CsplEypTZqDgeLmB/fK8ANJFy1Qgu6soPUIrGbsLhb2Hov5PVvbfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJYHNQtK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJYHNQtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069D9C4CEE7;
	Thu, 29 May 2025 08:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748506240;
	bh=6qlx5+iEC4eVDc2SViL9z2IxlgxtZi/p07OUwRKmvwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJYHNQtKYUXciJsqmOaeEIDqrmi1RVPFTukMYACG10PGDnQ9XyrXH8TpvhS82hyNa
	 48XiygPK9DakKS/ilEpbL02ZF1pa31iIyAyH6HQvdjRFUBvum3f2fbqkrUX0waT49K
	 PU3gHz9LDGwA3zvD6VMLSK6g4ChXU4c+tEcluPhmqj3Rm67jYepeJcmk9wwzXsE7ip
	 P9Hcm4vQPFxDyRAqvH7oYWphCTcRyHpa5xaq7HuVm6jw4ohdyK8GuVK6koKqen2hE8
	 mus0n6+0S8hos92LJE1m9EHpbvtlORd0m0qjFwq+ozawThOF2SfG/zeWUZgOCi3B3n
	 AeGHfygsPflSw==
From: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Fiona Behrens <me@kloenk.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] change blanket impls for `[Pin]Init` and add one for `Result<T, E>`
Date: Thu, 29 May 2025 10:10:24 +0200
Message-ID: <20250529081027.297648-2-lossin@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529081027.297648-1-lossin@kernel.org>
References: <20250529081027.297648-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the error from the blanket implementations `impl<T, E> Init<T, E>
for T` (and also for `PinInit`). Add implementations for `Result<T, E>`.

This allows one to easily construct (un)conditional failing
initializers. It also improves the compatibility with APIs that do not
use pin-init, because users can supply a `Result<T, E>` to a  function
taking an `impl PinInit<T, E>`.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/pin-init/pull/62/commits/58612514b256c6f4a4a0718be25298410e67387a
[ Also fix a compile error in block. - Benno ]
Signed-off-by: Benno Lossin <lossin@kernel.org>
---

This patch is also needed by Danilo for initializing `Devres`
ergonomically.

---
 rust/kernel/block/mq/tag_set.rs | 12 +++++++-----
 rust/pin-init/src/lib.rs        | 30 ++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index bcf4214ad149..c3cf56d52bee 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -9,7 +9,7 @@
 use crate::{
     bindings,
     block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
-    error,
+    error::{self, Result},
     prelude::try_pin_init,
     types::Opaque,
 };
@@ -41,7 +41,7 @@ pub fn new(
         // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
         // all are allowed to be 0.
         let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
-        let tag_set = core::mem::size_of::<RequestDataWrapper>()
+        let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
             .try_into()
             .map(|cmd_size| {
                 bindings::blk_mq_tag_set {
@@ -56,12 +56,14 @@ pub fn new(
                     nr_maps: num_maps,
                     ..tag_set
                 }
-            });
+            })
+            .map(Opaque::new)
+            .map_err(|e| e.into());
 
         try_pin_init!(TagSet {
-            inner <- PinInit::<_, error::Error>::pin_chain(Opaque::new(tag_set?), |tag_set| {
+            inner <- tag_set.pin_chain(|tag_set| {
                 // SAFETY: we do not move out of `tag_set`.
-                let tag_set = unsafe { Pin::get_unchecked_mut(tag_set) };
+                let tag_set: &mut Opaque<_> = unsafe { Pin::get_unchecked_mut(tag_set) };
                 // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
                 error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
             }),
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index d1c3ca5cfff4..f4e034497cdd 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -1391,8 +1391,8 @@ pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
 }
 
 // SAFETY: the `__init` function always returns `Ok(())` and initializes every field of `slot`.
-unsafe impl<T, E> Init<T, E> for T {
-    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
+unsafe impl<T> Init<T> for T {
+    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
         // SAFETY: `slot` is valid for writes by the safety requirements of this function.
         unsafe { slot.write(self) };
         Ok(())
@@ -1401,14 +1401,36 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
 
 // SAFETY: the `__pinned_init` function always returns `Ok(())` and initializes every field of
 // `slot`. Additionally, all pinning invariants of `T` are upheld.
-unsafe impl<T, E> PinInit<T, E> for T {
-    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+unsafe impl<T> PinInit<T> for T {
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), Infallible> {
         // SAFETY: `slot` is valid for writes by the safety requirements of this function.
         unsafe { slot.write(self) };
         Ok(())
     }
 }
 
+// SAFETY: when the `__init` function returns with
+// - `Ok(())`, `slot` was initialized and all pinned invariants of `T` are upheld.
+// - `Err(err)`, slot was not written to.
+unsafe impl<T, E> Init<T, E> for Result<T, E> {
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: `slot` is valid for writes by the safety requirements of this function.
+        unsafe { slot.write(self?) };
+        Ok(())
+    }
+}
+
+// SAFETY: when the `__pinned_init` function returns with
+// - `Ok(())`, `slot` was initialized and all pinned invariants of `T` are upheld.
+// - `Err(err)`, slot was not written to.
+unsafe impl<T, E> PinInit<T, E> for Result<T, E> {
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: `slot` is valid for writes by the safety requirements of this function.
+        unsafe { slot.write(self?) };
+        Ok(())
+    }
+}
+
 /// Smart pointer containing uninitialized memory and that can write a value.
 pub trait InPlaceWrite<T> {
     /// The type `Self` turns into when the contents are initialized.
-- 
2.49.0

