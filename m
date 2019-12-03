Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A4C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2987720661
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BNU0yWD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfLCJj1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCJj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7tGnw5Ck7d7pDDalWTV8uCh18W44+TXfsiC8Nui+qd4=; b=BNU0yWD32z2oJNY1ITgd8gconO
        mQn3Bhov1J7RprMMZtzmSBXS1VgtUIeU6G3YtxpGOfoyCUt5bxiyC5T6iMrPxeSTzaEzTtDKbXFY1
        dIT/vhyzHjIn2aeEDVVUEOLZ+5lw7Gl9bW4Qnmj3Dt22qN0opTBCsCwNTLIrolvQDtA3QBgIJmFlC
        jdFyLX9zkoNaCSP1h2iojiAHBWPlVqyz/6kSa67U0gQLK3lvdI2GEd3mkU2uI9NNpf56aceTkhPTm
        thUc8wMmScjE/28qI8+2uJPWZ/UbLohVnWqEpmrsTHSJnfyZPrzTcAcLpXQmFUTzoWslb//sS2x+g
        zdGd1bkw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eU-0002AE-In; Tue, 03 Dec 2019 09:39:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: [PATCH 7/8] block: don't handle bio based drivers in blk_revalidate_disk_zones
Date:   Tue,  3 Dec 2019 10:39:07 +0100
Message-Id: <20191203093908.24612-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203093908.24612-1-hch@lst.de>
References: <20191203093908.24612-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio based drivers only need to update q->nr_zones.  Do that manually
instead of overloading blk_revalidate_disk_zones to keep that function
simpler for the next round of changes that will rely even more on the
request based functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c             | 16 +++++-----------
 drivers/block/null_blk_main.c | 12 +++++++++---
 drivers/md/dm-table.c         | 12 +++++++-----
 include/linux/blkdev.h        |  5 -----
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0131f9e14bd1..51d427659ce7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -419,8 +419,9 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
  *
  * Helper function for low-level device drivers to (re) allocate and initialize
  * a disk request queue zone bitmaps. This functions should normally be called
- * within the disk ->revalidate method. For BIO based queues, no zone bitmap
- * is allocated.
+ * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
+ * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
+ * is correct.
  */
 int blk_revalidate_disk_zones(struct gendisk *disk)
 {
@@ -433,15 +434,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
 		return -EIO;
-
-	/*
-	 * BIO based queues do not use a scheduler so only q->nr_zones
-	 * needs to be updated so that the sysfs exposed value is correct.
-	 */
-	if (!queue_is_mq(q)) {
-		q->nr_zones = args.nr_zones;
-		return 0;
-	}
+	if (WARN_ON_ONCE(!queue_is_mq(q)))
+		return -EIO;
 
 	/*
 	 * Ensure that all memory allocations in this context are done as
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index dd6026289fbf..068cd0ae6e2c 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1576,11 +1576,17 @@ static int null_gendisk_register(struct nullb *nullb)
 	disk->queue		= nullb->q;
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
+#ifdef CONFIG_BLK_DEV_ZONED
 	if (nullb->dev->zoned) {
-		ret = blk_revalidate_disk_zones(disk);
-		if (ret)
-			return ret;
+		if (queue_is_mq(nullb->q)) {
+			ret = blk_revalidate_disk_zones(disk);
+			if (ret)
+				return ret;
+		} else {
+			nullb->q->nr_zones = blkdev_nr_zones(disk);
+		}
 	}
+#endif
 
 	add_disk(disk);
 	return 0;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 2ae0c1913766..0a2cc197f62b 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1954,12 +1954,14 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	/*
 	 * For a zoned target, the number of zones should be updated for the
 	 * correct value to be exposed in sysfs queue/nr_zones. For a BIO based
-	 * target, this is all that is needed. For a request based target, the
-	 * queue zone bitmaps must also be updated.
-	 * Use blk_revalidate_disk_zones() to handle this.
+	 * target, this is all that is needed.
 	 */
-	if (blk_queue_is_zoned(q))
-		blk_revalidate_disk_zones(t->md->disk);
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (blk_queue_is_zoned(q)) {
+		WARN_ON_ONCE(queue_is_mq(q));
+		q->nr_zones = blkdev_nr_zones(t->md->disk);
+	}
+#endif
 
 	/* Allow reads to exceed readahead limits */
 	q->backing_dev_info->io_pages = limits->max_sectors >> (PAGE_SHIFT - 9);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 503c4d4c5884..47eb22a3b7f9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -375,11 +375,6 @@ static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
 	return 0;
 }
 
-static inline int blk_revalidate_disk_zones(struct gendisk *disk)
-{
-	return 0;
-}
-
 static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
 					    fmode_t mode, unsigned int cmd,
 					    unsigned long arg)
-- 
2.20.1

