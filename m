Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804F155392
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516753; cv=none; b=r/uTyiNHsh2skYdvqFU3N3Qekhm18uC4QJ/xUCFjPzTfJae3KWquITj5EG8cwrY1UYvqPWqUZPmLwB3w+ExAL/kDNgRTBzd2WZu1JXeA/5wJl6PmnyxxcJg0kJkAbulk9OdYcVvRwzNYdXa69u0IEYdVqVkQ+110PTA5KblW0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516753; c=relaxed/simple;
	bh=2q/az6HaCPchXtkkz92LD2DZLCM0KCj/UmgVvpuf8jk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TRRWRLOhpoCJ7GlGF0xPVC+HxS/JPzpNjwGKX6TOAqEuzoYZojDiJIDNjwYIusBwvXCR97jlZ/6078w1TXR+gR2pDQ3HyeSXnN4/JiBhdXgL4K70Bnnu0SEVla5rvlYsOo0pCxZW7Eqou47NRQLWzbPYJ7dLS3tsEYTdsx7GzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9Y9YTY4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9Y9YTY4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d9e31e66eeso9787237b3.1
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 23:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725516751; x=1726121551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8FxsTOqdqzOkyw6TDf9xiFqZbYhyqbcaHGo9ObkAUmg=;
        b=Q9Y9YTY4KCQH6/W4Qgpfv2zqvb8i+7OPL+fkJ8X2wZbXNZVCZy46Abjce+L2EC+FBF
         BJ4R6gNlVTXN+FFqNXpJvkG0M9K/ekQeKPUzn9qsOgBv84Hxyrngcj5Lc+O952Iqtm3O
         HN0zkJoet8VSP2/fQUUMHeknI8yn/0o8KvyDof23chiE/9GDA3o9Jad2niQg07FPCInq
         xH5kZ1g9pRSPsEzcGDLSmJOkEzGi2EIO/Kpp8Hi+8hTAOK0e0FMIkHCEPf9Lkt+rI3q4
         09fdyxMFoMuwhfWgYnMKSNWHwV1LblvRk6RVE9SWrR6J8pNI6qkSPi3KKzYQN3F1wDbF
         c40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725516751; x=1726121551;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FxsTOqdqzOkyw6TDf9xiFqZbYhyqbcaHGo9ObkAUmg=;
        b=ZzVrPiR5ih0cKTr3++0sma458Mhvkp7Fr5vCuVOsrp/LTw0Dxh5mtD6odtdW6OwB8A
         evSLm2a6zNzGTZVdwGz1pMz2fQTrkN4EXYoiIG5hIjZbDa1s2IfbPcuvnSW1mQ8ja0z7
         38EJ5Lrqr7yqy+zV35EMVTtVCqv/fMo+bkHI5mGKEKn2ucGGs0ABJr1+eWlK9qa9amVx
         VTZMiYLFOS/nBpQ7AiZnN8uS8X2+YOGbTIUwMNehnJjaSK6kx0ro/k6jJonG//AocvPM
         n57oZneeWYTmysipusd05nK8BY/nuBdWFBdywAhsV7xsfzkuYX/p/pCLTs/Q7FdTuTzE
         s5eA==
X-Forwarded-Encrypted: i=1; AJvYcCUd9Qgsak8Tx9PYVGysaT9aLZcbxV22JvyFC3HllrXKbGCXi8E56HWUaOJJfihnewn4Xn9nxB3jcakW3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXFGSN3tSJZMsEiBOygHJPMxrXksEFYHDGMsPLzQ3hDZ46+ez
	OqxW8Io6qXfr2C6wx0BEH/FL9wInIkm9mLdR+k8tlGRApV0lZkcQlxthOac1H/OAlsT03VqftyC
	f1+JgwlcwWw==
X-Google-Smtp-Source: AGHT+IFb1uyLverYDvkTYTYyFuU6LY97S1fxJcQ5+perARjw81iOZxVvfKHhENGCOXBybmboZGZK6CqTqt35rg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ae56:0:b0:e05:6532:166 with SMTP id
 3f1490d57ef6-e1a79faf683mr114011276.1.1725516751120; Wed, 04 Sep 2024
 23:12:31 -0700 (PDT)
