Return-Path: <longli@linuxonhyperv.com>
From: Long Li <longli@exchange.microsoft.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH] block-mq: set both block queue and hardware queue restart bit for restart
Date: Wed,  5 Apr 2017 17:16:21 -0700
Message-Id: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
List-ID: <linux-block@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Under heavy I/O, one hardware queue may be unable to dispatch any I/O to the 
device layer. This poses a problem with restarting this hardware queue on I/O
finish in blk_mq_sched_restart_queues(), becaue there is nothing pending that
will finish in future on this hardware qeueu. This will result in deadlock.

With this patch, we check for all possible stalled hardware queues when I/O
finishes on any hardware queues. This prevents this deadlock.

Signed-off-by: Long Li <longli@microsoft.com>
---
 block/blk-mq-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 09af8ff..f7f3d44 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -202,7 +202,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * needing a restart in that case.
 	 */
 	if (!list_empty(&rq_list)) {
-		blk_mq_sched_mark_restart_hctx(hctx);
+		blk_mq_sched_mark_restart_queue(hctx);
 		did_work = blk_mq_dispatch_rq_list(hctx, &rq_list);
 	} else if (!has_sched_dispatch) {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
-- 
2.7.4
