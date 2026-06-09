Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1D4D2EFC;
	Tue,  9 Jun 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032303; cv=none; b=SCNbhiX8CQFKgl7m0k/APb7SHtMcCdHwXKoU5vU2wM4cLDR/XpPLPcoMT/5fK88CfBLNJObELbe6gSSV7etO5uvOaSN/gjgc2LnRmNLNJESKJmWpmdmcqgc2OzFZEmEHjHy6XTD/eT8d8j/Qmfbo8X4FBJf9UAIiDN654drtPSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032303; c=relaxed/simple;
	bh=Pgrl0umFQHfxEgGBhL3ORYr61hxvp3mCX9/WUL8WuTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d655Ad+eVBiYB2htH1rW8+OJURg0r2EEUl1mBxVkdI9Z1Z66G8Cta5Ia/Y9Yu66rujT6ig6u+EmUYMvD4ZAtB7LH4OONqGB/Mck4eCanCsFcRWoHHGfuhfbKRC9belWIsbdXfG95aCkFeX4iml6tj4tiKg9X3G4VDhM+QLteDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWscA1Ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWscA1Ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CBD1F00893;
	Tue,  9 Jun 2026 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032302;
	bh=cTMq75LVYGONeqD6aceZFLDHKDcK1Q7SK0j/d7sqNo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iWscA1RuPcNWUzsAri0x7rO9uKR2nATOTwgMdkliYE9DcAtE72IIAJLsDeIhftwio
	 JnhJp/MlW7V+wTCacbdY57b98GVq2ddUnxCrnWEi4KctzJ8ENaaUVrc/37X8NP11m9
	 HNQkWQQKwF0mPjOexVkyNhIoAe7rDLeWi1OtUuyQl8WJjJK8Kxr2sherQ1/SYBfFyP
	 bJXYW0Gjq74pBTnh2Abmk2nUXM/RdeLEB4O7pjXNqFOaUeT7Aw2QX2QxDyVtS8PpnO
	 pK3O4Y6jwzL068fD3Foi0NDofU3aGNR9iFoLtxVX6WyvshYjH20iefhjvY914dZYyF
	 QhquVR/aCZuDg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:16 +0200
Subject: [PATCH v2 37/83] block: rust: add a back reference feature to
 `GenDisk`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-37-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5601; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Pgrl0umFQHfxEgGBhL3ORYr61hxvp3mCX9/WUL8WuTA=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTWPDkbTCiF4AD045KZczuURzT6Ht4dFueuB
 WWPpi9oI4yJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk1gAKCRD6UCkIqsW9
 0NUHEACfPdxlqQtedQBoWcauh+uupMtyzebSZu/9dyy/KhNqkuWRHfrh7tskkROLw4OetVFM+85
 FIRjRx5EzlxXdiS8XjDCiRqCHDO5mXxwUDG6mUJjAKEvbT/xPdM/ZFr3EHO+1VWOUkdt8tb2tWE
 1CCV2dTvwd2RqPLZxVJOMSn869PyQJGNBXNUAcTwUwFqGNccu/faYuwjpvNWzUQXT7rHdtL4ugI
 RplKUy3PWkgIEukdwtUd1YvfsQAEYpRRKLyvJqKYtM5PPwJNzRXRbXyEsd+65znGhMnYJgf66S8
 6QxRdnbSQOHoRXKA/XsvwXD5nNsJEbpceZurQyjKafth8w3D2ejKhohwfD4cRmLWnd6taUNgxRX
 /95y3Fy4RJ8pwbnRxq5pAX6DRHbIbzn6gxydhJJM97TsiYAEx7BTgx1v10ktqkdmrlo5xXyLsOH
 LMpvBp7w0Bdk3/Y+jqn1Vlq/CP01y5SkFejkmA7C9D6ejGbcZbYvABTEh8b/0lATzLaE/L7A3JJ
 WEw4YURvDp5LZ6M505NRA9l0DiYOxKu0OJm+HNwZxqjQ8dwpFjODFVMR/waJG+Wc1fQQzQ473NP
 nQgH0XyDErWgWKxHViVDUbu7i7XIRAyke4TIAbBl997x5fB8ErWdzZ0G5ozTPgleIcgnrdO7ZYF
 YDjGmpDibn2T6Sw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

