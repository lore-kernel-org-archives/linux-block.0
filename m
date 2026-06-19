Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F835DA42;
	Fri, 19 Jun 2026 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862609; cv=none; b=KCpM2rDaTEStdNPl9yDE+go2cn6i37kzpqujMJlrlddK+yvwlaWdlCe8wBykLOv9MIF0MMk8CM7j56gS3/I4RpcF87QomI7UyZDgBWdDxprp83a8VlFOZ2Z+UQuvtFpn38VVABs1lzuV6DpmpQ8qJpdSipy2kskr4OQvX9LqE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862609; c=relaxed/simple;
	bh=IvkF1LHrc1w0vq7LzdsEwSu48dDkpijGh/cmB0LcTJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKShBvW23apZyCcUd9QlKKQkbBznXMPlKoFZHErUmIRu/JRLaBodR3jKvyJoILShjr37XiSDogJpKjUjjgjs+bBSBC6VYCSgVfQ6G5s/MIUx7Lts/VyCkkpaIOSevi71gHxcWF2ihsRPXXXqcM2FkeZmWjmYnqKe68ZjK2PZXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvWplysN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvWplysN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97731F000E9;
	Fri, 19 Jun 2026 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781862607;
	bh=hMDLm7TWVuc4y6AViJAriC0ZFUz4Mvz0eu/sxr7TJ7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HvWplysNnb2o2ub/HlRiszaVhVfNIvnSMPKgaLKyPuMM1Xi/yaf319mtP00WK62nm
	 +XaNgReHostJ7DbBBFP6VGNJy708ONa3NNpL7GFjppdL+gCSSL3CgzFxQ/QZpUZj2t
	 8shVX9+n7z8qyCluDuxlxKTaMZ6DCTOIQIKMtOWD4wTIeJCH35C+vg69I8uZjfhgLX
	 XRzgDSlCZTVLV27Fyy/GllARbLmgNgL7HAoD53214B+/38/xYXqy2Lc0DzaTPz7NXQ
	 /wHu5c+2aKM/swBzfsynJ7QP1SW6DCWP3Mi6PmhcwLeKqKnmUz3auUz6Ux5NHssYFQ
	 TgPpnFjOpaMsA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Christoph Hellwig
 <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>, Jens Axboe
 <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Ming Lei <tom.leiming@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, Qu
 Wenruo <wqu@suse.com>, Hillf Danton <hdanton@sina.com>, Miguel Ojeda
 <ojeda@kernel.org>
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
In-Reply-To: <9ebc39a8-6025-40e3-a378-ba26bf8d73ae@I-love.SAKURA.ne.jp>
References: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp>
 <4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org>
 <20260601071113.GB7468@lst.de>
 <420f723a-8168-4f56-b84a-2a36ecd87fea@I-love.SAKURA.ne.jp>
 <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <87wlwdifrv.fsf@kernel.org>
 <9ebc39a8-6025-40e3-a378-ba26bf8d73ae@I-love.SAKURA.ne.jp>
Date: Fri, 19 Jun 2026 11:49:58 +0200
Message-ID: <87a4sqg8qh.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2026/06/05 16:54, Andreas Hindborg wrote:
>> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:
>> 
>>> The block core currently allocates a single monolithic lockdep key for
>>> disk->open_mutex across all callers. This single key conflates locking
>>> hierarchies between independent block streams. For example, if a stacked
>>> driver like loop flushes its internal workqueues inside lo_release() while
>>> holding its own open_mutex, lockdep views this as a potential ABBA deadlock
>>> against the underlying storage stack, leading to numerous circular
>>> dependency splats.
>>>
>>> To structurally reduce false positives, this patch splits the global
>>> monolithic lock class into distinct, per-caller instances during disk
>>> allocation. This is done by replacing "struct lock_class_key" with
>>> "struct gendisk_lkclass", which contains two instances of
>>> "struct lock_class_key" for the legacy "(bio completion)" map and
>>> disk->open_mutex respectively.
>>>
>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> 
>> For the Rust part, we have existing infrastructure for lock class keys
>> [1]. Please take a look how we generate lock class keys elsewhere [2].
>
> My understanding is that we don't have infrastructure for lock class keys
> that can be applied to
>
>   +struct gendisk_lkclass {
>   +	struct lock_class_key bio_lkclass;
>   +	struct lock_class_key open_mutex_lkclass;
>   +};
>
>   -	static struct lock_class_key __key;
>   +	static struct gendisk_lkclass __key;
>
> change. Alternative approach is welcomed if you have one.

