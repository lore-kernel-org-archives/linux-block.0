Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdFFPWg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 11:22:36 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 01/12] blk-mq: pass correct hctx to blk_mq_try_issue_directly
Date: Tue,  6 Jun 2017 23:21:59 +0800
Message-Id: <20170606152210.22806-2-ming.lei@redhat.com>
In-Reply-To: <20170606152210.22806-1-ming.lei@redhat.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When direct issue is done on request picked up from plug list,
the hctx need to be updated with the actual hw queue, otherwise
wrong hctx is used and may hurt performance, especially when
wrong SRCU readlock is acquired/released

Reported-by: Bart Van Assche <bart.vanassche@sandisk.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 58688205c8f4..c13888922e18 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1558,9 +1558,12 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		blk_mq_put_ctx(data.ctx);
 
-		if (same_queue_rq)
+		if (same_queue_rq) {
+			data.hctx = blk_mq_map_queue(q,
+					same_queue_rq->mq_ctx->cpu);
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
+		}
 	} else if (q->nr_hw_queues > 1 && is_sync) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-- 
2.9.4
