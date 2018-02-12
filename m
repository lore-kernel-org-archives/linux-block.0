Return-Path: <prvs=5743cbe84=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH] block: Reorder the queue flag manipulaton function definitions
Date: Mon, 12 Feb 2018 09:34:17 -0800
Message-Id: <20180212173417.15363-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Move the definition of queue_flag_clear_unlocked() up and move the
definition of queue_in_flight() down such that all queue flag
manipulation function definitions become contiguous.

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 include/linux/blkdev.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9e31df5bb888..321f25c85faa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -706,6 +706,12 @@ static inline void queue_flag_set_unlocked(unsigned int flag,
 	__set_bit(flag, &q->queue_flags);
 }
 
+static inline void queue_flag_clear_unlocked(unsigned int flag,
+					     struct request_queue *q)
+{
+	__clear_bit(flag, &q->queue_flags);
+}
+
 static inline int queue_flag_test_and_clear(unsigned int flag,
 					    struct request_queue *q)
 {
@@ -738,17 +744,6 @@ static inline void queue_flag_set(unsigned int flag, struct request_queue *q)
 	__set_bit(flag, &q->queue_flags);
 }
 
-static inline void queue_flag_clear_unlocked(unsigned int flag,
-					     struct request_queue *q)
-{
-	__clear_bit(flag, &q->queue_flags);
-}
-
-static inline int queue_in_flight(struct request_queue *q)
-{
-	return q->in_flight[0] + q->in_flight[1];
-}
-
 static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 {
 	queue_lockdep_assert_held(q);
@@ -784,6 +779,11 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 extern int blk_set_preempt_only(struct request_queue *q);
 extern void blk_clear_preempt_only(struct request_queue *q);
 
+static inline int queue_in_flight(struct request_queue *q)
+{
+	return q->in_flight[0] + q->in_flight[1];
+}
+
 static inline bool blk_account_rq(struct request *rq)
 {
 	return (rq->rq_flags & RQF_STARTED) && !blk_rq_is_passthrough(rq);
-- 
2.16.1
