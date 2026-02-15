Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E092BEC4E;
	Sun, 15 Feb 2026 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198860; cv=none; b=eIXGF3NrduxGVJXFfnAfEyLJdAzzSzpEuhlM6dvlv5OubOW5RrGeNjLKyltuffMhTNJuQo66AX9Rd8QayKv4DhdLTdGJnd9w2U+rAcy/ZmUb6u9brAYihEwSXmYnGUNPcSVC0SroNDkS+OEUK3t8BwGPILG7u01WFOaCDRs1WQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198860; c=relaxed/simple;
	bh=Y3BHYVknJp7yqDHdJgoOQjOdwC77vJUS39fgNLkKcdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+6sulpIfpzLCShKt6CCHt6gRn4HZ8AdOd9bZDCPdC7b9vqTZKigyKu1UyWQ0VJ95d2qbr9xmjQG7iJKJ/Bn1fQ7kAxYFeTj85/RJ+CSq8CDG/VAFx5H7CIv8OB04jKwErLV4+gWJ5+dZezeStzEkW3ulTfH7TJz8zNdh4BDFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms5DzXKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms5DzXKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AF0C19425;
	Sun, 15 Feb 2026 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198859;
	bh=Y3BHYVknJp7yqDHdJgoOQjOdwC77vJUS39fgNLkKcdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ms5DzXKi/d/xecYPMsETnLIURLmAXjUVHfew9lDkm8mTu2Lx2EIODS2d5EH/1EWtY
	 CYd1KARZAi1lEs7tWFtTZNs1ITONN2icIgMAm8+TGP4/yAZaheSiwFxB/CFQ7kCGYl
	 lgxJaAOI+rbbzhQxdyFDpOqEZUfwPPKsX8zlbk2LucEkV4CsM38G5uE8Z3+eQjEprh
	 XsNNvEQF+6I0CJgfPCbZmodqW+agLhgzvc5xqJHHLwHzHtl3MIvBrnkhK1QpS2ikss
	 asFR6D7aJWJ9zEs5H2hdfxwDZqw+GCeB/XnOpmn4gQbN82a7SFCGUznyoI4IlS5Kxl
	 Ha34fEt/jaiyw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:34 +0100
Subject: [PATCH 47/79] block: rust: add zoned block device support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-47-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10869;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=Y3BHYVknJp7yqDHdJgoOQjOdwC77vJUS39fgNLkKcdI=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhGUDW7prSJo27C0mxbdYxJEQwAnNTB7yUsd
 cx/5l1zFDaJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYRgAKCRDhuBo+eShj
 d3inEACdaB0IAjno84bOvzt+dZs5T80xFhT129GRa5oGVUzDFGz9NdfNjOOYu/Oo3S7TKbDNiWj
 HM0Z8qIGLxRDlEeSog00YB1ZNYKUBOwq6pNuGgKQPzbUPNUiO13hNHu/fiW9OyQg/BuGW8A8JxT
 2/OAhCq1zRtu//wFcZjqkS/njgPRxVPfQdWW/sgak/BzFYCVwkAI6Mnx3gsbjUGdlVD+2p98y68
 7cz7Msg8Kmeh0Pq3Hp2LfSQ8aWD9yuMjaRSNCxaOSCccGN3mqgwqlbQLunbKCIk+VyZ8XU/+LwW
 s01zhY0td/ym4UcpW/ye1B83f0+jV1TUvY0FMrGJoEEMRDyvv2xp0LegdDK6J6IYjCsi9Xwcrb8
 vn9FOeYC76EGj0/hzoDr1uBIZTM8N9uCXW2gW7Ew2I3HMITw3WLNksepKsd86UjqwRdYqt6vn5r
 /4J58RevVcYyyYJggoNehZ1MZHBBGseHvNabSX/eMFEs2EQ2Mlly5pZl0/F/hq0nPcuHI1US9hi
 i/PisBaA1BGfN8fqq5cPtaWqBMpdkaSP48c8yz5C4g1xkSGWIPn3ARNLmpX/6Nkx3z/Ne3OUvVc
 G7KFZxA5vsQa4GgxkhS46iYTpBiqaFbX83ZMgB7ndF7t4XFPXbgUg7EeNWcy32ck7fjw9Qt6xet
 oijO/nTOZgX5Ceg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for zoned block devices to the Rust block layer bindings.
This includes the `report_zones` callback in `Operations` and methods
in `GenDiskBuilder` to configure zoned device parameters.

