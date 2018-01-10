Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	bart.vanassche@wdc.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: remove REQ_ATOM_POLL_SLEPT
Date: Tue,  9 Jan 2018 17:29:24 -0700
Message-Id: <1515544167-10751-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We don't need this to be an atomic flag, it can be a regular
flag. We either end up on the same CPU for the polling, in which
case the state is sane, or we did the sleep which would imply
the needed barrier to ensure we see the right state.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c | 1 -
 block/blk-mq.c         | 5 ++---
 block/blk.h            | 2 --
 include/linux/blkdev.h | 2 ++
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8adc83786256..2a9c9f8b6162 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -294,7 +294,6 @@ static const char *const rqf_name[] = {
 #define RQAF_NAME(name) [REQ_ATOM_##name] = #name
 static const char *const rqaf_name[] = {
 	RQAF_NAME(COMPLETE),
-	RQAF_NAME(POLL_SLEPT),
 };
 #undef RQAF_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9aa24c9508f9..faa31814983c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -483,7 +483,6 @@ void blk_mq_free_request(struct request *rq)
 		blk_put_rl(blk_rq_rl(rq));
 
 	blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
-	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -2970,7 +2969,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	unsigned int nsecs;
 	ktime_t kt;
 
-	if (test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
+	if (rq->rq_flags & RQF_MQ_POLL_SLEPT)
 		return false;
 
 	/*
@@ -2990,7 +2989,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	if (!nsecs)
 		return false;
 
-	set_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
+	rq->rq_flags |= RQF_MQ_POLL_SLEPT;
 
 	/*
 	 * This will be replaced with the stats tracking code, using
diff --git a/block/blk.h b/block/blk.h
index a68dbe312ea3..eb306c52121e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -124,8 +124,6 @@ void blk_account_io_done(struct request *req);
  */
 enum rq_atomic_flags {
 	REQ_ATOM_COMPLETE = 0,
-
-	REQ_ATOM_POLL_SLEPT,
 };
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 007a7cf1f262..ba31674d8581 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -127,6 +127,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
 /* timeout is expired */
 #define RQF_MQ_TIMEOUT_EXPIRED	((__force req_flags_t)(1 << 20))
+/* already slept for hybrid poll */
+#define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 21))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.7.4
