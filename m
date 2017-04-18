Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH v3 3/8] blk-mq: Unregister debugfs attributes earlier
Date: Tue, 18 Apr 2017 16:29:44 -0700
Message-ID: <20170418232949.5228-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170418232949.5228-1-bart.vanassche@sandisk.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

One of the debugfs attributes allows to run a queue. Since running
a queue after a queue has entered the "dead" state is not allowed
and even can cause a kernel crash, unregister the debugfs attributes
before a queue reaches the "dead" state.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-sysfs.c | 31 ++++++-------------------------
 block/blk-sysfs.c    |  3 +--
 2 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 727e3b675130..1b2107f229ee 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -258,7 +258,7 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
-	blk_mq_debugfs_unregister_hctxs(q);
+	blk_mq_debugfs_unregister(q);
 
 	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(&q->mq_kobj);
@@ -306,8 +306,7 @@ void blk_mq_sysfs_init(struct request_queue *q)
 
 int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	int ret, i;
+	int ret;
 
 	WARN_ON_ONCE(!q->kobj.parent);
 	lockdep_assert_held(&q->sysfs_lock);
@@ -318,14 +317,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(&q->mq_kobj, KOBJ_ADD);
 
-	blk_mq_debugfs_register(q);
-
-	queue_for_each_hw_ctx(q, hctx, i) {
-		ret = blk_mq_register_hctx(hctx);
-		if (ret)
-			break;
-	}
-
+	ret = blk_mq_debugfs_register(q);
 	if (ret)
 		__blk_mq_unregister_dev(dev, q);
 	else
@@ -351,20 +343,9 @@ EXPORT_SYMBOL_GPL(blk_mq_register_dev);
 
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	int i;
-
 	mutex_lock(&q->sysfs_lock);
-
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
-
-	blk_mq_debugfs_unregister_hctxs(q);
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_unregister_hctx(hctx);
-
-unlock:
+	if (q->mq_sysfs_init_done)
+		blk_mq_debugfs_unregister(q);
 	mutex_unlock(&q->sysfs_lock);
 }
 
@@ -380,7 +361,7 @@ int blk_mq_sysfs_register(struct request_queue *q)
 	if (!q->mq_sysfs_init_done)
 		goto unlock;
 
-	blk_mq_debugfs_register_hctxs(q);
+	blk_mq_debugfs_register(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 726ca28584dc..3b6eca07b7a4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -823,8 +823,7 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_trace_shutdown(q);
 
-	if (q->mq_ops)
-		blk_mq_debugfs_unregister(q);
+	WARN_ON_ONCE(q->debugfs_dir);
 
 	if (q->bio_split)
 		bioset_free(q->bio_split);
-- 
2.12.2
