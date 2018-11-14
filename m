Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B85C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5434322419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdDxu+Sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5434322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeKOCGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbeKOCGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i+M1Syl3Aa/zIxo0uSoSuirwFEr+QzUD05WN0gKBivg=; b=gdDxu+SxJAdtHKnOkSx+8KyBaz
        B2OOrgxK6+KaE80XCUhNTFYsWrpR2eqrglC/sBZRbtQJhZmN5MMY0eD4MYzsbRL7Yu3xFFFXai+oZ
        kVMHv7ejcnZYxVW8YlpDTaL3Cc8wcwTShLwYYRYFYX+Ap1OUNtVZ+K2VxLqPUVFwqobLYXNCwK0AY
        EN9lbL8tRYHdLpR/Ej24XD49EWy5PRk0dFwtoRS27d606iEoZYsAlvCvnczo9wLxm0+I48ClL6oq6
        eHEqMDLP45s2gY0caGL0wwfzxSPAdsdXhX2QLDs6yceUUnUhngeQooRypYVAcBYPumyFpeuRyUYsa
        5qgltO2g==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxd3-0006MS-Qw; Wed, 14 Nov 2018 16:02:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 13/16] mmc: simplify queue initialization
Date:   Wed, 14 Nov 2018 17:02:16 +0100
Message-Id: <20181114160219.28328-14-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Merge three functions initializing the queue into a single one, and drop
an unused argument for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/block.c |  2 +-
 drivers/mmc/core/queue.c | 86 ++++++++++++++--------------------------
 drivers/mmc/core/queue.h |  3 +-
 3 files changed, 32 insertions(+), 59 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c35b5b08bb33..27606e1382e5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2334,7 +2334,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	INIT_LIST_HEAD(&md->rpmbs);
 	md->usage = 1;
 
-	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
+	ret = mmc_init_queue(&md->queue, card, &md->lock);
 	if (ret)
 		goto err_putdisk;
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 6edffeed9953..37617fb1f9de 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -378,14 +378,38 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	init_waitqueue_head(&mq->wait);
 }
 
-static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
-			     const struct blk_mq_ops *mq_ops, spinlock_t *lock)
+/* Set queue depth to get a reasonable value for q->nr_requests */
+#define MMC_QUEUE_DEPTH 64
+
+/**
+ * mmc_init_queue - initialise a queue structure.
+ * @mq: mmc queue
+ * @card: mmc card to attach this queue
+ * @lock: queue lock
+ * @subname: partition subname
+ *
+ * Initialise a MMC card request queue.
+ */
+int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
+		   spinlock_t *lock)
 {
+	struct mmc_host *host = card->host;
 	int ret;
 
+	mq->card = card;
+	mq->use_cqe = host->cqe_enabled;
+
 	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
-	mq->tag_set.ops = mq_ops;
-	mq->tag_set.queue_depth = q_depth;
+	mq->tag_set.ops = &mmc_mq_ops;
+	/*
+	 * The queue depth for CQE must match the hardware because the request
+	 * tag is used to index the hardware queue.
+	 */
+	if (mq->use_cqe)
+		mq->tag_set.queue_depth =
+			min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
+	else
+		mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
 	mq->tag_set.numa_node = NUMA_NO_NODE;
 	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE |
 			    BLK_MQ_F_BLOCKING;
@@ -405,66 +429,16 @@ static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
 
 	mq->queue->queue_lock = lock;
 	mq->queue->queuedata = mq;
+	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 
+	mmc_setup_queue(mq, card);
 	return 0;
 
 free_tag_set:
 	blk_mq_free_tag_set(&mq->tag_set);
-
 	return ret;
 }
 
-/* Set queue depth to get a reasonable value for q->nr_requests */
-#define MMC_QUEUE_DEPTH 64
-
-static int mmc_mq_init(struct mmc_queue *mq, struct mmc_card *card,
-			 spinlock_t *lock)
-{
-	struct mmc_host *host = card->host;
-	int q_depth;
-	int ret;
-
-	/*
-	 * The queue depth for CQE must match the hardware because the request
-	 * tag is used to index the hardware queue.
-	 */
-	if (mq->use_cqe)
-		q_depth = min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
-	else
-		q_depth = MMC_QUEUE_DEPTH;
-
-	ret = mmc_mq_init_queue(mq, q_depth, &mmc_mq_ops, lock);
-	if (ret)
-		return ret;
-
-	blk_queue_rq_timeout(mq->queue, 60 * HZ);
-
-	mmc_setup_queue(mq, card);
-
-	return 0;
-}
-
-/**
- * mmc_init_queue - initialise a queue structure.
- * @mq: mmc queue
- * @card: mmc card to attach this queue
- * @lock: queue lock
- * @subname: partition subname
- *
- * Initialise a MMC card request queue.
- */
-int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
-		   spinlock_t *lock, const char *subname)
-{
-	struct mmc_host *host = card->host;
-
-	mq->card = card;
-
-	mq->use_cqe = host->cqe_enabled;
-
-	return mmc_mq_init(mq, card, lock);
-}
-
 void mmc_queue_suspend(struct mmc_queue *mq)
 {
 	blk_mq_quiesce_queue(mq->queue);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 9bf3c9245075..29218e12900d 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -95,8 +95,7 @@ struct mmc_queue {
 	struct work_struct	complete_work;
 };
 
-extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-			  const char *);
+extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
-- 
2.19.1

