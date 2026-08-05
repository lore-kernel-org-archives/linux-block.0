Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22133EDE56
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957659; cv=none; b=k2wTfqvWZLL/8NUD8Ig861K4vUklEYIN4vWAI0NVSxmSsOf6pABC0ht8v3W4AwKgq13NK0hOc8Eg9r4SjHzPMDZ1XJy4OiiSJbtgfzS/mRvyat9xKb9aiCDj26yk43rp1bfQDVtLTsf68Vl6v93zyP4XFwZXLF4nQUHT++0v21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957659; c=relaxed/simple;
	bh=M7+Xp5G3tZjyNJEGVQVB6k60p7Qw9FijqopxCE9sFOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLLCP2tzZGVDWahCvYQX8GBkTwO27EH04kkQ1G2zrzncLmoZ0BCTeADJ+xqxn78pEIU/DtkZjtZy+lmi/UPs+NqoE+iMCJJFyNtMd2aN3aV3nQaV9GUOL2atctCJSTAS+WpIFwxrdgfQ5SyO7t1XYUcsanaurBZOEV6He8SlSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qc/cEU7w; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc/cEU7w"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce98cb8165so2623825ad.1
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785957648; x=1786562448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJyM/9okkHYCeVF069aAYJMZJUD0kZWBXu8tJw0Mi1w=;
        b=qc/cEU7w42YEzgIaid8rWB0Bp+RokkA+FLzQ3J8+fxw+cSoTJtfNvWX//c4oz7yLuS
         l0Wm8Y/lKv22jbb3seFhvEe2tmRLUvzmV1HOcTdA8TgVZEU5JBwJx4FOvUJFlaaIwyv0
         gaSD5QP+BRGdqDeVooIcdtvx2cxvrUBtJSu7CfPMzwBZcqZrLFTOy0bv2lYX3nfLbv0t
         jHwsS9INh/RHTy8uYbqyGItjS26pT+xGxzuVdfK4htD0Iesds2+0UThgETEaZiYn9BNM
         VzdixjRJ3rXF1zBBgSaozGtwx3RVDu4P2syxtb6GfrMh0RnwH1arAxP+i7AZG10rYO8P
         CcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957648; x=1786562448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJyM/9okkHYCeVF069aAYJMZJUD0kZWBXu8tJw0Mi1w=;
        b=TV8E6RSYbNSDjm0/rlW/m55iHMi4qAHojB3W/gVPq1Tc0RFtOnEx68hb9JmBlhJmVo
         jtuDlswo32T4WIeqf8Grd50ZoVOP0spsJAStxktHxe9HxUay6lfm1r9wSg7mSWEbCZoW
         HyLiAod78FMmOzZBzakYn3WIbuHIaTGvNVF/pnxdDbcdgKUXvvixdAlsp9xe5CoRSzjQ
         V1Qgm6VuZAahiKKgxaB8a5OBcQ9tcN2pFCojdVXDrlq/pL65uETCBI6LVHzGNEgO+xPI
         YTOWkNVFPz122hQw50vu9myRuL7NDq7Vcy5Y5sJ2w9GOjIxDhcdIObu7iuKcbyhkIda0
         iHOg==
X-Forwarded-Encrypted: i=1; AHgh+RoYRbjkDbNFP5G8E3dXmGnhLGmAvV7TbKTKICT3Fct7+RYySjbup4j591GfN3iWKm6JwLFrpsEUbAuMtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGVg2i0jJJitVVKsP5JksErLf8GBTyh6UYS+MY6sEYJDugfRp
	ndKgnGJQLva/dvRkQsIjtYxvevSW5E7sC5DilXYHCopcbAw6TmWj8wwo
X-Gm-Gg: AR+sD10y6F+viur08I6s3aYXcq+g0ugIWCiuOkq1NpeUQEkR6o6fofO3Oy/0sh4EZNl
	C0zAiw/XY9LCQiOuhlv0MBujwwoR6wuhXB8Fena5D3dtnchPiYxJhsU7yzKTRwBWREBGEAYuXVr
	1X+fE1/lZ8vwj4U67A/VbWDbWGn4/8CrJ79IAMhmACqHsQnRYZGjyIQfbvuvukuEh+lue8VmIex
	2OHn/4UheeeQLQLeU+sNKlIFX3EDWl/IDaGh1UaHuKzCfhwBa0X11zNW38iZdhxbhlGvxziFw3I
	QHc8C/NlU95+i76/7DYQoiJSUuuV93ZvwTa0NhQLScSbCJcsoWFOLu/E2Lw/QRpNhH25SkrZndm
	+eaQX5gtJIXdp/gUWG4KeW/5wKfcXWb1oLWxQoNz3HPBzl9eOxPk/G7S10x//Y6Wg1USrBLwNYb
	6pVBPVCemzuV1F5hasAAQYbpv+jQ4C8KmUueyDcaiTLVDykrO64oZCn39/WDhEMik=
X-Received: by 2002:a17:902:da87:b0:2d0:401c:2edc with SMTP id d9443c01a7336-2d0f185d642mr11951815ad.1.1785957648176;
        Wed, 05 Aug 2026 12:20:48 -0700 (PDT)
