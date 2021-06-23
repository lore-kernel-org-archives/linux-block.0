Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAAEC49EA4
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 09:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B36E6113B
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFWJi7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 05:38:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhFWJi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 05:38:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EDD7821976;
        Wed, 23 Jun 2021 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624441000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qB6WZciel8xDXNiwzVgwxTmPDuDpG5WLmuhtMkXt06M=;
        b=foJa93b4hWL2WpHcjtmksVe/3HTkmqn2PKnE6gAA3BQD3n8IvjF3GZG4d9IFWoTQnCbQvS
        N7oZk0f0dOni3/SnZ4kTxx4cpI6hAuQhogk7cROEmQJtbIZNdw9DOXeC/nZEm+UsKFlHmZ
        4VDre6KBTyyxHIrqR4OoXFMlUpKTT3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624441000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qB6WZciel8xDXNiwzVgwxTmPDuDpG5WLmuhtMkXt06M=;
        b=ndt40tXPoFkIO0grQdgo8XwNK/KAZaR2YZuuo4S7G2JFgP51jYRnNi9eFOE835zksVdztq
        VLmFmO0FbYBk6DBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 8E53FA3B8D;
        Wed, 23 Jun 2021 09:36:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D11301F2CB0; Wed, 23 Jun 2021 11:36:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] blk: Fix lock inversion between ioc lock and bfqd lock
Date:   Wed, 23 Jun 2021 11:36:34 +0200
Message-Id: <20210623093634.27879-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210623093634.27879-1-jack@suse.cz>
References: <20210623093634.27879-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9349; h=from:subject; bh=I7PtGt7lGdlmr6gItnpXl70OEl0U2/tGO8fFojyBRA8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg0wCha8qmbTSrQdtEVVpCzKQaGkUrX/tmRRNSkOzR /KhjPluJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYNMAoQAKCRCcnaoHP2RA2TuqB/ 9Z7Diygb4W/gnn4PifvSEk2IHzBiFkyWfIOyJrheR+teDbEB/x5TCkl49BdswbjwmfS20IuM1hVTz5 nwv9p5CQMxhkPUNR5ixnI5KXbWE/kkjgDKWpUroBv1hVxvIKpewyjZI/SeEbFo61T4wsczBZmpMm4l WbgzXRhGux6VHAQ9vEuKKe9M5w8OI9q0/2/NYaZCjhX2+XxtfewgSmQU09VqKx6Ffc7NSl+jSUAt3D oA0ozeqtASKRcBdKWwl6uJXy+g1vSKg6FyBx6LWHslsJxv5HIdRZPb9NLv09J4WsapIQ0cXNIB5LSH 3Lx5SW4put6i95NqYlx/BUfWjDSZA7
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Lockdep complains about lock inversion between ioc->lock and bfqd->lock:

bfqd -> ioc:
 put_io_context+0x33/0x90 -> ioc->lock grabbed
 blk_mq_free_request+0x51/0x140
 blk_put_request+0xe/0x10
 blk_attempt_req_merge+0x1d/0x30
 elv_attempt_insert_merge+0x56/0xa0
 blk_mq_sched_try_insert_merge+0x4b/0x60
 bfq_insert_requests+0x9e/0x18c0 -> bfqd->lock grabbed
 blk_mq_sched_insert_requests+0xd6/0x2b0
 blk_mq_flush_plug_list+0x154/0x280
 blk_finish_plug+0x40/0x60
 ext4_writepages+0x696/0x1320
 do_writepages+0x1c/0x80
 __filemap_fdatawrite_range+0xd7/0x120
 sync_file_range+0xac/0xf0

ioc->bfqd:
 bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
 put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
 exit_io_context+0x48/0x50
 do_exit+0x7e9/0xdd0
 do_group_exit+0x54/0xc0

To avoid this inversion we change blk_mq_sched_try_insert_merge() to not
free the merged request but rather leave that upto the caller similarly
to blk_mq_sched_try_merge(). And in bfq_insert_requests() we make sure
to free all the merged requests after dropping bfqd->lock.

Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c      |  6 ++++--
 block/blk-merge.c        | 19 ++++++++-----------
 block/blk-mq-sched.c     |  5 +++--
 block/blk-mq-sched.h     |  3 ++-
 block/blk-mq.h           | 11 +++++++++++
 block/blk.h              |  2 +-
 block/elevator.c         | 11 ++++++++---
 block/mq-deadline-main.c |  5 ++++-
 include/linux/elevator.h |  3 ++-
 9 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9433d38e486c..727955918563 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2345,9 +2345,9 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 
+	spin_unlock_irq(&bfqd->lock);
 	if (free)
 		blk_mq_free_request(free);
-	spin_unlock_irq(&bfqd->lock);
 
 	return ret;
 }
