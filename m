Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/28] blk-mq: remove the request_list usage
Date: Thu, 25 Oct 2018 15:10:17 -0600
Message-Id: <20181025211039.11559-7-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We don't do anything with it, that's just the legacy path.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f91c6e5b17a..4c82dc44d4d8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -510,9 +510,6 @@ void blk_mq_free_request(struct request *rq)
 
 	rq_qos_done(q, rq);
 
-	if (blk_rq_rl(rq))
-		blk_put_rl(blk_rq_rl(rq));
-
 	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
@@ -1675,8 +1672,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 {
 	blk_init_request_from_bio(rq, bio);
 
-	blk_rq_set_rl(rq, blk_get_rl(rq->q, bio));
-
 	blk_account_io_start(rq, true);
 }
 
-- 
2.17.1
