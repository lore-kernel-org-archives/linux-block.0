Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36715 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759998AbdACRbW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2017 12:31:22 -0500
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        baolin.wang@linaro.org, riteshh@codeaurora.org, arnd@arndb.de,
        zhang.chunyan@linaro.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH PoCv2 1/2] Revert
 "mmc: queue: Share mmc request array between partitions"
Date: Tue, 03 Jan 2017 18:30:17 +0100
Message-id: <1483464618-16133-2-git-send-email-b.zolnierkie@samsung.com>
In-reply-to: <1483464618-16133-1-git-send-email-b.zolnierkie@samsung.com>
References: <1483464618-16133-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170103173119epcas5p32d141b74cc44c2eb5197695d66829720@epcas5p3.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Shared mmc queue changes break mmc-mq ones currently.

This reverts commit 6540ce8420b7790ef0696ccfd6e911df7ba84c33.

Conflicts:
	drivers/mmc/core/queue.c

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/core/block.c |  11 +--
 drivers/mmc/core/queue.c | 252 +++++++++++++++++++----------------------------
 drivers/mmc/core/queue.h |   2 -
 include/linux/mmc/card.h |   5 -
 4 files changed, 105 insertions(+), 165 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d4362f4..d87b613 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2183,7 +2183,6 @@ static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
 	char cap_str[10];