Received: from archlinux ([2402:e280:411b:ec:aa93:b1ec:5a6b:5fce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm18043913eec.4.2026.08.05.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:20:47 -0700 (PDT)
From: Adarsh Das <adarshdas950@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH] rust: block: set GenDisk block_device_operations.owner to THIS_MODULE
Date: Thu,  6 Aug 2026 00:50:20 +0530
Message-ID: <20260805192020.107601-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GenDiskBuilder currently installs block_device_operations with owner set
to NULL. The block layer uses this field to pin the driver module while
block device file operations are in use.

Take the driver's ThisModule in GenDiskBuilder::build() and store the
operations table in GenDisk so gendisk->fops stays valid if the disk is
moved, such as when rnull keeps it in an Option behind configfs. Update
rnull as the in-tree caller.

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 drivers/block/rnull/configfs.rs  |  1 +
 drivers/block/rnull/rnull.rs     |  3 +-
 rust/kernel/block/mq.rs          |  9 +++--
 rust/kernel/block/mq/gen_disk.rs | 58 +++++++++++++++++++-------------
 4 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b722..bba30d590f68 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -147,6 +147,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 
         if !guard.powered && power_op {
             guard.disk = Some(NullBlkDevice::new(
+                &THIS_MODULE,
                 &guard.name,
                 guard.block_size,
                 guard.rotational,
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..4265a133cbf0 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -46,6 +46,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
 impl NullBlkDevice {
     fn new(
+        this_module: &'static ThisModule,
         name: &CStr,
         block_size: u32,
         rotational: bool,
@@ -61,7 +62,7 @@ fn new(
             .logical_block_size(block_size)?
             .physical_block_size(block_size)?
             .rotational(rotational)
-            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
+            .build(this_module, fmt!("{}", name.to_str()?), tagset, queue_data)
     }
 }
 
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1fd0d54dd549..33561e0f67af 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -8,8 +8,8 @@
 //! - Implement [`Operations`] for a type `T`.
 //! - Create a [`TagSet<T>`].
 //! - Create a [`GenDisk<T>`], via the [`GenDiskBuilder`].
-//! - Add the disk to the system by calling [`GenDiskBuilder::build`] passing in
-//!   the `TagSet` reference.
+//! - Add the disk to the system by calling [`GenDiskBuilder::build`], passing in
+//!   the driver's [`ThisModule`], the disk name, the `TagSet`, and queue data.
 //!
 //! The types available in this module that have direct C counterparts are:
 //!
@@ -86,9 +86,12 @@
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
+//! # // SAFETY: Dummy `ThisModule` for doctest compilation only.
+//! # static THIS_MODULE: ThisModule =
+//! #     unsafe { ThisModule::from_ptr(core::ptr::null_mut()) };
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(fmt!("myblk"), tagset, ())?;
+//!     .build(&THIS_MODULE, fmt!("myblk"), tagset, ())?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..ff079223d31a 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -95,8 +95,12 @@ pub fn capacity_sectors(mut self, capacity: u64) -> Self {
     }
 
     /// Build a new `GenDisk` and add it to the VFS.
+    ///
+    /// `this_module` must be the [`ThisModule`] for the kernel module registering
+    /// the disk.
     pub fn build<T: Operations>(
         self,
+        this_module: &'static ThisModule,
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
         queue_data: T::QueueData,
@@ -125,30 +129,32 @@ pub fn build<T: Operations>(
             )
         })?;
 
-        const TABLE: bindings::block_device_operations = bindings::block_device_operations {
-            submit_bio: None,
-            open: None,
-            release: None,
-            ioctl: None,
-            compat_ioctl: None,
-            check_events: None,
-            unlock_native_capacity: None,
-            getgeo: None,
-            set_read_only: None,
-            swap_slot_free_notify: None,
-            report_zones: None,
-            devnode: None,
-            alternative_gpt_sector: None,
-            get_unique_id: None,
-            // TODO: Set to `THIS_MODULE`.
-            owner: core::ptr::null_mut(),
-            pr_ops: core::ptr::null_mut(),
-            free_disk: None,
-            poll_bio: None,
-        };
-
-        // SAFETY: `gendisk` is a valid pointer as we initialized it above
-        unsafe { (*gendisk).fops = &TABLE };
+        let fops = KBox::new(
+            bindings::block_device_operations {
+                submit_bio: None,
+                open: None,
+                release: None,
+                ioctl: None,
+                compat_ioctl: None,
+                check_events: None,
+                unlock_native_capacity: None,
+                getgeo: None,
+                set_read_only: None,
+                swap_slot_free_notify: None,
+                report_zones: None,
+                devnode: None,
+                alternative_gpt_sector: None,
+                get_unique_id: None,
+                owner: this_module.as_ptr(),
+                pr_ops: core::ptr::null_mut(),
+                free_disk: None,
+                poll_bio: None,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY: `gendisk` is a valid pointer as we initialized it above.
+        unsafe { (*gendisk).fops = core::ptr::from_ref(&*fops) };
 
         let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
             // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
@@ -193,6 +199,7 @@ pub fn build<T: Operations>(
         // `__blk_mq_alloc_disk` above.
         Ok(GenDisk {
             _tagset: tagset,
+            _fops: fops,
             gendisk,
         })
     }
@@ -206,8 +213,11 @@ pub fn build<T: Operations>(
 ///  - `gendisk` was added to the VFS through a call to
 ///    `bindings::device_add_disk`.
 ///  - `self.gendisk.queue.queuedata` is initialized by a call to `ForeignOwnable::into_foreign`.
+///  - `self._fops` stores the [`bindings::block_device_operations`] pointed to by
+///    `gendisk.fops`.
 pub struct GenDisk<T: Operations> {
     _tagset: Arc<TagSet<T>>,
+    _fops: KBox<bindings::block_device_operations>,
     gendisk: *mut bindings::gendisk,
 }
 
-- 
2.55.0

