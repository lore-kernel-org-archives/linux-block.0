Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1113D28F
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103692; cv=none; b=PGUNWyVk+apTSIukBm2gkVezceRqapNcoC70YrPR7tmrhWqRtTV83ekiD/Pu8FBe3I3/h8HmbyPCM0HA7dG7TyA5FWDMM8+jFfA+b4bJZcpXqAkNEBxHgWsTqdAH/p66Na9hh192gAj2F1Pyg+hpOwjn5xKk/jS4NpYcBdy3D0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103692; c=relaxed/simple;
	bh=RE6+26sA268ejnWTVotebq0zmGe987wJUrx+7uoppkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owNiKRin7Es1bBGLzEUZl3z7j5/TKyDxQgDIva7KA5nQct1wdQfV659s/263CAAF7SwIj6nZUF/TMg/kHYv4eFNYa6I1oxytR5r1sUbGmnhAX1CUxLhUVvaVNW4yRbkM/eZFnUd2u0vAY3w1z/E+/rzpEYigPTgVAgcItBLAfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AW1Qs5B5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW1Qs5B5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739103689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWIoHiz2awyXmVeZbGLuG1ySnYN09kxBetSD+HavMj8=;
	b=AW1Qs5B5iAux9bkOEXLX46vvCsLij+XeM80AjyBVX6wOuAJqnVInr7UnDtZ4WFqSiTyO7T
	pJhMfPvs2+X9QtrHya3qYTahCbIxd6rKAYnNsIQ7SKo2X+ycq0+RmMEoJjPrHabO7lqLp2
	cs/KxUa9B6PqToaNZbc1hY/oZ/11n/U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-5wkc_G91NfyKY70H1F7Vww-1; Sun,
 09 Feb 2025 07:21:26 -0500
X-MC-Unique: 5wkc_G91NfyKY70H1F7Vww-1
X-Mimecast-MFC-AGG-ID: 5wkc_G91NfyKY70H1F7Vww
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E1B3180034A;
	Sun,  9 Feb 2025 12:21:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 077581800265;
	Sun,  9 Feb 2025 12:21:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/7] block: don't grab q->debugfs_mutex
Date: Sun,  9 Feb 2025 20:20:31 +0800
Message-ID: <20250209122035.1327325-8-ming.lei@redhat.com>
In-Reply-To: <20250209122035.1327325-1-ming.lei@redhat.com>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

All block internal state for dealing adding/removing debugfs entries
have been removed, and debugfs can sync everything for us in fs level,
so don't grab q->debugfs_mutex for adding/removing block internal debugfs
entries.

Now q->debugfs_mutex is only used for blktrace, meantime move creating
queue debugfs dir code out of q->sysfs_lock. Both the two locks are
connected with queue freeze IO lock.  Then queue freeze IO lock chain
with debugfs lock is cut.

The following lockdep report can be fixed:

https://lore.kernel.org/linux-block/ougniadskhks7uyxguxihgeuh2pv4yaqv4q3emo4gwuolgzdt6@brotly74p6bs/

Follows contexts which adds/removes debugfs entries:

- update nr_hw_queues

- add/remove disks

- elevator switch

- blktrace

blktrace only adds entries under disk top directory, so we can ignore it,
because it can only work iff disk is added. Also nothing overlapped with
the other two contex, blktrace context is fine.

Elevator switch is only allowed after disk is added, so there isn't race
with add/remove disk. blk_mq_update_nr_hw_queues() always restores to
previous elevator, so no race between these two. Elevator switch context
is fine.

So far blk_mq_update_nr_hw_queues() doesn't hold debugfs lock for
adding/removing hctx entries, there might be race with add/remove disk,
which is just fine in reality:

- blk_mq_update_nr_hw_queues() is usually for error recovery, and disk
won't be added/removed at the same time

- even though there is race between the two contexts, it is just fine,
since hctx won't be freed until queue is dead

- we never see reports in this area without holding debugfs in
blk_mq_update_nr_hw_queues()

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c  | 12 ------------
 block/blk-mq-sched.c    |  8 --------
 block/blk-rq-qos.c      |  7 +------
 block/blk-sysfs.c       |  6 +-----
 kernel/trace/blktrace.c |  2 ++
 5 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6d98c2a6e7c6..9601823730e2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -770,8 +770,6 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 	struct elevator_type *e = q->elevator->type;
 	struct dentry *sched_dir;
 
