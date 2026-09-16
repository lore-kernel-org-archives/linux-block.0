Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25438F935
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521315; cv=none; b=sG3RD38ojwyKOoSBJv2oXMbYUr7XuMurTOzWm/nKbf1XNXuy741UoUQBkkCFvxPBsppli1zB0Bgyo55cZeTmhZ1EBBTLGvocltb8Knxs7k5s7ePJoh7jSQY6YEkI3zjNQTgSPGSlyZHLQhfC3pIDzHtZylQwBCIot57hhcOR+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521315; c=relaxed/simple;
	bh=1oHur9vEj+OaGrHshuKT+eDTAu8cXqL6ipLWH80GzPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1k2LHZdUFiLpBzIDEXwoftYMT4hH27NvsI0b9wE3ce3xXC8ytJg9ADpjcM4Le/US+I62o7RaRCqj9jQJm8c/nytxoNq9tOWmDYD50qTMo+V7OAcmSMwPtv4G14MupuwvRsVDkN5IJ4F1vVgP6X+88a92cBsjBPK8rgCeG0zgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAXcBLNF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAXcBLNF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so1634185e9.0
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789521311; x=1790126111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jnXDLK26KNZ+Nc8tc4KYaeGG7+wo+38IhWGefLy0ryc=;
        b=sAXcBLNF8mJ9yDJtXRLX2zVPFKNgN5+KR3ZA0BGPvB9GuDwmPW0M/ZWXPLacdfSBoQ
         soIGFj3p2SJpprt/WjtqqS9qg/BkbnoZS0NLIfUO+RCEEcal6KJ6ZW8SmOnmmSd9zNpF
         Y5GvJKpsNDBIaJZrFElsORrIyfpM2tKBul9Px60i3b5O4aj+WTJf4oxnz1xQ4AdL8o5o
         TuJp7vM64CRk8gg5KTD3E2DbWLohjzO023xdO/IcvLRChG9iHfG+cGHWdNIlzr9aMEB2
         ggntOWtaUHx7n8blfT/nXMhbYNOeT/VWfUjxHm8qsLa0M68TEAQev71UG7O2eBE3Z+vh
         mNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789521311; x=1790126111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jnXDLK26KNZ+Nc8tc4KYaeGG7+wo+38IhWGefLy0ryc=;
        b=qhPOqRq0lquci98hYa/DvPEiWFPucvO4L1yhAg/BpcEayhM16ZEv8NwscdOhGNpqWw
         AMP4/Wpo4xM0dDobRIBffT0Y0nlR0Qgg9deyzLcPhD4Qpva0kYYzsnvpcPv+Ph665pa3
         QHd04mhPzYgRzZ9dJgHEIbUNFjFrr8Np4e/kUlkzrweHcMeeH9BCA3o0+FN0G9zdXOx5
         h6wTr3g3Hd15wDHTep+L3ER/bQNf8d8j881KWO1/MrqpNM5JqmLMFWmK6t5Fr1NAoxNZ
         m2R/vaspuzWIxz0Bib7cBP34PIHQ5xwYTwZtEo+FxRBSv7sCwBPD2jxgZ1ca246ZWNoX
         PRCA==
X-Gm-Message-State: AFuF++mz+ERQaCO+YrAn1BgUAEEmXbeLpm0cIam9yxC3XT7d9WeMyoJf
	xDPO/TcWFzJjnKjaIOOVoIxdKnEHMBQl5apHwIUgqpxWgzdKljXu/isq
X-Gm-Gg: AYBFou3IDhm6U0iPKoS496RVIM83yLzY3qHtIjYJFEvEPLzVCxo15XzZXAa4D6Qht7t
	oYJe74aX2D2CVxssVmtc65R8ffCFTNuJ3xiLV7JAVTLW5JFwTeML+40v/RBfwor7frDwad4kzxA
	UOqe1iTv+T/c9x3yHQhY/i8JtI7ETYo/8GbvFxRRiTAkdccm3qOqI24Pqh34fsVhD6BrpeMGvKp
	Sz4TFWaWtKDBMhK1mCJZdCodJmFTWuZtnTVSrIpvsLNeK+0R8Z97NUuDL8+ndiYR5YPy4tsNRp6
	LQtHonRZBj+TpUpiT2MckjIxBs9iUvmjI1YV2T7EkAq0IovXr5UVRwDSwB1NBEwtmCF9XseS9Be
	PpljUQ5nGkJ2H/aRqWykqbh7wjirqRirPAeUlHI5mozZ1GspMQoxxjpJZN1zf+5sDYYGvep3TSU
	T5e72b3u4vfSpXZlo0usVxOvu535YyIY9xRKIt4Ipq9cPhs5LbMpYhdS5o2XFZLXtO+c+hYKOMT
	avdL1RQfNDEKmj395eKIWcMJS10vuLBOQc9Y4beOCgZAtgKn68IAAbUlRZvGmFUsA==
