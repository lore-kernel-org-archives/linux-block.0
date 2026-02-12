Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961E72C026E;
	Thu, 12 Feb 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770883301; cv=none; b=g3agjNb9tTK46nQdv3CXx+yD4KH58VBGPTnGT9gQN/OmJ0jBh6pNgOW+kQEgrsu1TWlFbsT+u6V7bnDRK2u8KY936HZYkeHTn8bV7lvGBdOHqnXpW3VGTNVa+Nb0fQuGgbwyBS12j7wuojiRcThtnEhsg81p3n9uQi3gyMqyn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770883301; c=relaxed/simple;
	bh=flCAHt/TgTNeBn2D7Yfc6mDIozS2TLt3Fvz8Nd4bJaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d63A+G6lplWYIZ+pGqSS4MYoWdGogLiFUPGmerEAg7R2zcVXeqbIzxGHBBOG940RSJltctmJ0SkcI8w1S0+0KSd9yvuzQPVje5S+uKV7Yd8KIeiG3bfsCwB2btA3tFb6R3JRWL/1r/VxA2fSNyGqVeFoiPHR4hzeeGH5bNeZ0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5012C4CEF7;
	Thu, 12 Feb 2026 08:01:37 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Jens Axboe <axboe@kernel.dk>,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	hch@lst.de,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: use NOIO context to prevent deadlock during debugfs creation
Date: Thu, 12 Feb 2026 16:01:35 +0800
Message-ID: <20260212080135.1673063-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating debugfs entries can trigger fs reclaim, which can enter back
into the block layer request_queue. This can cause deadlock if the
queue is frozen.

Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
to detect this condition, but it was racy since the queue can be frozen
from another context at any time.