Date: Thu,  5 Sep 2024 14:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905061214.3954271-1-davidgow@google.com>
Subject: [RFC PATCH] rust: block: Use 32-bit atomics
From: David Gow <davidgow@google.com>
To: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: David Gow <davidgow@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Not all architectures have core::sync::atomic::AtomicU64 available. In
particular, 32-bit x86 doesn't support it. AtomicU32 is available
everywhere, so use that instead.

Hopefully we can add AtomicU64 to Rust-for-Linux more broadly, so this
won't be an issue, but it's not supported in core from upstream Rust:
https://doc.rust-lang.org/std/sync/atomic/#portability

This can be tested on 32-bit x86 UML via:
./tools/testing/kunit/kunit.py run --make_options LLVM=1 --kconfig_add CONFIG_RUST=y --kconfig_add CONFIG_64BIT=n --kconfig_add CONFIG_FORTIFY_SOURCE=n

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Signed-off-by: David Gow <davidgow@google.com>
---

Hi all,

I encountered this build error with Rust/UML since the kernel::block::mq
stuff landed. I'm not 100% sure just swapping AtomicU64 with AtomicU32
is correct -- please correct me if not -- but this does at least get the
Rust/UML/x86-32 builds here compiling and running again.

(And gives me more encouragement to go to the Rust atomics talk at
Plumbers.)

Cheers,
-- David

---
 rust/kernel/block/mq/operations.rs |  4 ++--
 rust/kernel/block/mq/request.rs    | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 9ba7fdfeb4b2..c31c36af6bc4 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -11,7 +11,7 @@
     error::{from_result, Result},
     types::ARef,
 };
-use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+use core::{marker::PhantomData, sync::atomic::AtomicU32, sync::atomic::Ordering};
 
 /// Implement this trait to interface blk-mq as block devices.
 ///
@@ -186,7 +186,7 @@ impl<T: Operations> OperationsVTable<T> {
 
             // SAFETY: The refcount field is allocated but not initialized, so
             // it is valid for writes.
-            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU32::new(0)) };
 
             Ok(0)
         })
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4..418256dcd45b 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -13,7 +13,7 @@
 use core::{
     marker::PhantomData,
     ptr::{addr_of_mut, NonNull},
-    sync::atomic::{AtomicU64, Ordering},
+    sync::atomic::{AtomicU32, Ordering},
 };
 
 /// A wrapper around a blk-mq `struct request`. This represents an IO request.
@@ -159,13 +159,13 @@ pub(crate) struct RequestDataWrapper {
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no ARef references to it.
     /// - 2+: There are `ARef` references to the request.
-    refcount: AtomicU64,
+    refcount: AtomicU32,
 }
 
 impl RequestDataWrapper {
     /// Return a reference to the refcount of the request that is embedding
     /// `self`.
-    pub(crate) fn refcount(&self) -> &AtomicU64 {
+    pub(crate) fn refcount(&self) -> &AtomicU32 {
         &self.refcount
     }
 
@@ -175,7 +175,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     /// # Safety
     ///
     /// - `this` must point to a live allocation of at least the size of `Self`.
-    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU32 {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
         unsafe { addr_of_mut!((*this).refcount) }
@@ -193,7 +193,7 @@ unsafe impl<T: Operations> Sync for Request<T> {}
 
 /// Store the result of `op(target.load())` in target, returning new value of
 /// target.
-fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
+fn atomic_relaxed_op_return(target: &AtomicU32, op: impl Fn(u32) -> u32) -> u32 {
     let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
 
     // SAFETY: Because the operation passed to `fetch_update` above always
@@ -205,7 +205,7 @@ fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64
 
 /// Store the result of `op(target.load)` in `target` if `target.load() !=
 /// pred`, returning true if the target was updated.
-fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
+fn atomic_relaxed_op_unless(target: &AtomicU32, op: impl Fn(u32) -> u32, pred: u32) -> bool {
     target
         .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
             if x == pred {
-- 
2.46.0.469.g59c65b2a67-goog

