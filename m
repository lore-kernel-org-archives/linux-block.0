Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 21 Sep 2017 23:17:09 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v2 1/2] blk-mq: fix nr_requests wrong value when modify it
 from sysfs
Message-ID: <0dcb22e96bf2c3064c88dd554d6ac9eb95991a54.1506006064.git.zhangweiping@didichuxing.com>
References: <cover.1506006064.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1506006064.git.zhangweiping@didichuxing.com>
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
 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98a1860..479c35a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2642,8 +2642,12 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		 * queue depth. This is similar to what the old code would do.
 		 */
 		if (!hctx->sched_tags) {
-			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
-							min(nr, set->queue_depth),
+			if (nr > set->queue_depth) {
+				ret = -EINVAL;
+				break;
+			}
+
+			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
 							false);
 		} else {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-- 
2.9.4
