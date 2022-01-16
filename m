Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74816C433F5
	for <linux-block@archiver.kernel.org>; Sun, 16 Jan 2022 04:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiAPETh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jan 2022 23:19:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbiAPETg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jan 2022 23:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642306775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/21O1SNj8scvofYxA6kem9SP5kgd0y4vGMHb/2/7tY=;
        b=AGm0w4lHQa49kaxLvR41xhDXeBTbCz7r7LaW90/IcBeXpwubd3Y3KuzGBn1+5P1W0lA+4L
        Y7fsimAhzNIfc6ude801Q1tX8pIA39YA5Ap5GkxgyB59YdiELK7ReypdQ2Mf329hQ/btdW
        gv7G/WFaPY98PO61DvXJEOAteXWWB44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-bK-GUcJFOOuY2P5Z5pRAsg-1; Sat, 15 Jan 2022 23:19:32 -0500
X-MC-Unique: bK-GUcJFOOuY2P5Z5pRAsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D25A1083F64;
        Sun, 16 Jan 2022 04:19:31 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1C15C2F2;
        Sun, 16 Jan 2022 04:19:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] block: revert 8e141f9eb803 block: drain file system I/O on del_gendisk
Date:   Sun, 16 Jan 2022 12:18:15 +0800
Message-Id: <20220116041815.1218170-4-ming.lei@redhat.com>
In-Reply-To: <20220116041815.1218170-1-ming.lei@redhat.com>
References: <20220116041815.1218170-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk") is
added for addressing the issue in which disk release is done before
blk_cleanup_queue(), but it has several problems:

1) queue freezing can't drain FS I/O for bio based driver

2) it isn't easy to move elevator/cgroup/throttle shutdown during
del_gendisk, and q->disk can still be referred in these code paths

3) the added flag of GD_DEAD may not be observed reliably in
__bio_queue_enter() because queue freezing might not imply rcu grace
period.

We have moved freeing disk and its block_device into request queue's
release handler, and it is safe to refer to q->disk in IO related path
now, so revert this commit.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c      | 24 ++++++++++++------------
 block/blk.h           |  1 -
 block/genhd.c         | 23 -----------------------
 include/linux/genhd.h |  1 -
 4 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 97f8bc8d3a79..a16fb551ac03 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -50,6 +50,7 @@
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-throttle.h"
+#include "blk-rq-qos.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -270,8 +271,10 @@ void blk_put_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_put_queue);
 
-void blk_queue_start_drain(struct request_queue *q)
+void blk_set_queue_dying(struct request_queue *q)
 {
+	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
+
 	/*
 	 * When queue DYING flag is set, we need to block new req
 	 * entering queue, so we call blk_freeze_queue_start() to
@@ -283,12 +286,6 @@ void blk_queue_start_drain(struct request_queue *q)
 	/* Make blk_queue_enter() reexamine the DYING flag. */
 	wake_up_all(&q->mq_freeze_wq);
 }
-
-void blk_set_queue_dying(struct request_queue *q)
-{
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
-	blk_queue_start_drain(q);
-}
 EXPORT_SYMBOL_GPL(blk_set_queue_dying);
 
 /**
@@ -320,8 +317,13 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	blk_freeze_queue(q);
 
+	rq_qos_exit(q);
+
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
+	/* for synchronous bio-based driver finish in-flight integrity i/o */
+	blk_flush_integrity();
+
 	blk_sync_queue(q);
 	if (queue_is_mq(q)) {
 		blk_mq_cancel_work_sync(q);
@@ -383,10 +385,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 {
 	while (!blk_try_enter_queue(q, false)) {
-		struct gendisk *disk = bio->bi_bdev->bd_disk;
-
 		if (bio->bi_opf & REQ_NOWAIT) {
-			if (test_bit(GD_DEAD, &disk->state))
+			if (blk_queue_dying(q))
 				goto dead;
 			bio_wouldblock_error(bio);
 			return -EBUSY;
@@ -403,8 +403,8 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 		wait_event(q->mq_freeze_wq,
 			   (!q->mq_freeze_depth &&
 			    blk_pm_resume_queue(false, q)) ||
-			   test_bit(GD_DEAD, &disk->state));
-		if (test_bit(GD_DEAD, &disk->state))
+			   blk_queue_dying(q));
+		if (blk_queue_dying(q))
 			goto dead;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 9ee7ab1c5572..4293c8e0a082 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -43,7 +43,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
-void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 bool submit_bio_checks(struct bio *bio);
 
diff --git a/block/genhd.c b/block/genhd.c
index 9842371904d6..f7577dde18fc 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -29,7 +29,6 @@
 
 #include "blk.h"
 #include "blk-mq-sched.h"
-#include "blk-rq-qos.h"
 
 static struct kobject *block_depr;
 
@@ -569,8 +568,6 @@ EXPORT_SYMBOL(device_add_disk);
  */
 void del_gendisk(struct gendisk *disk)
 {
-	struct request_queue *q = disk->queue;
-
 	might_sleep();
 
 	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
@@ -587,17 +584,8 @@ void del_gendisk(struct gendisk *disk)
 	fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
 
-	/*
-	 * Fail any new I/O.
-	 */
-	set_bit(GD_DEAD, &disk->state);
 	set_capacity(disk, 0);
 
-	/*
-	 * Prevent new I/O from crossing bio_queue_enter().
-	 */
-	blk_queue_start_drain(q);
-
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
 
@@ -619,17 +607,6 @@ void del_gendisk(struct gendisk *disk)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
-
-	blk_mq_freeze_queue_wait(q);
-
-	rq_qos_exit(q);
-	blk_sync_queue(q);
-	blk_flush_integrity();
-	/*
-	 * Allow using passthrough request again after the queue is torn down.
-	 */
-	blk_mq_unfreeze_queue(q);
-
 }
 EXPORT_SYMBOL(del_gendisk);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6906a45bc761..3e9f234495e4 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -108,7 +108,6 @@ struct gendisk {
 	unsigned long state;
 #define GD_NEED_PART_SCAN		0
 #define GD_READ_ONLY			1
-#define GD_DEAD				2
 #define GD_NATIVE_CAPACITY		3
 
 	struct mutex open_mutex;	/* open/close mutex */
-- 
2.31.1

