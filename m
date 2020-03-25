Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDE3C43331
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 11:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726D320714
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 11:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VdjDfVHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCYLGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:06:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCYLGM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 07:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=66QEy6kErXjOLdZeS1xCuLI656U3NyRdGfVzHu8jlTE=; b=VdjDfVHg40uYSmgKAONEuDLEsY
        1cxst8eEeZ3Gn9fllM2vSLsun4IzGtdtPqa0idyRhqvmT1pIkj6Y45XuvHZJZPtKfz3Dtz91cWpC+
        Pm9S/N3sppV5MKs369ZG/S1sP6ddPkobWYkwaNHbKeJqohDNqEb0MjpJCNWz6GXbP+4NXL6FGY/54
        ZC6b7TwXNjCIF6fXH8chaG5OnPUS2j8IFgHZlCsgfivRjWLGteGfLD7zVdBSO3knyZ5hzmV8hsnmq
        wq9hrK2KBWBfBf57oBKGW5ka/qF/YcKgq248l4b0vcMZ05jjlapBea/2aCnK/3f86LrxNGVFmz3g8
        0wI6R7NQ==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3rQ-00039Z-3b; Wed, 25 Mar 2020 11:06:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] block: move block layer internals out of include/linux/genhd.h
Date:   Wed, 25 Mar 2020 12:03:37 +0100
Message-Id: <20200325110338.1029232-8-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325110338.1029232-1-hch@lst.de>
References: <20200325110338.1029232-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

None of this needs to be exposed to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h              | 116 +++++++++++++++++++++++++++++++++++++
 block/ioctl.c            |   1 +
 block/partitions/check.h |   1 +
 block/partitions/core.c  |   1 -
 include/linux/genhd.h    | 120 ---------------------------------------
 5 files changed, 118 insertions(+), 121 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 43df9dcb3d4e..224340be4c7a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -149,6 +149,9 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 	return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
 				bip_next->bip_vec[0].bv_offset);
 }
+
+void blk_integrity_add(struct gendisk *);
+void blk_integrity_del(struct gendisk *);
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline bool integrity_req_gap_back_merge(struct request *req,
 		struct bio *next)
@@ -171,6 +174,12 @@ static inline bool bio_integrity_endio(struct bio *bio)
 static inline void bio_integrity_free(struct bio *bio)
 {
 }
+static inline void blk_integrity_add(struct gendisk *disk)
+{
+}
+static inline void blk_integrity_del(struct gendisk *disk)
+{
+}
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 unsigned long blk_rq_timeout(unsigned long timeout);
@@ -365,4 +374,111 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 #endif
 
+void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
+			int rw);
+void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,
+			int rw);
+void update_io_ticks(struct hd_struct *part, unsigned long now);
+struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
+
+int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
+void blk_free_devt(dev_t devt);
+void blk_invalidate_devt(dev_t devt);
+char *disk_name(struct gendisk *hd, int partno, char *buf);
+#define ADDPART_FLAG_NONE	0
+#define ADDPART_FLAG_RAID	1
+#define ADDPART_FLAG_WHOLEDISK	2
+struct hd_struct *__must_check add_partition(struct gendisk *disk, int partno,
+		sector_t start, sector_t len, int flags,
+		struct partition_meta_info *info);
+void __delete_partition(struct percpu_ref *ref);
+void delete_partition(struct gendisk *disk, int partno);
+int disk_expand_part_tbl(struct gendisk *disk, int target);
+
+static inline int hd_ref_init(struct hd_struct *part)
+{
+	if (percpu_ref_init(&part->ref, __delete_partition, 0,
+				GFP_KERNEL))
+		return -ENOMEM;
+	return 0;
+}
+
+static inline void hd_struct_get(struct hd_struct *part)
+{
+	percpu_ref_get(&part->ref);
+}
+
+static inline int hd_struct_try_get(struct hd_struct *part)
+{
+	return percpu_ref_tryget_live(&part->ref);
+}
+
+static inline void hd_struct_put(struct hd_struct *part)
+{
+	percpu_ref_put(&part->ref);
+}
+
+static inline void hd_struct_kill(struct hd_struct *part)
+{
+	percpu_ref_kill(&part->ref);
+}
+
+static inline void hd_free_part(struct hd_struct *part)
+{
+	free_part_stats(part);
+	kfree(part->info);
+	percpu_ref_exit(&part->ref);
+}
+
+/*
+ * Any access of part->nr_sects which is not protected by partition
+ * bd_mutex or gendisk bdev bd_mutex, should be done using this
+ * accessor function.
+ *
+ * Code written along the lines of i_size_read() and i_size_write().
+ * CONFIG_PREEMPTION case optimizes the case of UP kernel with preemption
+ * on.
+ */
+static inline sector_t part_nr_sects_read(struct hd_struct *part)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	sector_t nr_sects;
+	unsigned seq;
+	do {
+		seq = read_seqcount_begin(&part->nr_sects_seq);
+		nr_sects = part->nr_sects;
+	} while (read_seqcount_retry(&part->nr_sects_seq, seq));
+	return nr_sects;
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
+	sector_t nr_sects;
+
+	preempt_disable();
+	nr_sects = part->nr_sects;
+	preempt_enable();
+	return nr_sects;
+#else
+	return part->nr_sects;
+#endif
+}
+
+/*
+ * Should be called with mutex lock held (typically bd_mutex) of partition
+ * to provide mutual exlusion among writers otherwise seqcount might be
+ * left in wrong state leaving the readers spinning infinitely.
+ */
+static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	write_seqcount_begin(&part->nr_sects_seq);
+	part->nr_sects = size;
+	write_seqcount_end(&part->nr_sects_seq);
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
+	preempt_disable();
+	part->nr_sects = size;
+	preempt_enable();
+#else
+	part->nr_sects = size;
+#endif
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/ioctl.c b/block/ioctl.c
index 127194b9f9bd..6e827de1a4c4 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -11,6 +11,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/pr.h>
 #include <linux/uaccess.h>
