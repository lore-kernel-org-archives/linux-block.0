Return-Path: <zhangweiping@didichuxing.com>
Date: Fri, 22 Sep 2017 01:13:22 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v3] blk-mq: fix nr_requests wrong value when modify it from
 sysfs
Message-ID: <20170921171317.GA2077@localhost.didichuxing.com>
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
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98a1860..491e336 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2642,8 +2642,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		 * queue depth. This is similar to what the old code would do.
 		 */
 		if (!hctx->sched_tags) {
-			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
-							min(nr, set->queue_depth),
+			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
 							false);
 		} else {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-- 
2.9.4
