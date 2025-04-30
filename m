Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5115D1
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987817; cv=none; b=b7ktP7eaTxFZuuFAWeaRXWshPgSUrzZ7863jqRdcvSKGUrdlDvfXDRAN3MEfj+EabRIQsQFAhjSYGDWVZUQzNdG82aLrw2sGvc+Ufg99EUtJCLvbiNdsxJpQVJsHf6EF1GqaCRzeMvYADFgxYSJg2mCrNThfcRAYqmzYdjtzSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987817; c=relaxed/simple;
	bh=XrgMtXVsnnsFS9sXNFad5tmLgF2Pb/JWuUS9wlEju4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0WqOGb7dZBgBM/Q6IJIqjru9KbyyhjvTefuNUWf7WUAE9p+cEWMcL0wayiTSVy1EHhGs5g0xSLtFCpe+Rh0NzWpBuHICanvddsrHNZHmIq9oX0/0oewvfLSO2O69hA1dCSx82zomtm3wjd0+ziWomQ9XHFJNBshNsSDRgYMVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VK0+BHqu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK0+BHqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8m7upFyXaZdofvMdef15ajuRZR9u7rQ3+1fxbtymJI=;
	b=VK0+BHquJu1qiFRhTdIfYafiD5MgTSHCY+K7FNb+AX/Wm0pEVkbPJzLE5M3M8e7NKGJzT+
	FA9yo2HuH25Fd3nmxuRsxt1yIj0wjebQdzzZvtPn74S/QEDhGFHm3qy5i5zY8Sz6qCBHf1
	Pbg52B87NDQ2ocT2/TtAQnLLQzIyzKU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-RLYunwnFPaKehSDUmhko7g-1; Wed,
 30 Apr 2025 00:36:53 -0400
X-MC-Unique: RLYunwnFPaKehSDUmhko7g-1
X-Mimecast-MFC-AGG-ID: RLYunwnFPaKehSDUmhko7g_1745987812
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3844D195608C;
	Wed, 30 Apr 2025 04:36:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BA2F1800367;
	Wed, 30 Apr 2025 04:36:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 20/24] block: move elv_register[unregister]_queue out of elevator_lock
Date: Wed, 30 Apr 2025 12:35:22 +0800
Message-ID: <20250430043529.1950194-21-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
so we can kill many lockdep warnings.

elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
debugfs things, no need to be done with queue frozen:

- when it is called from adding disk, elevator switch isn't possible
  because ->queue_kobj isn't added yet

- when it is called from deleting disk, disable_elv_switch() is
  responsible for preventing new elevator switch and draining old
  elevator switch.

- when it is called from blk_mq_update_nr_hw_queues(), adding/removing
  disk and elevator switch can't be allowed or in-progress

With this change, elevator's ->exit() is called before calling
elv_unregister_queue, then user may call into ->show()/store() of elevator's
sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.

For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
there isn't such issue.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   |  3 +--
 block/elevator.c | 63 ++++++++++++++++++++++++++++++++++++++----------
 block/genhd.c    |  6 +++++
 3 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b920eaedbaa9..a4bcfce4c4b9 100644
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
index 98a754f58de5..492a593160ae 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -49,6 +49,11 @@
 struct elv_change_ctx {
 	const char *name;
 	bool no_uevent;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
 };
 
 static DEFINE_SPINLOCK(elv_list_lock);
@@ -158,14 +163,14 @@ static void elevator_exit(struct request_queue *q)
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
@@ -466,8 +471,6 @@ static int elv_register_queue(struct request_queue *q,
 {
 	int error;
 
-	lockdep_assert_held(&q->elevator_lock);
-
 	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
 	if (!error) {
 		const struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -494,8 +497,6 @@ static int elv_register_queue(struct request_queue *q,
 static void elv_unregister_queue(struct request_queue *q,
 				 struct elevator_queue *e)
 {
-	lockdep_assert_held(&q->elevator_lock);
-
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
@@ -586,7 +587,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		elv_unregister_queue(q, q->elevator);
+		ctx->old = q->elevator;
 		elevator_exit(q);
 	}
 
@@ -594,11 +595,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		ret = blk_mq_init_sched(q, new_e);
 		if (ret)
 			goto out_unfreeze;
-		ret = elv_register_queue(q, q->elevator, !ctx->no_uevent);
-		if (ret) {
-			elevator_exit(q);
-			goto out_unfreeze;
-		}
+		ctx->new = q->elevator;
 	} else {
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
@@ -619,6 +616,38 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	return ret;
 }
 
+static void elv_exit_and_release(struct request_queue *q)
+{
+	struct elevator_queue *e;
+	unsigned memflags;
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+	e = q->elevator;
+	elevator_exit(q);
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
+		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
+		if (ret)
+			elv_exit_and_release(q);
+	}
+	return ret;
+}
+
 /*
  * Switch this queue to the given IO scheduler.
  */
@@ -645,6 +674,9 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 		ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+	if (!ret)
+		ret = elevator_change_done(q, ctx);
+
 	return ret;
 }
 
@@ -657,6 +689,7 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	struct elv_change_ctx ctx = {
 		.name	= "none",
 	};
+	int ret = -ENODEV;
 
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
@@ -664,8 +697,12 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q))
 		ctx.name = q->elevator->type->elevator_name;
 	/* force to reattach elevator after nr_hw_queue is updated */
-	elevator_switch(q, &ctx);
+	ret = elevator_switch(q, &ctx);
 	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue_nomemrestore(q);
+
+	if (!ret)
+		WARN_ON_ONCE(elevator_change_done(q, &ctx));
 }
 
 /*
diff --git a/block/genhd.c b/block/genhd.c
index 0e64e7400fb4..59d9febd8c14 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -751,11 +751,17 @@ static void __del_gendisk(struct gendisk *disk)
 
 static void disable_elv_switch(struct request_queue *q)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
+
 	WARN_ON_ONCE(!queue_is_mq(q));
 
 	mutex_lock(&q->elevator_lock);
 	blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, q);
 	mutex_unlock(&q->elevator_lock);
+
+	/* wait until in-progress elevator switch is done */
+	down_write(&set->update_nr_hwq_lock);
+	up_write(&set->update_nr_hwq_lock);
 }
 
 /**
-- 
2.47.0

