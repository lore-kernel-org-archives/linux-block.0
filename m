Return-Path: <zhangweiping@didichuxing.com>
Date: Sat, 20 Jan 2018 01:40:58 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blk-throttle: use queue_is_rq_based
Message-ID: <20180119174053.GA967@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

use queue_is_rq_based instead of open code.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 96ad326..457e985 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2456,7 +2456,7 @@ void blk_throtl_register_queue(struct request_queue *q)
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
 #endif
 
-	td->track_bio_latency = !q->mq_ops && !q->request_fn;
+	td->track_bio_latency = !(queue_is_rq_based(q));
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
 }
-- 
2.9.4