Sorry, I did not pay enough attention. I would suggest this approach:

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 21557a1ce866..13048cea8bb0 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -68,7 +68,7 @@ fn new(
             .logical_block_size(block_size)?
             .physical_block_size(block_size)?
             .rotational(rotational)
-            .build(fmt!("{}", name.to_str()?), tagset, queue_data, kernel::my_gendisk_lkclass!())
+            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
     }
 }
 
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 10f22b200567..1fd0d54dd549 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -88,7 +88,7 @@
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(fmt!("myblk"), tagset, (), kernel::my_gendisk_lkclass!())?;
+//!     .build(fmt!("myblk"), tagset, ())?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 8c452e90fe9d..58f87a184407 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -24,6 +24,7 @@
     sync::Arc,
     types::{
         ForeignOwnable,
+        Opaque,
         ScopeGuard, //
     }, //
 };
@@ -49,43 +50,6 @@ fn default() -> Self {
     }
 }
 
-/// A wrapper type for safely passing "struct gendisk_lkclass" argument.
-///
-/// This type can only be instantiated via the [`my_gendisk_lkclass!`] macro.
-pub struct GenDiskLockClass(pub(crate) *mut bindings::gendisk_lkclass);
-
-impl GenDiskLockClass {
-    /// Retrieve the underlying raw pointer.
-    pub(crate) fn as_ptr(&self) -> *mut bindings::gendisk_lkclass {
-        self.0
-    }
-}
-
-#[doc(hidden)]
-pub mod __internal {
-    use super::*;
-
-    /// Internal constructor used ONLY by the `my_gendisk_lkclass!` macro.
-    ///
-    /// SAFETY: `ptr` must point to a valid static `gendisk_lkclass` instance.
-    pub const unsafe fn new_lock_class(ptr: *mut bindings::gendisk_lkclass) -> GenDiskLockClass {
-        GenDiskLockClass(ptr)
-    }
-}
-
-/// Helper macro to generate a unique caller-local static lock class struct
-#[macro_export]
-macro_rules! my_gendisk_lkclass {
-    () => {{
-        static mut LKCLASS: $crate::bindings::gendisk_lkclass = $crate::bindings::gendisk_lkclass {
-            bio_lkclass: const { unsafe { ::core::mem::zeroed() } },
-            open_mutex_lkclass: const { unsafe { ::core::mem::zeroed() } },
-        };
-
-        unsafe { $crate::block::mq::gen_disk::__internal::new_lock_class(&raw mut LKCLASS) }
-    }};
-}
-
 impl GenDiskBuilder {
     /// Create a new instance.
     pub fn new() -> Self {
@@ -148,7 +112,6 @@ pub fn build<T: Operations>(
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
         queue_data: T::QueueData,
-        lkclass: GenDiskLockClass,
     ) -> Result<GenDisk<T>> {
         let data = queue_data.into_foreign();
         let recover_data = ScopeGuard::new(|| {
@@ -164,14 +127,21 @@ pub fn build<T: Operations>(
             lim.features = bindings::BLK_FEAT_ROTATIONAL;
         }
 
-        // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
+        let keys = KBox::pin_init(
+            Opaque::ffi_init(|ptr: *mut bindings::gendisk_lkclass| {
+                // SAFETY: `ptr` is valid for writes
+                unsafe { bindings::lockdep_register_key(&raw mut (*ptr).bio_lkclass) };
+                // SAFETY: `ptr` is valid for writes
+                unsafe { bindings::lockdep_register_key(&raw mut (*ptr).open_mutex_lkclass) };
+            }),
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY:
+        // - `tagset.raw_tag_set()` points to a valid and initialized tag set.
+        // - We keep `keys` alive for the lifetime of the returned gendisk.
         let gendisk = from_err_ptr(unsafe {
-            bindings::__blk_mq_alloc_disk(
-                tagset.raw_tag_set(),
-                &mut lim,
-                data,
-                lkclass.as_ptr(),
-            )
+            bindings::__blk_mq_alloc_disk(tagset.raw_tag_set(), &mut lim, data, keys.get())
         })?;
 
         const TABLE: bindings::block_device_operations = bindings::block_device_operations {
@@ -230,6 +200,7 @@ pub fn build<T: Operations>(
         Ok(GenDisk {
             _tagset: tagset,
             gendisk,
+            _lock_class_keys: keys,
         })
     }
 }
@@ -245,6 +216,7 @@ pub fn build<T: Operations>(
 pub struct GenDisk<T: Operations> {
     _tagset: Arc<TagSet<T>>,
     gendisk: *mut bindings::gendisk,
+    _lock_class_keys: Pin<KBox<Opaque<bindings::gendisk_lkclass>>>,
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
---


Best regards,
Andreas Hindborg



