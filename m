Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] block: rearrange a few request fields for better cache layout
Date: Tue,  9 Jan 2018 11:27:02 -0700
Message-Id: <1515522422-21596-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
References: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Move completion related items (like the call single data) near the
end of the struct, instead of mixing them in with the initial
queueing related fields.

Move queuelist below the bio structures. Then we have all
queueing related bits in the first cache line.

This yields a 1.5-2% increase in IOPS for a null_blk test, both for
sync and for high thread count access. Sync test goes form 975K to
992K, 32-thread case from 20.8M to 21.2M IOPS.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blkdev.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d4b2f7bb18d6..1b2472f6662e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -141,12 +141,6 @@ typedef __u32 __bitwise req_flags_t;
  * especially blk_mq_rq_ctx_init() to take care of the added fields.
  */
 struct request {
-	struct list_head queuelist;
-	union {
-		call_single_data_t csd;
-		u64 fifo_time;
-	};
-
 	struct request_queue *q;
 	struct blk_mq_ctx *mq_ctx;
 
@@ -164,6 +158,8 @@ struct request {
 	struct bio *bio;
 	struct bio *biotail;
 
+	struct list_head queuelist;
+
 	/*
 	 * The hash is used inside the scheduler, and killed once the
 	 * request reaches the dispatch list. The ipi_list is only used
@@ -260,6 +256,11 @@ struct request {
 
 	struct list_head timeout_list;
 
+	union {
+		call_single_data_t csd;
+		u64 fifo_time;
+	};
+
 	/*
 	 * completion callback.
 	 */
-- 
2.7.4
