Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D176CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BD760F6B
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 11:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbhITL14 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhITL1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 07:27:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC5C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U82b/stVTDz5lYW/LsyXom8j/HNBpqRvkv4zSa4ufeo=; b=hB1yqG7gEfnj+/UNxq3PjvBjFP
        KzGeubW71YUdcrPiWHH6hrnkWf57VqeQG410ctJRzeDjc2mDxB0w+2OWKeyS+PDLK1by7wD6oZ/xc
        HthMV7Rm6553d2Bo/3YjUL+D0rcQH/prgvU5G2wcgqU47nLRpRpu5WkCnpYAQ0Gt6g1cZqjjUAhnZ
        SK6n9yXFrjIgLxn0UxWrqLF2tER7UZS5bhiYW9GojC5B8kZ4XCyF2gDTYb9OcR4VJVI/gOV1OuMT7
        ooym6ahiq+OHMomgyvIkLf5Wihdgrg7AB+zpDAX6AwH5l5FuC7vmWI/MIrrL9iXmvtpW8PjqUuyyb
        6tod33cA==;
Received: from 213-225-6-64.nat.highway.a1.net ([213.225.6.64] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHQt-002c2v-0B; Mon, 20 Sep 2021 11:26:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] block: drain file system I/O on del_gendisk
Date:   Mon, 20 Sep 2021 13:24:04 +0200
Message-Id: <20210920112405.1299667-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920112405.1299667-1-hch@lst.de>
References: <20210920112405.1299667-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of delaying draining of file system I/O related items like the
blk-qos queues, the integrity read workqueue and timeouts only when the
request_queue is removed, do that when del_gendisk is called.  This is
important for SCSI where the upper level drivers that control the gendisk
are separate entities, and the disk can be freed much earlier than the
request_queue, or can even be unbound without tearing down the queue.

Fixes: edb0872f44ec ("block: move the bdi from the request_queue to the gendisk")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c      | 25 +++++++++++--------------
 block/blk.h           |  1 +
 block/genhd.c         | 21 +++++++++++++++++++++
 include/linux/genhd.h |  1 +
 4 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index be7cd1819b605..0b03f050a95cd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,7 +49,6 @@
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
-#include "blk-rq-qos.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -337,23 +336,25 @@ void blk_put_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_put_queue);
 
-void blk_set_queue_dying(struct request_queue *q)
+void blk_queue_start_drain(struct request_queue *q)
 {
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
-
 	/*
 	 * When queue DYING flag is set, we need to block new req
 	 * entering queue, so we call blk_freeze_queue_start() to
 	 * prevent I/O from crossing blk_queue_enter().
 	 */
 	blk_freeze_queue_start(q);
-
 	if (queue_is_mq(q))
 		blk_mq_wake_waiters(q);
-
 	/* Make blk_queue_enter() reexamine the DYING flag. */
 	wake_up_all(&q->mq_freeze_wq);
 }
+
+void blk_set_queue_dying(struct request_queue *q)
+{
+	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
+	blk_queue_start_drain(q);
+}
 EXPORT_SYMBOL_GPL(blk_set_queue_dying);
 
 /**
@@ -385,13 +386,8 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	blk_freeze_queue(q);
 
-	rq_qos_exit(q);
-
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
-	/* for synchronous bio-based driver finish in-flight integrity i/o */
-	blk_flush_integrity();
-
 	blk_sync_queue(q);
 	if (queue_is_mq(q))
 		blk_mq_exit_queue(q);
@@ -474,7 +470,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
 static inline int bio_queue_enter(struct bio *bio)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct request_queue *q = disk->queue;
 
 	while (!blk_try_enter_queue(q, false)) {
 		if (bio->bi_opf & REQ_NOWAIT) {
@@ -493,8 +490,8 @@ static inline int bio_queue_enter(struct bio *bio)
 		wait_event(q->mq_freeze_wq,
 			   (!q->mq_freeze_depth &&
 			    blk_pm_resume_queue(false, q)) ||
-			   blk_queue_dying(q));
-		if (blk_queue_dying(q)) {
+			   test_bit(GD_DEAD, &disk->state));
+		if (test_bit(GD_DEAD, &disk->state)) {
 			bio_io_error(bio);
 			return -ENODEV;
 		}
diff --git a/block/blk.h b/block/blk.h
index 7d2a0ba7ed21d..e2ed2257709ae 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -51,6 +51,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
+void blk_queue_start_drain(struct request_queue *q);
 
 #define BIO_INLINE_VECS 4
 struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
diff --git a/block/genhd.c b/block/genhd.c
index 7b6e5e1cf9564..b3c33495d7208 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -26,6 +26,7 @@
 #include <linux/badblocks.h>
 
 #include "blk.h"
+#include "blk-rq-qos.h"
 
 static struct kobject *block_depr;
 
@@ -559,6 +560,8 @@ EXPORT_SYMBOL(device_add_disk);
  */
 void del_gendisk(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
+
 	might_sleep();
 
 	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
@@ -575,8 +578,26 @@ void del_gendisk(struct gendisk *disk)
 	fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
 
+	/*
+	 * Fail any new I/O.
+	 */
+	set_bit(GD_DEAD, &disk->state);
 	set_capacity(disk, 0);
 
+	/*
+	 * Prevent new I/O from crossing bio_queue_enter().
+	 */
+	blk_queue_start_drain(q);
+	blk_mq_freeze_queue_wait(q);
+
+	rq_qos_exit(q);
+	blk_sync_queue(q);
+	blk_flush_integrity();
+	/*
+	 * Allow using passthrough request again after the queue is torn down.
+	 */
+	blk_mq_unfreeze_queue(q);
+
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c68d83c87f83f..0f5315c2b5a34 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -149,6 +149,7 @@ struct gendisk {
 	unsigned long state;
 #define GD_NEED_PART_SCAN		0
 #define GD_READ_ONLY			1
+#define GD_DEAD				2
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
-- 
2.30.2

