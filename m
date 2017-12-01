Return-Path: <prvs=5014e5409=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/7] blk-mq: Avoid that request processing stalls when sharing tags
Date: Thu, 30 Nov 2017 16:08:45 -0800
Message-Id: <20171201000848.2656-5-bart.vanassche@wdc.com>
In-Reply-To: <20171201000848.2656-1-bart.vanassche@wdc.com>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

blk_mq_sched_mark_restart_hctx() must be called before
blk_mq_dispatch_rq_list() is called. Make sure that
BLK_MQ_S_SCHED_RESTART is set before any blk_mq_dispatch_rq_list()
call occurs.

Fixes: commit b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d8e3533d3218..c4e0cb5f6f1f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -208,8 +208,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * on the dispatch list or we were able to dispatch from the
 	 * dispatch list.
 	 */
+	blk_mq_sched_mark_restart_hctx(hctx);
 	if (!list_empty(&rq_list)) {
-		blk_mq_sched_mark_restart_hctx(hctx);
 		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
 			if (has_sched_dispatch)
 				blk_mq_do_dispatch_sched(hctx);
-- 
2.15.0
