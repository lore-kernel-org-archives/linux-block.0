Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A547C04FDF
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjHHR5a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjHHR5G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248002AF3D
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31E346257F
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 13:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C150C433C9;
        Tue,  8 Aug 2023 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691503025;
        bh=q0UMnLgh+qnvgb/WpUXo/mLo5zZmtaZJkd+8lzC+LP0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MOtds5O1sqJFMWHw4xUNhkjbslLg0PHbungJSTDVOz9p01G4VMr1v/6aj3UjMudg/
         2KA0nge7GdIQJtW12yGJu8/opKcQmzLIMkR1GEvrAJnO6s6bCDbH9TGx60t8YBGw+k
         C9qx/5OQn7WbkIARwbjfpp1pa+3jWmV7WjKyLtrVbOh6w26uCMCNaUB3R2FFUryR33
         cH67SSjGUkqDJZVx4uw3/efThMB+NpM+oBb1Qo3Z4a0z8Bngo7SC0XUkx5/O2tF9od
         KeVAozKFvZGBCihQLb+L2GKR3G+iP574P6ovyXtmT501rTk86C87NE6EL5GUNkQxeO
         BslOrL9SYnMMA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 2/5] block: use pr_xxx() instead of printk()
Date:   Tue,  8 Aug 2023 22:56:59 +0900
Message-ID: <20230808135702.628588-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808135702.628588-1-dlemoal@kernel.org>
References: <20230808135702.628588-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the remaining calls to printk() in the block layer core code
with the equivalent pr_info(), pr_err() etc calls. The early block
device lookup code in early-lookup.c is left untouched and continues
using raw printk() calls.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/bio-integrity.c | 11 +++++++----
 block/blk-ioc.c       |  5 ++++-
 block/blk-mq.c        | 25 ++++++++++++++-----------
 block/blk-settings.c  | 19 +++++++++++--------
 block/bsg.c           |  7 +++++--
 block/elevator.c      |  5 ++++-
 block/genhd.c         |  7 +++++--
 7 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 045553a164e0..a2b5213d1ae8 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -14,6 +14,9 @@
 #include <linux/slab.h>
 #include "blk.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "bio-integrity: " fmt
+
 static struct kmem_cache *bip_slab;
 static struct workqueue_struct *kintegrityd_wq;
 
@@ -126,7 +129,7 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
 	if (bip->bip_vcnt >= bip->bip_max_vcnt) {
-		printk(KERN_ERR "%s: bip_vec full\n", __func__);
+		pr_err("%s: bip_vec full\n", __func__);
 		return 0;
 	}
 
@@ -227,7 +230,7 @@ bool bio_integrity_prep(struct bio *bio)
 	len = bio_integrity_bytes(bi, bio_sectors(bio));
 	buf = kmalloc(len, GFP_NOIO);
 	if (unlikely(buf == NULL)) {
-		printk(KERN_ERR "could not allocate integrity buffer\n");
+		pr_err("could not allocate integrity buffer\n");
 		goto err_end_io;
 	}
 
@@ -238,7 +241,7 @@ bool bio_integrity_prep(struct bio *bio)
 	/* Allocate bio integrity payload and integrity vectors */
 	bip = bio_integrity_alloc(bio, GFP_NOIO, nr_pages);
 	if (IS_ERR(bip)) {
-		printk(KERN_ERR "could not allocate data integrity bioset\n");
+		pr_err("could not allocate data integrity bioset\n");
 		kfree(buf);
 		goto err_end_io;
 	}
@@ -266,7 +269,7 @@ bool bio_integrity_prep(struct bio *bio)
 					     bytes, offset);
 
 		if (ret == 0) {
-			printk(KERN_ERR "could not attach integrity payload\n");
+			pr_err("could not attach integrity payload\n");
 			goto err_end_io;
 		}
 
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 25dd4db11121..b1c17b56396c 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -14,6 +14,9 @@
 #include "blk.h"
 #include "blk-mq-sched.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "blk-ioc: " fmt
+
 /*
  * For io context allocations
  */
@@ -395,7 +398,7 @@ static struct io_cq *ioc_create_icq(struct request_queue *q)
 		kmem_cache_free(et->icq_cache, icq);
 		icq = ioc_lookup_icq(q);
 		if (!icq)
-			printk(KERN_ERR "cfq: icq link failed!\n");
+			pr_err("icq link failed!\n");
 	}
 
 	spin_unlock(&ioc->lock);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f14b8669ac69..26eb36e3e12e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -42,6 +42,9 @@
 #include "blk-rq-qos.h"
 #include "blk-ioprio.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "blk-mq: " fmt
+
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
 
