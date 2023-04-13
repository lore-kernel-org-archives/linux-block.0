Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD47C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDMGmV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDMGmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:42:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B28A54
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gmnxPzxY3V2iuHZ+62X2590wiQYs3zbgTqohl1wRqPk=; b=fpxtlwc6sE1w4Wm0n+ptJJyhuo
        G4zw/7xV6G2O7i2T98siC5YzpIpFuby46fINPtYHE5i0/dFQYlTbPkh4BzmamPsGMz1/RQfd/CwIy
        WDHfozJDwQygbL1Ln4ktQsTiVzN/hTuxiabYooahMh5t1JA0zX4BiySeU2zN74fZkpCFgtYeyYgbB
        sDNycPTqADHlzhoNEuD3f0xOlctjQg3hWuo10EMBavVEIJ4buQCQhz9xvVUwMJ6bWoqYFYpzX91Au
        xMYczzkzPprqfrTuW3FTctg7j2th+hT70sJjSnDaZdTMeP75XtiselBwanDvYPLvAV9IWSi/ZWm5u
        R5MM9orQ==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqeU-005BZ4-2u;
        Thu, 13 Apr 2023 06:41:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 20/20] blk-mq: pass a flags argument to blk_mq_add_to_requeue_list
Date:   Thu, 13 Apr 2023 08:40:57 +0200
Message-Id: <20230413064057.707578-21-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the boolean at_head argument with the same flags that are already
passed to blk_mq_insert_request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 4 ++--
 block/blk-mq.c    | 6 +++---
 block/blk-mq.h    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 1d3af17619deb7..00dd2f61312d89 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -188,7 +188,7 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		blk_mq_add_to_requeue_list(rq, true);
+		blk_mq_add_to_requeue_list(rq, BLK_MQ_INSERT_AT_HEAD);
 		blk_mq_kick_requeue_list(q);
 		break;
 
@@ -346,7 +346,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	smp_wmb();
 	req_ref_set(flush_rq, 1);
 
-	blk_mq_add_to_requeue_list(flush_rq, false);
+	blk_mq_add_to_requeue_list(flush_rq, BLK_MQ_INSERT_AT_HEAD);
 	blk_mq_kick_requeue_list(q);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6c3db1a15dadc9..1e35c829bdddfe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1419,7 +1419,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 	/* this request will be re-inserted to io scheduler queue */
 	blk_mq_sched_requeue_request(rq);
 
-	blk_mq_add_to_requeue_list(rq, true);
+	blk_mq_add_to_requeue_list(rq, BLK_MQ_INSERT_AT_HEAD);
 
 	if (kick_requeue_list)
 		blk_mq_kick_requeue_list(q);
@@ -1464,7 +1464,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	blk_mq_run_hw_queues(q, false);
 }
 
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
+void blk_mq_add_to_requeue_list(struct request *rq, blk_insert_t insert_flags)
 {
 	struct request_queue *q = rq->q;
 	unsigned long flags;
@@ -1476,7 +1476,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
 	BUG_ON(rq->rq_flags & RQF_SOFTBARRIER);
 
 	spin_lock_irqsave(&q->requeue_lock, flags);
-	if (at_head) {
+	if (insert_flags & BLK_MQ_INSERT_AT_HEAD) {
 		rq->rq_flags |= RQF_SOFTBARRIER;
 		list_add(&rq->queuelist, &q->requeue_list);
 	} else {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index bb16c0a54411b0..f882677ff106a5 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,7 +47,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
 			     unsigned int);
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
+void blk_mq_add_to_requeue_list(struct request *rq, blk_insert_t insert_flags);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
-- 
2.39.2

