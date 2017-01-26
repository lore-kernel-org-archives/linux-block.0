Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41301 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753437AbdAZTsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 14:48:31 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <bart.vanassche@sandisk.com>, <hch@lst.de>, <osandov@fb.com>,
        <paolo.valente@linaro.org>, <hare@suse.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 5/5] blk-mq-sched: change ->dispatch_requests() to ->dispatch_request()
Date: Thu, 26 Jan 2017 12:48:18 -0700
Message-ID: <1485460098-16608-6-git-send-email-axboe@fb.com>
In-Reply-To: <1485460098-16608-1-git-send-email-axboe@fb.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When we invoke dispatch_requests(), the scheduler empties everything
into the passed in list. This isn't always a good thing, since it
means that we remove items that we could have potentially merged
with.

Change the function to dispatch single requests at the time. If
we do that, we can backoff exactly at the point where the device
can't consume more IO, and leave the rest with the scheduler for
better merging and future dispatch decision making.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-sched.c     | 23 +++++++++++++++--------
 block/blk-mq.c           |  2 +-
 block/mq-deadline.c      | 10 ++++++----
 include/linux/elevator.h |  2 +-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 69502ff89f3a..3136696f4991 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -200,15 +200,22 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * leave them there for as long as we can. Mark the hw queue as
 	 * needing a restart in that case.
 	 */
-	if (list_empty(&rq_list)) {
-		if (e && e->type->ops.mq.dispatch_requests)
-			e->type->ops.mq.dispatch_requests(hctx, &rq_list);
-		else
-			blk_mq_flush_busy_ctxs(hctx, &rq_list);
-	} else
+	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart(hctx);
-
-	blk_mq_dispatch_rq_list(hctx, &rq_list);
+		blk_mq_dispatch_rq_list(hctx, &rq_list);
+	} else if (!e || !e->type->ops.mq.dispatch_request) {
+		blk_mq_flush_busy_ctxs(hctx, &rq_list);
+		blk_mq_dispatch_rq_list(hctx, &rq_list);
+	} else {
+		do {
+			struct request *rq;
+
+			rq = e->type->ops.mq.dispatch_request(hctx);
+			if (!rq)
+				break;
+			list_add(&rq->queuelist, &rq_list);
+		} while (blk_mq_dispatch_rq_list(hctx, &rq_list));
+	}
 }
 
 void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fcb5f9f445f7..ee20f43f8e83 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -999,7 +999,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 	 */
 	if (!list_empty(list)) {
 		spin_lock(&hctx->lock);
-		list_splice(list, &hctx->dispatch);
+		list_splice_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
 
 		/*
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a01986d7b6fb..d93ec713fa62 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -287,14 +287,16 @@ static struct request *__dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
-static void dd_dispatch_requests(struct blk_mq_hw_ctx *hctx,
-				 struct list_head *rq_list)
+static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
+	struct request *rq;
 
 	spin_lock(&dd->lock);
-	blk_mq_sched_move_to_dispatch(hctx, rq_list, __dd_dispatch_request);
+	rq = __dd_dispatch_request(hctx);
 	spin_unlock(&dd->lock);
+
+	return rq;
 }
 
 static void dd_exit_queue(struct elevator_queue *e)
@@ -517,7 +519,7 @@ static struct elv_fs_entry deadline_attrs[] = {
 static struct elevator_type mq_deadline = {
 	.ops.mq = {
 		.insert_requests	= dd_insert_requests,
-		.dispatch_requests	= dd_dispatch_requests,
+		.dispatch_request	= dd_dispatch_request,
 		.next_request		= elv_rb_latter_request,
 		.former_request		= elv_rb_former_request,
 		.bio_merge		= dd_bio_merge,
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index ecb96fd67c6d..b5825c4f06f7 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -92,7 +92,7 @@ struct elevator_mq_ops {
 	struct request *(*get_request)(struct request_queue *, unsigned int, struct blk_mq_alloc_data *);
 	void (*put_request)(struct request *);
 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
-	void (*dispatch_requests)(struct blk_mq_hw_ctx *, struct list_head *);
+	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
 	void (*completed_request)(struct blk_mq_hw_ctx *, struct request *);
 	void (*started_request)(struct request *);
-- 
2.7.4

