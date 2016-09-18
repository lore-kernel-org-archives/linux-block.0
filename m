Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758142AbcIRHhg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:36 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 04/14] blk-mq: Do not limit number of queues to 'nr_cpu_ids' in allocations
Date: Sun, 18 Sep 2016 09:37:14 +0200
Message-Id: <9bb584d504bc2f8ef9d66822e68f082ee9a74ded.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently maximum number of used hardware queues is limited to
number of CPUs in the system. However, using 'nr_cpu_ids' as
the limit for (de-)allocations of data structures instead of
existing data structures' counters (a) worsens readability and
(b) leads to unused memory when number of hardware queues is
less than number of CPUs.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 276ec7b..2c77b68 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2054,8 +2054,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_ctx)
 		goto err_exit;
 
-	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
-						GFP_KERNEL, set->numa_node);
+	q->queue_hw_ctx = kzalloc_node(set->nr_hw_queues *
+			sizeof(*(q->queue_hw_ctx)), GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
@@ -2319,7 +2319,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
 
-	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
+	set->tags = kzalloc_node(set->nr_hw_queues * sizeof(*set->tags),
 				 GFP_KERNEL, set->numa_node);
 	if (!set->tags)
 		return -ENOMEM;
@@ -2360,7 +2360,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < nr_cpu_ids; i++) {
+	for (i = 0; i < set->nr_hw_queues; i++) {
 		if (set->tags[i])
 			blk_mq_free_rq_map(set, set->tags[i], i);
 	}
-- 
1.8.3.1

