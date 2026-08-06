Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7B43F0BA
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012849; cv=none; b=t9LZ05HwP5iyc583kBaqPV+Hgu0LG6pqW9WbLeMPQsoBYmH2GSOhigySLkC/e7ao/DAphzFun1FK/lU/hKbNsK7N29t3Jqp6ELxg4/8QSXPz17eNQkN6GyOAemYB/GSHx+wfEOgb+cUYJltfxyduDCVhILqxKEtvAQojDGQI4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012849; c=relaxed/simple;
	bh=tRfdsI9jyfAUpbfjwgHz3vA8D9iLRveb6evE1cckkuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNwlTg+Vcic17CMlb8ZYsV1rhPXnjgs0xEgWuWNb92y0xljg2odRK79kVruNEevR2FL83St2rqGQfpIJc3ZL1+8gdpZgwnTIx/g5EaPea92Q9mnE04zDU0deo241PJn9YYhGZU3elrszzlU6I8iMcMdpGQopcN8JKCPHOAxEu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmfT4Wnu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmfT4Wnu"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1304313a12.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 03:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786012847; x=1786617647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHhG+liuZTafcPBdaHPAIlQHTjNuSYOZDbFN67Y2dRk=;
        b=cmfT4Wnu6akDEB0lEmy/TKIcp8XKNy3n4AQKj7EM5FF9mxC1tptqSFsuaLLZTdew6n
         QUFaUl6Z/1xchVvwl+STnPzgRhjFzO397ZKRz0BSRD+bL1onx0CoOAuhslDQVlDagjmm
         AlavUSf89ezB0fTm0XNlZpnWpXStLf0KPvumGYnTpu6SfFaaecF8foMe+wUbKLFxyBC2
         WsNMdtl+TV98BIn37FSvTGO25P10sWcpsylfbkoa4/OHo+gvpki1xihDMx/wP5sMCggI
         UEf5wE78yprPPG169rBcMWK6J3Xv/RCV2mQbOFi0ascNknMtNYkwOQd8fq1rOAG5SS8R
         0Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786012847; x=1786617647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHhG+liuZTafcPBdaHPAIlQHTjNuSYOZDbFN67Y2dRk=;
        b=mFpupfJJBa97EaAsJXKw+GSpNMfsKObdU8qftEeg7JlNQ2wfHO2aJK3XFPVOMs4tSb
         DdFyeYnQJjao5YwYALYicdadxyYHnRFnbjwbiIvGO5tHXDyeI/uEB7YFaj2t8/GJJO3N
         zIF2TxSRfhfPSHlWoz5+FUpUSUlmSsokBIp5n8CXLOSRicCiFnYu1rxkP84Jzk8PmJ9e
         WsbO3OY5leTOyhWRvSeTOhKdNHNbViJ4eE9fvEaqGu5gMCsNwvfD/lUh79U3F/140Fd8
         AQ6sjrUjmTy4jgjCA9eysYP70Z6c5mUZ2qgdqjHBxvQFBLzNoqHP7TfOQKhU5S/xDQYz
         Awsw==
X-Forwarded-Encrypted: i=1; AHgh+RrxS9tQd1PTEvE48bvUZkXW+qLk5K4R3/InAVMi6NfPP2BYe6KhFg816cVUtwH3cv1BOiQTnE1LUU27/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WPcR55RXVoHlpudx9GJ66qf4PhaZ3UkdTrpMqBM/9QmUuQtd
	9njh6UwgFy84qlrITQGWKPIDcbEpFq/+AxWW+5KAv0rAFdPut+HEQGpG
