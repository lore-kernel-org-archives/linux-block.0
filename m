Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA1C433DB
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 02:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F8A2245C
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 02:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbhATCQo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 21:16:44 -0500
Received: from out28-49.mail.aliyun.com ([115.124.28.49]:56477 "EHLO
        out28-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbhATCQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 21:16:30 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07443002|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00585233-0.000255196-0.993892;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JN2OyIq_1611108925;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.JN2OyIq_1611108925)
          by smtp.aliyun-inc.com(10.194.99.21);
          Wed, 20 Jan 2021 10:15:26 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH] blk-mq: introduce REQ_COMPLETE_WQ and add a workqueue to complete the request
Date:   Wed, 20 Jan 2021 10:15:22 +0800
Message-Id: <20210120021522.28584-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit "40d09b53bfc557af7481b9d80f060a7ac9c7d314" has solved the
irqsoff problem by completing the request in softirq. But it may cause
the system to suffer bad preemptoff time.
Introduce the REQ_COMPLETE_WQ flag and blk_complete workqueue.
This flag makes the request to be completed in the blk_complete workqueue.
It can be used for requests that want to cut down both irqsoff and
preemptoff time.

Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 block/blk-mq.c            | 46 +++++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h |  4 ++++
 include/linux/blkdev.h    |  5 +++++
 3 files changed, 55 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f285a9123..c707582ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -42,6 +42,10 @@
 #include "blk-rq-qos.h"
 
 static DEFINE_PER_CPU(struct list_head, blk_cpu_done);
+/*
+ * Controlling structure for block complete
+ */
+static struct workqueue_struct *blk_complete_wq;
 
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
@@ -567,6 +571,26 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(blk_mq_end_request);
 
+static void blk_mq_complete_work(struct work_struct *work)
+{
+	struct request_queue *q =
+		container_of(work, struct request_queue, complete_work);
+	struct list_head local_list;
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->complete_lock, flags);
+	list_replace_init(&q->complete_list, &local_list);
+	spin_unlock_irqrestore(&q->complete_lock, flags);
+
+	while (!list_empty(&local_list)) {
+		struct request *rq;
+
+		rq = list_entry(local_list.next, struct request, complete_list);
+		list_del_init(&rq->complete_list);
+		rq->q->mq_ops->complete(rq);
+	}
+}
+
 /*
  * Softirq action handler - move entries to local list and loop over them
  * while passing them to the queue registered handler.
@@ -680,6 +704,19 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	if (rq->cmd_flags & REQ_HIPRI)
 		return false;
 
+	/*
+	 * For a request that wants to complete in workqueue,
+	 */
+	if (rq->cmd_flags & REQ_COMPLETE_WQ) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&rq->q->complete_lock, flags);
+		list_add_tail(&rq->complete_list, &rq->q->complete_list);
+		spin_unlock_irqrestore(&rq->q->complete_lock, flags);
+		queue_work(blk_complete_wq, &rq->q->complete_work);
+		return true;
+	}
+
 	if (blk_mq_complete_need_ipi(rq)) {
 		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
 		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
@@ -3211,6 +3248,10 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
 
+	INIT_WORK(&q->complete_work, blk_mq_complete_work);
+	INIT_LIST_HEAD(&q->complete_list);
+	spin_lock_init(&q->complete_lock);
+
 	q->nr_requests = set->queue_depth;
 
 	/*
@@ -3907,6 +3948,11 @@ static int __init blk_mq_init(void)
 		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
 
+	blk_complete_wq = alloc_workqueue("blk_complete",
+					WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (!blk_complete_wq)
+		panic("Failed to create blk_complete\n");
+
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
 				  "block/softirq:dead", NULL,
 				  blk_softirq_cpu_dead);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 866f74261..251110fd9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -421,6 +421,9 @@ enum req_flag_bits {
 
 	__REQ_HIPRI,
 
+	/* do req complete in workqueue */
+	__REQ_COMPLETE_WQ,
+
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
@@ -445,6 +448,7 @@ enum req_flag_bits {
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
+#define REQ_COMPLETE_WQ		(1ULL << __REQ_COMPLETE_WQ)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089..758aff8f0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -143,6 +143,7 @@ struct request {
 	struct bio *biotail;
 
 	struct list_head queuelist;
+	struct list_head complete_list;
 
 	/*
 	 * The hash is used inside the scheduler, and killed once the
@@ -543,6 +544,10 @@ struct request_queue {
 	spinlock_t		requeue_lock;
 	struct delayed_work	requeue_work;
 
+	struct list_head	complete_list;
+	spinlock_t		complete_lock;
+	struct work_struct	complete_work;
+
 	struct mutex		sysfs_lock;
 	struct mutex		sysfs_dir_lock;
 
-- 
2.17.1

