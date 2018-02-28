Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:62045 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933488AbeB1T2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 14:28:25 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 04/11] block: Protect queue flag changes with the queue lock
Date: Wed, 28 Feb 2018 11:28:16 -0800
Message-Id: <20180228192823.5191-5-bart.vanassche@wdc.com>
In-Reply-To: <20180228192823.5191-1-bart.vanassche@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since the queue flags may be changed concurrently from multiple
contexts after a queue becomes visible in sysfs, make these changes
safe by protecting these with the queue lock.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   | 3 +--
 block/blk-stat.c | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 67026494119b..899f357962e8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3022,8 +3022,7 @@ EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 /* Enable polling stats and return whether they were already enabled. */
 static bool blk_poll_stats_enable(struct request_queue *q)
 {
-	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
-	    test_and_set_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
+	if (blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q))
 		return true;
 	blk_stat_add_callback(q, q->poll_cb);
 	return false;
diff --git a/block/blk-stat.c b/block/blk-stat.c
index b664aa6df725..bd365a95fcf8 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -152,7 +152,7 @@ void blk_stat_add_callback(struct request_queue *q,
 
 	spin_lock(&q->stats->lock);
 	list_add_tail_rcu(&cb->list, &q->stats->callbacks);
-	queue_flag_set(QUEUE_FLAG_STATS, q);
+	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
 	spin_unlock(&q->stats->lock);
 }
 EXPORT_SYMBOL_GPL(blk_stat_add_callback);
@@ -163,7 +163,7 @@ void blk_stat_remove_callback(struct request_queue *q,
 	spin_lock(&q->stats->lock);
 	list_del_rcu(&cb->list);
 	if (list_empty(&q->stats->callbacks) && !q->stats->enable_accounting)
-		queue_flag_clear(QUEUE_FLAG_STATS, q);
+		blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
 	spin_unlock(&q->stats->lock);
 
 	del_timer_sync(&cb->timer);
@@ -191,7 +191,7 @@ void blk_stat_enable_accounting(struct request_queue *q)
 {
 	spin_lock(&q->stats->lock);
 	q->stats->enable_accounting = true;
-	queue_flag_set(QUEUE_FLAG_STATS, q);
+	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
 	spin_unlock(&q->stats->lock);
 }
 
-- 
2.16.2
