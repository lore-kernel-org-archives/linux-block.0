Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B14EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 11:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjF2LHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 07:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjF2LHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 07:07:20 -0400
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [IPv6:2001:41d0:203:375::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB151FE3
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 04:07:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688036836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MamvVjI1jeXw3Kjngjhi6g/DzhtYYjp3x8kVfhCNxDw=;
        b=gLJaqTIYrWNNdCKmHcyxDtI7XwL0mz5l3b8romo8vPvm3yG7ob3tBombjqyDMsDaGTHxQb
        +kHsA+GFLKWIs8pAEGKOvbbzIVfb/nq9my9qTM5RpeenzPBIiyKWjry3rp6b7NL5Rz8VSt
        15Y7uKyzuXr8dJjMaVC2yBqu+gsqTXE=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 2/4] blk-flush: count inflight flush_data requests
Date:   Thu, 29 Jun 2023 19:03:57 +0800
Message-Id: <20230629110359.1111832-3-chengming.zhou@linux.dev>
In-Reply-To: <20230629110359.1111832-1-chengming.zhou@linux.dev>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The flush state machine use a double list to link all inflight
flush_data requests, to avoid issuing separate post-flushes for
these flush_data requests which shared PREFLUSH.

So we can't reuse rq->queuelist, this is why we need rq->flush.list

In preparation of the next patch that reuse rq->queuelist for flush
state machine, we change the double linked list to unsigned long
counter, which count all inflight flush_data requests.

This is ok since we only need to know if there is any inflight
flush_data request, so unsigned long counter is good.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-flush.c | 9 +++++----
 block/blk.h       | 5 ++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index dba392cf22be..bb7adfc2a5da 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -187,7 +187,8 @@ static void blk_flush_complete_seq(struct request *rq,
 		break;
 
 	case REQ_FSEQ_DATA:
-		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
+		list_del_init(&rq->flush.list);
+		fq->flush_data_in_flight++;
 		spin_lock(&q->requeue_lock);
 		list_add_tail(&rq->queuelist, &q->flush_list);
 		spin_unlock(&q->requeue_lock);
@@ -299,7 +300,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 		return;
 
 	/* C2 and C3 */
-	if (!list_empty(&fq->flush_data_in_flight) &&
+	if (fq->flush_data_in_flight &&
 	    time_before(jiffies,
 			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
 		return;
@@ -374,6 +375,7 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 	 * the comment in flush_end_io().
 	 */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	fq->flush_data_in_flight--;
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
@@ -445,7 +447,7 @@ bool blk_insert_flush(struct request *rq)
 		blk_rq_init_flush(rq);
 		rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
 		spin_lock_irq(&fq->mq_flush_lock);
-		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
+		fq->flush_data_in_flight++;
 		spin_unlock_irq(&fq->mq_flush_lock);
 		return false;
 	default:
@@ -496,7 +498,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 
 	INIT_LIST_HEAD(&fq->flush_queue[0]);
 	INIT_LIST_HEAD(&fq->flush_queue[1]);
-	INIT_LIST_HEAD(&fq->flush_data_in_flight);
 
 	return fq;
 
diff --git a/block/blk.h b/block/blk.h
index 608c5dcc516b..686712e13835 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -15,15 +15,14 @@ struct elevator_type;
 extern struct dentry *blk_debugfs_root;
 
 struct blk_flush_queue {
+	spinlock_t		mq_flush_lock;
 	unsigned int		flush_pending_idx:1;
 	unsigned int		flush_running_idx:1;
 	blk_status_t 		rq_status;
 	unsigned long		flush_pending_since;
 	struct list_head	flush_queue[2];
-	struct list_head	flush_data_in_flight;
+	unsigned long		flush_data_in_flight;
 	struct request		*flush_rq;
-
-	spinlock_t		mq_flush_lock;
 };
 
 bool is_flush_rq(struct request *req);
-- 
2.39.2

