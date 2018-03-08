Return-Path: <prvs=5980fa318=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 01/11] block: Reorder the queue flag manipulation function definitions
Date: Wed,  7 Mar 2018 17:10:02 -0800
Message-Id: <20180308011012.31522-2-bart.vanassche@wdc.com>
In-Reply-To: <20180308011012.31522-1-bart.vanassche@wdc.com>
References: <20180308011012.31522-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Move the definition of queue_flag_clear_unlocked() up and move the
definition of queue_in_flight() down such that all queue flag
manipulation function definitions become contiguous.

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9becac7432d0..e1e2a06559dc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -724,6 +724,12 @@ static inline void queue_flag_set_unlocked(unsigned int flag,
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
@@ -756,17 +762,6 @@ static inline void queue_flag_set(unsigned int flag, struct request_queue *q)
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
@@ -802,6 +797,11 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
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
2.16.2
