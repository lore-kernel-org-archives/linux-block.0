Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] loop: fix aio/dio end of request clearing
Message-ID: <64287b95-4e2d-9220-acd5-6528954e8b60@kernel.dk>
Date: Thu, 12 Apr 2018 12:52:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

If we read more than the user asked for, we zero fill the last
part. But the current code assumes that the request has just
one bio, and since that's not guaranteed to be true, we can
run into a situation where we attempt to advance a bio by
a bigger amount than its size.

Handle the zero filling appropriately, regardless of what bio
ends up needing to be cleared.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c9d04497a415..d3aa96a2f369 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -455,9 +455,22 @@ static void lo_complete_rq(struct request *rq)
 	if (unlikely(req_op(cmd->rq) == REQ_OP_READ && cmd->use_aio &&
 		     cmd->ret >= 0 && cmd->ret < blk_rq_bytes(cmd->rq))) {
 		struct bio *bio = cmd->rq->bio;
+		long left = cmd->ret;
 
-		bio_advance(bio, cmd->ret);
-		zero_fill_bio(bio);
+		while (left >= bio->bi_iter.bi_size) {
+			left -= bio->bi_iter.bi_size;
+			bio = bio->bi_next;
+			if (WARN_ON_ONCE(!bio))
+				break;
+		}
+		while (bio) {
+			if (left) {
+				bio_advance(bio, left);
+				left = 0;
+			}
+			zero_fill_bio(bio);
+			bio = bio->bi_next;
+		}
 	}
 
 	blk_mq_end_request(rq, cmd->ret < 0 ? BLK_STS_IOERR : BLK_STS_OK);

-- 
Jens Axboe
