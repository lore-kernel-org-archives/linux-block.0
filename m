Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55194 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbcGUJYc (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 21 Jul 2016 05:24:32 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, agordeev@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/3] blk-mq: only allocate a single mq_map per tag_set
Date: Thu, 21 Jul 2016 11:24:18 +0200
Message-Id: <1469093059-24594-3-git-send-email-hch@lst.de>
In-Reply-To: <1469093059-24594-1-git-send-email-hch@lst.de>
References: <1469093059-24594-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The mapping is identical for all queues in a tag_set, so stop wasting
memory for building multiple.  Note that for now I've kept the mq_map
pointer in the request_queue, but we'll need to investigate if we can
remove it without suffering from the additional indirection.  The same
would apply to the mq_ops pointer as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 22 ++++++++++++++--------
 include/linux/blk-mq.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6e88e2c..c4adaa2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1972,7 +1972,6 @@ void blk_mq_release(struct request_queue *q)
 		kfree(hctx);
 	}
 
-	kfree(q->mq_map);
 	q->mq_map = NULL;
 
 	kfree(q->queue_hw_ctx);
@@ -2071,9 +2070,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
-	q->mq_map = blk_mq_make_queue_map(set);
-	if (!q->mq_map)
-		goto err_map;
+	q->mq_map = set->mq_map;
 
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
@@ -2123,8 +2120,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return q;
 
 err_hctxs:
-	kfree(q->mq_map);
-err_map:
 	kfree(q->queue_hw_ctx);
 err_percpu:
 	free_percpu(q->queue_ctx);
@@ -2346,14 +2341,22 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (!set->tags)
 		return -ENOMEM;
 
+	set->mq_map = blk_mq_make_queue_map(set);
+	if (!set->mq_map)
+		goto out_free_tags;
+
 	if (blk_mq_alloc_rq_maps(set))
-		goto enomem;
+		goto out_free_mq_map;
 
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
 
 	return 0;
-enomem:
+
+out_free_mq_map:
+	kfree(set->mq_map);
+	set->mq_map = NULL;
+out_free_tags:
 	kfree(set->tags);
 	set->tags = NULL;
 	return -ENOMEM;
@@ -2369,6 +2372,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 			blk_mq_free_rq_map(set, set->tags[i], i);
 	}
 
+	kfree(set->mq_map);
+	set->mq_map = NULL;
+
 	kfree(set->tags);
 	set->tags = NULL;
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e43bbff..a572227 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -65,6 +65,7 @@ struct blk_mq_hw_ctx {
 };
 
 struct blk_mq_tag_set {
+	unsigned int		*mq_map;
 	struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;
 	unsigned int		queue_depth;	/* max hw supported */
-- 
2.1.4

