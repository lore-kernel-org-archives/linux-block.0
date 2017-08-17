Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 01/12] block: Fix two comments that refer to .queue_rq() return values
Date: Thu, 17 Aug 2017 16:23:00 -0700
Message-Id: <20170817232311.25948-2-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since patch "blk-mq: switch .queue_rq return value to blk_status_t"
.queue_rq() returns a BLK_STS_* value instead of a BLK_MQ_RQ_*
value. Hence refer to the former in comments about .queue_rq()
return values.

Fixes: commit 39a70c76b89b ("blk-mq: clarify dispatch may not be drained/blocked by stopping queue")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fe764ca16993..f84d145490bf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1258,7 +1258,7 @@ EXPORT_SYMBOL(blk_mq_queue_stopped);
 /*
  * This function is often used for pausing .queue_rq() by driver when
  * there isn't enough resource or some conditions aren't satisfied, and
- * BLK_MQ_RQ_QUEUE_BUSY is usually returned.
+ * BLK_STS_RESOURCE is usually returned.
  *
  * We do not guarantee that dispatch can be drained or blocked
  * after blk_mq_stop_hw_queue() returns. Please use
@@ -1275,7 +1275,7 @@ EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 /*
  * This function is often used for pausing .queue_rq() by driver when
  * there isn't enough resource or some conditions aren't satisfied, and
- * BLK_MQ_RQ_QUEUE_BUSY is usually returned.
+ * BLK_STS_RESOURCE is usually returned.
  *
  * We do not guarantee that dispatch can be drained or blocked
  * after blk_mq_stop_hw_queues() returns. Please use
-- 
2.14.0
