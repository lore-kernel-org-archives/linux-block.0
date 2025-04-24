Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC01C6FF7
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508187; cv=none; b=Vz8FoYnl2Mbud8cRALF+wj0fT9EcDReeYHaOnkjJ0Dn8PJoJzREUEcTkBrq4MYA79kPky1m5eZQC4Jg8WUIcE9FbkRrXaBFtAgVgztTkncOG8nnJdULR0uVDIGwNea1NgXsyLPL6mWSFfzPfSK4t5FPwssbT8m1YNqwX3hGC2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508187; c=relaxed/simple;
	bh=sxml3vmjVXlDnQy+FiUm8/IF6ngN+SqCUh7bGI0XY6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nabCtTsOSbwJ+K/KuPXi5Hu6guBCRoCJXY5uJbIPNFB/AHNore78y80UTwPUXehMHQFj9CYjzFK5CY6pt9VTHJWf9pd8CAK8Y5gTUVeR6Po824MPaF/Q62UPrDkYKelhzngiIwUQy4rl/8/FS9b6w8YqikSegeEUq4nB4ZraDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIzv0az0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIzv0az0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0rJg75dF/Nq6pypbJXQHR4zU+/dGmHZTO4mhHqhlLc=;
	b=cIzv0az0XgCcLZixwyNAxFDEy/o2VS5ghwUCL/KXzDqzMB7fxOgtjeHSrpUpBQMyqdXRNd
	ZCSGJ//3JTeGvGYtlSqPwNLAMAt1sv6czdImJEagBDRS0XllRJdzXxn7CmJSxJS0tvfEkL
	HjWBM/cmQi2ZzzUDwYhXFP9HIRg6INo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453--EpnAtCEMVm3xTYmEwWzyw-1; Thu,
 24 Apr 2025 11:23:00 -0400
X-MC-Unique: -EpnAtCEMVm3xTYmEwWzyw-1
X-Mimecast-MFC-AGG-ID: -EpnAtCEMVm3xTYmEwWzyw_1745508178
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D217719560BB;
	Thu, 24 Apr 2025 15:22:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B849618001D5;
	Thu, 24 Apr 2025 15:22:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 16/20] block: move elv_register[unregister]_queue out of elevator_lock
Date: Thu, 24 Apr 2025 23:21:39 +0800
Message-ID: <20250424152148.1066220-17-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
so we can kill many lockdep warnings.

elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
debugfs things, no need to be done with queue frozen.

With this change, elevator's ->exit() is called before calling
elv_unregister_queue, then user may call into ->show()/store() of elevator's
sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.

For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
there isn't such issue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   |  3 +-
 block/elevator.c | 80 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3afcddd21586..3ecbf73773ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4997,11 +4997,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_debugfs_register_hctxs(q);
 	}
 
+	/* elv_update_nr_hw_queues() unfreeze queue for us */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		elv_update_nr_hw_queues(q);
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_unfreeze_queue_nomemrestore(q);
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/elevator.c b/block/elevator.c
index 48f2f202af98..aec8081a6be3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -50,6 +50,11 @@ struct elv_change_ctx {
 	const char *name;
 	bool uevent;
 	bool init;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
 };
 
 static DEFINE_SPINLOCK(elv_list_lock);
@@ -155,18 +160,18 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-static void elevator_exit(struct request_queue *q)
+static void __elevator_exit(struct request_queue *q)
 {
 	struct elevator_queue *e = q->elevator;
 
+	lockdep_assert_held(&q->elevator_lock);
+
 	ioc_clear_queue(q);
 	blk_mq_sched_free_rqs(q);
 
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
 	mutex_unlock(&e->sysfs_lock);
-
-	kobject_put(&e->kobj);
 }
 
 static inline void __elv_rqhash_del(struct request *rq)
@@ -471,8 +476,6 @@ static int elv_register_queue(struct request_queue *q,
 {
 	int error;
 
-	lockdep_assert_held(&q->elevator_lock);
-
 	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
 	if (!error) {
 		const struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -499,8 +502,6 @@ static int elv_register_queue(struct request_queue *q,
 static void elv_unregister_queue(struct request_queue *q,
 				 struct elevator_queue *e)
 {
-	lockdep_assert_held(&q->elevator_lock);
-
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
@@ -601,19 +602,15 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		elv_unregister_queue(q, q->elevator);
-		elevator_exit(q);
+		ctx->old = q->elevator;
+		__elevator_exit(q);
 	}
 
 	ret = blk_mq_init_sched(q, new_e);
 	if (ret)
 		goto out_unfreeze;
 
-	ret = elv_register_queue(q, q->elevator, ctx->uevent);
-	if (ret) {
-		elevator_exit(q);
-		goto out_unfreeze;
-	}
+	ctx->new = q->elevator;
 	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
 
 out_unfreeze:
@@ -627,15 +624,16 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	return ret;
 }
 
-static void elevator_disable(struct request_queue *q)
+static void elevator_disable(struct request_queue *q,
+			     struct elv_change_ctx *ctx)
 {
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
 	blk_mq_quiesce_queue(q);
 
-	elv_unregister_queue(q, q->elevator);
-	elevator_exit(q);
+	ctx->old = q->elevator;
+	__elevator_exit(q);
 	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 	q->elevator = NULL;
 	q->nr_requests = q->tag_set->queue_depth;
@@ -644,6 +642,38 @@ static void elevator_disable(struct request_queue *q)
 	blk_mq_unquiesce_queue(q);
 }
 
+static void elv_exit_and_release(struct request_queue *q)
+{
+	struct elevator_queue *e;
+	unsigned memflags;
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+	e = q->elevator;
+	__elevator_exit(q);
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
+	if (e)
+		kobject_put(&e->kobj);
+}
+
+static int elevator_change_done(struct request_queue *q,
+				struct elv_change_ctx *ctx)
+{
+	int ret = 0;
+
+	if (ctx->old) {
+		elv_unregister_queue(q, ctx->old);
+		kobject_put(&ctx->old->kobj);
+	}
+	if (ctx->new) {
+		ret = elv_register_queue(q, ctx->new, ctx->uevent);
+		if (ret)
+			elv_exit_and_release(q);
+	}
+	return ret;
+}
+
 /*
  * Switch this queue to the given IO scheduler.
  */
@@ -662,7 +692,7 @@ static int __elevator_change(struct request_queue *q,
 
 	if (!strncmp(elevator_name, "none", 4)) {
 		if (q->elevator)
-			elevator_disable(q);
+			elevator_disable(q, ctx);
 		return 0;
 	}
 
@@ -696,6 +726,9 @@ static int elevator_change(struct request_queue *q,
 		ret = __elevator_change(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+	if (!ret)
+		ret = elevator_change_done(q, ctx);
+
 	return ret;
 }
 
@@ -745,6 +778,8 @@ void elevator_set_none(struct request_queue *q)
 /*
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
+ *
+ * Note that this unfreezes the passed in queue.
  */
 void elv_update_nr_hw_queues(struct request_queue *q)
 {
@@ -752,12 +787,19 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 		.name	= "none",
 		.uevent	= true,
 	};
+	int ret = -ENODEV;
+
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
 	mutex_lock(&q->elevator_lock);
 	if (q->elevator && !blk_queue_dying(q))
 		ctx.name = q->elevator->type->elevator_name;
-	__elevator_change(q, &ctx);
+	ret = __elevator_change(q, &ctx);
 	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue_nomemrestore(q);
+
+	if (!ret)
+		WARN_ON_ONCE(elevator_change_done(q, &ctx));
 }
 
 static void elv_iosched_load_module(const char *elevator_name)
-- 
2.47.0