Introduce blk_debugfs_mutex_lock()/blk_debugfs_mutex_unlock() helpers
that combine the debugfs_mutex with memalloc_noio_save()/restore() to
prevent fs reclaim from triggering block I/O. Replace all raw
debugfs_mutex lock/unlock pairs with these helpers.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com/
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq-debugfs.c  | 10 +++-------
 block/blk-mq-sched.c    | 10 ++++++----
 block/blk-sysfs.c       | 10 ++++++----
 block/blk-wbt.c         | 10 ++++++----
 block/blk.h             | 21 +++++++++++++++++++++
 kernel/trace/blktrace.c | 41 ++++++++++++++++++++++++-----------------
 6 files changed, 66 insertions(+), 36 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index faeaa1fc86a7..28167c9baa55 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 				 const struct blk_mq_debugfs_attr *attr)
 {
 	lockdep_assert_held(&q->debugfs_mutex);
-	/*
-	 * Creating new debugfs entries with queue freezed has the risk of
-	 * deadlock.
-	 */
-	WARN_ON_ONCE(q->mq_freeze_depth != 0);
 	/*
 	 * debugfs_mutex should not be nested under other locks that can be
 	 * grabbed while queue is frozen.
@@ -693,12 +688,13 @@ void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
+	unsigned int memflags;
 	unsigned long i;
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_register_hctx(q, hctx);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 }
 
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e26898128a7e..2cd07fe65e40 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -390,25 +390,27 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int fla
 void blk_mq_sched_reg_debugfs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
+	unsigned int memflags;
 	unsigned long i;
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	blk_mq_debugfs_register_sched(q);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_register_sched_hctx(q, hctx);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 }
 
 void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
+	unsigned int memflags;
 	unsigned long i;
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_unregister_sched_hctx(hctx);
 	blk_mq_debugfs_unregister_sched(q);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 }
 
 void blk_mq_free_sched_tags(struct elevator_tags *et,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 003aa684e854..31967a2867f7 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -891,14 +891,15 @@ const struct kobj_type blk_queue_ktype = {
 static void blk_debugfs_remove(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int memflags;
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	blk_trace_shutdown(q);
 	debugfs_remove_recursive(q->debugfs_dir);
 	q->debugfs_dir = NULL;
 	q->sched_debugfs_dir = NULL;
 	q->rqos_debugfs_dir = NULL;
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 }
 
 /**
@@ -908,6 +909,7 @@ static void blk_debugfs_remove(struct gendisk *disk)
 int blk_register_queue(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int memflags;
 	int ret;
 
 	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
@@ -921,11 +923,11 @@ int blk_register_queue(struct gendisk *disk)
 	}
 	mutex_lock(&q->sysfs_lock);
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	q->debugfs_dir = debugfs_create_dir(disk->disk_name, blk_debugfs_root);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_register(q);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 
 	ret = disk_register_independent_access_ranges(disk);
 	if (ret)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 1415f2bf8611..6dba71e87387 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -776,6 +776,7 @@ void wbt_init_enable_default(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_wb *rwb;
+	unsigned int memflags;
 
 	if (!__wbt_enable_default(disk))
 		return;
@@ -789,9 +790,9 @@ void wbt_init_enable_default(struct gendisk *disk)
 		return;
 	}
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	blk_mq_debugfs_register_rq_qos(q);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 }
 
 static u64 wbt_default_latency_nsec(struct request_queue *q)
@@ -1015,9 +1016,10 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 	blk_mq_unquiesce_queue(q);
 out:
 	blk_mq_unfreeze_queue(q, memflags);
-	mutex_lock(&q->debugfs_mutex);
+
+	memflags = blk_debugfs_lock(q);
 	blk_mq_debugfs_register_rq_qos(q);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 
 	return ret;
 }
diff --git a/block/blk.h b/block/blk.h
index 401d19ed08a6..d4f193814110 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -740,4 +740,25 @@ static inline void blk_unfreeze_release_lock(struct request_queue *q)
 }
 #endif
 
+/*
+ * debugfs directory and file creation can trigger fs reclaim, which can enter
+ * back into the block layer request_queue. This can cause deadlock if the
+ * queue is frozen. Use NOIO context together with debugfs_mutex to prevent fs
+ * reclaim from triggering block I/O.
+ */
+static inline unsigned int blk_debugfs_lock(struct request_queue *q)
+{
+	unsigned int memflags = memalloc_noio_save();
+
+	mutex_lock(&q->debugfs_mutex);
+	return memflags;
+}
+
+static inline void blk_debugfs_unlock(struct request_queue *q,
+				      unsigned int memflags)
+{
+	mutex_unlock(&q->debugfs_mutex);
+	memalloc_noio_restore(memflags);
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c4db5c2e7103..bc938b80702d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -557,11 +557,12 @@ static int __blk_trace_remove(struct request_queue *q)
 
 int blk_trace_remove(struct request_queue *q)
 {
+	unsigned int memflags;
 	int ret;
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	ret = __blk_trace_remove(q);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 
 	return ret;
 }
@@ -767,6 +768,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	struct blk_user_trace_setup2 buts2;
 	struct blk_user_trace_setup buts;
 	struct blk_trace *bt;
+	unsigned int memflags;
 	int ret;
 
 	ret = copy_from_user(&buts, arg, sizeof(buts));
@@ -785,16 +787,16 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		.pid = buts.pid,
 	};
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	bt = blk_trace_setup_prepare(q, name, dev, buts.buf_size, buts.buf_nr,
 				     bdev);
 	if (IS_ERR(bt)) {
-		mutex_unlock(&q->debugfs_mutex);
+		blk_debugfs_unlock(q, memflags);
 		return PTR_ERR(bt);
 	}
 	blk_trace_setup_finalize(q, name, 1, bt, &buts2);
 	strscpy(buts.name, buts2.name, BLKTRACE_BDEV_SIZE);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
 		blk_trace_remove(q);
@@ -809,6 +811,7 @@ static int blk_trace_setup2(struct request_queue *q, char *name, dev_t dev,
 {
 	struct blk_user_trace_setup2 buts2;
 	struct blk_trace *bt;
+	unsigned int memflags;
 
 	if (copy_from_user(&buts2, arg, sizeof(buts2)))
 		return -EFAULT;
@@ -819,15 +822,15 @@ static int blk_trace_setup2(struct request_queue *q, char *name, dev_t dev,
 	if (buts2.flags != 0)
 		return -EINVAL;
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	bt = blk_trace_setup_prepare(q, name, dev, buts2.buf_size, buts2.buf_nr,
 				     bdev);
 	if (IS_ERR(bt)) {
-		mutex_unlock(&q->debugfs_mutex);
+		blk_debugfs_unlock(q, memflags);
 		return PTR_ERR(bt);
 	}
 	blk_trace_setup_finalize(q, name, 2, bt, &buts2);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 
 	if (copy_to_user(arg, &buts2, sizeof(buts2))) {
 		blk_trace_remove(q);
@@ -844,6 +847,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 	struct blk_user_trace_setup2 buts2;
 	struct compat_blk_user_trace_setup cbuts;
 	struct blk_trace *bt;
+	unsigned int memflags;
 
 	if (copy_from_user(&cbuts, arg, sizeof(cbuts)))
 		return -EFAULT;
@@ -860,15 +864,15 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 		.pid = cbuts.pid,
 	};
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	bt = blk_trace_setup_prepare(q, name, dev, buts2.buf_size, buts2.buf_nr,
 				     bdev);
 	if (IS_ERR(bt)) {
-		mutex_unlock(&q->debugfs_mutex);
+		blk_debugfs_unlock(q, memflags);
 		return PTR_ERR(bt);
 	}
 	blk_trace_setup_finalize(q, name, 1, bt, &buts2);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 
 	if (copy_to_user(arg, &buts2.name, ARRAY_SIZE(buts2.name))) {
 		blk_trace_remove(q);
@@ -896,11 +900,12 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 
 int blk_trace_startstop(struct request_queue *q, int start)
 {
+	unsigned int memflags;
 	int ret;
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 	ret = __blk_trace_startstop(q, start);
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 
 	return ret;
 }
@@ -2018,9 +2023,10 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 	struct block_device *bdev = dev_to_bdev(dev);
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct blk_trace *bt;
+	unsigned int memflags;
 	ssize_t ret = -ENXIO;
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 
 	bt = rcu_dereference_protected(q->blk_trace,
 				       lockdep_is_held(&q->debugfs_mutex));
@@ -2041,7 +2047,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 		ret = sprintf(buf, "%llu\n", bt->end_lba);
 
 out_unlock_bdev:
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 	return ret;
 }
 
@@ -2052,6 +2058,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	struct block_device *bdev = dev_to_bdev(dev);
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct blk_trace *bt;
+	unsigned int memflags;
 	u64 value;
 	ssize_t ret = -EINVAL;
 
@@ -2071,7 +2078,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 			goto out;
 	}
 
-	mutex_lock(&q->debugfs_mutex);
+	memflags = blk_debugfs_lock(q);
 
 	bt = rcu_dereference_protected(q->blk_trace,
 				       lockdep_is_held(&q->debugfs_mutex));
@@ -2106,7 +2113,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	}
 
 out_unlock_bdev:
-	mutex_unlock(&q->debugfs_mutex);
+	blk_debugfs_unlock(q, memflags);
 out:
 	return ret ? ret : count;
 }
-- 
2.51.0

