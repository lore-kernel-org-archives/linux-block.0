Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C03C4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4279B21881
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 12:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfIQMJY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:09:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17325 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfIQMJY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 08:09:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02E0C796EE;
        Tue, 17 Sep 2019 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A72A5D9D5;
        Tue, 17 Sep 2019 12:09:21 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, hch@infradead.org,
        linux-block@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 2/2] blk-mq: use BLK_MQ_GFP_FLAGS and memalloc_noio_save/restore instead
Date:   Tue, 17 Sep 2019 17:39:10 +0530
Message-Id: <20190917120910.24842-3-xiubli@redhat.com>
In-Reply-To: <20190917120910.24842-1-xiubli@redhat.com>
References: <20190917120910.24842-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 17 Sep 2019 12:09:24 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

There are at least 6 places are using the same combined GFP flags,
switch them to one macro instead to make the code get cleaner.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c52e4dfe132..8cdc747d5c4d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -20,6 +20,7 @@
 #include <linux/list_sort.h>
 #include <linux/cpu.h>
 #include <linux/cache.h>
+#include <linux/sched/mm.h>
 #include <linux/sched/sysctl.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/signal.h>
@@ -39,6 +40,8 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
+#define BLK_MQ_GFP_FLAGS (GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY)
+
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -2083,35 +2086,38 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					unsigned int reserved_tags)
 {
 	struct blk_mq_tags *tags;
+	unsigned int noio_flag;
 	int node;
 
 	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
+	noio_flag = memalloc_noio_save();
 	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags),
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
+				BLK_MQ_GFP_FLAGS);
 	if (!tags)
-		return NULL;
+		goto out;
 
 	tags->rqs = kcalloc_node(nr_tags, sizeof(struct request *),
-				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				 node);
+				 BLK_MQ_GFP_FLAGS, node);
 	if (!tags->rqs) {
 		blk_mq_free_tags(tags);
-		return NULL;
+		tags = NULL;
+		goto out;
 	}
 
 	tags->static_rqs = kcalloc_node(nr_tags, sizeof(struct request *),
-					GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-					node);
+					BLK_MQ_GFP_FLAGS, node);
 	if (!tags->static_rqs) {
 		kfree(tags->rqs);
 		blk_mq_free_tags(tags);
-		return NULL;
+		tags = NULL;
 	}
 
+out:
+	memalloc_noio_restore(noio_flag);
 	return tags;
 }
 
@@ -2158,6 +2164,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 	for (i = 0; i < depth; ) {
 		int this_order = max_order;
+		unsigned int noio_flag;
 		struct page *page;
 		int to_do;
 		void *p;
@@ -2165,9 +2172,10 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		while (this_order && left < order_to_size(this_order - 1))
 			this_order--;
 
+		noio_flag = memalloc_noio_save();
 		do {
 			page = alloc_pages_node(node,
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO,
+				BLK_MQ_GFP_FLAGS | __GFP_ZERO,
 				this_order);
 			if (page)
 				break;
@@ -2176,6 +2184,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 			if (order_to_size(this_order) < rq_size)
 				break;
 		} while (1);
+		memalloc_noio_restore(noio_flag);
 
 		if (!page)
 			goto fail;
@@ -2188,7 +2197,10 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		 * Allow kmemleak to scan these pages as they contain pointers
 		 * to additional allocations like via ops->init_request().
 		 */
-		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);
+		noio_flag = memalloc_noio_save();
+		kmemleak_alloc(p, order_to_size(this_order), 1,
+			       BLK_MQ_GFP_FLAGS);
+		memalloc_noio_restore(noio_flag);
 		entries_per_page = order_to_size(this_order) / rq_size;
 		to_do = min(entries_per_page, depth - i);
 		left -= to_do * rq_size;
@@ -2333,8 +2345,10 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 		int node)
 {
 	struct blk_mq_hw_ctx *hctx;
-	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
+	gfp_t gfp = BLK_MQ_GFP_FLAGS;
+	unsigned int noio_flag;
 
+	noio_flag = memalloc_noio_save();
 	hctx = kzalloc_node(blk_mq_hw_ctx_size(set), gfp, node);
 	if (!hctx)
 		goto fail_alloc_hctx;
@@ -2378,6 +2392,8 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!hctx->fq)
 		goto free_bitmap;
 
+	memalloc_noio_restore(noio_flag);
+
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
 	blk_mq_hctx_kobj_init(hctx);
@@ -2393,6 +2409,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
  free_hctx:
 	kfree(hctx);
  fail_alloc_hctx:
+	memalloc_noio_restore(noio_flag);
 	return NULL;
 }
 
@@ -3190,11 +3207,14 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 		struct request_queue *q)
 {
 	struct blk_mq_qe_pair *qe;
+	unsigned int noio_flag;
 
 	if (!q->elevator)
 		return true;
 
-	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
+	noio_flag = memalloc_noio_save();
+	qe = kmalloc(sizeof(*qe), BLK_MQ_GFP_FLAGS);
+	memalloc_noio_restore(noio_flag);
 	if (!qe)
 		return false;
 
-- 
2.21.0

