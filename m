Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3437153838;
	Thu,  5 Sep 2024 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578036; cv=none; b=t7PakqaAiOeM341SZVduZNAu6cWpHNKVl54xRG/ALhfn3qA99iijmm563Wq3P7T2iKw8cKyCAhgKspG9r5rXqXsz/hj03qVFtOKjVMWwZXgcor4+FtkuZXrIeXw/kHHC8KsJjaNCRWl3k49JCv82HBKvG1rtkRIy0balt+zRj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578036; c=relaxed/simple;
	bh=sEZ3UxCHet+ifl4ZmAf0+DJA2EeJrKVFGykfE/sbXng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KYMd55ZeFNVvME/I8YPbSGshNt7Zqp5RdDNgt0RjjTPbfuwoYy7BaVMc4LREUpMB29E1a9KR3loLxA6gxrMGXEPkKG50b/1P1zbVk24F3rtb/wqgXyuhJ62TDbA3wYfdw/qw83j7jouWqcjoHFfp5JK1HHwL6ehzmVyFqYmhboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUF0nwYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUF0nwYW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 594CEC4CEC3;
	Thu,  5 Sep 2024 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725578036;
	bh=sEZ3UxCHet+ifl4ZmAf0+DJA2EeJrKVFGykfE/sbXng=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iUF0nwYWdXWs3RQz2JhfK2bEhUhGThEKzArF7Kd8kNxVnBgIE+hWaDoIu4TClKPsG
	 3MPoenKWY76wDQWAj9X3pS7LdvDMYshyimzmNBuqfLBVw6+GDqviyBbal9/WofBPO/
	 Btq9md9mU35Bmn4640gTJCL5jAWNIwCDKlyAJ4fQvFfX1z0Fw57EtQKJaCgwvX4OUy
	 XB5953dFyWp08YeSZrwxkIcjRIzCzu+pVYiIJjUFJlvKAdU1IB0UsC7F4Zy5ib3iUc
	 3aGs7+MqQlNJFy7GeDt8e+f426jQKJ1BUej/glP6K4V5KKum+f0EnYFgmUzI/u+z4f
	 p5KP4ovRmJx2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40753CD4849;
	Thu,  5 Sep 2024 23:13:56 +0000 (UTC)
From: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>
Date: Thu, 05 Sep 2024 16:13:57 -0700
Subject: [PATCH RFC] rust: lockdep: Use Pin for all LockClassKey usages
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
X-B4-Tracking: v=1; b=H4sIADQ72mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNT3aLS4hLdnPzk7JTUAt0U41RjA1Mjw2SLpEQloJaCotS0zAqwcdF
 KQW7OSrG1tQAHLhiyYwAAAA==
To: Andreas Hindborg <a.hindborg@samsung.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725578037; l=8101;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=ibFwe6n0BNfNZ/U63sEUCAUC6QMeYuYX5RG8MBqosow=;
 b=N5SudSNW6s2JImEj1UoPFH/70ZNb+ss2Qu0wyjrQnglbtP0Q1bhft5J+3l9HCjCiRqkrsHQrb
 edqLq/bHbyuAlkCSGroJbO/f9DDs1d99oyLuLVWvjaw/0W5LsOOFbrK
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20240719 with
 auth_id=188
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: levymitchell0@gmail.com

From: Mitchell Levy <levymitchell0@gmail.com>

The current LockClassKey API has soundness issues related to the use of
dynamically allocated LockClassKeys. In particular, these keys can be
used without being registered and don't have address stability.

This fixes the issue by using Pin<&LockClassKey> and properly
registering/deregistering the keys on init/drop.

Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-1-nmi@metaspace.dk/
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
This change is based on applying the linked patch to the top of
rust-next.

I'm sending this as an RFC because I'm not sure that using
Pin<&'static LockClassKey> is appropriate as the parameter for, e.g.,
Work::new. This should preclude using dynamically allocated
LockClassKeys here, which might not be desirable. Unfortunately, using
Pin<&'a LockClassKey> creates other headaches as the compiler then
requires that T and PinImpl<Self> be bounded by 'a, which also seems
undesirable. I would be especially interested in feedback/ideas along
these lines.
---
 rust/kernel/block/mq/gen_disk.rs |  2 +-
 rust/kernel/sync.rs              | 30 +++++++++++++++++++++---------
 rust/kernel/sync/condvar.rs      | 13 ++++++++-----
 rust/kernel/sync/lock.rs         |  6 +++---
 rust/kernel/workqueue.rs         |  6 +++---
 5 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 708125dce96a..706ac3c532d5 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -108,7 +108,7 @@ pub fn build<T: Operations>(
                 tagset.raw_tag_set(),
                 &mut lim,
                 core::ptr::null_mut(),
-                static_lock_class!().as_ptr(),
+                static_lock_class!().get_ref().as_ptr(),
             )
         })?;
 
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..c46a296cbe6d 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -5,6 +5,8 @@
 //! This module contains the kernel APIs related to synchronisation that have been ported or
 //! wrapped for usage by Rust code in the kernel.
 
