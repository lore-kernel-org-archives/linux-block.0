Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbcIRHhn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:43 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 09/14] blk-mq: Move duplicating code to blk_mq_exit_hctx()
Date: Sun, 18 Sep 2016 09:37:19 +0200
Message-Id: <08fde52dea32101ca7fffe1ff6e1a4786a7eab2c.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3efb700..cd32a08 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1678,6 +1678,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
 	blk_free_flush_queue(hctx->fq);
 	blk_mq_free_bitmap(&hctx->ctx_map);
+
+	free_cpumask_var(hctx->cpumask);
+	kfree(hctx->ctxs);
+	kfree(hctx);
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
@@ -1686,12 +1690,8 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
+	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_exit_hctx(q, set, hctx, i);
-		free_cpumask_var(hctx->cpumask);
-		kfree(hctx->ctxs);
-		kfree(hctx);
-	}
 
 	q->nr_hw_queues = 0;
 }
@@ -2018,12 +2018,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 				set->tags[j] = NULL;
 			}
 			blk_mq_exit_hctx(q, set, hctx, j);
-			free_cpumask_var(hctx->cpumask);
 			kobject_put(&hctx->kobj);
-			kfree(hctx->ctxs);
-			kfree(hctx);
 			hctxs[j] = NULL;
-
 		}
 	}
 	q->nr_hw_queues = i;
-- 
1.8.3.1