Drivers can mark a disk as zoned and configure the zone size and
maximum zone append size. The `report_zones` callback is invoked by
the block layer to query zone information.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/bindings/bindings_helper.h    |  1 +
 rust/kernel/block/mq/gen_disk.rs   | 96 +++++++++++++++++++++++++++++++++-----
 rust/kernel/block/mq/operations.rs | 60 ++++++++++++++++++++++--
 3 files changed, 142 insertions(+), 15 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 76b58c3fd1ff1..05133a78ecf95 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -133,6 +133,7 @@ const blk_status_t RUST_CONST_HELPER_BLK_STS_ZONE_ACTIVE_RESOURCE = BLK_STS_ZONE
 const blk_status_t RUST_CONST_HELPER_BLK_STS_OFFLINE = BLK_STS_OFFLINE;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_DURATION_LIMIT = BLK_STS_DURATION_LIMIT;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_INVAL = BLK_STS_INVAL;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ZONED = BLK_FEAT_ZONED;
 const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET = FOP_UNSIGNED_OFFSET;
 
 const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index eb980079530bd..a6f113ea4bea4 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,7 +7,7 @@
 
 use crate::{
     bindings,
-    block::mq::{Operations, RequestQueue, TagSet},
+    block::mq::{operations::OperationsVTable, Operations, RequestQueue, TagSet},
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
     prelude::*,
@@ -28,6 +28,12 @@ pub struct GenDiskBuilder<T> {
     physical_block_size: u32,
     capacity_sectors: u64,
     max_hw_discard_sectors: u32,
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    zoned: bool,
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    zone_size_sectors: u32,
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    zone_append_max_sectors: u32,
     _p: PhantomData<T>,
 }
 
@@ -39,6 +45,12 @@ fn default() -> Self {
             physical_block_size: bindings::PAGE_SIZE as u32,
             capacity_sectors: 0,
             max_hw_discard_sectors: 0,
+            #[cfg(CONFIG_BLK_DEV_ZONED)]
+            zoned: false,
+            #[cfg(CONFIG_BLK_DEV_ZONED)]
+            zone_size_sectors: 0,
+            #[cfg(CONFIG_BLK_DEV_ZONED)]
+            zone_append_max_sectors: 0,
             _p: PhantomData,
         }
     }
@@ -110,6 +122,27 @@ pub fn max_hw_discard_sectors(mut self, max_hw_discard_sectors: u32) -> Self {
         self
     }
 
