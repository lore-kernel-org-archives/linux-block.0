Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD441A4EC
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005468; cv=none; b=RRsTMQOfEkRL+nPCf1D8h2vl4o6CO29QF4n/PLWuj7VN6wHH0JS0QDJzltXhqkrD+PbMJhVtJagW6cHxKEmOFfIcvtJB8SjAQ0jFfWmhSJFBV2ttnbMRTYgjqwEeymMyt4JjrGm5tuUOaIVZqGcQnrYvQGo+JJHrOkmO/Lgaomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005468; c=relaxed/simple;
	bh=K68TZ6Okn0Of995J9SNbWqHIkxrKzwj7KXt05vRCPIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsZM3BcXp5d+D5HbuOAN8/0wXJ9qk0S+hw2uiREyc9BrwI1dNlI0EUK6svyxS0SiqPc8rlEh8tLFEVUr19FJv/vzgWP7ZUeJx3rd8ZFGJ6/NI6PngbA5+Q7DjiZoLr8MqCVIeHvptH2W0xH61SOB42zJ0dtTTP1D1FcxeDsrYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EudU0Hrm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EudU0Hrm"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c999f162c9aso1378822a12.3
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786005447; x=1786610247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tkD7BsMHZyGAvnJ70CwDbdJKVjJ2J7o8mq8tbWHVAjY=;
        b=EudU0HrmP09D0vNctq2ksmx2aBX7kAiSbxx+m8q5RhNVJD9RXQ0KN+tEZhntFC+Z46
         /SmVqTKWnGJ/K78OHlz745qX2UFPjtVTwv/WjbAETe/dzGIkseZRkOfiBp5EeSct9WMS
         +7xSdrfGRuMlfUX0Ee3hVlS8YaiWZBA/Hm2vhMJyf6UFjrpHtCDhlXGWHEqfd2sFXxIT
         K+uxyl4rb9ZCfXLWtYR05vYo+DJLV6BEL5PEcAqdQ6sYMoBjngNFM2wbsHJUDzoGoUff
         5ebrmEURela4d65JeLJzLzSjQeShROtdB8eKE0s6uBb73tnlnZpAq/2TtaiT+/i+gF1k
         iDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786005447; x=1786610247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tkD7BsMHZyGAvnJ70CwDbdJKVjJ2J7o8mq8tbWHVAjY=;
        b=qcnAQI5Foi9wgM90TgsrfmReNoKK+XBRw619pEoU/Ws9oybKXaXo8x6bASBRrM4ULR
         HZBCd4ubkSkpNjPm7KiyJi6Hai+EOBTpvlnI1/2Y8htd6gSip5YwD/Anls+DnAY65YAD
         xiCkAFOWBuO8FXxijU3jr77xdju2GWz25iW8ZUSr1LAnw1fsX1GOQgVVZ9KsRcY5gq9M
         cAHPNiRtS+qzhFh3s+dfp/bsVTJbdRdjjn3Ybe9tXxyVh9oHK8vaoFU06u7Et7MVlumN
         jDHFudRLJrzEV13rC2Z6z5aqFBMzsWuSjNTXQyl9PblkbDsyXCD97TuVVMOh8tjYQZcL
         HETA==
X-Forwarded-Encrypted: i=1; AHgh+RpppHQjWdS3rf5NH8edKDP5auaCG+IxJr3BBE2nBnB5nLYiGDSfj/n7F/NfBd8DDSWVdRaomVhTjlpGMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmCN0y5ZjdYmBr4teT4yzn4HwwzWrDwH2sE3O/Bv1o3EyLHuL+
	wPZXO69Jv1VZwvC6Rwh6b2WLFfuaRWBSntlkdXFnDp/XXxqa0nPBd4gW
X-Gm-Gg: AR+sD1202kO5vO0RFkJX+m0lTAJVwXqETAviEo4nP9Uj/T80oivfBkaZ72It9NUJUOa
	Q5izdOZ5CLZuVWGrdvssQ1/OQq1rugG7u2YniuCjzjdkCHdmVCtp0qs2S+ernZ6/tWHON2GGCSK
	Tl/vXWAXJKcAEeEvQH/tf7lW+MfKxBGIDPj6x1AiTfLnF6P9VgrU5xI+H4RnAr5P6AFPVlAtjSm
	OCeAWThcdTLpylfeamBTjXGGs67WYm1wrMEyUTTVtD9rOfLZN+mzfo0hw92VZZigrXq0lAWRfLE
	TcphBjA/2TxVUWP4giqeJYTk5dDcOYtxZgP2Asq13iPFQAlCXU/rUnap98OUZc29JKh939tv8Y6
	9hm8mhPIeHDkFwW8IxALnjXqzk8wchRQ4tch9cf/SvkXhWJNAUqUYr6pQeVqAICz/6y9v51+Kl0
	utRwhe39U2UHsCEEc2ea1vnJ+Au4xoJzCF+gAgkT05DlCgR4kzxa9OgvidXsqvt1g=
