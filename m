Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH v3 1/8] blk-mq: Register <dev>/queue/mq after having registered <dev>/queue
Date: Tue, 18 Apr 2017 16:29:42 -0700
Message-ID: <20170418232949.5228-2-bart.vanassche@sandisk.com>
In-Reply-To: <20170418232949.5228-1-bart.vanassche@sandisk.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

A later patch in this series will modify blk_mq_debugfs_register()
such that it uses q->kobj.parent to determine the name of a
request queue. Hence make sure that that pointer is initialized
before blk_mq_debugfs_register() is called. To avoid lock inversion,
protect sysfs / debugfs registration with the queue sysfs_lock
instead of the global mutex all_q_mutex.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-sysfs.c | 43 +++++++++++++++++++++++++++++++++++--------
 block/blk-mq.h       |  1 +
 block/blk-sysfs.c    |  6 +++---
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index d745ab81033a..54ef9402914c 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -253,6 +253,8 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	lockdep_assert_held(&q->sysfs_lock);
+
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
@@ -267,9 +269,9 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 
 void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 {
-	blk_mq_disable_hotplug();
+	mutex_lock(&q->sysfs_lock);
 	__blk_mq_unregister_dev(dev, q);
-	blk_mq_enable_hotplug();
+	mutex_unlock(&q->sysfs_lock);
 }
 
 void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
@@ -302,12 +304,13 @@ void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
-int blk_mq_register_dev(struct device *dev, struct request_queue *q)
+int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int ret, i;
 
-	blk_mq_disable_hotplug();
+	WARN_ON_ONCE(!q->kobj.parent);
+	lockdep_assert_held(&q->sysfs_lock);
 
 	ret = kobject_add(&q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
 	if (ret < 0)
@@ -327,8 +330,20 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 		__blk_mq_unregister_dev(dev, q);
 	else
 		q->mq_sysfs_init_done = true;
+
 out:
-	blk_mq_enable_hotplug();
+	return ret;
+}
+
+int blk_mq_register_dev(struct device *dev, struct request_queue *q)
+{
+	int ret;
+
+	ret = mutex_lock_interruptible(&q->sysfs_lock);
+	if (ret < 0)
+		return ret;
+	ret = __blk_mq_register_dev(dev, q);
+	mutex_unlock(&q->sysfs_lock);
 
 	return ret;
 }
@@ -339,23 +354,32 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	mutex_lock(&q->sysfs_lock);
+
 	if (!q->mq_sysfs_init_done)
-		return;
+		goto unlock;
 
 	blk_mq_debugfs_unregister_hctxs(q);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
+
+unlock:
+	mutex_unlock(&q->sysfs_lock);
 }
 
 int blk_mq_sysfs_register(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
-	int i, ret = 0;
+	int i, ret;
 
-	if (!q->mq_sysfs_init_done)
+	ret = mutex_lock_interruptible(&q->sysfs_lock);
+	if (ret < 0)
 		return ret;
 
+	if (!q->mq_sysfs_init_done)
+		goto unlock;
+
 	blk_mq_debugfs_register_hctxs(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
@@ -364,5 +388,8 @@ int blk_mq_sysfs_register(struct request_queue *q)
 			break;
 	}
 
+unlock:
+	mutex_unlock(&q->sysfs_lock);
+
 	return ret;
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 524f44742816..7d955c756810 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -78,6 +78,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
  */
 extern void blk_mq_sysfs_init(struct request_queue *q);
 extern void blk_mq_sysfs_deinit(struct request_queue *q);
+extern int __blk_mq_register_dev(struct device *dev, struct request_queue *q);
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fc20489f0d2b..726ca28584dc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -894,9 +894,6 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		return ret;
 
-	if (q->mq_ops)
-		blk_mq_register_dev(dev, q);
-
 	/* Prevent changes through sysfs until registration is completed. */
 	mutex_lock(&q->sysfs_lock);
 
@@ -906,6 +903,9 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	if (q->mq_ops)
+		__blk_mq_register_dev(dev, q);
+
 	kobject_uevent(&q->kobj, KOBJ_ADD);
 
 	blk_wb_init(q);
-- 
2.12.2
