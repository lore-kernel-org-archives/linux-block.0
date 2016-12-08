Return-Path: <prvs=11505706e0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/7] blk-flush: run the queue when inserting blk-mq flush
Date: Thu, 8 Dec 2016 13:13:22 -0700
Message-ID: <1481228005-9245-5-git-send-email-axboe@fb.com>
In-Reply-To: <1481228005-9245-1-git-send-email-axboe@fb.com>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Currently we pass in to run the queue async, but don't flag the
queue to be run. We don't need to run it async here, but we should
run it. So fixup the parameters.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 1bdbb3d3e5f5..27a42dab5a36 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -426,7 +426,7 @@ void blk_insert_flush(struct request *rq)
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
 		if (q->mq_ops) {
-			blk_mq_insert_request(rq, false, false, true);
+			blk_mq_insert_request(rq, false, true, false);
 		} else
 			list_add_tail(&rq->queuelist, &q->queue_head);
 		return;
-- 
2.7.4
