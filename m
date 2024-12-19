Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471F1C5CC2;
	Thu, 19 Dec 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641970; cv=none; b=ek44GnP0YBojO4B2Wog7GGcxzGUmvRDqhaUacpT1mRfyfRKWMOz/VUd9gcKWqDfokt302na4W/wyINxJd9haMpYHMSXMcDDYnSRx2cd+5j06C3JhhaRh9RUSjaAsC1NlFuwyxbdJxriungkMvKpkhSrL0o3OI0fe91r8g5tKXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641970; c=relaxed/simple;
	bh=QuD4JNTgu6e39ZsqeIHqU8OqpHyfwMrov7KIj0iYBZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MlCTBEnPc6rezhzoyr5wlNpWttUOIrjX6MIIoTTY2TbJOGz3/okwVk/dYcjD0uL47TEt/1duZwu1bh249dJkFa/xCAOexY30zBfttDcO0H1+pNstMtkCmthr89CmWC9p0WlNMkqYJ/eaQOdeZjNe2EXTe2GFiFufNZo2hIlHzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR/zUBVB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR/zUBVB"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72764c995e5so783330b3a.2;
        Thu, 19 Dec 2024 12:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734641967; x=1735246767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMTO1Amf/MwIKXjUDiFtxqLEDE98nAKJGcdfM/qH0rk=;
        b=LR/zUBVBOQ/sXTCTgzM/H8c6oYt5awl01Dk0aWPM+DzJRnb7fJBwAuYpCYvfcDUlUH
         6uWSu9rp6QXkUT/02PI+279QGW8shWKalSt2/iIUwOEXhOJA6lrMhMWZnP63y4A99Rcf
         IrcwhafNa/HCMp+zBfTz7yN8TzR3ABrBp2yTzPkzv07EG21keuTv38ysnAXB8YWFIIYo
         RhEbLKUPvtuVOp+o0QZi8XvwFgsNMBhygEZ0yaNE3HpvMqHFuLD6BVfaq18RYsR0hSkr
         0RGPtk8Nwb8JLVNUmnpJYPw1VvZTO4q7aBnR+VWC/gm5zbQkPTNw8TcsnxsDBszaNm8L
         bSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641967; x=1735246767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMTO1Amf/MwIKXjUDiFtxqLEDE98nAKJGcdfM/qH0rk=;
        b=Wqfz+jJSRKP0yY3fbCEz9tqB2TV1+5o2jebdnYySyJD0Y0yvL8Qzbte1pUTSZoj5OO
         hX3PDiIJsuBIfR6M5iv4CHPNKfiqMaP2ySlIy2ELq0pULe+UuU2rkGBZK/Zc1V7DKc+I
         Oc09yLdYzw3ieLecj6Xe4KlmsHgpr1xE09r9UKjBPabtn4eoO4kZj4hzqZHzve7r/RKy
         Ks5J6bundf50m1pu2yw0nShgteRgyPeqLa4lzYnNdWNT8B5W5jagr4AaTApBhmaA0wIQ
         sBb2APjTSYxU9flw06XFLpZQkAW3QwkhxSid8+PRss/ub9LYDdlkiVKm1VnRO42EJF9G
         l4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV9EwgD0gPAZqdtkAy/yLnAIYuEZU8y92ZrqFqEC2c5Nu9axfM+IlDgPIWImVyA3qiDrFo9dAm5JcSzPSk=@vger.kernel.org, AJvYcCXQWhzKKOl/1lohcBswir3EYk4v66uxt3GQN6fd+Cz2uzeUku91UJAfIMPO2+lR9YVpMjt1ucWstrf8DEG4/Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylUybp88Taj5+8cj5fiS2Z10QMYHf0/FMSRsRDqkNTGjJa4U0d
	frAJ4MBHf6TBeWubS/B1BI4gRaNIBIO767HQSpe1ypzl4FSeWmaj
