Return-Path: <tahsin@google.com>
Return-Path: <tahsin@google.com>
From: Tahsin Erdogan <tahsin@google.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tahsin Erdogan <tahsin@google.com>
Subject: [PATCH] block: do not allow updates through sysfs until registration completes
Date: Tue, 14 Feb 2017 19:27:38 -0800
Message-Id: <20170215032738.22689-1-tahsin@google.com>
List-ID: <linux-block@vger.kernel.org>

When a new disk shows up, sysfs queue directory is created before elevator
is registered. This allows a user to attempt a scheduler switch even though
the initial registration hasn't completed yet.

In one scenario, blk_register_queue() calls elv_register_queue() and
right before cfq_registered_queue() is called, another process executes
elevator_switch() and replaces q->elevator with deadline scheduler. When
cfq_registered_queue() executes it interprets e->elevator_data as struct
cfq_data even though it is actually struct deadline_data.

Grab q->sysfs_lock in blk_register_queue() to synchronize with sysfs
callers.

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
---
 block/blk-sysfs.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 070d81bae1d5..002af836aa87 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -902,17 +902,20 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		return ret;
 
+	if (q->mq_ops)
+		blk_mq_register_dev(dev, q);
+
+	/* Prevent changes through sysfs until registration is completed. */
+	mutex_lock(&q->sysfs_lock);
+
 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
 	if (ret < 0) {
 		blk_trace_remove_sysfs(dev);
-		return ret;
+		goto unlock;
 	}
 
 	kobject_uevent(&q->kobj, KOBJ_ADD);
 
-	if (q->mq_ops)
-		blk_mq_register_dev(dev, q);
-
 	blk_wb_init(q);
 
 	if (q->request_fn || (q->mq_ops && q->elevator)) {
@@ -922,11 +925,13 @@ int blk_register_queue(struct gendisk *disk)
 			kobject_del(&q->kobj);
 			blk_trace_remove_sysfs(dev);
 			kobject_put(&dev->kobj);
-			return ret;
+			goto unlock;
 		}
 	}
-
-	return 0;
+	ret = 0;
+unlock:
+	mutex_unlock(&q->sysfs_lock);
+	return ret;
 }
 
 void blk_unregister_queue(struct gendisk *disk)
-- 
2.11.0.483.g087da7b7c-goog
