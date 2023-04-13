Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75E5C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDMGmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDMGlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FA76EA0
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=861DjOxRz0hWq3oLEJVQ7Zp9Eze0CaEbJvu/eq8SwTc=; b=3LBZH4mvqCRT8MDssYJ0izr2PE
        gMobKBmQRjGdtAkuDUIffPUp55Jf8MDKPIC6DtJqHHHWxv16aKgfjuC7y4LppQp6eiEoOZFiw+nC+
        Cov7A5a4NQ+SpTRocAdxD9T2hbtC+y8+yxdDkCnAKqbBgiCamk2kVsagrKLyMspLtIpmcI4FhcWxh
        RhhW4bQRwubQ8rRQcDULShel8db4HqW0ZyNAVEq9bS2OlvQ/cbrMsCXNjTlGZYxgXB55BNwrMn+t0
        ks82wX20Ps7HXPOIbo7OTsYLcvsoflcBQ4sVJtqiPf40bWXkKNPVtjUSocn+p/Z4nsE2hxj+C11kI
        SidrCFdg==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqeK-005BXH-1u;
        Thu, 13 Apr 2023 06:41:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 16/20] blk-mq: don't kick the requeue_list in blk_mq_add_to_requeue_list
Date:   Thu, 13 Apr 2023 08:40:53 +0200
Message-Id: <20230413064057.707578-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_add_to_requeue_list takes a bool parameter to control how to kick
the requeue list at the end of the function.  Move the call to
blk_mq_kick_requeue_list to the callers that want it instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c |  6 ++++--
 block/blk-mq.c    | 13 +++++++------
 block/blk-mq.h    |  3 +--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3561aba8cc23f8..015982bd2f7c8f 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -188,7 +188,8 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		blk_mq_add_to_requeue_list(rq, true, true);
+		blk_mq_add_to_requeue_list(rq, true);
+		blk_mq_kick_requeue_list(q);
 		break;
 
 	case REQ_FSEQ_DONE:
@@ -345,7 +346,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	smp_wmb();
 	req_ref_set(flush_rq, 1);
 
-	blk_mq_add_to_requeue_list(flush_rq, false, true);
+	blk_mq_add_to_requeue_list(flush_rq, false);
+	blk_mq_kick_requeue_list(q);
 }
 
 static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cde7ba9c39bf6b..db806c1a194c7b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1412,12 +1412,17 @@ static void __blk_mq_requeue_request(struct request *rq)
 
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 {
+	struct request_queue *q = rq->q;
+
 	__blk_mq_requeue_request(rq);
 
 	/* this request will be re-inserted to io scheduler queue */
 	blk_mq_sched_requeue_request(rq);
 
-	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
+	blk_mq_add_to_requeue_list(rq, true);
+
+	if (kick_requeue_list)
+		blk_mq_kick_requeue_list(q);
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);
 
@@ -1459,8 +1464,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	blk_mq_run_hw_queues(q, false);
 }
 
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
-				bool kick_requeue_list)
+void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
 {
 	struct request_queue *q = rq->q;
 	unsigned long flags;
@@ -1479,9 +1483,6 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 		list_add_tail(&rq->queuelist, &q->requeue_list);
 	}
 	spin_unlock_irqrestore(&q->requeue_lock, flags);
-
-	if (kick_requeue_list)
-		blk_mq_kick_requeue_list(q);
 }
 
 void blk_mq_kick_requeue_list(struct request_queue *q)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f30f99166f3870..5d3761c5006346 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -44,8 +44,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
 			     unsigned int);
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
-				bool kick_requeue_list);
+void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
-- 
2.39.2

