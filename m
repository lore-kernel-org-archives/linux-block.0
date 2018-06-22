Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] block: fix the lock inversion caused by kobject_del under sysfs_lock
Date: Fri, 22 Jun 2018 15:11:20 +0800
Message-Id: <1529651480-1734-4-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Currently, the kobject_del for sysfs mq and hctx entry is invoked
under q->sysfs_lock. lock inversion will came up when someone try
to access the sysfs entries concurrently. The scenario is as below:
  hold q->sysfs_lock    access mq,hctx sysfs entries
  kobject_del
  __kernfs_remove          kernfs_get_active
    kernfs_drain
     wait kn->active       require q->sysfs_lock
To fix this issue, we do as following:
 - still reserve q->sysfs_lock as the sync method between queue, mq
   hctx sysfs entries' show and store method.
 - use QUEUE_FLAG_REGISTERED to sync the blk_register/unregister_queue
   with sysfs entries.
 - use QUEUE_FLAG_REGISTERED to sync the blk_mq_register/unregister_dev
   with blk_mq_sysfs_register/unregister.
 - change q->mq_sysfs_init_done to q->mq_sysfs_ready to sync
   blk_mq_register/unregister_dev and blk_mq_sysfs_register/unregister
   with mq,hctx entries.
Then we don't need sysfs_lock on kobject_del anymore.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sysfs.c   | 66 +++++++++++++++++++++++++++++++++++++-------------
 block/blk-sysfs.c      | 39 +++++++++++++++--------------
 block/blk-wbt.c        |  4 ---
 block/elevator.c       |  3 ++-
 include/linux/blkdev.h |  2 +-
 5 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index ec26745..0923c2c 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -55,7 +55,9 @@ static ssize_t blk_mq_sysfs_show(struct kobject *kobj, struct attribute *attr,
 
 	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
+	if (!blk_queue_dying(q) &&
+	    blk_queue_registered(q) &&
+	    q->mq_sysfs_ready)
 		res = entry->show(ctx, page);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -78,7 +80,9 @@ static ssize_t blk_mq_sysfs_store(struct kobject *kobj, struct attribute *attr,
 
 	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
+	if (!blk_queue_dying(q) &&
+	    blk_queue_registered(q) &&
+	    q->mq_sysfs_ready)
 		res = entry->store(ctx, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -101,7 +105,9 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 
 	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
+	if (!blk_queue_dying(q) &&
+	    blk_queue_registered(q) &&
+	    q->mq_sysfs_ready)
 		res = entry->show(hctx, page);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -125,7 +131,9 @@ static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
 
 	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
+	if (!blk_queue_dying(q) &&
+	    blk_queue_registered(q) &&
+	    q->mq_sysfs_ready)
 		res = entry->store(hctx, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -253,7 +261,9 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	lockdep_assert_held(&q->sysfs_lock);
+	mutex_lock(&q->sysfs_lock);
+	q->mq_sysfs_ready = false;
+	mutex_unlock(&q->sysfs_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
@@ -262,7 +272,6 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	kobject_del(&q->mq_kobj);
 	kobject_put(&dev->kobj);
 
-	q->mq_sysfs_init_done = false;
 }
 
 void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
@@ -295,13 +304,22 @@ void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
+/*
+ * blk_mq_register_dev/blk_mq_unregister_dev are only invoked by
+ * blk_register_queue/blk_unregister_queue. So we could use
+ * QUEUE_FLAG_REGISTERED to sync with blk_mq_sysfs_register/unregister.
+ * If QUEUE_FLAG_REGISTERED is set, q->mq_kobj is ok, otherwise, it is
+ * not there.
+ * blk_mq_register/unregister_dev blk_mq_sysfs_register/unregister all
+ * use q->mq_sysfs_ready to sync with mq and hctx sysfs entries' store
+ * and show method.
+ */
 int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int ret, i;
 
 	WARN_ON_ONCE(!q->kobj.parent);
-	lockdep_assert_held(&q->sysfs_lock);
 
 	ret = kobject_add(&q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
 	if (ret < 0)
@@ -315,7 +333,9 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 			goto unreg;
 	}
 
-	q->mq_sysfs_init_done = true;
+	mutex_lock(&q->sysfs_lock);
+	q->mq_sysfs_ready = true;
+	mutex_unlock(&q->sysfs_lock);
 
 out:
 	return ret;
@@ -335,15 +355,20 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	/*
+	 * If QUEUE_FLAG_REGISTERED is not set, q->mq_kobj
+	 * is not ready.
+	 */
 	mutex_lock(&q->sysfs_lock);
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
+	if (!blk_queue_registered(q)) {
+		mutex_unlock(&q->sysfs_lock);
+		return;
+	}
+	q->mq_sysfs_ready = false;
+	mutex_unlock(&q->sysfs_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
-
-unlock:
-	mutex_unlock(&q->sysfs_lock);
 }
 
 int blk_mq_sysfs_register(struct request_queue *q)
@@ -351,9 +376,16 @@ int blk_mq_sysfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i, ret = 0;
 
+	/*
+	 * If QUEUE_FLAG_REGISTERED is not set, q->mq_kobj
+	 * is not ready.
+	 */
 	mutex_lock(&q->sysfs_lock);
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
+	if (!blk_queue_registered(q)) {
+		mutex_unlock(&q->sysfs_lock);
+		return ret;
+	}
+	mutex_unlock(&q->sysfs_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
@@ -361,8 +393,8 @@ int blk_mq_sysfs_register(struct request_queue *q)
 			break;
 	}
 
-unlock:
+	mutex_lock(&q->sysfs_lock);
+	q->mq_sysfs_ready = true;
 	mutex_unlock(&q->sysfs_lock);
-
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 96dcbb9..a3ef681 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -741,7 +741,8 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	if (!entry->show)
 		return -EIO;
 	mutex_lock(&q->sysfs_lock);
-	if (blk_queue_dying(q)) {
+	if (blk_queue_dying(q) ||
+	    !blk_queue_registered(q)) {
 		mutex_unlock(&q->sysfs_lock);
 		return -ENOENT;
 	}
@@ -763,7 +764,8 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	q = container_of(kobj, struct request_queue, kobj);
 	mutex_lock(&q->sysfs_lock);
-	if (blk_queue_dying(q)) {
+	if (blk_queue_dying(q) ||
+	    !blk_queue_registered(q)) {
 		mutex_unlock(&q->sysfs_lock);
 		return -ENOENT;
 	}
@@ -866,7 +868,6 @@ int blk_register_queue(struct gendisk *disk)
 	WARN_ONCE(blk_queue_registered(q),
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
-	queue_flag_set_unlocked(QUEUE_FLAG_REGISTERED, q);
 
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
@@ -887,17 +888,16 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		return ret;
 
-	/* Prevent changes through sysfs until registration is completed. */
-	mutex_lock(&q->sysfs_lock);
-
 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
 	if (ret < 0) {
 		blk_trace_remove_sysfs(dev);
-		goto unlock;
+		return ret;
 	}
 
 	if (q->mq_ops) {
-		blk_mq_register_dev(dev, q);
+		ret = blk_mq_register_dev(dev, q);
+		if (ret)
+			goto err_kobj;
 		blk_mq_debugfs_register(q);
 	}
 
@@ -907,20 +907,25 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_throtl_register_queue(q);
 
+	/* Prevent changes through sysfs until registration is completed. */
+	mutex_lock(&q->sysfs_lock);
 	if (q->request_fn || (q->mq_ops && q->elevator)) {
 		ret = elv_register_queue(q);
 		if (ret) {
 			mutex_unlock(&q->sysfs_lock);
-			kobject_uevent(&q->kobj, KOBJ_REMOVE);
-			kobject_del(&q->kobj);
-			blk_trace_remove_sysfs(dev);
-			kobject_put(&dev->kobj);
-			return ret;
+			goto err_kobj;
 		}
 	}
-	ret = 0;
-unlock:
+
+	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	mutex_unlock(&q->sysfs_lock);
+	return 0;
+
+err_kobj:
+	kobject_uevent(&q->kobj, KOBJ_REMOVE);
+	kobject_del(&q->kobj);
+	blk_trace_remove_sysfs(dev);
+	kobject_put(&dev->kobj);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
@@ -949,16 +954,14 @@ void blk_unregister_queue(struct gendisk *disk)
 	 * concurrent elv_iosched_store() calls.
 	 */
 	mutex_lock(&q->sysfs_lock);
-
 	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
-
+	mutex_unlock(&q->sysfs_lock);
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
 	 */
 	if (q->mq_ops)
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
-	mutex_unlock(&q->sysfs_lock);
 
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
 	kobject_del(&q->kobj);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 43ae265..c26deca 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -706,10 +706,6 @@ void wbt_enable_default(struct request_queue *q)
 	if (q->rq_wb)
 		return;
 
-	/* Queue not registered? Maybe shutting down... */
-	if (!blk_queue_registered(q))
-		return;
-
 	if ((q->mq_ops && IS_ENABLED(CONFIG_BLK_WBT_MQ)) ||
 	    (q->request_fn && IS_ENABLED(CONFIG_BLK_WBT_SQ)))
 		wbt_init(q);
diff --git a/block/elevator.c b/block/elevator.c
index a574841..a68e3e6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -869,7 +869,8 @@ void elv_unregister_queue(struct request_queue *q)
 		kobject_del(&e->kobj);
 		e->registered = 0;
 		/* Re-enable throttling in case elevator disabled it */
-		wbt_enable_default(q);
+		if (blk_queue_registered(q))
+			wbt_enable_default(q);
 	}
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6174ed..df53e8f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -666,7 +666,7 @@ struct request_queue {
 	struct dentry		*sched_debugfs_dir;
 #endif
 
-	bool			mq_sysfs_init_done;
+	bool			mq_sysfs_ready;
 
 	size_t			cmd_size;
 	void			*rq_alloc_data;
-- 
2.7.4
