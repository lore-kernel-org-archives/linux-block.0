Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC93C77B73
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 20:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDPUKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDPUKC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 16:10:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006826B2
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kskBz+K5hDOHsU7cPAhbmxuJUmo719Z1ic+aOMKg+SA=; b=NjpHTd3py1ValragXM1evvvQS2
        JXCrq+5Hpj6dk4iZm1AkQaOV7u5wkTgVg/xa4APbkztbwM4/nSHM9/8eE+EMFwDjCWNXoNiGS6R2+
        oxrdu5ROFWnxa4csJw1DBZ7A/TEYR+E08lZ2m40VhEpRx2U3J1Dftbs6srTOoSG3ul+kv8p8LX5Oy
        ToI5I99Faj4bxKUx6t2r1ReJ+5VRU7Htu2rCQafX8+w+ox+I8DdIGaOdiOHK86ZqIHq+nF5v+fjTl
        H4fpt8MCJvJICS+Jf0RH7HGdG6PWbrrxivyltrnNzvg/KaHIrQUdZek/caBoieb9NIwn2kgr0XwXn
        nwql71Uw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8hC-00EOJZ-1R;
        Sun, 16 Apr 2023 20:09:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush commands
Date:   Sun, 16 Apr 2023 22:09:30 +0200
Message-Id: <20230416200930.29542-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416200930.29542-1-hch@lst.de>
References: <20230416200930.29542-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently both requeues of commands that were already sent to the
driver and flush commands submitted from the flush state machine
share the same requeue_list struct request_queue, despite requeues
doing head insertations and flushes not.  Switch to using two
separate lists instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c      |  9 +++++++--
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 36 +++++++++++++++---------------------
 block/blk-mq.h         |  1 -
 include/linux/blk-mq.h |  4 +---
 include/linux/blkdev.h |  1 +
 6 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 69e9806f575455..231d3780e74ad1 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -188,7 +188,9 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		blk_mq_add_to_requeue_list(rq, 0);
+		spin_lock(&q->requeue_lock);
+		list_add_tail(&rq->queuelist, &q->flush_list);
+		spin_unlock(&q->requeue_lock);
 		blk_mq_kick_requeue_list(q);
 		break;
 
@@ -349,7 +351,10 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	smp_wmb();
 	req_ref_set(flush_rq, 1);
 
-	blk_mq_add_to_requeue_list(flush_rq, 0);
+	spin_lock(&q->requeue_lock);
+	list_add_tail(&flush_rq->queuelist, &q->flush_list);
+	spin_unlock(&q->requeue_lock);
+
 	blk_mq_kick_requeue_list(q);
 }
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d23a8554ec4aeb..0d2a0f0524b53e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -241,7 +241,6 @@ static const char *const cmd_flag_name[] = {
 #define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
 static const char *const rqf_name[] = {
 	RQF_NAME(STARTED),
-	RQF_NAME(SOFTBARRIER),
 	RQF_NAME(FLUSH_SEQ),
 	RQF_NAME(MIXED_MERGE),
 	RQF_NAME(MQ_INFLIGHT),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 50a03e1592819c..eaed84a346c9c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1403,13 +1403,16 @@ static void __blk_mq_requeue_request(struct request *rq)
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 {
 	struct request_queue *q = rq->q;
+	unsigned long flags;
 
 	__blk_mq_requeue_request(rq);
 
 	/* this request will be re-inserted to io scheduler queue */
 	blk_mq_sched_requeue_request(rq);
 
-	blk_mq_add_to_requeue_list(rq, BLK_MQ_INSERT_AT_HEAD);
+	spin_lock_irqsave(&q->requeue_lock, flags);
+	list_add_tail(&rq->queuelist, &q->requeue_list);
+	spin_unlock_irqrestore(&q->requeue_lock, flags);
 
 	if (kick_requeue_list)
 		blk_mq_kick_requeue_list(q);
@@ -1421,13 +1424,16 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	struct request_queue *q =
 		container_of(work, struct request_queue, requeue_work.work);
 	LIST_HEAD(rq_list);
-	struct request *rq, *next;
+	LIST_HEAD(flush_list);
+	struct request *rq;
 
 	spin_lock_irq(&q->requeue_lock);
 	list_splice_init(&q->requeue_list, &rq_list);
+	list_splice_init(&q->flush_list, &flush_list);
 	spin_unlock_irq(&q->requeue_lock);
 
-	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
+	while (!list_empty(&rq_list)) {
+		rq = list_entry(rq_list.next, struct request, queuelist);
 		/*
 		 * If RQF_DONTPREP ist set, the request has been started by the
 		 * driver already and might have driver-specific data allocated
@@ -1435,18 +1441,16 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		 * block layer merges for the request.
 		 */
 		if (rq->rq_flags & RQF_DONTPREP) {
-			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
 			blk_mq_request_bypass_insert(rq, 0);
-		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
-			rq->rq_flags &= ~RQF_SOFTBARRIER;
+		} else {
 			list_del_init(&rq->queuelist);
 			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
 		}
 	}
 
-	while (!list_empty(&rq_list)) {
-		rq = list_entry(rq_list.next, struct request, queuelist);
+	while (!list_empty(&flush_list)) {
+		rq = list_entry(flush_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
 		blk_mq_insert_request(rq, 0);
 	}
@@ -1454,24 +1458,13 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	blk_mq_run_hw_queues(q, false);
 }
 
-void blk_mq_add_to_requeue_list(struct request *rq, blk_insert_t insert_flags)
+void blk_flush_queue_insert(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	unsigned long flags;
 
-	/*
-	 * We abuse this flag that is otherwise used by the I/O scheduler to
-	 * request head insertion from the workqueue.
-	 */
-	BUG_ON(rq->rq_flags & RQF_SOFTBARRIER);
-
 	spin_lock_irqsave(&q->requeue_lock, flags);
-	if (insert_flags & BLK_MQ_INSERT_AT_HEAD) {
-		rq->rq_flags |= RQF_SOFTBARRIER;
-		list_add(&rq->queuelist, &q->requeue_list);
-	} else {
-		list_add_tail(&rq->queuelist, &q->requeue_list);
-	}
+	list_add_tail(&rq->queuelist, &q->flush_list);
 	spin_unlock_irqrestore(&q->requeue_lock, flags);
 }
 
@@ -4222,6 +4215,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_update_poll_flag(q);
 
 	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
+	INIT_LIST_HEAD(&q->flush_list);
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 62c505e6ef1e40..1955e0c08d154c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,7 +47,6 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
 			     unsigned int);
-void blk_mq_add_to_requeue_list(struct request *rq, blk_insert_t insert_flags);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a204a5f3cc9524..23fa9fdf59f3e1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -28,8 +28,6 @@ typedef __u32 __bitwise req_flags_t;
 
 /* drive already may have started this one */
 #define RQF_STARTED		((__force req_flags_t)(1 << 1))
-/* may not be passed by ioscheduler */
-#define RQF_SOFTBARRIER		((__force req_flags_t)(1 << 3))
 /* request for flush sequence */
 #define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
 /* merge of different types, fail separately */
@@ -65,7 +63,7 @@ typedef __u32 __bitwise req_flags_t;
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
+	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
 
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6ede578dfbc642..649274b4043b69 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -490,6 +490,7 @@ struct request_queue {
 	 * for flush operations
 	 */
 	struct blk_flush_queue	*fq;
+	struct list_head	flush_list;
 
 	struct list_head	requeue_list;
 	spinlock_t		requeue_lock;
-- 
2.39.2