-	int ret;
 
 	/*
 	 * Check that the card supports the command class(es) we need.
@@ -2193,15 +2192,9 @@ static int mmc_blk_probe(struct mmc_card *card)
 
 	mmc_fixup_device(card, blk_fixups);
 
-	ret = mmc_queue_alloc_shared_queue(card);
-	if (ret)
-		return ret;
-
 	md = mmc_blk_alloc(card);
-	if (IS_ERR(md)) {
-		mmc_queue_free_shared_queue(card);
+	if (IS_ERR(md))
 		return PTR_ERR(md);
-	}
 
 	string_get_size((u64)get_capacity(md->disk), 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
@@ -2239,7 +2232,6 @@ static int mmc_blk_probe(struct mmc_card *card)
  out:
 	mmc_blk_remove_parts(card, md);
 	mmc_blk_remove_req(md);
-	mmc_queue_free_shared_queue(card);
 	return 0;
 }
 
@@ -2257,7 +2249,6 @@ static void mmc_blk_remove(struct mmc_card *card)
 	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
 	dev_set_drvdata(&card->dev, NULL);
-	mmc_queue_free_shared_queue(card);
 }
 
 static int _mmc_blk_suspend(struct mmc_card *card)
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index aa98f1b..6284101 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -156,13 +156,17 @@ static void mmc_request_fn(struct request_queue *q)
 		wake_up_process(mq->thread);
 }
 
-static struct scatterlist *mmc_alloc_sg(int sg_len)
+static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
 {
 	struct scatterlist *sg;
 
-	sg = kmalloc_array(sg_len, sizeof(*sg), GFP_KERNEL);
-	if (sg)
+	sg = kmalloc(sizeof(struct scatterlist)*sg_len, GFP_KERNEL);
+	if (!sg)
+		*err = -ENOMEM;
+	else {
+		*err = 0;
 		sg_init_table(sg, sg_len);
+	}
 
 	return sg;
 }
@@ -188,178 +192,94 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
-static void mmc_queue_req_free_bufs(struct mmc_queue_req *mqrq)
-{
-	kfree(mqrq->bounce_sg);
-	mqrq->bounce_sg = NULL;
-
-	kfree(mqrq->sg);
-	mqrq->sg = NULL;
-
-	kfree(mqrq->bounce_buf);
-	mqrq->bounce_buf = NULL;
-}
-
-static void mmc_queue_reqs_free_bufs(struct mmc_queue_req *mqrq, int qdepth)
+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
+					unsigned int bouncesz)
 {
 	int i;
 
-	for (i = 0; i < qdepth; i++)
-		mmc_queue_req_free_bufs(&mqrq[i]);
-}
-
-static void mmc_queue_free_mqrqs(struct mmc_queue_req *mqrq, int qdepth)
-{
-	mmc_queue_reqs_free_bufs(mqrq, qdepth);
-	kfree(mqrq);
-}
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
+		if (!mq->mqrq[i].bounce_buf)
+			goto out_err;
+	}
 
-static struct mmc_queue_req *mmc_queue_alloc_mqrqs(int qdepth)
-{
-	struct mmc_queue_req *mqrq;
-	int i;
+	return true;
 
-	mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
-	if (mqrq) {
-		for (i = 0; i < qdepth; i++)
-			mqrq[i].task_id = i;
+out_err:
+	while (--i >= 0) {
+		kfree(mq->mqrq[i].bounce_buf);
+		mq->mqrq[i].bounce_buf = NULL;
 	}
-
-	return mqrq;
+	pr_warn("%s: unable to allocate bounce buffers\n",
+		mmc_card_name(mq->card));
+	return false;
 }
 
-#ifdef CONFIG_MMC_BLOCK_BOUNCE
-static int mmc_queue_alloc_bounce_bufs(struct mmc_queue_req *mqrq, int qdepth,
-				       unsigned int bouncesz)
+static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
+				      unsigned int bouncesz)
 {
-	int i;
+	int i, ret;
 
-	for (i = 0; i < qdepth; i++) {
-		mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-		if (!mqrq[i].bounce_buf)
-			return -ENOMEM;
-
-		mqrq[i].sg = mmc_alloc_sg(1);
-		if (!mqrq[i].sg)
-			return -ENOMEM;
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].sg = mmc_alloc_sg(1, &ret);
+		if (ret)
+			return ret;
 
-		mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512);
-		if (!mqrq[i].bounce_sg)
-			return -ENOMEM;
+		mq->mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
+#endif
 
-static bool mmc_queue_alloc_bounce(struct mmc_queue_req *mqrq, int qdepth,
-				   unsigned int bouncesz)
+static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
 {
-	int ret;
+	int i, ret;
 
-	ret = mmc_queue_alloc_bounce_bufs(mqrq, qdepth, bouncesz);
-	if (ret)
-		mmc_queue_reqs_free_bufs(mqrq, qdepth);
+	for (i = 0; i < mq->qdepth; i++) {
+		mq->mqrq[i].sg = mmc_alloc_sg(max_segs, &ret);
+		if (ret)
+			return ret;
+	}
 
-	return !ret;
+	return 0;
 }
 
-static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
+static void mmc_queue_req_free_bufs(struct mmc_queue_req *mqrq)
 {
-	unsigned int bouncesz = MMC_QUEUE_BOUNCESZ;
-
-	if (host->max_segs != 1)
-		return 0;
-
-	if (bouncesz > host->max_req_size)
-		bouncesz = host->max_req_size;
-	if (bouncesz > host->max_seg_size)
-		bouncesz = host->max_seg_size;
-	if (bouncesz > host->max_blk_count * 512)
-		bouncesz = host->max_blk_count * 512;
-
-	if (bouncesz <= 512)
-		return 0;
+	kfree(mqrq->bounce_sg);
+	mqrq->bounce_sg = NULL;
 
-	return bouncesz;
-}
-#else
-static inline bool mmc_queue_alloc_bounce(struct mmc_queue_req *mqrq,
-					  int qdepth, unsigned int bouncesz)
-{
-	return false;
-}
+	kfree(mqrq->sg);
+	mqrq->sg = NULL;
 
-static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
-{
-	return 0;
+	kfree(mqrq->bounce_buf);
+	mqrq->bounce_buf = NULL;
 }
-#endif
 
-static int mmc_queue_alloc_sgs(struct mmc_queue_req *mqrq, int qdepth,
-			       int max_segs)
+static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
 {
 	int i;
 
-	for (i = 0; i < qdepth; i++) {
-		mqrq[i].sg = mmc_alloc_sg(max_segs);
-		if (!mqrq[i].sg)
-			return -ENOMEM;
-	}
-
-	return 0;
+	for (i = 0; i < mq->qdepth; i++)
+		mmc_queue_req_free_bufs(&mq->mqrq[i]);
 }
 
-void mmc_queue_free_shared_queue(struct mmc_card *card)
-{
-	if (card->mqrq) {
-		mmc_queue_free_mqrqs(card->mqrq, card->qdepth);
-		card->mqrq = NULL;
-	}
-}
-
-static int __mmc_queue_alloc_shared_queue(struct mmc_card *card, int qdepth)
+static struct mmc_queue_req *mmc_queue_alloc_mqrqs(int qdepth)
 {
-	struct mmc_host *host = card->host;
 	struct mmc_queue_req *mqrq;
-	unsigned int bouncesz;
-	int ret = 0;
-
-	if (card->mqrq)
-		return -EINVAL;
-
-	mqrq = mmc_queue_alloc_mqrqs(qdepth);
-	if (!mqrq)
-		return -ENOMEM;
-
-	card->mqrq = mqrq;
-	card->qdepth = qdepth;
-
-	bouncesz = mmc_queue_calc_bouncesz(host);
-
-	if (bouncesz && !mmc_queue_alloc_bounce(mqrq, qdepth, bouncesz)) {
-		bouncesz = 0;
-		pr_warn("%s: unable to allocate bounce buffers\n",
-			mmc_card_name(card));
-	}
-
-	card->bouncesz = bouncesz;
+	int i;
 
-	if (!bouncesz) {
-		ret = mmc_queue_alloc_sgs(mqrq, qdepth, host->max_segs);
-		if (ret)
-			goto out_err;
+	mqrq = kcalloc(qdepth, sizeof(*mqrq), GFP_KERNEL);
+	if (mqrq) {
+		for (i = 0; i < qdepth; i++)
+			mqrq[i].task_id = i;
 	}
 
-	return ret;
-
-out_err:
-	mmc_queue_free_shared_queue(card);
-	return ret;
-}
-
-int mmc_queue_alloc_shared_queue(struct mmc_card *card)
-{
-	return __mmc_queue_alloc_shared_queue(card, 2);
+	return mqrq;
 }
 
 /**
@@ -376,6 +296,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
+	bool bounce = false;
 	int ret = -ENOMEM;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
@@ -386,8 +307,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
-	mq->mqrq = card->mqrq;
-	mq->qdepth = card->qdepth;
+	mq->qdepth = 2;
+	mq->mqrq = mmc_queue_alloc_mqrqs(mq->qdepth);
+	if (!mq->mqrq)
+		goto blk_cleanup;
 	mq->queue->queuedata = mq;
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
@@ -396,17 +319,44 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-	if (card->bouncesz) {
-		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_ANY);
-		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segments(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segment_size(mq->queue, card->bouncesz);
-	} else {
+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+	if (host->max_segs == 1) {
+		unsigned int bouncesz;
+
+		bouncesz = MMC_QUEUE_BOUNCESZ;
+
+		if (bouncesz > host->max_req_size)
+			bouncesz = host->max_req_size;
+		if (bouncesz > host->max_seg_size)
+			bouncesz = host->max_seg_size;
+		if (bouncesz > (host->max_blk_count * 512))
+			bouncesz = host->max_blk_count * 512;
+
+		if (bouncesz > 512 &&
+		    mmc_queue_alloc_bounce_bufs(mq, bouncesz)) {
+			blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_ANY);
+			blk_queue_max_hw_sectors(mq->queue, bouncesz / 512);
+			blk_queue_max_segments(mq->queue, bouncesz / 512);
+			blk_queue_max_segment_size(mq->queue, bouncesz);
+
+			ret = mmc_queue_alloc_bounce_sgs(mq, bouncesz);
+			if (ret)
+				goto cleanup_queue;
+			bounce = true;
+		}
+	}
+#endif
+
+	if (!bounce) {
 		blk_queue_bounce_limit(mq->queue, limit);
 		blk_queue_max_hw_sectors(mq->queue,
 			min(host->max_blk_count, host->max_req_size / 512));
 		blk_queue_max_segments(mq->queue, host->max_segs);
 		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
+
+		ret = mmc_queue_alloc_sgs(mq, host->max_segs);
+		if (ret)
+			goto cleanup_queue;
 	}
 
 	sema_init(&mq->thread_sem, 1);
@@ -421,8 +371,11 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
 	return 0;
 
-cleanup_queue:
+ cleanup_queue:
+	mmc_queue_reqs_free_bufs(mq);
+	kfree(mq->mqrq);
 	mq->mqrq = NULL;
+blk_cleanup:
 	blk_cleanup_queue(mq->queue);
 	return ret;
 }
@@ -444,7 +397,10 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
+	mmc_queue_reqs_free_bufs(mq);
+	kfree(mq->mqrq);
 	mq->mqrq = NULL;
+
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index ee26724..95ca330 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -48,8 +48,6 @@ struct mmc_queue {
 	unsigned long		qslots;
 };
 
-extern int mmc_queue_alloc_shared_queue(struct mmc_card *card);
-extern void mmc_queue_free_shared_queue(struct mmc_card *card);
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
 			  const char *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 514ed4e..95d69d4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -206,7 +206,6 @@ struct sdio_cis {
 struct mmc_ios;
 struct sdio_func;
 struct sdio_func_tuple;
-struct mmc_queue_req;
 
 #define SDIO_MAX_FUNCS		7
 
@@ -307,10 +306,6 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
-
-	struct mmc_queue_req	*mqrq;		/* Shared queue structure */
-	unsigned int		bouncesz;	/* Bounce buffer size */
-	int			qdepth;		/* Shared queue depth */
 };
 
 /*
-- 
1.9.1

