Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C453EC4332D
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 10:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD5C2310D
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 10:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbhAFKZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:25:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:54028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbhAFKZQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jan 2021 05:25:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1153DB7A7;
        Wed,  6 Jan 2021 10:24:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C5B5F1E0802; Wed,  6 Jan 2021 11:24:34 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] Revert "blk-mq, elevator: Count requests per hctx to improve performance"
Date:   Wed,  6 Jan 2021 11:24:27 +0100
Message-Id: <20210106102428.551-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210106102428.551-1-jack@suse.cz>
References: <20210106102428.551-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit b445547ec1bbd3e7bf4b1c142550942f70527d95.

Since both mq-deadline and BFQ completely ignore hctx they are passed to
their dispatch function and dispatch whatever request they deem fit
checking whether any request for a particular hctx is queued is just
pointless since we'll very likely get a request from a different hctx
anyway. In the following commit we'll deal with lock contention in these
IO schedulers in presence of multiple HW queues in a different way.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c    | 5 -----
 block/blk-mq.c         | 1 -
 block/mq-deadline.c    | 6 ------
 include/linux/blk-mq.h | 4 ----
 4 files changed, 16 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e81d1052091..a99dfaa75a8c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4640,9 +4640,6 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 
-	if (!atomic_read(&hctx->elevator_queued))
-		return false;
-
 	/*
 	 * Avoiding lock: a race on bfqd->busy_queues should cause at
 	 * most a call to dispatch for nothing
@@ -5557,7 +5554,6 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
 		bfq_insert_request(hctx, rq, at_head);
-		atomic_inc(&hctx->elevator_queued);
 	}
 }
 
@@ -5925,7 +5921,6 @@ static void bfq_finish_requeue_request(struct request *rq)
 
 		bfq_completed_request(bfqq, bfqd);
 		bfq_finish_requeue_request_body(bfqq);
-		atomic_dec(&rq->mq_hctx->elevator_queued);
 
 		spin_unlock_irqrestore(&bfqd->lock, flags);
 	} else {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f285a9123a8b..57f3482b2c26 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2653,7 +2653,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 		goto free_hctx;
 
 	atomic_set(&hctx->nr_active, 0);
-	atomic_set(&hctx->elevator_queued, 0);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 	hctx->numa_node = node;
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 800ac902809b..b57470e154c8 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -386,8 +386,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	spin_lock(&dd->lock);
 	rq = __dd_dispatch_request(dd);
 	spin_unlock(&dd->lock);
-	if (rq)
-		atomic_dec(&rq->mq_hctx->elevator_queued);
 
 	return rq;
 }
@@ -535,7 +533,6 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
 		dd_insert_request(hctx, rq, at_head);
-		atomic_inc(&hctx->elevator_queued);
 	}
 	spin_unlock(&dd->lock);
 }
@@ -582,9 +579,6 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 
-	if (!atomic_read(&hctx->elevator_queued))
-		return false;
-
 	return !list_empty_careful(&dd->dispatch) ||
 		!list_empty_careful(&dd->fifo_list[0]) ||
 		!list_empty_careful(&dd->fifo_list[1]);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d705b174d346..b4b9604bbfd7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -140,10 +140,6 @@ struct blk_mq_hw_ctx {
 	 * shared across request queues.
 	 */
 	atomic_t		nr_active;
-	/**
-	 * @elevator_queued: Number of queued requests on hctx.
-	 */
-	atomic_t                elevator_queued;
 
 	/** @cpuhp_online: List to store request if CPU is going to die */
 	struct hlist_node	cpuhp_online;
-- 
2.26.2

