Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758186AbcIRHhj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:39 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 07/14] blk-mq: Cleanup a loop exit condition
Date: Sun, 18 Sep 2016 09:37:17 +0200
Message-Id: <28367fd20927339e103d7e5afef31e2988e7ee78.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9fbfe31..b2ef8f5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1681,16 +1681,13 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set, int nr_queue)
+		struct blk_mq_tag_set *set)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (i == nr_queue)
-			break;
+	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_exit_hctx(q, set, hctx, i);
-	}
 }
 
 static void blk_mq_free_hw_queues(struct request_queue *q,
@@ -2124,7 +2121,7 @@ void blk_mq_free_queue(struct request_queue *q)
 
 	blk_mq_del_queue_tag_set(q);
 
-	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
+	blk_mq_exit_hw_queues(q, set);
 	blk_mq_free_hw_queues(q, set);
 }
 
-- 
1.8.3.1

