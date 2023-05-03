Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB78C77B7F
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 09:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjECJIU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjECJHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 05:07:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC144ED6
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 02:07:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-304935cc79bso4848708f8f.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104848; x=1685696848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHrN32lBaAC78cOIMsVaenJPrzKJjknoApgieLS2EVM=;
        b=oA2PVI7kXpD5OIbFur9s7uaOC1Nh/L72pwK/S62AuuQQaQp4WS6rCh6e1Qiu311wQM
         i+tmijmYwryRpAB+BQXDD6we65meeLaoR7RiUgcCodh6T1WdeG3rXHU3aZ7RyUOXMl3G
         TpBB2cGgmPdRWJt4X4inUYYm8i6bJcsAq9WphlZqTjKnuQu0J21VXA/d2UN7hiTp+25Y
         oBFKxT3L7/ViA4VeKCx5UI0YHrZqbgbOXKdIaytdI7oCcrlH1MOqviwi9jouVUUIxAd6
         bxkaj0/ygyyrL74KdQ1C3LsOjbhlUrt5uX0Z8rNBRK89XnyS3Fh7uD9pLe/0c96ZDAgH
         tviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104848; x=1685696848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHrN32lBaAC78cOIMsVaenJPrzKJjknoApgieLS2EVM=;
        b=ey4lUVheJM5ZsT3ZWK5bdFFaVHdwAJrR4BpOGneJur0tl/FedMfuaM5dmUYwb1iV7J
         qdwr7yg+5bw3KhAdNzIdUqNpqPdZsgTwvPGCpcbyVGCdQuNTrzfe/5WR4d/VFIpIywGz
         wLS6qxKOTgcdRXdGKbrxlHdb0NStZLRGEYat9Mj9IUerhs3zUS34I/XxGPC+LZzrvoYw
         rzIMKxSoEQBZsx2DypnnU21clozR5ZiNHqHsDAfH7qjYkdifh5hY+aQj+MwpepHae3B+
         yKvx5AEW1tYwRM9/n3BdNGchS8H1qxXuSBozblNO6Kk9Alyicv7OEh/uOc+JWiFEtVWe
         i6+Q==
X-Gm-Message-State: AC+VfDyxgWEO8cVePOT9JuX8KpR0+2TlAPIJ8jEdHFbUwj620B2Uq3yO
        qhzH06y9s2e+AfdUb7VE8RZggw==
X-Google-Smtp-Source: ACHHUZ7P6M/jU8n50FGEjgTSgEYAcUdKtRM+n+M8XLe9UPXqN9jUX6WcfyARZKzQxoFqI3CdjYYuxQ==
X-Received: by 2002:a05:6000:11c5:b0:2fb:600e:55bd with SMTP id i5-20020a05600011c500b002fb600e55bdmr15479168wrx.39.1683104848425;
        Wed, 03 May 2023 02:07:28 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id e22-20020a5d5956000000b003012030a0c6sm33106775wri.18.2023.05.03.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:28 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 11/11] rust: inline a number of short functions
Date:   Wed,  3 May 2023 11:07:08 +0200
Message-Id: <20230503090708.2524310-12-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

The rust compiler will not inline functions that live in vmlinux when
building modules. Add inline directives to these short functions to ensure that
they are inlined when building modules.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/sync/lock.rs          | 2 ++
 rust/kernel/sync/lock/mutex.rs    | 2 ++
 rust/kernel/sync/lock/spinlock.rs | 2 ++
 rust/kernel/types.rs              | 6 ++++++
 4 files changed, 12 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index bb21af8a8377..4bfc2f5d9841 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -101,6 +101,7 @@ impl<T: ?Sized, B: IrqSaveBackend> Lock<T, B> {
     /// Before acquiring the lock, it disables interrupts. When the guard is dropped, the interrupt
     /// state (either enabled or disabled) is restored to its state before
     /// [`lock_irqsave`](Self::lock_irqsave) was called.
+    #[inline(always)]
     pub fn lock_irqsave(&self) -> Guard<'_, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
@@ -210,6 +211,7 @@ impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
 }
 
 impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
+    #[inline(always)]
     fn drop(&mut self) {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 923472f04af4..5e8096811b98 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -104,12 +104,14 @@ unsafe impl super::Backend for MutexBackend {
         unsafe { bindings::__mutex_init(ptr, name, key) }
     }
 
+    #[inline(always)]
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
         unsafe { bindings::mutex_lock(ptr) };
     }
 
+    #[inline(always)]
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
         // caller is the owner of the mutex.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 50b8775bb49d..23a973dab85c 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -122,6 +122,7 @@ unsafe impl super::Backend for SpinLockBackend {
         None
     }
 
+    #[inline(always)]
     unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState) {
         match guard_state {
             // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that
@@ -141,6 +142,7 @@ unsafe impl super::Backend for SpinLockBackend {
 // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
 // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
 unsafe impl super::IrqSaveBackend for SpinLockBackend {
+    #[inline(always)]
     unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 98e71e96a7fc..7be1f64bbde9 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -70,10 +70,12 @@ pub trait ForeignOwnable: Sized {
 impl<T: 'static> ForeignOwnable for Box<T> {
     type Borrowed<'a> = &'a T;
 
+    #[inline(always)]
     fn into_foreign(self) -> *const core::ffi::c_void {
         Box::into_raw(self) as _
     }
 
+    #[inline(always)]
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
@@ -82,6 +84,7 @@ impl<T: 'static> ForeignOwnable for Box<T> {
         unsafe { &*ptr.cast() }
     }
 
+    #[inline(always)]
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
@@ -92,12 +95,15 @@ impl<T: 'static> ForeignOwnable for Box<T> {
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
+    #[inline(always)]
     fn into_foreign(self) -> *const core::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
+    #[inline(always)]
     unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
 
+    #[inline(always)]
     unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 }
 
-- 
2.40.0