@@ -5969,14 +5969,16 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct bfq_queue *bfqq;
 	bool idle_timer_disabled = false;
 	unsigned int cmd_flags;
+	LIST_HEAD(free);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys) && rq->bio)
 		bfqg_stats_update_legacy_io(q, rq);
 #endif
 	spin_lock_irq(&bfqd->lock);
-	if (blk_mq_sched_try_insert_merge(q, rq)) {
+	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		spin_unlock_irq(&bfqd->lock);
+		blk_mq_free_requests(&free);
 		return;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4d97fb6dd226..1398b52a24b4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -846,18 +846,15 @@ static struct request *attempt_front_merge(struct request_queue *q,
 	return NULL;
 }
 
-int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
-			  struct request *next)
+/*
+ * Try to merge 'next' into 'rq'. Return true if the merge happened, false
+ * otherwise. The caller is responsible for freeing 'next' if the merge
+ * happened.
+ */
+bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
+			   struct request *next)
 {
-	struct request *free;
-
-	free = attempt_merge(q, rq, next);
-	if (free) {
-		blk_put_request(free);
-		return 1;
-	}
-
-	return 0;
+	return attempt_merge(q, rq, next);
 }
 
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2403a5c2b053..c838d81ac058 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -399,9 +399,10 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	return ret;
 }
 
-bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq)
+bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
+				   struct list_head *free)
 {
-	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq);
+	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq, free);
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index aff037cfd8e7..5246ae040704 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -13,7 +13,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs);
-bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
+bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
+				   struct list_head *free);
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 4b1ca7b7bbeb..d08779f77a26 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -302,6 +302,17 @@ static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
 	return NULL;
 }
 
+/* Free all requests on the list */
+static inline void blk_mq_free_requests(struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct request *rq = list_entry_rq(list->next);
+
+		list_del_init(&rq->queuelist);
+		blk_mq_free_request(rq);
+	}
+}
+
 /*
  * For shared tag users, we track the number of currently active users
  * and attempt to provide a fair share of the tag depth for each of them.
diff --git a/block/blk.h b/block/blk.h
index d3fa47af3607..9ad3c7ee6ba0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -224,7 +224,7 @@ ssize_t part_timeout_store(struct device *, struct device_attribute *,
 void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
-int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
+bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
 unsigned int blk_recalc_rq_segments(struct request *rq);
 void blk_rq_set_mixed_merge(struct request *rq);
diff --git a/block/elevator.c b/block/elevator.c
index 85d0d4adbb64..52ada14cfe45 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -350,9 +350,11 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
  * we can append 'rq' to an existing request, so we can throw 'rq' away
  * afterwards.
  *
- * Returns true if we merged, false otherwise
+ * Returns true if we merged, false otherwise. 'free' will contain all
+ * requests that need to be freed.
  */
-bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
+bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq,
+			      struct list_head *free)
 {
 	struct request *__rq;
 	bool ret;
@@ -363,8 +365,10 @@ bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
 	/*
 	 * First try one-hit cache.
 	 */
-	if (q->last_merge && blk_attempt_req_merge(q, q->last_merge, rq))
+	if (q->last_merge && blk_attempt_req_merge(q, q->last_merge, rq)) {
+		list_add(&rq->queuelist, free);
 		return true;
+	}
 
 	if (blk_queue_noxmerges(q))
 		return false;
@@ -378,6 +382,7 @@ bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
 		if (!__rq || !blk_attempt_req_merge(q, __rq, rq))
 			break;
 
+		list_add(&rq->queuelist, free);
 		/* The merged request could be merged with others, try again */
 		ret = true;
 		rq = __rq;
diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
index 4815e536091f..9db6da9ef4c6 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline-main.c
@@ -719,6 +719,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
 	struct dd_blkcg *blkcg;
+	LIST_HEAD(free);
 
 	lockdep_assert_held(&dd->lock);
 
@@ -742,8 +743,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	WARN_ON_ONCE(rq->elv.priv[0]);
 	rq->elv.priv[0] = blkcg;
 
-	if (blk_mq_sched_try_insert_merge(q, rq))
+	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
+		blk_mq_free_requests(&free);
 		return;
+	}
 
 	trace_block_rq_insert(rq);
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 783ecb3cb77a..ef9ceead3db1 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -117,7 +117,8 @@ extern void elv_merge_requests(struct request_queue *, struct request *,
 			       struct request *);
 extern void elv_merged_request(struct request_queue *, struct request *,
 		enum elv_merge);
-extern bool elv_attempt_insert_merge(struct request_queue *, struct request *);
+extern bool elv_attempt_insert_merge(struct request_queue *, struct request *,
+				     struct list_head *);
 extern struct request *elv_former_request(struct request_queue *, struct request *);
 extern struct request *elv_latter_request(struct request_queue *, struct request *);
 void elevator_init_mq(struct request_queue *q);
-- 
2.26.2

