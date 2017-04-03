Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH v2 2/5] blk-mq: Make it safe to use RCU to iterate over blk_mq_tag_set.tag_list
Date: Mon, 3 Apr 2017 16:22:25 -0700
Message-ID: <20170403232228.11208-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170403232228.11208-1-bart.vanassche@sandisk.com>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

A later patch in this series will namely use RCU to iterate over
this list.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 block/blk-mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 061fc2cc88d3..8fb983e6e2e4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2093,6 +2093,8 @@ static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set, bool shared)
 {
 	struct request_queue *q;
 
+	lockdep_assert_held(&set->tag_list_lock);
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_freeze_queue(q);
 		queue_set_hctx_shared(q, shared);
@@ -2113,6 +2115,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		blk_mq_update_tag_set_depth(set, false);
 	}
 	mutex_unlock(&set->tag_list_lock);
+
+	synchronize_rcu();
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
@@ -2618,6 +2622,8 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
 	struct request_queue *q;
 
+	lockdep_assert_held(&set->tag_list_lock);
+
 	if (nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
 	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
-- 
2.12.0
