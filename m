Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbdKHBLg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Nov 2017 20:11:36 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] blk-mq: put driver tag if dispatch budget can't be got
Date: Wed,  8 Nov 2017 09:11:22 +0800
Message-Id: <20171108011122.21654-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We have to put the driver tag if dispatch budget can't be got, otherwise
it might cause IO deadlock, especially in case that size of tags is very
small.

Fixes: de1482974080(blk-mq: introduce .get_budget and .put_budget in blk_mq_ops)
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	add Fixes tag

 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c501cbd0de93..3d759bb8a5bb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1080,8 +1080,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			}
 		}
 
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
+		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+			blk_mq_put_driver_tag(rq);
 			break;
+		}
 
 		list_del_init(&rq->queuelist);
 
-- 
2.9.5
