Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2597125A0
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706518; cv=none; b=L2x2cKNRmwe+WELfAo5RaHVheQu/w319as2IUrlY8CnrFeKeAwDMdfAd0bozSc65GFi/BP0KUcYvreiSkSY+sUH+zaynDFW78/XWhZh/Jni14E8ESqgo2RYRkMDS4TzgN3N8Vq169P6ERAOon/dK7ba1kyU9Y7dXHLEqKj2FuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706518; c=relaxed/simple;
	bh=nhqpIyR9ct9FsMOL/4fcHhvDsblZ1OGIn0Wl+/ZLVJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRUQFKR9r/xGHfQ7fxaa7W7fk0NLJ3GXXuOLP3/G8OclhvWWMZeNnLuftHCazN7Hvu2/cRC97GgdK1UQZ9T2Nes+dC1X9D/861lo4A3KQe25CSJKM5K7og7s8H548BXqh5nD0zuCMKQevyKGxHXRhR8VYuZJUTnfglBbZDAKuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B03C4CEFB;
	Fri, 21 Nov 2025 06:28:35 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v2 2/9] blk-rq-qos: fix possible debugfs_mutex deadlock
Date: Fri, 21 Nov 2025 14:28:22 +0800
Message-ID: <20251121062829.1433332-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121062829.1433332-1-yukuai@fnnas.com>
References: <20251121062829.1433332-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently rq-qos debugfs entries are created from rq_qos_add(), while
rq_qos_add() can be called while queue is still frozen. This can
deadlock because creating new entries can trigger fs reclaim.

Fix this problem by delaying creating rq-qos debugfs entries after queue
is unfrozen.

- For wbt, 1) it can be initialized by default, fix it by calling new
  helper after wbt_init() from wbt_enable_default; 2) it can be
  initialized by sysfs, fix it by calling new helper after queue is
  unfrozen from queue_wb_lat_store().
- For iocost and iolatency, they can only be initialized by blkcg
  configuration, fix by calling the new helper from blkg_conf_end().

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 38 +++++++++++++++++++++++++++++---------
 block/blk-rq-qos.c |  7 -------
 block/blk-sysfs.c  |  4 ++++
 block/blk-wbt.c    |  6 +++++-
 4 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3cffb68ba5d8..ad3bd43b2859 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -33,6 +33,7 @@
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
+#include "blk-mq-debugfs.h"
 
 static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
 
@@ -966,14 +967,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 }
 EXPORT_SYMBOL_GPL(blkg_conf_prep);
 
-/**
- * blkg_conf_exit - clean up per-blkg config update
- * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
- *
- * Clean up after per-blkg config update. This function must be called on all
- * blkg_conf_ctx's initialized with blkg_conf_init().
- */
-void blkg_conf_exit(struct blkg_conf_ctx *ctx)
+static void __blkg_conf_exit(struct blkg_conf_ctx *ctx)
 	__releases(&ctx->bdev->bd_queue->queue_lock)
 	__releases(&ctx->bdev->bd_queue->rq_qos_mutex)
 {
@@ -986,6 +980,26 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 		mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
 		blkdev_put_no_open(ctx->bdev);
 		ctx->body = NULL;
+	}
+}
+
+/**
+ * blkg_conf_exit - clean up per-blkg config update
+ * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
+ *
+ * Clean up after per-blkg config update. This function must be called on all
+ * blkg_conf_ctx's initialized with blkg_conf_init().
+ */
+void blkg_conf_exit(struct blkg_conf_ctx *ctx)
+{
+	__blkg_conf_exit(ctx);
+	if (ctx->bdev) {
+		struct request_queue *q = ctx->bdev->bd_queue;
+
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rq_qos(q);
+		mutex_unlock(&q->debugfs_mutex);
+
 		ctx->bdev = NULL;
 	}
 }
@@ -1000,8 +1014,14 @@ void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags)
 	if (ctx->bdev) {
 		struct request_queue *q = ctx->bdev->bd_queue;
 
-		blkg_conf_exit(ctx);
+		__blkg_conf_exit(ctx);
 		blk_mq_unfreeze_queue(q, memflags);
+
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rq_qos(q);
+		mutex_unlock(&q->debugfs_mutex);
+
+		ctx->bdev = NULL;
 	}
 }
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 654478dfbc20..d7ce99ce2e80 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -347,13 +347,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
 
 	blk_mq_unfreeze_queue(q, memflags);
-
-	if (rqos->ops->debugfs_attrs) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_rqos(rqos);
-		mutex_unlock(&q->debugfs_mutex);
-	}
-
 	return 0;
 ebusy:
 	blk_mq_unfreeze_queue(q, memflags);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 5c2d29ac6570..fb165f2977e6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -722,6 +722,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 out:
 	blk_mq_unfreeze_queue(q, memflags);
 
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_register_rq_qos(q);
+	mutex_unlock(&q->debugfs_mutex);
+
 	return ret;
 }
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index eb8037bae0bd..b1ab0f297f24 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -724,8 +724,12 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && enable)
+	if (queue_is_mq(q) && enable) {
 		wbt_init(disk);
+		mutex_lock(&q->debugfs_mutex);
+		blk_mq_debugfs_register_rq_qos(q);
+		mutex_unlock(&q->debugfs_mutex);
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
-- 
2.51.0

