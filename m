Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] blk-mq: sync the update nr_hw_queues with part_in_flight
Date: Fri, 17 Aug 2018 11:54:03 +0800
Message-Id: <1534478043-7170-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
account the inflight requests. It will access the queue_hw_ctx and
nr_hw_queues w/o any protection. When updating nr_hw_queues and
blk_mq_in_flight/rw occur concurrently, panic comes up.

Before update nr_hw_queues, the q will be frozen. So we could use
q_usage_counter to avoid the race. percpu_ref_is_zero is used here
so that we will not miss any in-flight request. And also both the
check and blk_mq_queue_tag_busy_iter are under rcu critical section,
then __blk_mq_update_nr_hw_queues could ensure the zeroed q_usage_counter
to be globally visible.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index de7027f..9ec98bd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -112,7 +112,22 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
+
+	/*
+	 * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
+	 * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
+	 * to avoid race with it. __blk_mq_update_nr_hw_queues will use
+	 * synchronize_rcu to ensure all of the users of blk_mq_in_flight
+	 * go out of the critical section and see zeroed q_usage_counter.
+	 */
+	rcu_read_lock();
+	if (percpu_ref_is_zero(&q->q_usage_counter)) {
+		rcu_read_unlock();
+		return;
+	}
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	rcu_read_unlock();
 }
 
 static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
@@ -131,7 +146,18 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
+
+	/*
+	 * See comment of blk_mq_in_flight.
+	 */
+	rcu_read_lock();
+	if (percpu_ref_is_zero(&q->q_usage_counter)) {
+		rcu_read_unlock();
+		return;
+	}
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
+	rcu_read_unlock();
 }
 
 void blk_freeze_queue_start(struct request_queue *q)
@@ -2905,7 +2931,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
-
+	/*
+	 * Sync with blk_mq_in_flight and blk_mq_in_flight_rw
+	 */
+	synchronize_rcu();
 	/*
 	 * switch io scheduler to NULL to clean up the data in it.
 	 * will get it back after update mapping between cpu and hw queues.
-- 
2.7.4
