Return-Path: <prvs=11458901a0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/7] blk-mq: blk_account_io_start() takes a bool
Date: Fri, 2 Dec 2016 20:15:18 -0700
Message-ID: <1480734921-23701-5-git-send-email-axboe@fb.com>
In-Reply-To: <1480734921-23701-1-git-send-email-axboe@fb.com>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bac12caece06..90db5b490df9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1237,7 +1237,7 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 {
 	init_request_from_bio(rq, bio);
 
-	blk_account_io_start(rq, 1);
+	blk_account_io_start(rq, true);
 }
 
 static inline bool hctx_allow_merges(struct blk_mq_hw_ctx *hctx)
-- 
2.7.4
