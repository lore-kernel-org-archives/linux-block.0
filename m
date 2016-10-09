Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbcJIVaW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Oct 2016 17:30:22 -0400
Date: Sun, 9 Oct 2016 23:30:18 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v3 6/8] blk-mq: Rework blk_mq_realloc_hw_ctxs()
Message-ID: <20161009213017.GA21398@dhcp-27-118.brq.redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
 <7459c980dd965b5f7b91e3bf1c3114d658535229.1475241231.git.agordeev@redhat.com>
 <259f9d8c-e552-7565-5e05-88a1c8430317@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <259f9d8c-e552-7565-5e05-88a1c8430317@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Rework blk_mq_realloc_hw_ctxs() so deallocation is done in order
reverse to allocation and indentation is bit more easy to read.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 15c03c2..d2c11fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1895,6 +1895,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
 	int i, j;
+	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
@@ -1908,33 +1909,36 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		if (node == NUMA_NO_NODE)
 			node = set->numa_node;
 
-		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
-					GFP_KERNEL, node);
-		if (!hctxs[i])
+		hctx = kzalloc_node(sizeof(*hctx), GFP_KERNEL, node);
+		if (!hctx)
 			break;
 
-		if (blk_mq_init_hctx(q, set, hctxs[i], i, node)) {
-			kfree(hctxs[i]);
-			hctxs[i] = NULL;
+		if (blk_mq_init_hctx(q, set, hctx, i, node)) {
+			kfree(hctx);
 			break;
 		}
-		blk_mq_hctx_kobj_init(hctxs[i]);
+
+		blk_mq_hctx_kobj_init(hctx);
+		hctxs[i] = hctx;
 	}
 	for (j = i; j < q->nr_hw_queues; j++) {
-		struct blk_mq_hw_ctx *hctx = hctxs[j];
+		hctx = hctxs[j];
 
-		if (hctx) {
-			if (hctx->tags) {
-				blk_mq_free_rq_map(set, hctx->tags, j);
-				set->tags[j] = NULL;
-			}
-			blk_mq_exit_hctx(q, set, hctx, j);
-			kobject_put(&hctx->kobj);
-			kfree(hctx->ctxs);
-			kfree(hctx);
-			hctxs[j] = NULL;
+		if (!hctx)
+			continue;
 
+		hctxs[j] = NULL;
+		kobject_put(&hctx->kobj);
+
+		if (hctx->tags) {
+			blk_mq_free_rq_map(set, hctx->tags, j);
+			set->tags[j] = NULL;
 		}
+
+		blk_mq_exit_hctx(q, set, hctx, j);
+
+		kfree(hctx->ctxs);
+		kfree(hctx);
 	}
 	q->nr_hw_queues = i;
 	blk_mq_sysfs_register(q);
-- 
1.8.3.1

