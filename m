Return-Path: <prvs=550bc9d12=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 2/3] blk-mq: Avoid that blk_mq_delay_run_hw_queue() introduces unintended delays
Date: Fri, 19 Jan 2018 08:58:55 -0800
Message-Id: <20180119165856.17677-3-bart.vanassche@wdc.com>
In-Reply-To: <20180119165856.17677-1-bart.vanassche@wdc.com>
References: <20180119165856.17677-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Make sure that calling blk_mq_run_hw_queue() or
blk_mq_kick_requeue_list() triggers a queue run without delay even
if blk_mq_delay_run_hw_queue() has been called recently and if its
delay has not yet expired.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/blk-mq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6859b5492509..01f271d40825 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -787,7 +787,7 @@ EXPORT_SYMBOL(blk_mq_add_to_requeue_list);
 
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
-	kblockd_schedule_delayed_work(&q->requeue_work, 0);
+	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work, 0);
 }
 EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 
@@ -1403,9 +1403,8 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		put_cpu();
 	}
 
-	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
-					 &hctx->run_work,
-					 msecs_to_jiffies(msecs));
+	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
+				    msecs_to_jiffies(msecs));
 }
 
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
-- 
2.15.1
