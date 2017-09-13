Return-Path: <philipp.guendisch@fau.de>
From: Philipp Guendisch <philipp.guendisch@fau.de>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	damien.lemoal@wdc.com,
	axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	bart.vanassche@sandisk.com,
	martin.petersen@oracle.com,
	hare@suse.de,
	osandov@fb.com,
	dan.j.williams@intel.com,
	ming.lei@redhat.com,
	linux-kernel@i4.cs.fau.de,
	Philipp Guendisch <philipp.guendisch@fau.de>,
	Mate Horvath <horvatmate@gmail.com>
Subject: [PATCH] Support for secure erase functionality
Date: Wed, 13 Sep 2017 17:37:53 +0200
Message-Id: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de>
List-ID: <linux-block@vger.kernel.org>

This patch adds a software based secure erase option to improve data
confidentiality. The CONFIG_BLK_DEV_SECURE_ERASE option enables a mount
flag called 'sw_secure_erase'. When you mount a volume with this flag,
every discard call is prepended by an explicit write command to overwrite
the data before it is discarded. A volume without a discard compatibility
can be used as well but the discard calls will be enabled for this device
and suppressed after the write call is made.

Built against torvalds/linux

Signed-off-by: Philipp Guendisch <philipp.guendisch@fau.de>
Signed-off-by: Mate Horvath <horvatmate@gmail.com>
---
 block/Kconfig          | 14 ++++++++
 block/blk-lib.c        | 86 +++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/super.c             | 59 ++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 14 ++++++++
 4 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 3ab42bb..438da83 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -103,6 +103,20 @@ config BLK_DEV_ZONED
 
 	Say yes here if you have a ZAC or ZBC storage device.
 
+config BLK_DEV_SECURE_ERASE
+	bool "Block layer secure erase support (EXPERIMENTAL)"
+	default n
+	---help---
+	With this option set, every discard operation will be prepended by
+	a write operation which overwrites the data with random values.
+	Use this option for a secure deletion of data.
+
+	WARNING:
+	Due to unpredictable circumstances we cannot guarantee you that your
+	data will be irrecoverably deleted in every case.
+	This option also increases the amount of data written to block
+	devices which may reduce their lifetime.
+
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP=y
diff --git a/block/blk-lib.c b/block/blk-lib.c
index e01adb5..949a666 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -6,6 +6,9 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
+#ifdef CONFIG_BLK_DEV_SECURE_ERASE
+#include <linux/random.h>
+#endif
 
 #include "blk.h"
 
@@ -22,6 +25,60 @@ static struct bio *next_bio(struct bio *bio, unsigned int nr_pages,
 	return new;
 }
 
+/*
+ * __blkdev_secure_erase - erase data queued for discard
+ * @bdev:	blockdev to issue discard for
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to discard
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * Description:
+ *    Overwrites sectors issued to discard with random data before discarding
+ */
+#ifdef CONFIG_BLK_DEV_SECURE_ERASE
+static unsigned int __blkdev_sectors_to_bio_pages(sector_t nr_sects);
+static void __blkdev_secure_erase(struct block_device *bdev, sector_t sector,
+				  sector_t nr_sects, gfp_t gfp_mask,
+				  struct bio **biop)
+{
+	struct bio *bio = *biop;
+	int bi_size = 0;
+	static struct page *datapage;
+	void *page_cont;
+	static unsigned int count = 1;
+	unsigned int sz;
+
+	if (unlikely(!datapage))
+		datapage = alloc_page(GFP_NOIO);
+
+	if (unlikely(count % 64 == 1)) {
+		page_cont = kmap(datapage);
+		get_random_bytes(page_cont, PAGE_SIZE);
+		kunmap(datapage);
+	}
+	count++;
+
+	while (nr_sects != 0) {
+		bio = next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
+			       gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+		bio_set_dev(bio, bdev);
+		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
+
+		while (nr_sects != 0) {
+			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
+			bi_size = bio_add_page(bio, datapage, sz, 0);
+			nr_sects -= bi_size >> 9;
+			sector += bi_size >> 9;
+			if (bi_size < sz)
+				break;
+		}
+		cond_resched();
+	}
+}
+#endif
+
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop)
@@ -29,13 +86,14 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
 	unsigned int granularity;
-	unsigned int op;
+	unsigned int op = REQ_OP_DISCARD;
 	int alignment;
 	sector_t bs_mask;
 
 	if (!q)
 		return -ENXIO;
 
+#ifndef CONFIG_BLK_DEV_SECURE_ERASE
 	if (flags & BLKDEV_DISCARD_SECURE) {
 		if (!blk_queue_secure_erase(q))
 			return -EOPNOTSUPP;
@@ -45,6 +103,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 			return -EOPNOTSUPP;
 		op = REQ_OP_DISCARD;
 	}
+#endif
 
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	if ((sector | nr_sects) & bs_mask)
@@ -54,6 +113,31 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	granularity = max(q->limits.discard_granularity >> 9, 1U);
 	alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
 
