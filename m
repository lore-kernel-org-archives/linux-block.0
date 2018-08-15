Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: sync the update nr_hw_queues with part_in_flight
Date: Wed, 15 Aug 2018 15:25:15 +0800
Message-Id: <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
account the inflight requests. It will access the queue_hw_ctx and
nr_hw_queues w/o any protection. When updating nr_hw_queues and
blk_mq_in_flight/rw occur concurrently, panic comes up.
To fix it, introduce mq_realloc_hw_ctxs into mark the updating
nr_hw_queues process and use rcu to ensure the mq_realloc_hw_ctxs
globally visible.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c         |  3 +++
 block/genhd.c          | 10 ++++++++--
 include/linux/blkdev.h |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 89904cc..ff50afc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2517,6 +2517,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 	blk_mq_sysfs_unregister(q);
 
+	WRITE_ONCE(q->mq_realloc_hw_ctxs, true);
+	synchronize_rcu();
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
@@ -2564,6 +2566,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	}
 	q->nr_hw_queues = i;
 	mutex_unlock(&q->sysfs_lock);
+	WRITE_ONCE(q->mq_realloc_hw_ctxs, false);
 	blk_mq_sysfs_register(q);
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index 8cc719a3..f9e46aa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -69,7 +69,10 @@ void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2])
 {
 	if (q->mq_ops) {
-		blk_mq_in_flight(q, part, inflight);
+		rcu_read_lock();
+		if (!q->mq_realloc_hw_ctxs)
+			blk_mq_in_flight(q, part, inflight);
+		rcu_read_unlock();
 		return;
 	}
 
@@ -86,7 +89,10 @@ void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2])
 {
 	if (q->mq_ops) {
-		blk_mq_in_flight_rw(q, part, inflight);
+		rcu_read_lock();
+		if (!q->mq_realloc_hw_ctxs)
+			blk_mq_in_flight_rw(q, part, inflight);
+		rcu_read_unlock();
 		return;
 	}
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ee930c4..5cb6662 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -662,6 +662,7 @@ struct request_queue {
 #endif
 
 	bool			mq_sysfs_init_done;
+	bool			mq_realloc_hw_ctxs;
 
 	size_t			cmd_size;
 	void			*rq_alloc_data;
-- 
2.7.4
