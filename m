Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33470 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761544AbdAKVkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:15 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 07/10] blk-mq: abstract out helpers for allocating/freeing tag maps
Date: Wed, 11 Jan 2017 14:40:00 -0700
Message-ID: <1484170803-9311-8-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Prep patch for adding an extra tag map for scheduler requests.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 119 ++++++++++++++++++++++++++++++++++++---------------------
 block/blk-mq.h |  14 ++++---
 2 files changed, 84 insertions(+), 49 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6fab8e9c724f..3b7a087e8bf0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1553,8 +1553,8 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	return cookie;
 }
 
-void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-			unsigned int hctx_idx)
+void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx)
 {
 	struct page *page;
 
@@ -1580,33 +1580,30 @@ void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		kmemleak_free(page_address(page));
 		__free_pages(page, page->private);
 	}
+}
 
+void blk_mq_free_rq_map(struct blk_mq_tags *tags)
+{
 	kfree(tags->rqs);
+	tags->rqs = NULL;
 
 	blk_mq_free_tags(tags);
 }
 
-static size_t order_to_size(unsigned int order)
-{
-	return (size_t)PAGE_SIZE << order;
-}
-
-struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
-				       unsigned int hctx_idx)
+struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
+					unsigned int hctx_idx,
+					unsigned int nr_tags,
+					unsigned int reserved_tags)
 {
 	struct blk_mq_tags *tags;
-	unsigned int i, j, entries_per_page, max_order = 4;
-	size_t rq_size, left;
 
-	tags = blk_mq_init_tags(set->queue_depth, set->reserved_tags,
+	tags = blk_mq_init_tags(nr_tags, reserved_tags,
 				set->numa_node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
 	if (!tags)
 		return NULL;
 
-	INIT_LIST_HEAD(&tags->page_list);
-
-	tags->rqs = kzalloc_node(set->queue_depth * sizeof(struct request *),
+	tags->rqs = kzalloc_node(nr_tags * sizeof(struct request *),
 				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
 				 set->numa_node);
 	if (!tags->rqs) {
@@ -1614,15 +1611,31 @@ struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 		return NULL;
 	}
 
+	return tags;
+}
+
+static size_t order_to_size(unsigned int order)
+{
+	return (size_t)PAGE_SIZE << order;
+}
+
+int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx, unsigned int depth)
+{
+	unsigned int i, j, entries_per_page, max_order = 4;
+	size_t rq_size, left;
+
+	INIT_LIST_HEAD(&tags->page_list);
+
 	/*
 	 * rq_size is the size of the request plus driver payload, rounded
 	 * to the cacheline size
 	 */
 	rq_size = round_up(sizeof(struct request) + set->cmd_size,
 				cache_line_size());
-	left = rq_size * set->queue_depth;
+	left = rq_size * depth;
 
-	for (i = 0; i < set->queue_depth; ) {
+	for (i = 0; i < depth; ) {
 		int this_order = max_order;
 		struct page *page;
 		int to_do;
@@ -1656,7 +1669,7 @@ struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 		 */
 		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);
 		entries_per_page = order_to_size(this_order) / rq_size;
-		to_do = min(entries_per_page, set->queue_depth - i);
+		to_do = min(entries_per_page, depth - i);
 		left -= to_do * rq_size;
 		for (j = 0; j < to_do; j++) {
 			tags->rqs[i] = p;
@@ -1673,11 +1686,11 @@ struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 			i++;
 		}
 	}
-	return tags;
+	return 0;
 
 fail:
-	blk_mq_free_rq_map(set, tags, hctx_idx);
-	return NULL;
+	blk_mq_free_rqs(set, tags, hctx_idx);
+	return -ENOMEM;
 }
 
 /*
@@ -1869,6 +1882,33 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 	}
 }
 
+static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
+{
+	int ret = 0;
+
+	set->tags[hctx_idx] = blk_mq_alloc_rq_map(set, hctx_idx,
+					set->queue_depth, set->reserved_tags);
+	if (!set->tags[hctx_idx])
+		return false;
+
+	ret = blk_mq_alloc_rqs(set, set->tags[hctx_idx], hctx_idx,
+				set->queue_depth);
+	if (!ret)
+		return true;
+
+	blk_mq_free_rq_map(set->tags[hctx_idx]);
+	set->tags[hctx_idx] = NULL;
+	return false;
+}
+
+static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
+					 unsigned int hctx_idx)
+{
+	blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
+	blk_mq_free_rq_map(set->tags[hctx_idx]);
+	set->tags[hctx_idx] = NULL;
+}
+
 static void blk_mq_map_swqueue(struct request_queue *q,
 			       const struct cpumask *online_mask)
 {
@@ -1897,17 +1937,15 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 
 		hctx_idx = q->mq_map[i];
 		/* unmapped hw queue can be remapped after CPU topo changed */
-		if (!set->tags[hctx_idx]) {
-			set->tags[hctx_idx] = blk_mq_init_rq_map(set, hctx_idx);
-
+		if (!set->tags[hctx_idx] &&
+		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
 			/*
 			 * If tags initialization fail for some hctx,
 			 * that hctx won't be brought online.  In this
 			 * case, remap the current ctx to hctx[0] which
 			 * is guaranteed to always have tags allocated
 			 */
-			if (!set->tags[hctx_idx])
-				q->mq_map[i] = 0;
+			q->mq_map[i] = 0;
 		}
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
@@ -1930,10 +1968,9 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 			 * fallback in case of a new remap fails
 			 * allocation
 			 */
-			if (i && set->tags[i]) {
-				blk_mq_free_rq_map(set, set->tags[i], i);
-				set->tags[i] = NULL;
-			}
+			if (i && set->tags[i])
+				blk_mq_free_map_and_requests(set, i);
+
 			hctx->tags = NULL;
 			continue;
 		}
@@ -2100,10 +2137,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx = hctxs[j];
 
 		if (hctx) {
-			if (hctx->tags) {
-				blk_mq_free_rq_map(set, hctx->tags, j);
-				set->tags[j] = NULL;
-			}
+			if (hctx->tags)
+				blk_mq_free_map_and_requests(set, j);
 			blk_mq_exit_hctx(q, set, hctx, j);
 			free_cpumask_var(hctx->cpumask);
 			kobject_put(&hctx->kobj);
@@ -2299,17 +2334,15 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < set->nr_hw_queues; i++) {
-		set->tags[i] = blk_mq_init_rq_map(set, i);
-		if (!set->tags[i])
+	for (i = 0; i < set->nr_hw_queues; i++)
+		if (!__blk_mq_alloc_rq_map(set, i))
 			goto out_unwind;
-	}
 
 	return 0;
 
 out_unwind:
 	while (--i >= 0)
-		blk_mq_free_rq_map(set, set->tags[i], i);
+		blk_mq_free_rq_map(set->tags[i]);
 
 	return -ENOMEM;
 }
@@ -2392,12 +2425,12 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
 
+	ret = -ENOMEM;
 	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
 				 GFP_KERNEL, set->numa_node);
 	if (!set->tags)
 		return -ENOMEM;
 
-	ret = -ENOMEM;
 	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
 			GFP_KERNEL, set->numa_node);
 	if (!set->mq_map)
@@ -2433,10 +2466,8 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < nr_cpu_ids; i++) {
-		if (set->tags[i])
-			blk_mq_free_rq_map(set, set->tags[i], i);
-	}
+	for (i = 0; i < nr_cpu_ids; i++)
+		blk_mq_free_map_and_requests(set, i);
 
 	kfree(set->mq_map);
 	set->mq_map = NULL;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 48b7771eb192..1b279b02d0f6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -37,17 +37,21 @@ void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 /*
  * Internal helpers for allocating/freeing the request map
  */
-void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-			unsigned int hctx_idx);
-struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
-					unsigned int hctx_idx);
+void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx);
+void blk_mq_free_rq_map(struct blk_mq_tags *tags);
+struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
+					unsigned int hctx_idx,
+					unsigned int nr_tags,
+					unsigned int reserved_tags);
+int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx, unsigned int depth);
 
 /*
  * Internal helpers for request insertion into sw queues
  */
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 				bool at_head);
-
 /*
  * CPU hotplug helpers
  */
-- 
2.7.4

