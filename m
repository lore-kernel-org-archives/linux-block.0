Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DB14885D
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103688; cv=none; b=dIZsmbW3dqPhN8AtWDo18vwxAYWFhDBcSPgDHnNTHgx7z98CSIuVgUchRHzYBVZFJCwF3Kcu3BM2tlnfxWCqwj/weDr9p29bm/pntZSIelGbU/GJGeZRqVpBW+t/McF+84XvlS+Vkr2b2jcl9lXPrdK7PwsiVrcYmYvv5GMqpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103688; c=relaxed/simple;
	bh=1SUA5oSQ3LyAmB+Zqt7w7ry2YOfi54OgMjAKSMzZKu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5gPljR5Ok4daiuHVifPf6KR6N1QOnSEkGjRNYs0gFLdZGonj+P9Xv37jecuaXE0YZAwgMQCyHf+Vw7E0byRZtSRxim0JElUuQlf2v39irNKPD57YOWNk2m/iyiTSKu5oUZH3dglK8FlG/rXwB3CJboSCSeKbeo6TOnSP6H4zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIquQ1at; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIquQ1at"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739103685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbQ4dK4N1DU8LUVoPizsrTjXfHqZpArF+Z+f+IZZTxA=;
	b=dIquQ1atQOe0HYd3y+DDJmlIgR9VpT3e+QPZ/iJl6C/M5LgXhsMoF0RaLlRUJS16faBPJk
	vuzTEgowDCcVcNJkjF+gDFuatWQAzmGk7jR2KFyladW/Be1XvOvbJ//RzrOPBHmDylPjSW
	wH8z0UvNqDeWx8zOMNNHszHOj+aIT7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-R9yv10bqMnSh6J8xqQyJXw-1; Sun,
 09 Feb 2025 07:21:21 -0500
X-MC-Unique: R9yv10bqMnSh6J8xqQyJXw-1
X-Mimecast-MFC-AGG-ID: R9yv10bqMnSh6J8xqQyJXw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C50C218004A7;
	Sun,  9 Feb 2025 12:21:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6D73180087A;
	Sun,  9 Feb 2025 12:21:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/7] block: remove q->debugfs_dir
Date: Sun,  9 Feb 2025 20:20:30 +0800
Message-ID: <20250209122035.1327325-7-ming.lei@redhat.com>
In-Reply-To: <20250209122035.1327325-1-ming.lei@redhat.com>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

For each rqos instance, its debugfs path is fixed, which can be queried
from its block debugfs dentry & disk name directly, so it isn't necessary to
cache it in request_queue instance because it isn't used in fast path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c  | 73 ++++++++++++++++++++++++++++++-----------
 block/blk-sysfs.c       |  5 ++-
 include/linux/blkdev.h  |  1 -
 kernel/trace/blktrace.c | 25 +++++++++++---
 4 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 40eb104fc1d5..6d98c2a6e7c6 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -616,15 +616,25 @@ static void debugfs_create_files(struct dentry *parent, void *data,
 				    (void *)attr, &blk_mq_debugfs_fops);
 }
 
+static __must_check struct dentry *blk_mq_get_queue_entry(
+		struct request_queue *q)
+{
+	return debugfs_lookup(q->disk->disk_name, blk_debugfs_root);
+}
+
 void blk_mq_debugfs_register(struct request_queue *q)
 {
+	struct dentry *queue_dir = blk_mq_get_queue_entry(q);
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
+	if (IS_ERR_OR_NULL(queue_dir))
+		return;
+
+	debugfs_create_files(queue_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
-	 * blk_mq_init_sched() attempted to do this already, but q->debugfs_dir
+	 * blk_mq_init_sched() attempted to do this already, but queue debugfs_dir
 	 * didn't exist yet (because we don't know what to name the directory
 	 * until the queue is registered to a gendisk).
 	 */
@@ -638,7 +648,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
-	debugfs_create_dir("rqos", q->debugfs_dir);
+	debugfs_create_dir("rqos", queue_dir);
 
 	if (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
@@ -648,15 +658,25 @@ void blk_mq_debugfs_register(struct request_queue *q)
 			rqos = rqos->next;
 		}
 	}