X-Gm-Gg: AR+sD10PPTI4cMqPq30hcT0Mn5qouBcsHvUvHWoHa9+jXY0V0NJoGmRzBGwWCixat9z
	db4eoRsRPqTUEPOMFAc8jbY9vkWt20M8E8FASUlBvHEcr+Qy5OlDuv/W/0jIDU4OHPv6ipS3CUs
	cx+876IrYRjnTbeVeN5N4bqzAD+pkavt0igAO2HGVs0e1rtgnWB7bdY8n/dE3um06iO3Z8Wphe1
	zi3+c7NpsK4sPP4UUxbuSDXS6r1fBSmLfgtgWpn2xz0ucX4rCzFxF4ru4gCsugIUIE0v2mPIN6k
	Y+VoFD2dJZPHxM7s3dzxWnFWH3Xy7OJtRA9mY+Ft+At1sRniqXylO5bfRrzWpmb1Il23ly4cchI
	mDU7yfxP8iFZjRrUcuH8u8NQUgI3nI8emDO/aTny3pJ2HtQW6PEO8+3vIMKK6zOGKmjSj38xPu6
	XV4HHjm8w4rOEJ5i7NEHQ4/bPv3Fo7o8d3Qc1TWiSYLiy63n0fYoYbA4atZE0r1Q==
X-Received: by 2002:a05:6a20:6a10:b0:3bf:6237:4d46 with SMTP id adf61e73a8af0-3cb85ef7e35mr15288484637.28.1786012847127;
        Thu, 06 Aug 2026 03:40:47 -0700 (PDT)
Received: from archlinux ([2402:e280:411b:ec:aa93:b1ec:5a6b:5fce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b761asm39061397eec.1.2026.08.06.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:40:46 -0700 (PDT)
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
Subject: [PATCH v3] rust: block: set GenDisk block_device_operations.owner to THIS_MODULE
Date: Thu,  6 Aug 2026 16:10:27 +0530
Message-ID: <20260806104027.83940-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806083655.23161-1-adarshdas950@gmail.com>
References: <20260806083655.23161-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GenDiskBuilder left block_device_operations.owner NULL. Set owner from a
const block_device_operations table using this_module::<M>() and update
rnull to pass NullBlkModule.

Add ModuleMetadata::THIS_MODULE and this_module() so the owner pointer is
available in const context. Rebased on Alvins fix-fops-owner series [1].

Link: https://lore.kernel.org/all/20260805192020.107601-1-adarshdas950@gmail.com/

v2:
- Free fops in free_disk instead of GenDisk::drop to fix use-after-free
  when the device stays open after removal. (Sashiko)
- Install the cleanup guard before fops allocation to avoid leaking gendisk
  on -ENOMEM. (Sashiko)
- Link to v1: https://lore.kernel.org/all/20260805192020.107601-1-adarshdas950@gmail.com/

v3:
- Use const fops with this_module::<M>() instead of heap allocation
  (as suggested by Andreas).
- Integrate ModuleMetadata::THIS_MODULE from [1].
- Dismiss recover_data before fallible build steps after the cleanup guard.
  (Sashiko)
- Link to v2: https://lore.kernel.org/all/20260806083655.23161-1-adarshdas950@gmail.com/

[1] https://lore.kernel.org/r/20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 drivers/block/rnull/rnull.rs     |  2 +-
 rust/kernel/block/mq.rs          | 13 ++++++--
 rust/kernel/block/mq/gen_disk.rs | 56 +++++++++++++++++---------------
 rust/kernel/lib.rs               |  9 +++++
 rust/macros/module.rs            | 16 +++++++++
 5 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..912526be4ec2 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -61,7 +61,7 @@ fn new(
             .logical_block_size(block_size)?
             .physical_block_size(block_size)?
             .rotational(rotational)
-            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
+            .build::<NullBlkModule, Self>(fmt!("{}", name.to_str()?), tagset, queue_data)
     }
 }
 
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1fd0d54dd549..faa9fcbac935 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -8,8 +8,8 @@
 //! - Implement [`Operations`] for a type `T`.
 //! - Create a [`TagSet<T>`].
 //! - Create a [`GenDisk<T>`], via the [`GenDiskBuilder`].
-//! - Add the disk to the system by calling [`GenDiskBuilder::build`] passing in
-//!   the `TagSet` reference.
+//! - Add the disk to the system by calling [`GenDiskBuilder::build`], passing in
+//!   the module type, the disk name, the `TagSet`, and queue data.
 //!
 //! The types available in this module that have direct C counterparts are:
 //!
@@ -86,9 +86,16 @@
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
+//! # struct MyModule;
+//! # impl kernel::ModuleMetadata for MyModule {
+//! #     const NAME: &'static kernel::str::CStr = c"myblk";
+//! #     // SAFETY: Doctest stub; no module is loaded.
+//! #     const THIS_MODULE: ThisModule =
+//! #         unsafe { ThisModule::from_ptr(core::ptr::null_mut()) };
+//! # }
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(fmt!("myblk"), tagset, ())?;
+//!     .build::<MyModule, MyBlkDevice>(fmt!("myblk"), tagset, ())?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..4a503f183cc9 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -15,8 +15,34 @@
     str::NullTerminatedFormatter,
     sync::Arc,
     types::{ForeignOwnable, ScopeGuard},
+    ModuleMetadata,
 };
 