X-Gm-Gg: ASbGnctp7kR8VRHmkccO5Jf0ALrLtGNO0jVdV8TuH6y7rFJ8Rk52u2mmwwpFfsIby6n
	QzjRbL5D5KdJK8SZZpoKui5jwhuAgPR21rxCn2W/hGC+yNautJDlhQ5w4kmAgY5ENm/RMTjD+ym
	P8TGjdRXKLlE8CXbRYqD2/kEF2w/E365CSo0sfjYOGFYBFQSS1gFzZ7izFHAzj9pXQIRKMdYyMd
	yb6tVH6LRh33hZ/Zntg5qxbMaOX8T1QNFNR8Fi+qIiPDN/ynqPUkq28IQRYHdW9BQ==
X-Google-Smtp-Source: AGHT+IH4dxenXt8SYXCiwcVOwZi8ohpz4CWPKvIxeDCV7WmSXrIhG5+d5dibvoE6RcB2JOKxvsMMng==
X-Received: by 2002:a05:6a00:428e:b0:72a:8461:d179 with SMTP id d2e1a72fcca58-72abdd20f79mr247143b3a.1.1734641967422;
        Thu, 19 Dec 2024 12:59:27 -0800 (PST)
Received: from mitchelllevy. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c331sm1751090b3a.196.2024.12.19.12.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:59:26 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Thu, 19 Dec 2024 12:58:56 -0800
Subject: [PATCH v2 2/2] rust: lockdep: Use Pin for all LockClassKey usages
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-rust-lockdep-v2-2-f65308fbc5ca@gmail.com>
References: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>
In-Reply-To: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734641963; l=9242;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=QuD4JNTgu6e39ZsqeIHqU8OqpHyfwMrov7KIj0iYBZs=;
 b=bQwa8o0urFcACDWUqtpQC/2m0mmz6+qyHsP+9D9xJ/TBE+0JmT1E4O04YG8jfizL1qt9ieBn7
 1EhlQ88sMO/CZqJTnhEOuPVWAJQdwqy6NvEMPwd69pRFYH98SEmf4mt
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Reintroduce dynamically-allocated LockClassKeys such that they are
automatically (de)registered. Require that all usages of LockClassKeys
ensure that they are Pin'd.

Closes: https://github.com/Rust-for-Linux/linux/issues/1102
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/helpers/helpers.c          |  1 +
 rust/helpers/sync.c             | 13 ++++++++++
 rust/kernel/sync.rs             | 57 ++++++++++++++++++++++++++++++++++++++---
 rust/kernel/sync/condvar.rs     |  5 ++--
 rust/kernel/sync/lock.rs        |  9 +++----
 rust/kernel/sync/lock/global.rs |  5 ++--
 rust/kernel/sync/poll.rs        |  2 +-
 rust/kernel/workqueue.rs        |  3 ++-
 8 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index dcf827a61b52..572af343212c 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -25,6 +25,7 @@
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
+#include "sync.c"
 #include "task.c"
 #include "uaccess.c"
 #include "vmalloc.c"
diff --git a/rust/helpers/sync.c b/rust/helpers/sync.c
new file mode 100644
index 000000000000..ff7e68b48810
--- /dev/null
+++ b/rust/helpers/sync.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/lockdep.h>
+
+void rust_helper_lockdep_register_key(struct lock_class_key *k)
+{
+	lockdep_register_key(k);
+}
+
+void rust_helper_lockdep_unregister_key(struct lock_class_key *k)
+{
+	lockdep_unregister_key(k);
+}
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index ae16bfd98de2..13bfdc647c5b 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -5,6 +5,8 @@
 //! This module contains the kernel APIs related to synchronisation that have been ported or
 //! wrapped for usage by Rust code in the kernel.
 
+use crate::pin_init;
+use crate::prelude::*;
 use crate::types::Opaque;
 
 mod arc;
