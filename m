Return-Path: <xiaoguang.wang@linux.alibaba.com>
From: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH] blk-mq: place trace_block_getrq() in correct place
Date: Tue, 23 Oct 2018 22:30:50 +0800
Message-Id: <20181023143050.121915-1-xiaoguang.wang@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

trace_block_getrq() is to indicate a request struct has been allcoated
for queue, so put it in right place.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c39ea8e17b..93aec25f1340 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1833,8 +1833,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	rq_qos_throttle(q, bio, NULL);
 
-	trace_block_getrq(q, bio, bio->bi_opf);
-
 	rq = blk_mq_get_request(q, bio, bio->bi_opf, &data);
 	if (unlikely(!rq)) {
 		rq_qos_cleanup(q, bio);
@@ -1843,6 +1841,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	trace_block_getrq(q, bio, bio->bi_opf);
+
 	rq_qos_track(q, rq, bio);
 
 	cookie = request_to_qc_t(data.hctx, rq);
-- 
2.14.4.44.g2045bb6