+    /// Mark this device as a zoned block device.
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    pub fn zoned(mut self, enable: bool) -> Self {
+        self.zoned = enable;
+        self
+    }
+
+    /// Set the zone size of this block device.
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    pub fn zone_size(mut self, sectors: u32) -> Self {
+        self.zone_size_sectors = sectors;
+        self
+    }
+
+    /// Set the max zone append size for this block device.
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    pub fn zone_append_max(mut self, sectors: u32) -> Self {
+        self.zone_append_max_sectors = sectors;
+        self
+    }
+
     /// Build a new `GenDisk` and add it to the VFS.
     pub fn build(
         self,
@@ -130,7 +163,18 @@ pub fn build(
         lim.physical_block_size = self.physical_block_size;
         lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
         if self.rotational {
-            lim.features = bindings::BLK_FEAT_ROTATIONAL;
+            lim.features |= bindings::BLK_FEAT_ROTATIONAL;
+        }
+
+        #[cfg(CONFIG_BLK_DEV_ZONED)]
+        if self.zoned {
+            if !T::HAS_REPORT_ZONES {
+                return Err(error::code::EINVAL);
+            }
+
+            lim.features |= bindings::BLK_FEAT_ZONED;
+            lim.chunk_sectors = self.zone_size_sectors;
+            lim.max_hw_zone_append_sectors = self.zone_append_max_sectors;
         }
 
         // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
@@ -160,14 +204,6 @@ pub fn build(
         // operation, so we will not race.
         unsafe { bindings::set_capacity(gendisk, self.capacity_sectors) };
 
-        crate::error::to_result(
-            // SAFETY: `gendisk` points to a valid and initialized instance of
-            // `struct gendisk`.
-            unsafe {
-                bindings::device_add_disk(core::ptr::null_mut(), gendisk, core::ptr::null_mut())
-            },
-        )?;
-
         recover_data.dismiss();
 
         // INVARIANT: `gendisk` was initialized above.
@@ -195,7 +231,27 @@ pub fn build(
             GFP_KERNEL,
         )?;
 
-        Ok(disk.into())
+        let disk: Arc<_> = disk.into();
+
+        // SAFETY: `disk.gendisk` is valid for write as we initialized it above. We have exclusive
+        // access.
+        unsafe { (*disk.gendisk).private_data = Arc::as_ptr(&disk).cast_mut().cast() };
+
+        #[cfg(CONFIG_BLK_DEV_ZONED)]
+        if self.zoned {
+            // SAFETY: `disk.gendisk` is valid as we initialized it above. We have exclusive access.
+            unsafe { bindings::blk_revalidate_disk_zones(gendisk) };
+        }
+
+        crate::error::to_result(
+            // SAFETY: `gendisk` points to a valid and initialized instance of
+            // `struct gendisk`.
+            unsafe {
+                bindings::device_add_disk(core::ptr::null_mut(), gendisk, core::ptr::null_mut())
+            },
+        )?;
+
+        Ok(disk)
     }
 
     const VTABLE: bindings::block_device_operations = bindings::block_device_operations {
@@ -209,7 +265,11 @@ pub fn build(
         getgeo: None,
         set_read_only: None,
         swap_slot_free_notify: None,
-        report_zones: None,
+        report_zones: if T::HAS_REPORT_ZONES {
+            Some(OperationsVTable::<T>::report_zones_callback)
+        } else {
+            None
+        },
         devnode: None,
         alternative_gpt_sector: None,
         get_unique_id: None,
@@ -295,6 +355,18 @@ fn drop(&mut self) {
 /// `self.0` is valid for use as a reference.
 pub struct GenDiskRef<T: Operations>(NonNull<GenDisk<T>>);
 
+impl<T: Operations> GenDiskRef<T> {
+    /// Create a `GenDiskRef` from a pointer to a `GenDisk`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be valid for use as a `GenDisk` reference for the lifetime of the returned
+    /// `GenDiskRef`.
+    pub(crate) unsafe fn from_ptr(ptr: NonNull<GenDisk<T>>) -> GenDiskRef<T> {
+        Self(ptr)
+    }
+}
+
 // SAFETY: It is safe to transfer ownership of `GenDiskRef` across thread boundaries.
 unsafe impl<T: Operations> Send for GenDiskRef<T> {}
 
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 17468a39af60f..3f84ebadec86b 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -8,14 +8,14 @@
     bindings,
     block::{
         error::BlkResult,
-        mq::{request::RequestDataWrapper, IdleRequest, Request},
+        mq::{gen_disk::GenDiskRef, request::RequestDataWrapper, IdleRequest, Request},
     },
-    error::{from_result, Result},
+    error::{from_result, to_result, Result},
     prelude::*,
     sync::{aref::ARef, atomic::ordering, Refcount},
     types::{ForeignOwnable, Owned},
 };
-use core::marker::PhantomData;
+use core::{marker::PhantomData, ptr::NonNull};
 use pin_init::PinInit;
 
 type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
@@ -87,6 +87,20 @@ fn init_hctx(
     fn poll(_hw_data: ForeignBorrowed<'_, Self::HwData>) -> bool {
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
+
+    /// Called by the kernel to get a zone report from the driver.
+    ///
+    /// The driver must call `callback` once for each zone on `disk` and populate the first argument
+    /// with a zone descriptor and the second argument when the zone index.
+    // TODO: We cannot gate this on CONFIG_BLK_DEV_ZONED due to limitations of the `vtable` macro.
+    fn report_zones(
+        _disk: &GenDiskRef<Self>,
+        _sector: u64,
+        _nr_zones: u32,
+        _callback: impl Fn(&bindings::blk_zone, u32) -> Result,
+    ) -> Result<u32> {
+        Err(ENOTSUPP)
+    }
 }
 
 /// A vtable for blk-mq to interact with a block device driver.
@@ -340,6 +354,46 @@ impl<T: Operations> OperationsVTable<T> {
         unsafe { core::ptr::drop_in_place(pdu) };
     }
 
+    /// This function is a callback hook for the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// - This function may only be called by blk-mq C infrastructure.
+    /// - `disk_ptr` must be a pointer to a gendisk initialized by `GenDisk::build`.
+    pub(crate) unsafe extern "C" fn report_zones_callback(
+        disk_ptr: *mut bindings::gendisk,
+        sector: u64,
+        nr_zones: u32,
+        args: *mut bindings::blk_report_zones_args,
+    ) -> i32 {
+        // SAFETY: As `disk_ptr` is a gendisk initialized by `GenDisk::build`, `private_data` is not
+        // null.
+        let disk_ref_ptr = unsafe { NonNull::new_unchecked((*disk_ptr).private_data.cast()) };
+
+        // SAFETY: `disk_ptr.private_data` is a pointer to the `GenDisk` owner of `disk_ptr` that we
+        // installed when we initialized `disk_ptr`. It is valid for use as a reference for the
+        // duration of this call.
+        let disk = unsafe { GenDiskRef::from_ptr(disk_ref_ptr) };
+
+        from_result(|| {
+            T::report_zones(&disk, sector, nr_zones, |zone, idx| -> Result {
+                to_result(
+                    // SAFETY: `disk_ptr` is valid by function safety requirements.
+                    unsafe {
+                        bindings::disk_report_zone(
+                            disk_ptr,
+                            core::ptr::from_ref(zone).cast_mut(),
+                            idx,
+                            args,
+                        )
+                    },
+                )
+            })
+            .and_then(|v: u32| -> Result<_> { Ok(v.try_into()?) })
+        })
+    }
+
     const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
         queue_rq: Some(Self::queue_rq_callback),
         queue_rqs: None,

-- 
2.51.2