During certain block layer callbacks, drivers may need access to the Rust
`GenDisk` representing a disk the driver is managing. In some situations it
is only possible to obtain a pointer to the C `struct gendisk`. With the
current setup, it is not possible to obtain the `GenDisk` for this C
`gendisk`. To circumvent this, we add a back reference feature to the
`GenDisk` so that we can store a reference counted reference to the
`GenDisk` somewhere easily accessible.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs  |  2 +-
 drivers/block/rnull/rnull.rs     |  4 +--
 rust/kernel/block/mq/gen_disk.rs | 65 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 504bb477c2d0..4df0b748596a 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -198,7 +198,7 @@ struct DeviceConfigInner {
     capacity_mib: u64,
     irq_mode: IRQMode,
     completion_time: time::Delta,
-    disk: Option<GenDisk<NullBlkDevice>>,
+    disk: Option<Arc<GenDisk<NullBlkDevice>>>,
     memory_backed: bool,
     submit_queues: u32,
     home_node: i32,
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 877683dba0ac..fd9b770965a6 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -134,7 +134,7 @@ struct NullBlkModule {
     #[pin]
     configfs_subsystem: kernel::configfs::Subsystem<configfs::Config>,
     #[pin]
-    param_disks: Mutex<KVec<GenDisk<NullBlkDevice>>>,
+    param_disks: Mutex<KVec<Arc<GenDisk<NullBlkDevice>>>>,
 }
 
 impl kernel::InPlaceModule for NullBlkModule {
@@ -216,7 +216,7 @@ struct NullBlkDevice {
 }
 
 impl NullBlkDevice {
-    fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
+    fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
         let NullBlkOptions {
             name,
             block_size,
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 94af85fe1716..f51bccb0d2ef 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -21,14 +21,19 @@
         Write, //
     },
     prelude::*,
+    revocable::Revocable,
     static_lock_class,
     str::NullTerminatedFormatter,
-    sync::Arc,
+    sync::{
+        Arc,
+        UniqueArc, //
+    },
     types::{
         ForeignOwnable,
         ScopeGuard, //
     },
 };
+use core::ptr::NonNull;
 
 /// A builder for [`GenDisk`].
 ///
@@ -125,7 +130,7 @@ pub fn build<T: Operations>(
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
         queue_data: T::QueueData,
-    ) -> Result<GenDisk<T>> {
+    ) -> Result<Arc<GenDisk<T>>> {
         let data = queue_data.into_foreign();
         let recover_data = ScopeGuard::new(|| {
             // SAFETY: T::QueueData was created by the call to `into_foreign()` above
@@ -204,10 +209,28 @@ pub fn build<T: Operations>(
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
         // INVARIANT: `gendisk.queue.queue_data` is set to `data` in the call to
         // `__blk_mq_alloc_disk` above.
-        Ok(GenDisk {
-            _tagset: tagset,
-            gendisk,
-        })
+        let mut disk = UniqueArc::new(
+            GenDisk {
+                _tagset: tagset,
+                gendisk,
+                backref: Arc::pin_init(
+                    // INVARIANT: We break `GenDiskRef` invariant here, but we restore it below.
+                    Revocable::new(GenDiskRef(NonNull::dangling())),
+                    GFP_KERNEL,
+                )?,
+            },
+            GFP_KERNEL,
+        )?;
+
+        disk.backref = Arc::pin_init(
+            // INVARIANT: The `GenDisk` in `disk` is a valid for use as a reference.
+            Revocable::new(GenDiskRef(
+                NonNull::new(UniqueArc::as_ptr(&disk).cast_mut()).expect("Should not be null"),
+            )),
+            GFP_KERNEL,
+        )?;
+
+        Ok(disk.into())
     }
 }
 
@@ -222,6 +245,14 @@ pub fn build<T: Operations>(
 pub struct GenDisk<T: Operations> {
     _tagset: Arc<TagSet<T>>,
     gendisk: *mut bindings::gendisk,
+    backref: Arc<Revocable<GenDiskRef<T>>>,
+}
+
+impl<T: Operations> GenDisk<T> {
+    /// Get a `GenDiskRef` referencing this `GenDisk`.
+    pub fn get_ref(&self) -> Arc<Revocable<GenDiskRef<T>>> {
+        self.backref.clone()
+    }
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
@@ -264,3 +295,25 @@ fn drop(&mut self) {
         drop(unsafe { T::QueueData::from_foreign(queue_data) });
     }
 }
+
+/// A reference to a `GenDisk`.
+///
+/// # Invariants
+///
+/// `self.0` is valid for use as a reference.
+pub struct GenDiskRef<T: Operations>(NonNull<GenDisk<T>>);
+
+// SAFETY: It is safe to transfer ownership of `GenDiskRef` across thread boundaries.
+unsafe impl<T: Operations> Send for GenDiskRef<T> {}
+
+// SAFETY: It is safe to share references to `GenDiskRef` across thread boundaries.
+unsafe impl<T: Operations> Sync for GenDiskRef<T> {}
+
+impl<T: Operations> core::ops::Deref for GenDiskRef<T> {
+    type Target = GenDisk<T>;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By type invariant, `self.0` is valid for use as a reference.
+        unsafe { self.0.as_ref() }
+    }
+}

-- 
2.51.2