-	lockdep_assert_held(&q->debugfs_mutex);
-
 	/*
 	 * If the parent directory has not been created yet, return, we will be
 	 * called again later on and the directory/files will be created then.
@@ -793,8 +791,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 {
 	struct dentry *queue_dir = blk_mq_get_queue_entry(q);
 
-	lockdep_assert_held(&q->debugfs_mutex);
-
 	if (IS_ERR_OR_NULL(queue_dir))
 		return;
 	debugfs_lookup_and_remove("sched", queue_dir);
@@ -832,8 +828,6 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 	struct dentry *queue_dir = blk_mq_get_queue_entry(q);
 	struct dentry *rqos_top;
 
-	lockdep_assert_held(&q->debugfs_mutex);
-
 	if (IS_ERR_OR_NULL(queue_dir))
 		return;
 
@@ -853,8 +847,6 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 	struct dentry *rqos_top;
 	struct dentry *rqos_dir;
 
-	lockdep_assert_held(&q->debugfs_mutex);
-
 	if (!rqos->ops->debugfs_attrs)
 		return;
 
@@ -874,8 +866,6 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 	struct elevator_type *e = q->elevator->type;
 	struct dentry *sched_dir;
 
-	lockdep_assert_held(&q->debugfs_mutex);
-
 	/*
 	 * If the parent debugfs directory has not been created yet, return;
 	 * We will be called again later on with appropriate parent debugfs
@@ -897,8 +887,6 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct dentry *sched_dir;
 
-	lockdep_assert_held(&hctx->queue->debugfs_mutex);
-
 	sched_dir = blk_mq_get_hctx_sched_entry(hctx);
 	if (sched_dir) {
 		debugfs_remove_recursive(sched_dir);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 7442ca27c2bf..1ca127297b2c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -469,9 +469,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (ret)
 		goto err_free_map_and_rqs;
 
-	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_register_sched(q);
-	mutex_unlock(&q->debugfs_mutex);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->ops.init_hctx) {
@@ -484,9 +482,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 				return ret;
 			}
 		}
-		mutex_lock(&q->debugfs_mutex);
 		blk_mq_debugfs_register_sched_hctx(q, hctx);
-		mutex_unlock(&q->debugfs_mutex);
 	}
 
 	return 0;
@@ -527,9 +523,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	unsigned int flags = 0;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		mutex_lock(&q->debugfs_mutex);
 		blk_mq_debugfs_unregister_sched_hctx(hctx);
-		mutex_unlock(&q->debugfs_mutex);
 
 		if (e->type->ops.exit_hctx && hctx->sched_data) {
 			e->type->ops.exit_hctx(hctx, i);
@@ -538,9 +532,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 		flags = hctx->flags;
 	}
 
-	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_unregister_sched(q);
-	mutex_unlock(&q->debugfs_mutex);
 
 	if (e->type->ops.exit_sched)
 		e->type->ops.exit_sched(e);
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index d4d4f4dc0e23..529640ed2ff5 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -320,11 +320,8 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 
 	blk_mq_unfreeze_queue(q, memflags);
 
-	if (rqos->ops->debugfs_attrs) {
-		mutex_lock(&q->debugfs_mutex);
+	if (rqos->ops->debugfs_attrs)
 		blk_mq_debugfs_register_rqos(rqos);
-		mutex_unlock(&q->debugfs_mutex);
-	}
 
 	return 0;
 ebusy:
@@ -349,7 +346,5 @@ void rq_qos_del(struct rq_qos *rqos)
 	}
 	blk_mq_unfreeze_queue(q, memflags);
 
-	mutex_lock(&q->debugfs_mutex);
 	blk_mq_debugfs_unregister_rqos(rqos);
-	mutex_unlock(&q->debugfs_mutex);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 68bd84e06aac..b0bfb4c82e0e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -744,10 +744,8 @@ static void blk_debugfs_remove(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 
-	mutex_lock(&q->debugfs_mutex);
 	blk_trace_shutdown(q);
 	debugfs_lookup_and_remove(disk->disk_name, blk_debugfs_root);
-	mutex_unlock(&q->debugfs_mutex);
 }
 
 /**
@@ -769,14 +767,12 @@ int blk_register_queue(struct gendisk *disk)
 		if (ret)
 			goto out_put_queue_kobj;
 	}
-	mutex_lock(&q->sysfs_lock);
 
-	mutex_lock(&q->debugfs_mutex);
 	debugfs_create_dir(disk->disk_name, blk_debugfs_root);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_register(q);
-	mutex_unlock(&q->debugfs_mutex);
 
+	mutex_lock(&q->sysfs_lock);
 	ret = disk_register_independent_access_ranges(disk);
 	if (ret)
 		goto out_debugfs_remove;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 32cda8f5d008..13efd48adcc3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -775,9 +775,11 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
  **/
 void blk_trace_shutdown(struct request_queue *q)
 {
+	mutex_lock(&q->debugfs_mutex);
 	if (rcu_dereference_protected(q->blk_trace,
 				      lockdep_is_held(&q->debugfs_mutex)))
 		__blk_trace_remove(q);
+	mutex_unlock(&q->debugfs_mutex);
 }
 
 #ifdef CONFIG_BLK_CGROUP
-- 
2.47.0

