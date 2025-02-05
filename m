Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A6211A22;
	Wed,  5 Feb 2025 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785574; cv=none; b=ISs2NLDXWUy4OcLIZS5vzFQY0VaE1VAmbdQW0epRCpUIYRp3K1V198ZUo+N9folQp7SLRdmMXeeWXoklOYWX38O3QhTJK9JQJZsVtC91JxZBcso1tsioBRBh9myuaIzCITWOHG2IzUN32FiII5J+DknBqM8rKYKSXN1X/7ATLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785574; c=relaxed/simple;
	bh=uWZGrFppv6j2Qge74gKSOQBqBxNw6jgyNfZv0idm3Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REWgdcaogemBGlwMiLtK60GKpZ6DdVE0goMWb0HXaX/KfDZ5ACgC3vdq18sNJRsAw0l66iOkBfWvuEDKAgKyS4zAk6zTuHkYPcv6xXyVmj0q0E/7LaPN8iiSE7qdG/fYlXir0hUjVjbO3aBSA9t0deaf3AYODPmT7hVjJ4AttkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ims655Na; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ims655Na"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so112884a91.2;
        Wed, 05 Feb 2025 11:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738785572; x=1739390372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7O+2QdRtjbIOucUMl/fKCiJHC3zGqj9teB/yIuuE5Fs=;
        b=Ims655NaeNnodzHvxxTCHYIdSO3e6d7pV4rcQnmFqtQueHD5WNr2tWlzpinisHQTXQ
         h7PDBOTwaJScECmEeDZdaPdN6WD9BFUgqw7AvkOdTG6LqmtTzhNw72B6VHQiodFLvRdL
         iO6r84fpKW6rjSmYIQE2GQIciojMUolr7zgS5+nGPiNccGrhaqhvuK4wAutr/QehOFul
         u/8A+C7NEN/kydjFPYmAlSjwitr0/jiaUu4Bhec+GQSqo7PbJQIlvyXs7j6YZhzxSDlJ
         EPpUY+hmY2jaD7BPCbp+ldP+Pr81JjioPnBLG8Oo16qBrtKbLW+/VEpcqRgwopvTAweL
         Sx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785572; x=1739390372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7O+2QdRtjbIOucUMl/fKCiJHC3zGqj9teB/yIuuE5Fs=;
        b=i0YXf4si3TFFBuWqN/LZWAPWkXtutx9+0K9BbTQMoN2OLGj6sG03+vP2xQhWqIUhJO
         eukwuLMuefDmMQL7R9qT+M9QHrjh6L8Pv9PMp2b17vjPgz+le4vfF0gtC42os8Ls9hDm
         mQpOr+3FSbhitgX9Fw+xMzIxpbZjG89IV5QBZenjo9QRIbemVUolkqMWXdhPbOKSw9E2
         1YVsHJIvdj3q3U038N0EawKCEhUYOR2AIKFVvCBQzxFdL/9VCvoRV+jkUWVnj+9MvqRp
         vs/CzatLhfqMrU0UhBkYCwYVl21qC83qz6x/Ll1J1TgVjSkRU7s/JFmw8Q7JpAXJFRy3
         zI0A==
X-Forwarded-Encrypted: i=1; AJvYcCVRN45P9+hjGu6isECODiUR9cvyAJp86QHu2gS/AQ7KbPu69zcQMpI/Frqkh8e1uTF1+ofQi0yIoAXTHtg=@vger.kernel.org, AJvYcCVXUBEG0TAcplxSx7ftekF+JnZG/QARDc60MSFahmUsNoAzdlaTbkeMKcuvU7ERssn3kZNtpDBvZyZAgp8CbJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgvqHGR+4nimXxAbTPfgALes5kgWtSLC72u1VapmqAIKJ97Qu
	FyVHFLs8whuRs0prABWxP//zUQzIoB30dqF1AEp6g589mxr8ravnV1z/nU8G
X-Gm-Gg: ASbGncubNslL2KQHdaU3tefhh1Bys/cpiUbf20qevW9jnITMUhn1WDnwXfJmovKEFQb
	PJxp7+g3oNHdTFnmHq41CTrI16y1NmE4Cf3+nGBaAcWh6B5nvzISqi/UdNeeaO+RtDaYadolOjO
	kp0s5AQKBiNeF/JC6u0VXpADRTf5C4VdgeOZe5zMXw9eICRq33P7/9LbhmKqA5HxbMY3vD1cKYX
	gibrqVO/jvzCEqkf44vNrhzjtIz85O4uzEEWv78SPkgaiCPfozayEWb+zFOcpQYT4gLZiogCmqY
	pxbGNRjDDPtitTzg0G825mqV
X-Google-Smtp-Source: AGHT+IGvVWqi8mbO31y/3eHYmoYn4PISxCRAu9tTzPoVp4gXHbIJjsDwoyKEN5R+k3Jk3paQkxmfcw==
X-Received: by 2002:a17:90b:1848:b0:2ef:2d9f:8e55 with SMTP id 98e67ed59e1d1-2f9e0789104mr7105476a91.17.1738785571731;
        Wed, 05 Feb 2025 11:59:31 -0800 (PST)
Received: from mitchelllevy. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1668800fsm19685765ad.158.2025.02.05.11.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:59:30 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Feb 2025 11:59:05 -0800
Subject: [PATCH v3 2/2] rust: lockdep: Use Pin for all LockClassKey usages
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-rust-lockdep-v3-2-5313e83a0bef@gmail.com>
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com>
In-Reply-To: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738785568; l=9283;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=uWZGrFppv6j2Qge74gKSOQBqBxNw6jgyNfZv0idm3Rc=;
 b=URWyD3hGrvX0NQmMuO/j4bATBvEp4CRBb7UfZuS13VgMadgQjUuhqfF5ukvQY5g43PJIzsvOc
 nnpBihR1fFJBB2Uyp/UwNwSQGbNuGo9H0EvDXZnMGVKCWzHQ+/prmEr
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
 rust/kernel/workqueue.rs        |  2 +-
 8 files changed, 78 insertions(+), 16 deletions(-)

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
index cb92f2c323e5..a02acde1f22e 100644
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
+    /// {
+    ///     stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
+    ///         0,
+    ///         c_str!("my_spinlock"),
+    ///         // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose
+    ///         // `from_foreign()` has not yet been called.
+    ///         unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
+    ///     ));
+    /// }
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
             // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
             // lock_class_key
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
index 1dcd53478edd..88154f55b329 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -369,7 +369,7 @@ unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
 impl<T: ?Sized, const ID: u64> Work<T, ID> {
     /// Creates a new instance of [`Work`].
     #[inline]
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self>
     where
         T: WorkItem<ID>,
     {

-- 
2.34.1

