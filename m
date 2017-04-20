Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r138sm297117ita.24.2017.04.20.15.45.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 15:45:57 -0700 (PDT)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq-sched: add might_sleep() check for flush/fua insert
Message-ID: <cd6d3a9a-8f6d-1cf8-6379-51de69544c1d@kernel.dk>
Date: Thu, 20 Apr 2017 16:45:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

If we're doing a flush/fua insert, insertion might block on getting
a driver tag, if can_block == true. Add a might_sleep check for that,
since we just had a bug like that. This will help us catch a similar
issue quicker in the future.

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9e3c0f92851b..57aec8462e93 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -372,6 +372,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 
 	if (rq->tag == -1 && op_is_flush(rq->cmd_flags)) {
+		might_sleep_if(can_block);
 		blk_mq_sched_insert_flush(hctx, rq, can_block);
 		return;
 	}

Signed-off-by: Jens Axboe <axboe@fb.com>
