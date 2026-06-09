Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5C3EB0F2;
	Tue,  9 Jun 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032331; cv=none; b=oCPE8ePgDmp1bSDpRAZDDwUeUrVxg5Pi6iWHB7E1muZaxU94nE0dUBQeuHu9RV8qz7fp7zaKMJfurI0LdtDApeV18nOgvszM1F5sZruuiRg4wErw6NsPWOjJABbd4KjL1oasgTVQkdTSr/h2SG+A04AG3Nw5o3z3m458aTuq9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032331; c=relaxed/simple;
	bh=a+eWU5zLlvyoRr0+a9110st2xDfdKu1tkbHU0hHggYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RD1AXBf+ZQa8tR8Ek3PGkS6wtaSb+2KvqK+eiudKAQ8fSH6LOCvmKxA6Z3uo+q3YMhcADqUpPAGMry3Az/tmo86hYumBLix74cfcfdCyTImOG8wXrCY9NlNl6uQEtKg7B+fDk2jr8yd6DjSi1p09raqXPhDg2ijSh1sTeOIxiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzjF7g8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzjF7g8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C511F00898;
	Tue,  9 Jun 2026 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032329;
	bh=nqc86KcUVxZTdVaOG+SDVXI6QBFEXbnIR9/IB4zof7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fzjF7g8hqCBIQqu0hkw28HiFPgTi6wEP/2SThQdUdkG8bwJ+e2esJGkua58Bpc663
	 eQ0mccMeWcLtwJ7jL4pVOHLXXsn6vcb1OUNRqKFIzDcH2spcjyO1xsZJuF6cts2xQ8
	 KrKKa2oFJPy2LvVoAZaTqp8DSh75OjA70KiXf85Em3EPDyuZV4Zs/ozZLjIAmBRYMl
	 0C7nznhMYSNT4GktfNZNw2+gXY4Wf17jndEkxQ9Y3YX2jdNQczeJ8EPM1y8wUiVn0L
	 ynbpYZuDP4Ix83K5AQy7HzFSi52+FsYssztH7cNPf9qMW4BuGdlsEzz70YdrP4lRCs
	 ye/y/XEvZcxdg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:30 +0200
Subject: [PATCH v2 51/83] block: rust: add zoned block device support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-51-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10741;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=a+eWU5zLlvyoRr0+a9110st2xDfdKu1tkbHU0hHggYA=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTiFZEVhsuDWxvjg8aek7snzhrQ8IDiU8X+K
 3NI4zNl2h6JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk4gAKCRD6UCkIqsW9
 0J14D/409i6f2gq2UFsEg83A5npLQ7XUUl/lMbAv8if9BRE1FRGBbo9zszd4Hb+sq7JUp3ytZE2
 +bRsL3nhWR+BC4X1Jsj/F4bETG/5o66JlOpSXSl8F8dBnLXhkbWqoiyzHMLOLFHV0+gIpQZrj9Q
 tnu41D7jOnya4/4lUw6dPK77WGB/HJcitwAUenDhsl75BBzipcnKpvneAEUsuEVxgkNC5Yr03HO
 5yQ2lsdhbIGsOEbWWIosSwdCIuiKgARwiJfMWIALm3zYp6jXpA5TDQHaat7mxCPOR2U7t059CZY
 sgt8D8sy7onJF//G7N+N7eMRxra0zi0deRrasV1zQMLL9e4zbjLYBI91QDnA0TsDM7O3+dclNcd
 ziUPx5hMNIxNLnP/Sv8tzNJABzk9K8fJ9LaFmXzfhl9EZFOIheSTWDA+lOX1Udft8aexw1pBqvq
 x9RUemeiQfJhV5dqBD1OiX0Vc/t+q4zOXoYhsrBlTvo54OK4tPUt/35T+SdVjdr5iIleeu5YcBH
 ySyUbu+HIHCjmhCWLGVqAE27gnB/RJkjUcwSWVXsNMn64rt3nWNsp7AZ+8pG8rnkC15hyb47+0F
 PZ0qhAj8A0IDv2MmuicLy0lkD+d2XyBbpYqRkhiyf/bAjRTP+F9UZ8klhY4bGWAJLLtsu8l0Zju
 TtfAW7rKnkP+klQ==
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
 rust/kernel/block/mq/gen_disk.rs   | 95 +++++++++++++++++++++++++++++++++-----
 rust/kernel/block/mq/operations.rs | 61 +++++++++++++++++++++++-
 3 files changed, 145 insertions(+), 12 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index eaf05d60dda9..2a69c17bf271 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -139,6 +139,7 @@ const blk_status_t RUST_CONST_HELPER_BLK_STS_ZONE_ACTIVE_RESOURCE = BLK_STS_ZONE
 const blk_status_t RUST_CONST_HELPER_BLK_STS_OFFLINE = BLK_STS_OFFLINE;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_DURATION_LIMIT = BLK_STS_DURATION_LIMIT;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_INVAL = BLK_STS_INVAL;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ZONED = BLK_FEAT_ZONED;
 const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET = FOP_UNSIGNED_OFFSET;
 
 const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 79a67b545eca..eedba691e167 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -8,6 +8,7 @@
 use crate::{
     bindings,
     block::mq::{
+        operations::OperationsVTable,
         Operations,
         RequestQueue,
         TagSet, //
@@ -48,6 +49,12 @@ pub struct GenDiskBuilder<T> {
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
 
@@ -59,6 +66,12 @@ fn default() -> Self {
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
@@ -130,6 +143,27 @@ pub fn max_hw_discard_sectors(mut self, max_hw_discard_sectors: u32) -> Self {
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
@@ -149,7 +183,18 @@ pub fn build(
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
@@ -179,14 +224,6 @@ pub fn build(
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
@@ -214,7 +251,27 @@ pub fn build(
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
@@ -228,7 +285,11 @@ pub fn build(
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
@@ -327,6 +388,18 @@ fn drop(&mut self) {
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
index b9a2bf6592b3..71d4192d627f 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -9,6 +9,7 @@
     block::{
         error::BlkResult,
         mq::{
+            gen_disk::GenDiskRef,
             request::RequestDataWrapper,
             IdleRequest,
             Request, //
@@ -16,6 +17,7 @@
     },
     error::{
         from_result,
+        to_result,
         Result, //
     },
     prelude::*,
@@ -29,7 +31,10 @@
         Owned, //
     },
 };
-use core::marker::PhantomData;
+use core::{
+    marker::PhantomData,
+    ptr::NonNull, //
+};
 use pin_init::PinInit;
 
 type ForeignBorrowed<'a, T> = <T as ForeignOwnable>::Borrowed<'a>;
@@ -107,6 +112,20 @@ fn init_hctx(
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
@@ -359,6 +378,46 @@ impl<T: Operations> OperationsVTable<T> {
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


