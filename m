Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CF3C433F1
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AF621775
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iW8rqW1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGTGM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgGTGM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 02:12:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9152CC0619D2
        for <linux-block@vger.kernel.org>; Sun, 19 Jul 2020 23:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8daV8r/qFxWDHpdjOBYXBjl9K8YuFUivqt0kDie5aX4=; b=iW8rqW1RT/Z9zgoLcZzBnY59zM
        YN5kpZ8KFASM1guz3D/nJFSpW4Dapr1pIo7jIlIpFR6qo60+D9UbjVyBF1UersTl+LcU4zGUhjY3U
        xPwb5ifntZhte2og2+hffvaIFRfmMG6rwr9I9SoQGkhlqX8jlhZU9wi+fTTIrffe1buM2J2p0TkJ4
        ZErJTKPcS/CXOxzNAViJ95VeEIswS8+wo5SNrx5H5wzwnR4yG+WQWXleIToY1hFfomSZDuY6sKJOI
        sWKy1sTuzkoerXatO2mGcE7SiImQ8QIrBcUBCbavV3BfEyk4ulyZ9t2zoN0pBS8qHy6ye3w14nEM5
        lfjNmP2A==;
Received: from [2001:4bb8:105:4a81:b96b:120c:c0c5:74fd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxP2k-0006gG-Ik; Mon, 20 Jul 2020 06:12:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 2/3] block: remove bdev_stack_limits
Date:   Mon, 20 Jul 2020 08:12:50 +0200
Message-Id: <20200720061251.652457-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720061251.652457-1-hch@lst.de>
References: <20200720061251.652457-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function is just a tiny wrapper around blk_stack_limit and has
two callers.  Simplify the stack a bit by open coding it in the two
callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c   | 25 ++-----------------------
 drivers/md/dm-table.c  |  3 ++-
 include/linux/blkdev.h |  2 --
 3 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9cddbd73647405..8c63af7726850c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -614,28 +614,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 }
 EXPORT_SYMBOL(blk_stack_limits);
 
-/**
- * bdev_stack_limits - adjust queue limits for stacked drivers
- * @t:	the stacking driver limits (top device)
- * @bdev:  the component block_device (bottom)
- * @start:  first data sector within component device
- *
- * Description:
- *    Merges queue limits for a top device and a block_device.  Returns
- *    0 if alignment didn't change.  Returns -1 if adding the bottom
- *    device caused misalignment.
- */
-int bdev_stack_limits(struct queue_limits *t, struct block_device *bdev,
-		      sector_t start)
-{
-	struct request_queue *bq = bdev_get_queue(bdev);
-
-	start += get_start_sect(bdev);
-
-	return blk_stack_limits(t, &bq->limits, start);
-}
-EXPORT_SYMBOL(bdev_stack_limits);
-
 /**
  * disk_stack_limits - adjust queue limits for stacked drivers
  * @disk:  MD/DM gendisk (top)
@@ -651,7 +629,8 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 {
 	struct request_queue *t = disk->queue;
 
-	if (bdev_stack_limits(&t->limits, bdev, offset >> 9) < 0) {
+	if (blk_stack_limits(&t->limits, &bdev_get_queue(bdev)->limits,
+			get_start_sect(bdev) + (offset >> 9)) < 0) {
 		char top[BDEVNAME_SIZE], bottom[BDEVNAME_SIZE];
 
 		disk_name(disk, 0, top);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ec5364133cef7f..aac4c31cfc8498 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -458,7 +458,8 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 		return 0;
 	}
 
-	if (bdev_stack_limits(limits, bdev, start) < 0)
+	if (blk_stack_limits(limits, &q->limits,
+			get_start_sect(bdev) + start) < 0)
 		DMWARN("%s: adding target device %s caused an alignment inconsistency: "
 		       "physical_block_size=%u, logical_block_size=%u, "
 		       "alignment_offset=%u, start=%llu",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 67b9ccc1da3560..247b0e0a2901f0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1106,8 +1106,6 @@ extern void blk_set_default_limits(struct queue_limits *lim);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
-extern int bdev_stack_limits(struct queue_limits *t, struct block_device *bdev,
-			    sector_t offset);
 extern void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 			      sector_t offset);
 extern void blk_queue_stack_limits(struct request_queue *t, struct request_queue *b);
-- 
2.27.0

