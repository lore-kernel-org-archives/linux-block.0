Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753090AbdAZTsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 14:48:38 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <bart.vanassche@sandisk.com>, <hch@lst.de>, <osandov@fb.com>,
        <paolo.valente@linaro.org>, <hare@suse.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/5] blk-mq: improve scheduler queue sync/async running
Date: Thu, 26 Jan 2017 12:48:14 -0700
Message-ID: <1485460098-16608-2-git-send-email-axboe@fb.com>
In-Reply-To: <1485460098-16608-1-git-send-email-axboe@fb.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We'll use the same criteria for whether we need to run the queue sync
or async when we have a scheduler, as we do without one.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 84d13b5cafd0..223b9b080820 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1476,7 +1476,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	if (q->elevator) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-		blk_mq_sched_insert_request(rq, false, true, true);
+		blk_mq_sched_insert_request(rq, false, true,
+						!is_sync || is_flush_fua);
 		goto done;
 	}
 	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
@@ -1585,7 +1586,8 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	if (q->elevator) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-		blk_mq_sched_insert_request(rq, false, true, true);
+		blk_mq_sched_insert_request(rq, false, true,
+						!is_sync || is_flush_fua);
 		goto done;
 	}
 	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
-- 
2.7.4