X-Received: by 2002:a05:6a20:e290:b0:3c4:3112:33 with SMTP id adf61e73a8af0-3cb85de7c9bmr15386526637.6.1786005447444;
        Thu, 06 Aug 2026 01:37:27 -0700 (PDT)
Received: from archlinux ([2402:e280:411b:ec:aa93:b1ec:5a6b:5fce])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca9111b6sm21986347c88.13.2026.08.06.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:37:26 -0700 (PDT)
From: Adarsh Das <adarshdas950@gmail.com>
To: adarshdas950@gmail.com
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	axboe@kernel.dk,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev
Subject: [PATCH v2] rust: block: set GenDisk block_device_operations.owner to THIS_MODULE
Date: Thu,  6 Aug 2026 14:06:55 +0530
Message-ID: <20260806083655.23161-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805192020.107601-1-adarshdas950@gmail.com>
References: <20260805192020.107601-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GenDiskBuilder left block_device_operations.owner NULL. Pass the driver's
ThisModule into GenDiskBuilder::build(), heap-allocate the operations
table, and keep it alive until the gendisk is released via free_disk.
Update rnull as the in-tree caller.

v2:
- Free fops in free_disk instead of GenDisk::drop to fix use-after-free
  when the device stays open after removal. (Sashiko)
- Install the cleanup guard before fops allocation to avoid leaking gendisk
  on -ENOMEM. (Sashiko)
- Link to v1: https://lore.kernel.org/all/20260805192020.107601-1-adarshdas950@gmail.com/

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 drivers/block/rnull/configfs.rs  |  1 +
 drivers/block/rnull/rnull.rs     |  3 +-
 rust/kernel/block/mq.rs          |  9 ++--
 rust/kernel/block/mq/gen_disk.rs | 82 ++++++++++++++++++++++----------
 4 files changed, 66 insertions(+), 29 deletions(-)

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
index fc97dd873974..a51027e8c1c1 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -17,6 +17,23 @@
     types::{ForeignOwnable, ScopeGuard},
 };
 
+/// # Safety
+///
+/// `disk` must be valid.
+unsafe extern "C" fn free_fops(disk: *mut bindings::gendisk) {
+    // SAFETY: `disk` is valid.
+    let fops = unsafe { (*disk).fops };
+    if fops.is_null() {
+        return;
+    }
+
+    // SAFETY: `disk` is valid; `fops` came from `KBox::into_raw` in `build`.
+    unsafe {
+        (*disk).fops = core::ptr::null_mut();
+        drop(KBox::from_raw(fops.cast_mut()));
+    }
+}
+
 /// A builder for [`GenDisk`].
 ///
 /// Use this struct to configure and add new [`GenDisk`] to the VFS.
@@ -95,8 +112,12 @@ pub fn capacity_sectors(mut self, capacity: u64) -> Self {
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
@@ -125,32 +146,16 @@ pub fn build<T: Operations>(
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
-
         let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
+            // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
+            // has not been added to the VFS on this cleanup path.
+            let fops = unsafe { (*gendisk).fops };
+            if !fops.is_null() {
+                // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above.
+                unsafe { (*gendisk).fops = core::ptr::null_mut() };
+                // SAFETY: `fops` came from `KBox::into_raw` below on this path.
+                drop(unsafe { KBox::from_raw(fops.cast_mut()) });
+            }
             // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
             // has not been added to the VFS on this cleanup path.
             unsafe { bindings::put_disk(gendisk) };
@@ -159,6 +164,33 @@ pub fn build<T: Operations>(
             drop(unsafe { T::QueueData::from_foreign(data) });
         });
 
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
+                free_disk: Some(free_fops),
+                poll_bio: None,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY: `gendisk` is a valid pointer as we initialized it above.
+        unsafe { (*gendisk).fops = KBox::into_raw(fops).cast() };
+
         // The failure guard now owns both pieces of cleanup; the early guard
         // must not run on this path anymore.
         recover_data.dismiss();
-- 
2.55.0

