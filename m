Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191DE4779B2
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487651; cv=none; b=UVcy1cUBR1WCFN0NeUNpayB/GoO7gTzM69l6gd29jgGHORlLu5STja6+EkTR24lOk9H1PDeBc3zGbvkDgpphigNmCNODO195UGsIZj/VGmKPwZSXusZM3detkOFBQIbcCi5UOQIO/67h/jIWOQxPl8TQSoOiUEdk4qEmXVrqHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487651; c=relaxed/simple;
	bh=yk0UDJizu0Gg/sk7jV2vu0m5KM4mvy1JqT+TfUiNDNw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LlZTTehl6Tg4WHREp69JkIDZokeUQe7iR2go4xiV9Cxa+8fj8aYFZpTCUh2QhrN4G20yWpsTk9S5rGhO3/Inrl5oqY9Pv06jz5oF9RZE1nCD2bs8J8CqOQngaP8fCdtuPJPDX6oiorYDFFMkf99n77Xlrqt1DvMwmfwD9NE3MSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 653Bs7wS042845;
	Wed, 3 Jun 2026 20:54:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 653Bs7i3042842
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 20:54:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
Date: Wed, 3 Jun 2026 20:54:05 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ming Lei <tom.leiming@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
        Qu Wenruo <wqu@suse.com>, Hillf Danton <hdanton@sina.com>,
        Miguel Ojeda <ojeda@kernel.org>
References: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp>
 <4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org> <20260601071113.GB7468@lst.de>
 <420f723a-8168-4f56-b84a-2a36ecd87fea@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <420f723a-8168-4f56-b84a-2a36ecd87fea@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

The block core currently allocates a single monolithic lockdep key for
disk->open_mutex across all callers. This single key conflates locking
hierarchies between independent block streams. For example, if a stacked
driver like loop flushes its internal workqueues inside lo_release() while
holding its own open_mutex, lockdep views this as a potential ABBA deadlock
against the underlying storage stack, leading to numerous circular
dependency splats.

To structurally reduce false positives, this patch splits the global
monolithic lock class into distinct, per-caller instances during disk
allocation. This is done by replacing "struct lock_class_key" with
"struct gendisk_lkclass", which contains two instances of
"struct lock_class_key" for the legacy "(bio completion)" map and
disk->open_mutex respectively.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v3:
- Adjusted Rust part for safe pointer passing, pointed out by sashiko
  ( https://sashiko.dev/#/patchset/420f723a-8168-4f56-b84a-2a36ecd87fea%40I-love.SAKURA.ne.jp ) .

Changes in v2:
- Replaced a two-element array with a struct with two named members, suggested by Bart Van Assche
  ( https://lore.kernel.org/all/4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org/ ).
- Added changes needed by Rust block layer bindings and rnull module, pointed out by sashiko
  ( https://sashiko.dev/#/patchset/147ed056-03d9-4214-b925-0f10fc00cf27%40I-love.SAKURA.ne.jp ).

Testing result of v1:
- I kept v1 patch in linux-next for several more days, but result was that
  some of circular dependency splats which I thought this change succeeded to
  eliminate are still getting reported. That is, we need to determine whether
  we should make this change without example syzbot reports that demonstrates
  difference. But in general, keeping locking chains simpler and shorter
  should be a good change.

Acknowledgment:
  Since I have no experience with Rust, changes needed by Rust block layer
  bindings and rnull module are made based on conversation with the Gemini
  AI collaborator.

 block/blk-mq.c                   |  4 ++--
 block/blk.h                      |  2 +-
 block/genhd.c                    |  8 +++----
 drivers/block/rnull/rnull.rs     |  2 +-
 drivers/scsi/sd.c                |  2 +-
 drivers/scsi/sr.c                |  2 +-
 include/linux/blk-mq.h           |  6 ++---
 include/linux/blkdev.h           |  9 +++++--
 rust/kernel/block/mq.rs          |  2 +-
 rust/kernel/block/mq/gen_disk.rs | 41 ++++++++++++++++++++++++++++++--
 10 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a24175441380..5203e8cc6a28 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4492,7 +4492,7 @@ EXPORT_SYMBOL(blk_mq_destroy_queue);
 
 struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
 		struct queue_limits *lim, void *queuedata,
-		struct lock_class_key *lkclass)
+		struct gendisk_lkclass *lkclass)
 {
 	struct request_queue *q;
 	struct gendisk *disk;
@@ -4513,7 +4513,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
 EXPORT_SYMBOL(__blk_mq_alloc_disk);
 
 struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
-		struct lock_class_key *lkclass)
+		struct gendisk_lkclass *lkclass)
 {
 	struct gendisk *disk;
 
diff --git a/block/blk.h b/block/blk.h
index b998a7761faf..611bcd655357 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -614,7 +614,7 @@ void drop_partition(struct block_device *part);
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
-		struct lock_class_key *lkclass);
+		struct gendisk_lkclass *lkclass);
 struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
