Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6128C48BE8
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 05:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF5B61375
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 05:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhFPFm1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 01:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhFPFm1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 01:42:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58AC061574;
        Tue, 15 Jun 2021 22:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b3hnNB4W26EFy+cXA5L2WpgsI2r6QOggv8dEppmKBbM=; b=oXrE5R5fuszYzjul1pgcpUtEpX
        xfLv5fQmMnO5VCgCt5tj+QIY/8JBdgxiuNgmc857v6wZpfVXx0u1RblBTYxKOHsgmWUwMBku9Bxnc
        GmeGs14JnO69FXUqHpdWSVqwH0xAyq2pi1TA1e2Xtzeb1/k2dZqhzw7r3tdqKVFulSwBoIUoB/4hX
        1bxoXSSsGpbL1NukHegwawHrjUdBxsYbFZ5vhoKA63Gu5CWZdzzjc2ZWwsshUbis21TVXliwgdFUk
        3jUZZskyP9LsxHN1UV3S10rqgJrBPCi/mClDhcUHLHk3iMROzbTCN5f7ubhhbBYjYUosDBnQXE57E
        jfzrX30A==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltOHU-007eBw-VE; Wed, 16 Jun 2021 05:40:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 2/2] mmc: switch to blk_mq_alloc_disk
Date:   Wed, 16 Jun 2021 07:39:34 +0200
Message-Id: <20210616053934.880951-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616053934.880951-1-hch@lst.de>
References: <20210616053934.880951-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the blk_mq_alloc_disk to allocate the request_queue and gendisk
together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/block.c | 14 +++-----------
 drivers/mmc/core/queue.c | 23 ++++++++++-------------
 drivers/mmc/core/queue.h |  2 +-
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 947624e76c33..6652e1f1d4b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2310,27 +2310,21 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 */
 	md->read_only = mmc_blk_readonly(card);
 
-	md->disk = alloc_disk(perdev_minors);
-	if (md->disk == NULL) {
-		ret = -ENOMEM;
+	md->disk = mmc_init_queue(&md->queue, card);
+	if (IS_ERR(md->disk)) {
+		ret = PTR_ERR(md->disk);
 		goto err_kfree;
 	}
 
 	INIT_LIST_HEAD(&md->part);
 	INIT_LIST_HEAD(&md->rpmbs);
 	md->usage = 1;
-
-	ret = mmc_init_queue(&md->queue, card);
-	if (ret)
-		goto err_putdisk;
-
 	md->queue.blkdata = md;
 
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->first_minor = devidx * perdev_minors;
 	md->disk->fops = &mmc_bdops;
 	md->disk->private_data = md;
-	md->disk->queue = md->queue.queue;
 	md->parent = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
 	md->disk->flags = GENHD_FL_EXT_DEVT;
@@ -2379,8 +2373,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	return md;
 
- err_putdisk:
-	put_disk(md->disk);
  err_kfree:
 	kfree(md);
  out:
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index d600e0a4a460..cc3261777637 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -424,9 +424,10 @@ static inline bool mmc_merge_capable(struct mmc_host *host)
  *
  * Initialise a MMC card request queue.
  */
-int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
+struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
+	struct gendisk *disk;
 	int ret;
 
 	mq->card = card;
@@ -464,26 +465,22 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 
 	ret = blk_mq_alloc_tag_set(&mq->tag_set);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
+		
 
-	mq->queue = blk_mq_init_queue(&mq->tag_set);
-	if (IS_ERR(mq->queue)) {
-		ret = PTR_ERR(mq->queue);
-		goto free_tag_set;
+	disk = blk_mq_alloc_disk(&mq->tag_set, mq);
+	if (IS_ERR(disk)) {
+		blk_mq_free_tag_set(&mq->tag_set);
+		return disk;
 	}
+	mq->queue = disk->queue;
 
 	if (mmc_host_is_spi(host) && host->use_spi_crc)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, mq->queue);
-
-	mq->queue->queuedata = mq;
 	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 
 	mmc_setup_queue(mq, card);
-	return 0;
-
-free_tag_set:
-	blk_mq_free_tag_set(&mq->tag_set);
-	return ret;
+	return disk;
 }
 
 void mmc_queue_suspend(struct mmc_queue *mq)
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 3319d8ab57d0..9ade3bcbb714 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -94,7 +94,7 @@ struct mmc_queue {
 	struct work_struct	complete_work;
 };
 
-extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *);
+struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
-- 
2.30.2