X-Received: by 2002:a05:600c:3b97:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49ebcc010d5mr9739045e9.15.1789521311221;
        Tue, 15 Sep 2026 18:15:11 -0700 (PDT)
Received: from moosama76.. ([156.193.15.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83fca34asm26367435e9.1.2026.09.15.18.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 18:15:10 -0700 (PDT)
From: Mohamed Osama <mohamed.osama189110@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Osama <mohamed.osama189110@gmail.com>,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH] rust: mem: add DropGuard
Date: Wed, 16 Sep 2026 04:15:00 +0300
Message-ID: <20260916011500.529743-1-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a `DropGuard` type to the Rust kernel memory module for running
cleanup code when a scope is left.

`DropGuard` runs a `FnOnce` callback when dropped and provides
`dismiss()` to take the wrapped value without running the callback.

Replace the current `ScopeGuard` users in `gen_disk`, `serdev`, and
`sync::lock` with `DropGuard`. Keep `ScopeGuard` since it is still used
elsewhere.

Add KUnit tests for cleanup on drop and `dismiss()`.

Tested with:
- `make LLVM=1 -j$(nproc)`
- KUnit: 8 tests passed
- `make LLVM=1 rustfmtcheck`
- `git diff --check`
- `checkpatch.pl`
- `make LLVM=1 rustdoc`

Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://github.com/Rust-for-Linux/linux/issues/1255
Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/Kconfig.test         |  10 +++
 rust/kernel/block/mq/gen_disk.rs |  11 +--
 rust/kernel/mem.rs               | 116 +++++++++++++++++++++++++++++++
 rust/kernel/serdev.rs            |   8 +--
 rust/kernel/sync/lock.rs         |   5 +-
 5 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
index e6a5c7a795f0..011c72f14e2c 100644
--- a/rust/kernel/Kconfig.test
+++ b/rust/kernel/Kconfig.test
@@ -33,6 +33,16 @@ config RUST_KVEC_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RUST_DROP_GUARD_KUNIT_TEST
+	bool "KUnit tests for Rust DropGuard API" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables KUnit tests for the Rust DropGuard API.
+	  These are only for development and testing, not for regular
+	  kernel use cases.
+
+	  If unsure, say N.
+
 config RUST_BITMAP_KUNIT_TEST
 	bool "KUnit tests for Rust bitmap API" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..d9019fbbb361 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -10,11 +10,12 @@
     block::mq::{Operations, TagSet},
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
+    mem::DropGuard,
     prelude::*,
     static_lock_class,
     str::NullTerminatedFormatter,
     sync::Arc,
-    types::{ForeignOwnable, ScopeGuard},
+    types::ForeignOwnable,
 };
 
 /// A builder for [`GenDisk`].