diff --git a/block/genhd.c b/block/genhd.c
index 7d6854fd28e9..8f4a3d8ca15e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1444,7 +1444,7 @@ dev_t part_devt(struct gendisk *disk, u8 partno)
 }
 
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
-		struct lock_class_key *lkclass)
+		struct gendisk_lkclass *lkclass)
 {
 	struct gendisk *disk;
 
@@ -1467,7 +1467,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		goto out_free_bdi;
 
 	disk->node_id = node_id;
-	mutex_init(&disk->open_mutex);
+	mutex_init_with_key(&disk->open_mutex, &lkclass->open_mutex_lkclass);
 	xa_init(&disk->part_tbl);
 	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
 		goto out_destroy_part_tbl;
@@ -1482,7 +1482,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	device_initialize(disk_to_dev(disk));
 	inc_diskseq(disk);
 	q->disk = disk;
-	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
+	lockdep_init_map(&disk->lockdep_map, "(bio completion)", &lkclass->bio_lkclass, 0);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&disk->slave_bdevs);
 #endif
@@ -1506,7 +1506,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 }
 
 struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
-		struct lock_class_key *lkclass)
+		struct gendisk_lkclass *lkclass)
 {
 	struct queue_limits default_lim = { };
 	struct request_queue *q;
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..476a8910c432 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -61,7 +61,7 @@ fn new(
             .logical_block_size(block_size)?
             .physical_block_size(block_size)?
             .rotational(rotational)
-            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
+            .build(fmt!("{}", name.to_str()?), tagset, queue_data, kernel::my_gendisk_lkclass!())
     }
 }
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 599e75f33334..63fe8c86606a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -112,7 +112,7 @@ static DEFINE_MUTEX(sd_mutex_lock);
 static mempool_t *sd_page_pool;
 static mempool_t *sd_large_page_pool;
 static atomic_t sd_large_page_pool_users = ATOMIC_INIT(0);
-static struct lock_class_key sd_bio_compl_lkclass;
+static struct gendisk_lkclass sd_bio_compl_lkclass;
 
 static const char *sd_cache_types[] = {
 	"write through", "none", "write back",
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index c36c54ecd354..734567ae0e43 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -106,7 +106,7 @@ static struct scsi_driver sr_template = {
 static unsigned long sr_index_bits[SR_DISKS / BITS_PER_LONG];
 static DEFINE_SPINLOCK(sr_index_lock);
 
-static struct lock_class_key sr_bio_compl_lkclass;
+static struct gendisk_lkclass sr_bio_compl_lkclass;
 
 static int sr_open(struct cdrom_device_info *, int);
 static void sr_release(struct cdrom_device_info *);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..5aa17e82c3ba 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -726,15 +726,15 @@ enum {
 
 struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
 		struct queue_limits *lim, void *queuedata,
-		struct lock_class_key *lkclass);
+		struct gendisk_lkclass *lkclass);
 #define blk_mq_alloc_disk(set, lim, queuedata)				\
 ({									\
-	static struct lock_class_key __key;				\
+	static struct gendisk_lkclass __key;				\
 									\
 	__blk_mq_alloc_disk(set, lim, queuedata, &__key);		\
 })
 struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
-		struct lock_class_key *lkclass);
+		struct gendisk_lkclass *lkclass);
 struct request_queue *blk_mq_alloc_queue(struct blk_mq_tag_set *set,
 		struct queue_limits *lim, void *queuedata);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1c..28b0aee6b3ba 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -49,6 +49,11 @@ extern const struct device_type disk_type;
 extern const struct device_type part_type;
 extern const struct class block_class;
 