+struct BlockFops<M: ModuleMetadata>(core::marker::PhantomData<M>);
+
+impl<M: ModuleMetadata> BlockFops<M> {
+    const TABLE: bindings::block_device_operations = bindings::block_device_operations {
+        submit_bio: None,
+        open: None,
+        release: None,
+        ioctl: None,
+        compat_ioctl: None,
+        check_events: None,
+        unlock_native_capacity: None,
+        getgeo: None,
+        set_read_only: None,
+        swap_slot_free_notify: None,
+        report_zones: None,
+        devnode: None,
+        alternative_gpt_sector: None,
+        get_unique_id: None,
+        owner: crate::this_module::<M>().as_ptr(),
+        pr_ops: core::ptr::null_mut(),
+        free_disk: None,
+        poll_bio: None,
+    };
+}
+
 /// A builder for [`GenDisk`].
 ///
 /// Use this struct to configure and add new [`GenDisk`] to the VFS.
@@ -95,7 +121,7 @@ pub fn capacity_sectors(mut self, capacity: u64) -> Self {
     }
 
     /// Build a new `GenDisk` and add it to the VFS.
-    pub fn build<T: Operations>(
+    pub fn build<M: ModuleMetadata, T: Operations>(
         self,
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
@@ -125,30 +151,8 @@ pub fn build<T: Operations>(
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
+        // SAFETY: `gendisk` is a valid pointer as we initialized it above.
+        unsafe { (*gendisk).fops = &BlockFops::<M>::TABLE };
 
         let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
             // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
@@ -159,8 +163,6 @@ pub fn build<T: Operations>(
             drop(unsafe { T::QueueData::from_foreign(data) });
         });
 
-        // The failure guard now owns both pieces of cleanup; the early guard
-        // must not run on this path anymore.
         recover_data.dismiss();
 
         let mut writer = NullTerminatedFormatter::new(
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df..9bbabaf84e20 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -185,6 +185,15 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Erro
 pub trait ModuleMetadata {
     /// The name of the module as specified in the `module!` macro.
     const NAME: &'static crate::str::CStr;
+
+    /// The module's `THIS_MODULE` pointer.
+    const THIS_MODULE: ThisModule;
+}
+
+/// Returns the [`ThisModule`] pointer for the given module type.
+#[inline]
+pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
+    &M::THIS_MODULE
 }
 
 /// Equivalent to `THIS_MODULE` in the C API.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 06c18e207508..8df38718224b 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -519,6 +519,22 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
 
         impl ::kernel::ModuleMetadata for #type_ {
             const NAME: &'static ::kernel::str::CStr = #name_cstr;
+
+            #[cfg(MODULE)]
+            const THIS_MODULE: ::kernel::ThisModule = {
+                extern "C" {
+                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
+                }
+
+                // SAFETY: `__this_module` is constructed by the kernel at load time and lives
+                // until the module is unloaded.
+                unsafe { ::kernel::ThisModule::from_ptr(__this_module.get()) }
+            };
+
+            #[cfg(not(MODULE))]
+            const THIS_MODULE: ::kernel::ThisModule = unsafe {
+                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
+            };
         }
 
         // Double nested modules, since then nobody can access the public items inside.
-- 
2.55.0

