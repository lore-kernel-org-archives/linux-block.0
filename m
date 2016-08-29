Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932179AbcH2Kxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 06:53:45 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 2/7] blk-mq: only allocate a single mq_map per tag_set
Date: Mon, 29 Aug 2016 12:53:28 +0200
Message-Id: <1472468013-29936-3-git-send-email-hch@lst.de>
In-Reply-To: <1472468013-29936-1-git-send-email-hch@lst.de>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The mapping is identical for all queues in a tag_set, so stop wasting
memory for building multiple.  Note that for now I've kept the mq_map
pointer in the request_queue, but we'll need to investigate if we can
remove it without suffering too much from the additional pointer chasing.
The same would apply to the mq_ops pointer as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 22 ++++++++++++++--------
 include/linux/blk-mq.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b29e7b2..15c36c1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1963,7 +1963,6 @@ void blk_mq_release(struct request_queue *q)
 		kfree(hctx);
 	}
 
-	kfree(q->mq_map);
 	q->mq_map = NULL;
 
 	kfree(q->queue_hw_ctx);
@@ -2062,9 +2061,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
-	q->mq_map = blk_mq_make_queue_map(set);
-	if (!q->mq_map)
-		goto err_map;
+	q->mq_map = set->mq_map;
 
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
@@ -2114,8 +2111,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return q;
 
 err_hctxs:
-	kfree(q->mq_map);
-err_map:
 	kfree(q->queue_hw_ctx);
 err_percpu:
 	free_percpu(q->queue_ctx);
@@ -2337,14 +2332,22 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
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
@@ -2360,6 +2363,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
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