@@ -102,7 +103,7 @@ pub fn build<T: Operations>(
         queue_data: T::QueueData,
     ) -> Result<GenDisk<T>> {
         let data = queue_data.into_foreign();
-        let recover_data = ScopeGuard::new(|| {
+        let recover_data = DropGuard::new((), |_| {
             // SAFETY: T::QueueData was created by the call to `into_foreign()` above
             drop(unsafe { T::QueueData::from_foreign(data) });
         });
@@ -150,7 +151,7 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
-        let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
+        let cleanup_failure = DropGuard::new((gendisk, data), |(gendisk, data)| {
             // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
             // has not been added to the VFS on this cleanup path.
             unsafe { bindings::put_disk(gendisk) };
@@ -161,7 +162,7 @@ pub fn build<T: Operations>(
 
         // The failure guard now owns both pieces of cleanup; the early guard
         // must not run on this path anymore.
-        recover_data.dismiss();
+        DropGuard::dismiss(recover_data);
 
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
@@ -185,7 +186,7 @@ pub fn build<T: Operations>(
             },
         )?;
 
-        cleanup_failure.dismiss();
+        DropGuard::dismiss(cleanup_failure);
 
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
index f2d4cdf87d00..e098675ea195 100644
--- a/rust/kernel/mem.rs
+++ b/rust/kernel/mem.rs
@@ -4,6 +4,88 @@
 
 use crate::prelude::*;
 
+use core::mem::ManuallyDrop;
+use core::ops::{Deref, DerefMut};
+
+/// Wraps a value and runs a closure when dropped.
+///
+/// This is useful for running cleanup code when leaving a scope.
+///
+/// The [`DropGuard::dismiss`] function can be used to take ownership of the wrapped
+/// value without running the cleanup function.
+#[doc(alias = "ScopeGuard")]
+#[doc(alias = "defer")]
+pub struct DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    inner: ManuallyDrop<T>,
+    f: ManuallyDrop<F>,
+}
+
+impl<T, F> DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    /// Creates a new `DropGuard`.
+    #[must_use]
+    pub fn new(inner: T, f: F) -> Self {
+        Self {
+            inner: ManuallyDrop::new(inner),
+            f: ManuallyDrop::new(f),
+        }
+    }
+
+    /// Consumes the `DropGuard`, returning the wrapped value without
+    /// running the cleanup function.
+    pub fn dismiss(guard: Self) -> T {
+        let mut guard = ManuallyDrop::new(guard);
+
+        // SAFETY: We have taken ownership of the guard and prevent its destructor from running.
+        let value = unsafe { ManuallyDrop::take(&mut guard.inner) };
+
+        // SAFETY: We have taken ownership of the guard.
+        unsafe { ManuallyDrop::drop(&mut guard.f) };
+
+        value
+    }
+}
+
+impl<T, F> Deref for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        &self.inner
+    }
+}
+
+impl<T, F> DerefMut for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    fn deref_mut(&mut self) -> &mut T {
+        &mut self.inner
+    }
+}
+
+impl<T, F> Drop for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    fn drop(&mut self) {
+        // SAFETY: `DropGuard` is in the process of being dropped.
+        let inner = unsafe { ManuallyDrop::take(&mut self.inner) };
+
+        // SAFETY: `DropGuard` is in the process of being dropped.
+        let f = unsafe { ManuallyDrop::take(&mut self.f) };
+
+        f(inner);
+    }
+}
+
 /// Transmute between two types.
 ///
 /// Use this instead of [`core::mem::transmute`] when it is known that sizes are identical but this
@@ -232,3 +314,37 @@ unsafe impl AsReprMut for $signed {}
     // `usize` is not normalized to particular integer for portability.
     usize isize,
 }
+
+#[cfg(CONFIG_RUST_DROP_GUARD_KUNIT_TEST)]
+#[macros::kunit_tests(rust_drop_guard)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_drop_runs_cleanup() {
+        let mut cleaned = false;
+
+        {
+            let _guard = DropGuard::new(42, |value| {
+                assert_eq!(value, 42);
+                cleaned = true;
+            });
+        }
+
+        assert!(cleaned);
+    }
+
+    #[test]
+    fn test_dismiss_returns_value_without_cleanup() {
+        let mut cleaned = false;
+
+        let guard = DropGuard::new(42, |_| {
+            cleaned = true;
+        });
+
+        let value = DropGuard::dismiss(guard);
+
+        assert_eq!(value, 42);
+        assert!(!cleaned);
+    }
+}
diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..a400d241c2ad 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -13,6 +13,7 @@
         to_result,
         VTABLE_DEFAULT_ERROR, //
     },
+    mem::DropGuard,
     new_mutex,
     of,
     prelude::*,
@@ -21,10 +22,7 @@
         Mutex, //
     },
     time::Jiffies,
-    types::{
-        Opaque,
-        ScopeGuard, //
-    }, //
+    types::Opaque, //
 };
 
 use core::{
@@ -174,7 +172,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
             }))?;
             // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
             let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
-            let private_data = ScopeGuard::new_with_data(private_data, |_| {
+            let private_data = DropGuard::new(private_data, |_| {
                 // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
                 drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData<'_, T>>() });
             });
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 10b6b5e9b024..15f9cbe76c8d 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,8 +7,9 @@
 
 use super::LockClassKey;
 use crate::{
+    mem::DropGuard,
     str::{CStr, CStrExt as _},
-    types::{NotThreadSafe, Opaque, ScopeGuard},
+    types::{NotThreadSafe, Opaque},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
 use pin_init::{pin_data, pin_init, PinInit, Wrapper};
@@ -242,7 +243,7 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 
-        let _relock = ScopeGuard::new(||
+        let _relock = DropGuard::new((), |_|
                 // SAFETY: The lock was just unlocked above and is being relocked now.
                 unsafe { B::relock(self.lock.state.get(), &mut self.state) });
 
-- 
2.43.0

