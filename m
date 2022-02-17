Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163DBC433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 07:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiBQHww (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 02:52:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiBQHww (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 02:52:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF45174684
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 23:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YLLtSmcQMbskR3Au306U+hXO/5gULNT7Ygiw7u9JEKQ=; b=kE8uNkSIemt5hYgmry+B300BUf
        AOh9Kd2z0GeKuQfzCfeROrwXk4YqPFyab/Z50ukhQW0FjrIDcau+u+Su55Bf552RZeLOjfOojxcxN
        sJEPJ/EjaEUxsA3CNucAfGIunguK1Lmue4VFpxRXEEhYxvlMVoJnvSVsJQRJnrR6vCprfxu8YXm6R
        rxS/1rVrHxCoXhbbtIEKqBe3oEVQA7hIfCJ5WbQc1L83BZaPoyRYCnd7ffftRn8BfT+iEcz67Go6p
        vg/vj1k/oan6K4B/fvHgZcV9ltEjCV5bxV6PP74Sbq6beomGb+Q2ulkrhZRN0mqERYpEhBDJU7q3e
        FgEJCxHw==;
Received: from [2001:4bb8:184:543c:7ed8:203d:6251:e8f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKbab-009H4i-Ox; Thu, 17 Feb 2022 07:52:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     kbusch@kernel.org, markus.bloechl@ipetronik.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH v2] block: fix surprise removal for drivers calling blk_set_queue_dying
Date:   Thu, 17 Feb 2022 08:52:31 +0100
Message-Id: <20220217075231.1140-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various block drivers call blk_set_queue_dying to mark a disk as dead due
to surprise removal events, but since commit 8e141f9eb803 that doesn't
work given that the GD_DEAD flag needs to be set to stop I/O.

Replace the driver calls to blk_set_queue_dying with a new (and properly
documented) blk_mark_disk_dead API, and fold blk_set_queue_dying into the
only remaining caller.

Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
Reported-by: Markus Blöchl <markus.bloechl@ipetronik.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - fix the kerneldoc for blk_mark_disk_dead
 - move blk_mark_disk_dead into genhd.c to sit next to del_gendisk

 block/blk-core.c                  | 10 ++--------
 block/genhd.c                     | 14 ++++++++++++++
 drivers/block/mtip32xx/mtip32xx.c |  2 +-
 drivers/block/rbd.c               |  2 +-
 drivers/block/xen-blkfront.c      |  2 +-
 drivers/md/dm.c                   |  2 +-
 drivers/nvme/host/core.c          |  2 +-
 drivers/nvme/host/multipath.c     |  2 +-
 include/linux/blkdev.h            |  3 ++-
 9 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d93e3bb9a769b..1039515c99d6a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -284,13 +284,6 @@ void blk_queue_start_drain(struct request_queue *q)
 	wake_up_all(&q->mq_freeze_wq);
 }
 
-void blk_set_queue_dying(struct request_queue *q)
-{
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
-	blk_queue_start_drain(q);
-}
-EXPORT_SYMBOL_GPL(blk_set_queue_dying);
-
 /**
  * blk_cleanup_queue - shutdown a request queue
  * @q: request queue to shutdown
@@ -308,7 +301,8 @@ void blk_cleanup_queue(struct request_queue *q)
 	WARN_ON_ONCE(blk_queue_registered(q));
 
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
-	blk_set_queue_dying(q);
+	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
+	blk_queue_start_drain(q);
 
 	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a6..9eca1f7d35c97 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -548,6 +548,20 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 }
 EXPORT_SYMBOL(device_add_disk);
 
+/**
+ * blk_mark_disk_dead - mark a disk as dead
+ * @disk: disk to mark as dead
+ *
+ * Mark as disk as dead (e.g. surprise removed) and don't accept any new I/O
+ * to this disk.
+ */
+void blk_mark_disk_dead(struct gendisk *disk)
+{
+	set_bit(GD_DEAD, &disk->state);
+	blk_queue_start_drain(disk->queue);
+}
+EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
+
 /**
  * del_gendisk - remove the gendisk
  * @disk: the struct gendisk to remove
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index e6005c2323281..2b588b62cbbb2 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4112,7 +4112,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 			"Completion workers still active!\n");
 	}
 
-	blk_set_queue_dying(dd->queue);
+	blk_mark_disk_dead(dd->disk);
 	set_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag);
 
 	/* Clean up the block layer. */
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4203cdab8abfd..b844432bad20b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -7185,7 +7185,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 		 * IO to complete/fail.
 		 */
 		blk_mq_freeze_queue(rbd_dev->disk->queue);
-		blk_set_queue_dying(rbd_dev->disk->queue);
+		blk_mark_disk_dead(rbd_dev->disk);
 	}
 
 	del_gendisk(rbd_dev->disk);
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index ccd0dd0c6b83c..ca71a0585333f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2126,7 +2126,7 @@ static void blkfront_closing(struct blkfront_info *info)
 
 	/* No more blkif_request(). */
 	blk_mq_stop_hw_queues(info->rq);
-	blk_set_queue_dying(info->rq);
+	blk_mark_disk_dead(info->gd);
 	set_capacity(info->gd, 0);
 
 	for_each_rinfo(info, rinfo, i) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dcbd6d201619d..997ace47bbd54 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2077,7 +2077,7 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
 	set_bit(DMF_FREEING, &md->flags);
 	spin_unlock(&_minor_lock);
 
-	blk_set_queue_dying(md->queue);
+	blk_mark_disk_dead(md->disk);
 
 	/*
 	 * Take suspend_lock so that presuspend and postsuspend methods
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79005ea1a33e3..469f23186159c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4574,7 +4574,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
 
-	blk_set_queue_dying(ns->queue);
+	blk_mark_disk_dead(ns->disk);
 	nvme_start_ns_queue(ns);
 
 	set_capacity_and_notify(ns->disk, 0);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f8bf6606eb2fc..ff775235534cf 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -848,7 +848,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	blk_set_queue_dying(head->disk->queue);
+	blk_mark_disk_dead(head->disk);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f35aea98bc351..16b47035e4b06 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -748,7 +748,8 @@ extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 
 bool __must_check blk_get_queue(struct request_queue *);
 extern void blk_put_queue(struct request_queue *);
-extern void blk_set_queue_dying(struct request_queue *);
+
+void blk_mark_disk_dead(struct gendisk *disk);
 
 #ifdef CONFIG_BLOCK
 /*
-- 
2.30.2

