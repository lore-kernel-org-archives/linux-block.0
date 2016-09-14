Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763863AbcINOTv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:51 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] blk-mq: get rid of the cpumask in struct blk_mq_tags
Date: Wed, 14 Sep 2016 16:18:59 +0200
Message-Id: <1473862739-15032-14-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Unused now that NVMe sets up irq affinity before calling into blk-mq.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c     |  6 ------
 block/blk-mq-tag.h     |  1 -
 block/blk-mq.c         | 25 +++++++++++++++++++++----
 include/linux/blk-mq.h |  1 -
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 1602813..2eae3d5 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -665,11 +665,6 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	if (!tags)
 		return NULL;
 
-	if (!zalloc_cpumask_var(&tags->cpumask, GFP_KERNEL)) {
-		kfree(tags);
-		return NULL;
-	}
-
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
@@ -680,7 +675,6 @@ void blk_mq_free_tags(struct blk_mq_tags *tags)
 {
 	bt_free(&tags->bitmap_tags);
 	bt_free(&tags->breserved_tags);
-	free_cpumask_var(tags->cpumask);
 	kfree(tags);
 }
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d468a79..5569641 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -44,7 +44,6 @@ struct blk_mq_tags {
 	struct list_head page_list;
 
 	int alloc_policy;
-	cpumask_var_t cpumask;
 };
 
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3ef898..4411dbb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1851,7 +1851,6 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 		hctx->tags = set->tags[i];
 		WARN_ON(!hctx->tags);
 
-		cpumask_copy(hctx->tags->cpumask, hctx->cpumask);
 		/*
 		 * Set the map size to the number of mapped software queues.
 		 * This is more accurate and more efficient than looping
@@ -2262,11 +2261,29 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags)
+static int blk_mq_create_mq_map(struct blk_mq_tag_set *set,
+		const struct cpumask *affinity_mask)
 {
-	return tags->cpumask;
+	int queue = -1, cpu = 0;
+
+	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
+			GFP_KERNEL, set->numa_node);
+	if (!set->mq_map)
+		return -ENOMEM;
+
+	if (!affinity_mask)
+		return 0;	/* map all cpus to queue 0 */
+
+	/* If cpus are offline, map them to first hctx */
+	for_each_online_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, affinity_mask))
+			queue++;
+		if (queue >= 0)
+			set->mq_map[cpu] = queue;
+	}
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(blk_mq_tags_cpumask);
 
 /*
  * Alloc a tag set to be associated with one or more request queues.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ead450a..07589a2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -199,7 +199,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int op,
 		unsigned int flags, unsigned int hctx_idx);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
-struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags);
 
 enum {
 	BLK_MQ_UNIQUE_TAG_BITS = 16,
-- 
2.1.4