+#ifdef CONFIG_BLK_DEV_SECURE_ERASE
+	if (!(bdev->bd_queue->sec_erase_flags & SECURE_ERASE_FLAG_ACTIVATED))
+		goto skip;
+
+	if (flags & BLKDEV_DISCARD_SECURE) {
+		if (blk_queue_secure_erase(q)) {
+			op = REQ_OP_SECURE_ERASE;
+			goto skip;
+		}
+	}
+
+	__blkdev_secure_erase(bdev, sector, nr_sects, gfp_mask, &bio);
+
+	/*
+	 * If the device originally did not support
+	 * discards it should not finish this function
+	 */
+	if (!(bdev->bd_queue->sec_erase_flags &
+	      SECURE_ERASE_FLAG_DISCARD_CAPABLE)) {
+		*biop = bio;
+		return 0;
+	}
+
+skip:
+#endif
 	while (nr_sects) {
 		unsigned int req_sects;
 		sector_t end_sect, tmp;
diff --git a/fs/super.c b/fs/super.c
index 221cfa1..b66edba 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1070,6 +1070,14 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	struct super_block *s;
 	fmode_t mode = FMODE_READ | FMODE_EXCL;
 	int error = 0;
+#ifdef CONFIG_BLK_DEV_SECURE_ERASE
+	struct request_queue *q;
+	int option_length;
+	char *data_string = data;
+	char *option_string = data;
+	char *se_opt = "sw_secure_erase";
+	int se_opt_len = strlen(se_opt);
+#endif
 
 	if (!(flags & MS_RDONLY))
 		mode |= FMODE_WRITE;
@@ -1078,6 +1086,46 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
+#ifdef CONFIG_BLK_DEV_SECURE_ERASE
+	q = bdev->bd_queue;
+	if (option_string == NULL || (flags & MS_RDONLY))
+		goto skip;
+	option_string = strstr(option_string, se_opt);
+	if (option_string) {
+		if (blk_queue_discard(q))
+			q->sec_erase_flags |= SECURE_ERASE_FLAG_DISCARD_CAPABLE;
+		else
+			__set_bit(QUEUE_FLAG_DISCARD, &q->queue_flags);
+
+		q->sec_erase_flags |= SECURE_ERASE_FLAG_ACTIVATED;
+		option_length = strlen(option_string);
+		if (option_string != data_string) {
+			if (option_string[se_opt_len] == '\0') {
+				*(option_string-1) = '\0';
+			} else {
+				memmove(option_string,
+					&option_string[se_opt_len+1],
+					strlen(&option_string[se_opt_len+1])+1);
+			}
+		} else { /* first or only option */
+			if (option_string[se_opt_len] == ',')
+				data = &option_string[se_opt_len+1];
+			else if (option_string[se_opt_len] == '\0')
+				data = NULL;
+		}
+	}
+	if (strcmp(fs_type->name, "ext4") != 0 &&
+	    strcmp(fs_type->name, "btrfs") != 0 &&
+	    strcmp(fs_type->name, "gfs2") != 0 &&
+	    strcmp(fs_type->name, "gfs2meta") != 0 &&
+	    strcmp(fs_type->name, "xfs") != 0 &&
+	    strcmp(fs_type->name, "jfs") != 0) {
+		pr_warn("fs: The mounted %s filesystem on drive %s does not generate discards, secure erase won't work",
+				fs_type->name, dev_name);
+	}
+skip:
+#endif
+
 	/*
 	 * once the super is inserted into the list by sget, s_umount
 	 * will protect the lockfs code from trying to start a snapshot
@@ -1147,6 +1195,17 @@ void kill_block_super(struct super_block *sb)
 	sync_blockdev(bdev);
 	WARN_ON_ONCE(!(mode & FMODE_EXCL));
 	blkdev_put(bdev, mode | FMODE_EXCL);
+#ifdef CONFIG_BLK_DEV_SECURE_ERASE
+	if (bdev->bd_queue->sec_erase_flags & SECURE_ERASE_FLAG_ACTIVATED) {
+		if (!(bdev->bd_queue->sec_erase_flags &
+		      SECURE_ERASE_FLAG_DISCARD_CAPABLE)) {
+			WARN_ON(!blk_queue_discard(bdev->bd_queue));
+			bdev->bd_queue->queue_flags ^=
+						    (1 << QUEUE_FLAG_DISCARD);
+		}
+		bdev->bd_queue->sec_erase_flags = 0;
+	}
+#endif
 }
 
 EXPORT_SYMBOL(kill_block_super);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 460294b..316a97d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -596,6 +596,14 @@ struct request_queue {
 
 	struct work_struct	release_work;
 
+/*
+ * These flags are needed for the software implemented version
+ * of the secure erase functionality
+ */
+#ifdef CONFIG_BLK_DEV_SECURE_ERASE
+	unsigned char		sec_erase_flags;
+#endif
+
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
@@ -641,6 +649,12 @@ struct request_queue {
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
 				 (1 << QUEUE_FLAG_POLL))
 
+/* Needed for the secure erase functionality */
+#ifdef CONFIG_BLK_DEV_SECURE_ERASE
+#define SECURE_ERASE_FLAG_DISCARD_CAPABLE	1
+#define SECURE_ERASE_FLAG_ACTIVATED		2
+#endif
+
 /*
  * @q->queue_lock is set while a queue is being initialized. Since we know
  * that no other threads access the queue object before @q->queue_lock has
-- 
2.7.4
