Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753798AbdASSAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 13:00:11 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0JHXcNP004473
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2017 09:37:39 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2831tkr1rg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2017 09:37:39 -0800
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Subject: [PATCH] blk-mq: allow resize of scheduler requests
Message-ID: <62d3fe78-9a16-edce-8746-e8d2e7181f23@fb.com>
Date: Thu, 19 Jan 2017 09:37:34 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Add support for growing the tags associated with a hardware queue, for
the scheduler tags. Currently we only support resizing within the
limits of the original depth, change that so we can grow it as well by
allocating and replacing the existing scheduler tag set.

This is similar to how we could increase the software queue depth with
the legacy IO stack and schedulers.

Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 5504eb7ed10b..3ab514f6f288 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -387,19 +387,52 @@ void blk_mq_free_tags(struct blk_mq_tags *tags)
 	kfree(tags);
 }
 
-int blk_mq_tag_update_depth(struct blk_mq_tags *tags, unsigned int tdepth)
+int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
+			    struct blk_mq_tags **tagsptr, unsigned int tdepth,
+			    bool can_grow)
 {
+	struct blk_mq_tags *tags = *tagsptr;
+
 	tdepth -= tags->nr_reserved_tags;
-	if (tdepth > tags->nr_tags)
-		return -EINVAL;
+
+	/*
+	 * If we are allowed to grow beyond the original size, allocate
+	 * a new set of tags before freeing the old one.
+	 */
+	if (tdepth > tags->nr_tags) {
+		struct blk_mq_tag_set *set = hctx->queue->tag_set;
+		struct blk_mq_tags *new;
+		bool ret;
+
+		if (!can_grow)
+			return -EINVAL;
+
+		/*
+		 * We need some sort of upper limit, set it high enough that
+		 * no valid use cases should require more.
+		 */
+		if (tdepth > 16 * BLKDEV_MAX_RQ)
+			return -EINVAL;
+
+		new = blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth, 0);
+		if (!new)
+			return -ENOMEM;
+		ret = blk_mq_alloc_rqs(set, new, hctx->queue_num, tdepth);
+		if (ret) {
+			blk_mq_free_rq_map(new);
+			return -ENOMEM;
+		}
+
+		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num);
+		blk_mq_free_rq_map(*tagsptr);
+		tags = *tagsptr = new;
+	}
 
 	/*
 	 * Don't need (or can't) update reserved tags here, they remain
 	 * static and should never need resizing.
 	 */
 	sbitmap_queue_resize(&tags->bitmap_tags, tdepth);
-
-	blk_mq_tag_wakeup_all(tags, false);
 	return 0;
 }
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 41cd15fd1afd..ac22878462e7 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -29,7 +29,9 @@ extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
 			   struct blk_mq_ctx *ctx, unsigned int tag);
 extern bool blk_mq_has_free_tags(struct blk_mq_tags *tags);
 extern ssize_t blk_mq_tag_sysfs_show(struct blk_mq_tags *tags, char *page);
-extern int blk_mq_tag_update_depth(struct blk_mq_tags *tags, unsigned int depth);
+extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
+					struct blk_mq_tags **tags,
+					unsigned int depth, bool can_grow);
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b365cde4c909..ee69e5e89769 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2561,6 +2561,9 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	if (!set)
 		return -EINVAL;
 
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
 	ret = 0;
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->tags)
@@ -2569,11 +2572,14 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		 * If we're using an MQ scheduler, just update the scheduler
 		 * queue depth. This is similar to what the old code would do.
 		 */
-		if (!hctx->sched_tags)
-			ret = blk_mq_tag_update_depth(hctx->tags,
-							min(nr, set->queue_depth));
-		else
-			ret = blk_mq_tag_update_depth(hctx->sched_tags, nr);
+		if (!hctx->sched_tags) {
+			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
+							min(nr, set->queue_depth),
+							false);
+		} else {
+			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
+							nr, true);
+		}
 		if (ret)
 			break;
 	}
@@ -2581,6 +2587,9 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	if (!ret)
 		q->nr_requests = nr;
 
+	blk_mq_unfreeze_queue(q);
+	blk_mq_start_stopped_hw_queues(q, true);
+
 	return ret;
 }
 