+
+	dput(queue_dir);
 }
 
 static __must_check struct dentry *blk_mq_get_hctx_entry(
 		struct blk_mq_hw_ctx *hctx)
 {
+	struct dentry *queue_dir = blk_mq_get_queue_entry(hctx->queue);
+	struct dentry *dir;
 	char name[20];
 
+	if (IS_ERR_OR_NULL(queue_dir))
+		return NULL;
+
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
-	return debugfs_lookup(name, hctx->queue->debugfs_dir);
+	dir = debugfs_lookup(name, queue_dir);
+	dput(queue_dir);
+
+	return dir;
 }
 
 static __must_check struct dentry *blk_mq_get_hctx_sched_entry(
@@ -692,32 +712,32 @@ static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 void blk_mq_debugfs_register_hctx(struct request_queue *q,
 				  struct blk_mq_hw_ctx *hctx)
 {
+	struct dentry *queue_dir = blk_mq_get_queue_entry(q);
 	struct dentry *hctx_dir;
 	struct blk_mq_ctx *ctx;
 	char name[20];
 	int i;
 
-	if (!q->debugfs_dir)
+	if (IS_ERR_OR_NULL(queue_dir))
 		return;
 
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
-	hctx_dir = debugfs_create_dir(name, q->debugfs_dir);
+	hctx_dir = debugfs_create_dir(name, queue_dir);
 	if (IS_ERR_OR_NULL(hctx_dir))
-		return;
+		goto exit;
 
 	debugfs_create_files(hctx_dir, hctx, blk_mq_debugfs_hctx_attrs);
 
 	hctx_for_each_ctx(hctx, ctx, i)
 		blk_mq_debugfs_register_ctx(hctx, ctx);
+exit:
+	dput(queue_dir);
 }
 
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct dentry *hctx_dir;
 
-	if (!hctx->queue->debugfs_dir)
-		return;
-
 	hctx_dir = blk_mq_get_hctx_entry(hctx);
 	if (IS_ERR_OR_NULL(hctx_dir))
 		return;
@@ -746,6 +766,7 @@ void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 
 void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
+	struct dentry *queue_dir = blk_mq_get_queue_entry(q);
 	struct elevator_type *e = q->elevator->type;
 	struct dentry *sched_dir;
 
@@ -755,22 +776,29 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 	 * If the parent directory has not been created yet, return, we will be
 	 * called again later on and the directory/files will be created then.
 	 */
-	if (!q->debugfs_dir)
+	if (IS_ERR_OR_NULL(queue_dir))
 		return;
 
 	if (!e->queue_debugfs_attrs)
-		return;
+		goto exit;
 
-	sched_dir = debugfs_create_dir("sched", q->debugfs_dir);
+	sched_dir = debugfs_create_dir("sched", queue_dir);
 
 	debugfs_create_files(sched_dir, q, e->queue_debugfs_attrs);
+exit:
+	dput(queue_dir);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 {
+	struct dentry *queue_dir = blk_mq_get_queue_entry(q);
+
 	lockdep_assert_held(&q->debugfs_mutex);
 
-	debugfs_lookup_and_remove("sched", q->debugfs_dir);
+	if (IS_ERR_OR_NULL(queue_dir))
+		return;
+	debugfs_lookup_and_remove("sched", queue_dir);
+	dput(queue_dir);
 }
 
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
@@ -789,24 +817,33 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 static __must_check struct dentry *blk_mq_debugfs_get_rqos_top(
 		struct request_queue *q)
 {
-	return debugfs_lookup("rqos", q->debugfs_dir);
+	struct dentry *queue_dir = blk_mq_get_queue_entry(q);
+	struct dentry *dir = NULL;
+
+	if (queue_dir)
+		dir = debugfs_lookup("rqos", queue_dir);
+	dput(queue_dir);
+	return dir;
 }
 
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
+	struct dentry *queue_dir = blk_mq_get_queue_entry(q);
 	struct dentry *rqos_top;
 
 	lockdep_assert_held(&q->debugfs_mutex);
 
-	if (!q->debugfs_dir)
+	if (IS_ERR_OR_NULL(queue_dir))
 		return;
 
 	rqos_top = blk_mq_debugfs_get_rqos_top(q);
 	if (IS_ERR_OR_NULL(rqos_top))
-		return;
+		goto exit;
 	debugfs_lookup_and_remove(rq_qos_id_to_name(rqos->id), rqos_top);
 	dput(rqos_top);
+exit:
+	dput(queue_dir);
 }
 
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
@@ -862,8 +899,6 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 
 	lockdep_assert_held(&hctx->queue->debugfs_mutex);
 
