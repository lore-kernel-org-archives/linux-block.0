Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFB3101BB;
	Sun, 15 Feb 2026 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199131; cv=none; b=SDcHfuehN2FRLOfdz9fsPpK7qjABYBvg9fGdgn9iHKxN982wYmD2BqnccOlWBjSLZHufsoQHlt11geP8ZNI4wZDb5RQ9FL9LnqZhi7k672Jcl9J0lJ0TXUnQJaix7GeOyvYC9SWUyalzeB8Xl5RtTAcgW2Bs+rUpYFREUu/GJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199131; c=relaxed/simple;
	bh=qLgrvGBsm8luC4Me0/E3xSd0EWUQhPqRJxd9FYG64Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o+D/q+BTRkWf/CmkbbjchLwB+I/KAGZahFQR3zTZL2RlBCJ5PScyPEtxxqtMlVruC7szX4mZK6BPb+00bYa+Im662++0zzuj3PrvCOo9ED+44zjf2isPSdciPtU4CFyTMkavxe5O8hyJDfgK3Br6xRUv11qeYP2WOZ0wJ5kdzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgKHcPV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgKHcPV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F4DC4CEF7;
	Sun, 15 Feb 2026 23:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199130;
	bh=qLgrvGBsm8luC4Me0/E3xSd0EWUQhPqRJxd9FYG64Es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XgKHcPV4QAuD0r244AZm13XfsgYTI5i0W28mgVl156ZV3FmyeA34v8/B/HdF2AZRP
	 fn12kMgKt8aygP8C+QGVOFi38wllCmJDHUBL1MoetTkeCn44uBLjoJ8nmSk5cyJew2
	 /NDCDb00AoszqOtPn0BKJZooSay2G06m2u5rSCxDszZQtbLRSWH3+cO3leL9LbMY+R
	 hjgbnEmh1JDIcAMsXT7OEzPLoJy9/fW24lEIREoIbTeN5AH37e978wVqyzQeL4ww1s
	 hRcnFKCi9WCY/gcLEWQGU+Vsspgn9mgoZNWC0dbXdSqHk0ouLw9W4/TqEjsuR1CZUA
	 fE2sEwvljvdpg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:20 +0100
Subject: [PATCH 33/79] block: rust: add a back reference feature to
 `GenDisk`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-33-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5572; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=qLgrvGBsm8luC4Me0/E3xSd0EWUQhPqRJxd9FYG64Es=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg5BJGIL8taDlyK7FXYOiW5WtQkD0IpNT66B
 xLE+gKs5UWJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYOQAKCRDhuBo+eShj
 d3LWD/wJEsfnfKofG0SwluYFnyTS45Ttty3Rtjxsq4+AtupouLO2AgmdqLPg3JbLfCwFLSujmDo
 IOchozOWKm8dC8h3VsaXsc0SABrxNZq/tnBzy5RexaTQSkIHM5bJ9ifkIFYHZWcHJIGojq9wQm4
 LB47jsWD2AUovrxJQKow476RNvnDMBnkljJ2Rg1vB9+LApUxwQLEISWlLXXyy3bB+eqXridTC1q
 Hgps3tI+E0p/DGd4jFScyPxRuh8y5POxTm7oDuLgo3o8JwTSwuPcxFJ6eR6Kuxn882TEi+PHki8
 fxs7A2SUBAIDTTRkLwpxROC7vwFQ+3ESHbbQLtvRSrtTuDmzaew4BaSAPapahnyGgdAV2T7Sfmj
 V5/HP7BcVlLRnGiqlJpl9pgPNUb0ggHHDDWKnHZk9pIDhuqWT4Hq0axj/LuPK97KerOVbLC4vDP
 hJGSAkUCIOSjr8vvU6CtJcqmldmX3SapQ6iQbD3DGA5DSKdRevhY6phf8SL/3v+oKL+O1pSaw9q
 +0QQzn/DD7/JFrnFPH/Vf7XwSP1ZGshRCh6Js7FriyGvqr8T7Rc/FcKTpNox2xPCuDyjP3jz57h
 jdT3zxo/L91N9XT/8u3v7cH+Kmz44M1dlBfxhVuhkyMFUuKB0bAnZGfCVrGqnLlZx2PwKZF4Als
 eC1laFvJ1AC8gmg==
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
 rust/kernel/block/mq/gen_disk.rs | 62 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index d679f12ee6749..e365eb06be6de 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -189,7 +189,7 @@ struct DeviceConfigInner {
     capacity_mib: u64,
     irq_mode: IRQMode,
     completion_time: time::Delta,
-    disk: Option<GenDisk<NullBlkDevice>>,
+    disk: Option<Arc<GenDisk<NullBlkDevice>>>,
     memory_backed: bool,
     submit_queues: u32,
     home_node: i32,
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index cca497aef40df..aa59ede72e495 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -136,7 +136,7 @@ struct NullBlkModule {
     #[pin]
     configfs_subsystem: kernel::configfs::Subsystem<configfs::Config>,
     #[pin]
-    param_disks: Mutex<KVec<GenDisk<NullBlkDevice>>>,
+    param_disks: Mutex<KVec<Arc<GenDisk<NullBlkDevice>>>>,
 }
 
 impl kernel::InPlaceModule for NullBlkModule {
@@ -218,7 +218,7 @@ struct NullBlkDevice {
 }
 
 impl NullBlkDevice {
-    fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
+    fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
         let NullBlkOptions {
             name,
             block_size,
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 72bbf3cadfe82..8d39bb70725b0 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -11,11 +11,13 @@
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
     prelude::*,
+    revocable::Revocable,
     static_lock_class,
     str::NullTerminatedFormatter,
-    sync::Arc,
+    sync::{Arc, UniqueArc},
     types::{ForeignOwnable, ScopeGuard},
 };
+use core::ptr::NonNull;
 
 /// A builder for [`GenDisk`].
 ///
@@ -112,7 +114,7 @@ pub fn build<T: Operations>(
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
         queue_data: T::QueueData,
-    ) -> Result<GenDisk<T>> {
+    ) -> Result<Arc<GenDisk<T>>> {
         let data = queue_data.into_foreign();
         let recover_data = ScopeGuard::new(|| {
             // SAFETY: T::QueueData was created by the call to `into_foreign()` above
@@ -194,10 +196,28 @@ pub fn build<T: Operations>(
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
+                NonNull::new(disk.as_ptr().cast_mut()).expect("Should not be null"),
+            )),
+            GFP_KERNEL,
+        )?;
+
+        Ok(disk.into())
     }
 }
 
@@ -212,6 +232,14 @@ pub fn build<T: Operations>(
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
@@ -241,3 +269,25 @@ fn drop(&mut self) {
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