@@ -22,15 +24,64 @@
 
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
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
+    /// Initializes a dynamically allocated lock class key. In the common case of using a
+    /// statically allocated lock class key, the static_lock_class! macro should be used instead.
+    ///
+    /// # Example
+    /// ```
+    /// # use kernel::{c_str, stack_pin_init};
+    /// # use kernel::alloc::KBox;
+    /// # use kernel::types::ForeignOwnable;
+    /// # use kernel::sync::{LockClassKey, SpinLock};
+    ///
+    /// let key = KBox::pin_init(LockClassKey::new_dynamic(), GFP_KERNEL)?;
+    /// let key_ptr = key.into_foreign();
+    ///
+    /// // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose `from_foreign()` has
+    /// // not yet been called.
+    /// stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
+    ///     0,
+    ///     c_str!("my_spinlock"),
+    ///     unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
+    /// ));
+    ///
+    /// drop(num);
+    ///
+    /// // SAFETY: We dropped `num`, the only use of the key, so the result of the previous
+    /// // `borrow` has also been dropped. Thus, it's safe to use from_foreign.
+    /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_foreign(key_ptr)) };
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn new_dynamic() -> impl PinInit<Self> {
+        pin_init!(Self {
+            // SAFETY: lockdep_register_key expects an uninitialized block of memory
+            inner <- Opaque::ffi_init(|slot| unsafe { bindings::lockdep_register_key(slot) })
+        })
+    }
+
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
-        self.0.get()
+        self.inner.get()
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for LockClassKey {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: self.as_ptr was registered with lockdep and self is pinned, so the address
+        // hasn't changed. Thus, it's safe to pass to unregister.
+        unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
     }
 }
 
@@ -43,7 +94,7 @@ macro_rules! static_lock_class {
         // lock_class_key
         static CLASS: $crate::sync::LockClassKey =
             unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
-        &CLASS
+        $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }
 
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 7df565038d7d..29289ccf55cc 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -15,8 +15,7 @@
     time::Jiffies,
     types::Opaque,
 };
-use core::marker::PhantomPinned;
-use core::ptr;
+use core::{marker::PhantomPinned, pin::Pin, ptr};
 use macros::pin_data;
 
 /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
@@ -101,7 +100,7 @@ unsafe impl Sync for CondVar {}
 
 impl CondVar {
     /// Constructs a new condvar initialiser.
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 41dcddac69e2..119e5f569bdb 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,12 +7,9 @@
 
 use super::LockClassKey;
 use crate::{
-    init::PinInit,
-    pin_init,
-    str::CStr,
-    types::{NotThreadSafe, Opaque, ScopeGuard},
+    init::PinInit, pin_init, str::CStr, types::NotThreadSafe, types::Opaque, types::ScopeGuard,
 };
-use core::{cell::UnsafeCell, marker::PhantomPinned};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
 use macros::pin_data;
 
 pub mod mutex;
@@ -121,7 +118,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             data: UnsafeCell::new(t),
             _pin: PhantomPinned,
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 480ee724e3cc..d65f94b5caf2 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -13,6 +13,7 @@
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
+    pin::Pin,
 };
 
 /// Trait implemented for marker types for global locks.
@@ -26,7 +27,7 @@ pub trait GlobalLockBackend {
     /// The backend used for this global lock.
     type Backend: Backend + 'static;
     /// The class for this global lock.
-    fn get_lock_class() -> &'static LockClassKey;
+    fn get_lock_class() -> Pin<&'static LockClassKey>;
 }
 
 /// Type used for global locks.
@@ -270,7 +271,7 @@ impl $crate::sync::lock::GlobalLockBackend for $name {
             type Item = $valuety;
             type Backend = $crate::global_lock_inner!(backend $kind);
 
-            fn get_lock_class() -> &'static $crate::sync::LockClassKey {
+            fn get_lock_class() -> Pin<&'static $crate::sync::LockClassKey> {
                 $crate::static_lock_class!()
             }
         }
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index d5f17153b424..c4934f82d68b 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -89,7 +89,7 @@ pub struct PollCondVar {
 
 impl PollCondVar {
     /// Constructs a new condvar initialiser.
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             inner <- CondVar::new(name, key),
         })
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 1dcd53478edd..f8f2f971f985 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -369,7 +369,8 @@ unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
 impl<T: ?Sized, const ID: u64> Work<T, ID> {
     /// Creates a new instance of [`Work`].
     #[inline]
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
+    #[allow(clippy::new_ret_no_self)]
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self>
     where
         T: WorkItem<ID>,
     {

-- 
2.34.1