+#include "blk.h"
 
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
diff --git a/block/partitions/check.h b/block/partitions/check.h
index f845355489ec..c577e9ee67f0 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -2,6 +2,7 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
+#include "../blk.h"
 
 /*
  * add_gd_partition adds a partitions details to the devices partition
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b442bc209b86..b79c4513629b 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,7 +10,6 @@
 #include <linux/vmalloc.h>
 #include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
-#include "../blk.h"
 #include "check.h"
 
 static int (*check_part[])(struct parsed_partitions *) = {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 18fd9e01c511..8156cb35ff1f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -299,9 +299,6 @@ extern void disk_part_iter_init(struct disk_part_iter *piter,
 extern struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter);
 extern void disk_part_iter_exit(struct disk_part_iter *piter);
 
-extern struct hd_struct *disk_map_sector_rcu(struct gendisk *disk,
-					     sector_t sector);
-
 /*
  * Macros to operate on percpu disk statistics:
  *
@@ -413,13 +410,6 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_local_read_cpu(gendiskp, field, cpu)			\
 	local_read(&(part_stat_get_cpu(gendiskp, field, cpu)))
 
-void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
-			int rw);
-void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,
-			int rw);
-
-void update_io_ticks(struct hd_struct *part, unsigned long now);
-
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk,
 			    const struct attribute_group **groups);
@@ -469,27 +459,11 @@ static inline void set_capacity(struct gendisk *disk, sector_t size)
 	disk->part0.nr_sects = size;
 }
 
-#define ADDPART_FLAG_NONE	0
-#define ADDPART_FLAG_RAID	1
-#define ADDPART_FLAG_WHOLEDISK	2
-
-extern int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
-extern void blk_free_devt(dev_t devt);
-extern void blk_invalidate_devt(dev_t devt);
 extern dev_t blk_lookup_devt(const char *name, int partno);
-extern char *disk_name (struct gendisk *hd, int partno, char *buf);
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev);
-extern int disk_expand_part_tbl(struct gendisk *disk, int target);
-extern struct hd_struct * __must_check add_partition(struct gendisk *disk,
-						     int partno, sector_t start,
-						     sector_t len, int flags,
-						     struct partition_meta_info
-						       *info);
-extern void __delete_partition(struct percpu_ref *);
-extern void delete_partition(struct gendisk *, int);
 extern void printk_all_partitions(void);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
@@ -521,100 +495,6 @@ extern void blk_unregister_region(dev_t devt, unsigned long range);
 
 #define alloc_disk(minors) alloc_disk_node(minors, NUMA_NO_NODE)
 
-static inline int hd_ref_init(struct hd_struct *part)
-{
-	if (percpu_ref_init(&part->ref, __delete_partition, 0,
-				GFP_KERNEL))
-		return -ENOMEM;
-	return 0;
-}
-
-static inline void hd_struct_get(struct hd_struct *part)
-{
-	percpu_ref_get(&part->ref);
-}
-
-static inline int hd_struct_try_get(struct hd_struct *part)
-{
-	return percpu_ref_tryget_live(&part->ref);
-}
-
-static inline void hd_struct_put(struct hd_struct *part)
-{
-	percpu_ref_put(&part->ref);
-}
-
-static inline void hd_struct_kill(struct hd_struct *part)
-{
-	percpu_ref_kill(&part->ref);
-}
-
-static inline void hd_free_part(struct hd_struct *part)
-{
-	free_part_stats(part);
-	kfree(part->info);
-	percpu_ref_exit(&part->ref);
-}
-
-/*
- * Any access of part->nr_sects which is not protected by partition
- * bd_mutex or gendisk bdev bd_mutex, should be done using this
- * accessor function.
- *
- * Code written along the lines of i_size_read() and i_size_write().
- * CONFIG_PREEMPTION case optimizes the case of UP kernel with preemption
- * on.
- */
-static inline sector_t part_nr_sects_read(struct hd_struct *part)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	sector_t nr_sects;
-	unsigned seq;
-	do {
-		seq = read_seqcount_begin(&part->nr_sects_seq);
-		nr_sects = part->nr_sects;
-	} while (read_seqcount_retry(&part->nr_sects_seq, seq));
-	return nr_sects;
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
-	sector_t nr_sects;
-
-	preempt_disable();
-	nr_sects = part->nr_sects;
-	preempt_enable();
-	return nr_sects;
-#else
-	return part->nr_sects;
-#endif
-}
-
-/*
- * Should be called with mutex lock held (typically bd_mutex) of partition
- * to provide mutual exlusion among writers otherwise seqcount might be
- * left in wrong state leaving the readers spinning infinitely.
- */
-static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
-{
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	write_seqcount_begin(&part->nr_sects_seq);
-	part->nr_sects = size;
-	write_seqcount_end(&part->nr_sects_seq);
-#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
-	preempt_disable();
-	part->nr_sects = size;
-	preempt_enable();
-#else
-	part->nr_sects = size;
-#endif
-}
-
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
-extern void blk_integrity_add(struct gendisk *);
-extern void blk_integrity_del(struct gendisk *);
-#else	/* CONFIG_BLK_DEV_INTEGRITY */
-static inline void blk_integrity_add(struct gendisk *disk) { }
-static inline void blk_integrity_del(struct gendisk *disk) { }
-#endif	/* CONFIG_BLK_DEV_INTEGRITY */
-
 #else /* CONFIG_BLOCK */
 
 static inline void printk_all_partitions(void) { }
-- 
2.25.1

