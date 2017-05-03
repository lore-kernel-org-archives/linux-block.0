Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757644AbdECT7V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 15:59:21 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/5] blk-mq: don't update q->nr_requests when updating hw queue's depth
Date: Thu,  4 May 2017 03:58:37 +0800
Message-Id: <20170503195839.6539-4-ming.lei@redhat.com>
In-Reply-To: <20170503195839.6539-1-ming.lei@redhat.com>
References: <20170503195839.6539-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In MQ scheduler, q->nr_requests represents requests in scheduler
queue depth, so don't update it if hw queue's depth is updated.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index be475ad112ec..681bf33d8de8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2643,6 +2643,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	int i, ret;
+	bool sched = false;
 
 	if (!set)
 		return -EINVAL;
@@ -2664,12 +2665,13 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		} else {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
 							nr, true);
+			sched = true;
 		}
 		if (ret)
 			break;
 	}
 
-	if (!ret)
+	if (!ret && sched)
 		q->nr_requests = nr;
 
 	blk_mq_unfreeze_queue(q);
-- 
2.9.3
