Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] blk-mq-sched: Allocate sched reserved tags as specified in the original queue tagset
Date: Mon, 27 Feb 2017 17:36:20 +0200
Message-Id: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 98c7b061781e..46ca965fff5c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -454,7 +454,8 @@ int blk_mq_sched_setup(struct request_queue *q)
 	 */
 	ret = 0;
 	queue_for_each_hw_ctx(q, hctx, i) {
-		hctx->sched_tags = blk_mq_alloc_rq_map(set, i, q->nr_requests, 0);
+		hctx->sched_tags = blk_mq_alloc_rq_map(set, i,
+				q->nr_requests, set->reserved_tags);
 		if (!hctx->sched_tags) {
 			ret = -ENOMEM;
 			break;
-- 
2.7.4