-	if (!hctx->queue->debugfs_dir)
-		return;
 	sched_dir = blk_mq_get_hctx_sched_entry(hctx);
 	if (sched_dir) {
 		debugfs_remove_recursive(sched_dir);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0679116bb195..68bd84e06aac 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -746,8 +746,7 @@ static void blk_debugfs_remove(struct gendisk *disk)
 
 	mutex_lock(&q->debugfs_mutex);
 	blk_trace_shutdown(q);
-	debugfs_remove_recursive(q->debugfs_dir);
-	q->debugfs_dir = NULL;
+	debugfs_lookup_and_remove(disk->disk_name, blk_debugfs_root);
 	mutex_unlock(&q->debugfs_mutex);
 }
 
@@ -773,7 +772,7 @@ int blk_register_queue(struct gendisk *disk)
 	mutex_lock(&q->sysfs_lock);
 
 	mutex_lock(&q->debugfs_mutex);
-	q->debugfs_dir = debugfs_create_dir(disk->disk_name, blk_debugfs_root);
+	debugfs_create_dir(disk->disk_name, blk_debugfs_root);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_register(q);
 	mutex_unlock(&q->debugfs_mutex);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7663f0c482de..adde68134ce4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -597,7 +597,6 @@ struct request_queue {
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 
-	struct dentry		*debugfs_dir;
 	/*
 	 * Serializes all debugfs metadata operations using the above dentries.
 	 */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3679a6d18934..32cda8f5d008 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,17 +311,31 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_restore(flags);
 }
 
+static struct dentry *blk_get_queue_debugfs_dir(struct request_queue *q)
+{
+	struct dentry *dir = NULL;;
+
+	if (q->disk)
+		dir = debugfs_lookup(q->disk->disk_name, blk_debugfs_root);
+	return dir;
+}
+
 static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 {
 	relay_close(bt->rchan);
 
 	/*
 	 * If 'bt->dir' is not set, then both 'dropped' and 'msg' are created
-	 * under 'q->debugfs_dir', thus lookup and remove them.
+	 * under block queue debugfs dir, thus lookup and remove them.
 	 */
 	if (!bt->dir) {
-		debugfs_lookup_and_remove("dropped", q->debugfs_dir);
-		debugfs_lookup_and_remove("msg", q->debugfs_dir);
+		struct dentry *dir = blk_get_queue_debugfs_dir(q);
+
+		if (!IS_ERR_OR_NULL(dir)) {
+			debugfs_lookup_and_remove("dropped", dir);
+			debugfs_lookup_and_remove("msg", dir);
+			dput(dir);
+		}
 	} else {
 		debugfs_remove(bt->dir);
 	}
@@ -517,6 +531,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 {
 	struct blk_trace *bt = NULL;
 	struct dentry *dir = NULL;
+	struct dentry *dir_to_drop = NULL;
 	int ret;
 
 	lockdep_assert_held(&q->debugfs_mutex);
@@ -563,7 +578,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 * directory that will be removed once the trace ends.
 	 */
 	if (bdev && !bdev_is_partition(bdev))
-		dir = q->debugfs_dir;
+		dir_to_drop = dir = blk_get_queue_debugfs_dir(q);
 	else
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
@@ -614,6 +629,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 err:
 	if (ret)
 		blk_trace_free(q, bt);
+	if (!IS_ERR_OR_NULL(dir_to_drop))
+		dput(dir_to_drop);
 	return ret;
 }
 
-- 
2.47.0