+use crate::pin_init;
+use crate::prelude::*;
 use crate::types::Opaque;
 
 mod arc;
@@ -20,7 +22,11 @@
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
-pub struct LockClassKey(Opaque<bindings::lock_class_key>);
+#[pin_data(PinnedDrop)]
+pub struct LockClassKey {
+    #[pin]
+    inner: Opaque<bindings::lock_class_key>,
+}
 
 // SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
 // provides its own synchronization.
@@ -28,18 +34,22 @@ unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
     /// Creates a new lock class key.
-    pub const fn new() -> Self {
-        Self(Opaque::uninit())
+    pub fn new_dynamic() -> impl PinInit<Self> {
+        pin_init!(Self {
+            // SAFETY: lockdep_register_key expects an uninitialized block of memory
+            inner <- Opaque::ffi_init(|slot| unsafe { bindings::lockdep_register_key(slot) })
+        })
     }
 
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
-        self.0.get()
+        self.inner.get()
     }
 }
 
-impl Default for LockClassKey {
-    fn default() -> Self {
-        Self::new()
+#[pinned_drop]
+impl PinnedDrop for LockClassKey {
+    fn drop(self: Pin<&mut Self>) {
+        unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
     }
 }
 
@@ -48,8 +58,10 @@ fn default() -> Self {
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
-        &CLASS
+        static CLASS: $crate::sync::LockClassKey = unsafe {
+            ::core::mem::MaybeUninit::uninit().assume_init()
+        };
+        $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }
 
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 2b306afbe56d..6c40b45e35cd 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -14,9 +14,12 @@
     time::Jiffies,
     types::Opaque,
 };
-use core::ffi::{c_int, c_long};
-use core::marker::PhantomPinned;
-use core::ptr;
+use core::{
+    ffi::{c_int, c_long},
+    marker::PhantomPinned,
+    pin::Pin,
+    ptr,
+};
 use macros::pin_data;
 
 /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
@@ -102,13 +105,13 @@ unsafe impl Sync for CondVar {}
 
 impl CondVar {
     /// Constructs a new condvar initialiser.
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
             // static lifetimes so they live indefinitely.
             wait_queue_head <- Opaque::ffi_init(|slot| unsafe {
-                bindings::__init_waitqueue_head(slot, name.as_char_ptr(), key.as_ptr())
+                bindings::__init_waitqueue_head(slot, name.as_char_ptr(), key.get_ref().as_ptr())
             }),
         })
     }
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..c6bdbb85a39c 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,7 +7,7 @@
 
 use super::LockClassKey;
 use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned, pin::Pin};
 use macros::pin_data;
 
 pub mod mutex;
@@ -106,14 +106,14 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             data: UnsafeCell::new(t),
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
             // static lifetimes so they live indefinitely.
             state <- Opaque::ffi_init(|slot| unsafe {
-                B::init(slot, name.as_char_ptr(), key.as_ptr())
+                B::init(slot, name.as_char_ptr(), key.get_ref().as_ptr())
             }),
         })
     }
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 553a5cba2adc..eefc2b7b578c 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -367,9 +367,9 @@ impl<T: ?Sized, const ID: u64> Work<T, ID> {
     /// Creates a new instance of [`Work`].
     #[inline]
     #[allow(clippy::new_ret_no_self)]
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self>
     where
-        T: WorkItem<ID>,
+        T: WorkItem<ID>
     {
         pin_init!(Self {
             work <- Opaque::ffi_init(|slot| {
@@ -381,7 +381,7 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
                         Some(T::Pointer::run),
                         false,
                         name.as_char_ptr(),
-                        key.as_ptr(),
+                        key.get_ref().as_ptr(),
                     )
                 }
             }),

---
base-commit: 8edf38a534a38e5d78470a98d43454e3b73e307c
change-id: 20240905-rust-lockdep-d3e30521c8ba

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>