+struct gendisk_lkclass {
+	struct lock_class_key bio_lkclass;
+	struct lock_class_key open_mutex_lkclass;
+};
+
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
@@ -974,7 +979,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 
 void put_disk(struct gendisk *disk);
 struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
-		struct lock_class_key *lkclass);
+		struct gendisk_lkclass *lkclass);
 
 /**
  * blk_alloc_disk - allocate a gendisk structure
@@ -990,7 +995,7 @@ struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
  */
 #define blk_alloc_disk(lim, node_id)					\
 ({									\
-	static struct lock_class_key __key;				\
+	static struct gendisk_lkclass __key;				\
 									\
 	__blk_alloc_disk(lim, node_id, &__key);				\
 })
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1fd0d54dd549..10f22b200567 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -88,7 +88,7 @@
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(fmt!("myblk"), tagset, ())?;
+//!     .build(fmt!("myblk"), tagset, (), kernel::my_gendisk_lkclass!())?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..7e669ca5c032 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -11,7 +11,6 @@
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
     prelude::*,
-    static_lock_class,
     str::NullTerminatedFormatter,
     sync::Arc,
     types::{ForeignOwnable, ScopeGuard},
@@ -38,6 +37,43 @@ fn default() -> Self {
     }
 }
 
+/// A wrapper type for safely passing "struct gendisk_lkclass" argument.
+///
+/// This type can only be instantiated via the [`my_gendisk_lkclass!`] macro.
+pub struct GenDiskLockClass(pub(crate) *mut bindings::gendisk_lkclass);
+
+impl GenDiskLockClass {
+    /// Retrieve the underlying raw pointer.
+    pub(crate) fn as_ptr(&self) -> *mut bindings::gendisk_lkclass {
+        self.0
+    }
+}
+
+#[doc(hidden)]
+pub mod __internal {
+    use super::*;
+
+    /// Internal constructor used ONLY by the `my_gendisk_lkclass!` macro.
+    ///
+    /// SAFETY: `ptr` must point to a valid static `gendisk_lkclass` instance.
+    pub const unsafe fn new_lock_class(ptr: *mut bindings::gendisk_lkclass) -> GenDiskLockClass {
+        GenDiskLockClass(ptr)
+    }
+}
+
+/// Helper macro to generate a unique caller-local static lock class struct
+#[macro_export]
+macro_rules! my_gendisk_lkclass {
+    () => {{
+        static mut LKCLASS: $crate::bindings::gendisk_lkclass = $crate::bindings::gendisk_lkclass {
+            bio_lkclass: const { unsafe { ::core::mem::zeroed() } },
+            open_mutex_lkclass: const { unsafe { ::core::mem::zeroed() } },
+        };
+
+        unsafe { $crate::block::mq::gen_disk::__internal::new_lock_class(&raw mut LKCLASS) }
+    }};
+}
+
 impl GenDiskBuilder {
     /// Create a new instance.
     pub fn new() -> Self {
@@ -100,6 +136,7 @@ pub fn build<T: Operations>(
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
         queue_data: T::QueueData,
+        lkclass: GenDiskLockClass,
     ) -> Result<GenDisk<T>> {
         let data = queue_data.into_foreign();
         let recover_data = ScopeGuard::new(|| {
@@ -121,7 +158,7 @@ pub fn build<T: Operations>(
                 tagset.raw_tag_set(),
                 &mut lim,
                 data,
-                static_lock_class!().as_ptr(),
+                lkclass.as_ptr(),
             )
         })?;
 
-- 
2.54.0

