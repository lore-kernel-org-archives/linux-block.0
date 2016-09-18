Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757566AbcIRHhd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:33 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 01/14] blk-mq: Fix memory leaks on queue cleanup
Date: Sun, 18 Sep 2016 09:37:11 +0200
Message-Id: <6bbad3e6321685525574d6c0f01b875375351b81.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some data are leaked when blk_cleanup_queue() interface
is called.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f1c5263..66505af7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1699,8 +1699,13 @@ static void blk_mq_free_hw_queues(struct request_queue *q,
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	queue_for_each_hw_ctx(q, hctx, i)
+	queue_for_each_hw_ctx(q, hctx, i) {
 		free_cpumask_var(hctx->cpumask);
+		kfree(hctx->ctxs);
+		kfree(hctx);
+	}
+
+	q->nr_hw_queues = 0;
 }
 
 static int blk_mq_init_hctx(struct request_queue *q,
-- 
1.8.3.1