@@ -733,15 +736,15 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 
 void blk_dump_rq_flags(struct request *rq, char *msg)
 {
-	printk(KERN_INFO "%s: dev %s: flags=%llx\n", msg,
+	pr_info("%s: dev %s: flags=%llx\n", msg,
 		rq->q->disk ? rq->q->disk->disk_name : "?",
 		(__force unsigned long long) rq->cmd_flags);
 
-	printk(KERN_INFO "  sector %llu, nr/cnr %u/%u\n",
-	       (unsigned long long)blk_rq_pos(rq),
-	       blk_rq_sectors(rq), blk_rq_cur_sectors(rq));
-	printk(KERN_INFO "  bio %p, biotail %p, len %u\n",
-	       rq->bio, rq->biotail, blk_rq_bytes(rq));
+	pr_info("  sector %llu, nr/cnr %u/%u\n",
+		(unsigned long long)blk_rq_pos(rq),
+		blk_rq_sectors(rq), blk_rq_cur_sectors(rq));
+	pr_info("  bio %p, biotail %p, len %u\n",
+		rq->bio, rq->biotail, blk_rq_bytes(rq));
 }
 EXPORT_SYMBOL(blk_dump_rq_flags);
 
@@ -783,7 +786,7 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 
 static void blk_print_req_error(struct request *req, blk_status_t status)
 {
-	printk_ratelimited(KERN_ERR
+	pr_err_ratelimited(
 		"%s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
 		"phys_seg %u prio class %u\n",
 		blk_status_to_str(status),
@@ -3032,8 +3035,8 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 		if (max_sectors == 0)
 			return BLK_STS_NOTSUPP;
 
-		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
-			__func__, blk_rq_sectors(rq), max_sectors);
+		pr_err("%s: over max size limit. (%u > %u)\n",
+		       __func__, blk_rq_sectors(rq), max_sectors);
 		return BLK_STS_IOERR;
 	}
 
@@ -3043,8 +3046,8 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	 */
 	rq->nr_phys_segments = blk_recalc_rq_segments(rq);
 	if (rq->nr_phys_segments > max_segments) {
-		printk(KERN_ERR "%s: over max segments limit. (%u > %u)\n",
-			__func__, rq->nr_phys_segments, max_segments);
+		pr_err("%s: over max segments limit. (%u > %u)\n",
+		       __func__, rq->nr_phys_segments, max_segments);
 		return BLK_STS_IOERR;
 	}
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 5e2dbd34436b..25d119187eab 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -19,6 +19,9 @@
 #include "blk-rq-qos.h"
 #include "blk-wbt.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "blk-settings: " fmt
+
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 {
 	q->rq_timeout = timeout;
@@ -127,8 +130,8 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 
 	if ((max_hw_sectors << 9) < PAGE_SIZE) {
 		max_hw_sectors = 1 << PAGE_SECTORS_SHIFT;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_hw_sectors);
+		pr_info("Set max_hw_sectors to minimum %u\n",
+			max_hw_sectors);
 	}
 
 	max_hw_sectors = round_down(max_hw_sectors,
@@ -248,8 +251,8 @@ void blk_queue_max_segments(struct request_queue *q, unsigned short max_segments
 {
 	if (!max_segments) {
 		max_segments = 1;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_segments);
+		pr_info("Set max_segments to minimum %u\n",
+			max_segments);
 	}
 
 	q->limits.max_segments = max_segments;
@@ -285,8 +288,8 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
 	if (max_size < PAGE_SIZE) {
 		max_size = PAGE_SIZE;
-		printk(KERN_INFO "%s: set to minimum %d\n",
-		       __func__, max_size);
+		pr_info("Set max_segment_size to minimum %u\n",
+			max_size);
 	}
 
 	/* see blk_queue_virt_boundary() for the explanation */
@@ -740,8 +743,8 @@ void blk_queue_segment_boundary(struct request_queue *q, unsigned long mask)
 {
 	if (mask < PAGE_SIZE - 1) {
 		mask = PAGE_SIZE - 1;
-		printk(KERN_INFO "%s: set to minimum %lx\n",
-		       __func__, mask);
+		pr_info("Set segment_boundary to minimum %lx\n",
+			mask);
 	}
 
 	q->limits.seg_boundary_mask = mask;
diff --git a/block/bsg.c b/block/bsg.c
index 72157a59b788..298fe90923b8 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -17,6 +17,9 @@
 #include <scsi/scsi_ioctl.h>
 #include <scsi/sg.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #define BSG_DESCRIPTION	"Block layer SCSI generic (bsg) driver"
 #define BSG_VERSION	"0.4"
 
@@ -261,8 +264,8 @@ static int __init bsg_init(void)
 		goto destroy_bsg_class;
 	bsg_major = MAJOR(devid);
 
-	printk(KERN_INFO BSG_DESCRIPTION " version " BSG_VERSION
-	       " loaded (major %d)\n", bsg_major);
+	pr_info(BSG_DESCRIPTION " version " BSG_VERSION
+		" loaded (major %d)\n", bsg_major);
 	return 0;
 
 destroy_bsg_class:
diff --git a/block/elevator.c b/block/elevator.c
index 8400e303fbcb..3b7ec9fb1abf 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -45,6 +45,9 @@
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "elevator: " fmt
+
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -527,7 +530,7 @@ int elv_register(struct elevator_type *e)
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock(&elv_list_lock);
 
-	printk(KERN_INFO "io scheduler %s registered\n", e->elevator_name);
+	pr_info("io scheduler %s registered\n", e->elevator_name);
 
 	return 0;
 }
diff --git a/block/genhd.c b/block/genhd.c
index 3d287b32d50d..4653d94b1751 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -33,6 +33,9 @@
 #include "blk-rq-qos.h"
 #include "blk-cgroup.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "genhd: " fmt
+
 static struct kobject *block_depr;
 
 /*
@@ -227,7 +230,7 @@ int __register_blkdev(unsigned int major, const char *name,
 		}
 
 		if (index == 0) {
-			printk("%s: failed to get major for %s\n",
+			pr_err("%s: Failed to get major for %s\n",
 			       __func__, name);
 			ret = -EBUSY;
 			goto out;
@@ -270,7 +273,7 @@ int __register_blkdev(unsigned int major, const char *name,
 	spin_unlock(&major_names_spinlock);
 
 	if (ret < 0) {
-		printk("register_blkdev: cannot get major %u for %s\n",
+		pr_err("register_blkdev: cannot get major %u for %s\n",
 		       major, name);
 		kfree(p);
 	}
-- 
2.41.0

