Return-Path: <zhangweiping@didichuxing.com>
Date: Sun, 3 Sep 2017 21:46:39 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blk-mq: fix nr_requests wrong value when modify it from sysfs
Message-ID: <20170903134634.GA27411@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

if blk-mq use "none" io scheduler, nr_request get a wrong value when
input a number > tag_set->queue_depth. blk_mq_tag_update_depth will get
the smaller one min(nr, set->queue_depth), and then q->nr_request get a
wrong value.

Reproduce:

echo none > /sys/block/nvme0n1/queue/ioscheduler
echo 1000000 > /sys/block/nvme0n1/queue/nr_requests
cat /sys/block/nvme0n1/queue/nr_requests
1000000

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-mq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f84d145..8303e5e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2622,8 +2622,11 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		 * queue depth. This is similar to what the old code would do.
 		 */
 		if (!hctx->sched_tags) {
-			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
-							min(nr, set->queue_depth),
+			if (nr > set->queue_depth) {
+				nr = set->queue_depth;
+				pr_warn("reduce nr_request to %u\n", nr);
+			}
+			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
 							false);
 		} else {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-- 
2.9.4
