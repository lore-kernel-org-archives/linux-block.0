Return-Path: <prvs=547e67762=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 3/3] block: Protect less code with sysfs_lock in blk_{un,}register_queue()
Date: Tue, 16 Jan 2018 10:17:52 -0800
Message-Id: <20180116181752.25847-4-bart.vanassche@wdc.com>
In-Reply-To: <20180116181752.25847-1-bart.vanassche@wdc.com>
References: <20180116181752.25847-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The __blk_mq_register_dev(), blk_mq_unregister_dev(),
elv_register_queue() and elv_unregister_queue() calls need to be
protected with sysfs_lock but other code in these functions not.
Hence protect only this code with sysfs_lock. This patch fixes a
locking inversion issue in blk_unregister_queue() and also in an
error path of blk_register_queue(): it is not allowed to hold
sysfs_lock around the kobject_del(&q->kobj) call.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/blk-sysfs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4a6a40ffd78e..e9ce45ff0ef2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -909,11 +909,12 @@ int blk_register_queue(struct gendisk *disk)
 	if (q->request_fn || (q->mq_ops && q->elevator)) {
 		ret = elv_register_queue(q);
 		if (ret) {
+			mutex_unlock(&q->sysfs_lock);
 			kobject_uevent(&q->kobj, KOBJ_REMOVE);
 			kobject_del(&q->kobj);
 			blk_trace_remove_sysfs(dev);
 			kobject_put(&dev->kobj);
-			goto unlock;
+			return ret;
 		}
 	}
 	ret = 0;
@@ -934,28 +935,22 @@ void blk_unregister_queue(struct gendisk *disk)
 	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
 		return;
 
-	/*
-	 * Protect against the 'queue' kobj being accessed
-	 * while/after it is removed.
-	 */
-	mutex_lock(&q->sysfs_lock);
-
 	spin_lock_irq(q->queue_lock);
 	queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
 	spin_unlock_irq(q->queue_lock);
 
 	wbt_exit(q);
 
+	mutex_lock(&q->sysfs_lock);
 	if (q->mq_ops)
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 
 	if (q->request_fn || (q->mq_ops && q->elevator))
 		elv_unregister_queue(q);
+	mutex_unlock(&q->sysfs_lock);
 
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
 	kobject_del(&q->kobj);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 	kobject_put(&disk_to_dev(disk)->kobj);
-
-	mutex_unlock(&q->sysfs_lock);
 }
-- 
2.15.1
