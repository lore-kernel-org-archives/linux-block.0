Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA44208A7
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994313; cv=none; b=U8huVJ1vmXpVz8NajmOBH+I9s1YKDK2C3IuEk5geHHWgftinAQaSzZurlNJlc3x/EoI6NDH3MaWEZNrRk7ua+5M80f24pB2VYEJfYMFRnWROnQkzyiqc2k4RmlSoo4tXQM0uKkGQtCmb6jSRMZV89JzX4MCjnmer6IYtUroQFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994313; c=relaxed/simple;
	bh=n0PjAqp1SLEPoDi51x/AOlF+xp2ZX8yyEZ7g8BVGRzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPm9zQUb86TT35RwFSc6ztx8PvIRybzrdx6GXbrlZi/vc9DXgLsqNHiuRK6hQRsMKSS7g7vrrKfp3vuAeB0ssYEHkv1xI2MVSEjMiz1atXSWDZA2ke6sYZ0x88YZKLEUMuYSLeeUGYIAl+2HAhxMcLxLoqzp99WoQjIzQA7lcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/P756Ze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/P756Ze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n003RY9MWUqFmwHicd3yeJ7i5Q8gpS0sXbB8dpyS9uY=;
	b=F/P756Ze3ISrdYfigqLAi0Y7fKZMJq5438IWFVbhFvyCDR4uLD73XG3jHrIuscPImJLlQy
	hwuT6/MJZ6PVbfnLIm4GMvH79bMC2mduGqJq4aKh5l3uEsNgPGjoFSiPN0pRZo6DqdVrzx
	39779Ujk4T7NN2TsEiouzX4Cd10WlrI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-NWuZpid1NYiTKKwqECIXqw-1; Fri,
 18 Apr 2025 12:38:27 -0400
X-MC-Unique: NWuZpid1NYiTKKwqECIXqw-1
X-Mimecast-MFC-AGG-ID: NWuZpid1NYiTKKwqECIXqw_1744994306
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6D8C1800876;
	Fri, 18 Apr 2025 16:38:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D27BA19560A3;
	Fri, 18 Apr 2025 16:38:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 16/20] block: move elv_register[unregister]_queue out of elevator_lock
Date: Sat, 19 Apr 2025 00:36:57 +0800
Message-ID: <20250418163708.442085-17-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 block/blk-mq.c   |  9 ++++----
 block/blk.h      |  1 +
 block/elevator.c | 58 ++++++++++++++++++++++++++++++++++--------------
 block/elevator.h |  5 +++++
 4 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1a287c2e791c..9a361a173a8e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4993,16 +4993,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			.force	= true,
 			.uevent	= true,
 		};
+		int ret = -ENODEV;
 
 		mutex_lock(&q->elevator_lock);
 		if (q->elevator && !blk_queue_dying(q))
 			ctx.name = q->elevator->type->elevator_name;
-		__elevator_change(q, &ctx);
+		ret = __elevator_change(q, &ctx);
 		mutex_unlock(&q->elevator_lock);
-	}
-
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue_nomemrestore(q);
+		if (!ret)
+			WARN_ON_ONCE(elevator_change_done(q, &ctx));
+	}
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/blk.h b/block/blk.h
index 0e19c09009ed..48cf6b1c36fe 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -323,6 +323,7 @@ bool blk_insert_flush(struct request *rq);
 int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
+int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx);
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
diff --git a/block/elevator.c b/block/elevator.c
index 16171ea92f80..8652fe45a2db 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -151,18 +151,24 @@ static void elevator_release(struct kobject *kobj)
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
+}
 
-	kobject_put(&e->kobj);
+static void elevator_exit(struct request_queue *q)
+{
+	__elevator_exit(q);
+	kobject_put(&q->elevator->kobj);
 }
 
 static inline void __elv_rqhash_del(struct request *rq)
@@ -467,8 +473,6 @@ static int elv_register_queue(struct request_queue *q,
 {
 	int error;
 
-	lockdep_assert_held(&q->elevator_lock);
-
 	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
 	if (!error) {
 		const struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -495,8 +499,6 @@ static int elv_register_queue(struct request_queue *q,
 static void elv_unregister_queue(struct request_queue *q,
 				 struct elevator_queue *e)
 {
-	lockdep_assert_held(&q->elevator_lock);
-
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
@@ -640,19 +642,15 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
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
@@ -666,15 +664,16 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
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
@@ -683,6 +682,28 @@ static void elevator_disable(struct request_queue *q)
 	blk_mq_unquiesce_queue(q);
 }
 
+int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
+{
+	int ret = 0;
+
+	if (ctx->old) {
+		elv_unregister_queue(q, ctx->old);
+		kobject_put(&ctx->old->kobj);
+	}
+	if (ctx->new) {
+		ret = elv_register_queue(q, ctx->new, ctx->uevent);
+		if (ret) {
+			unsigned memflags = blk_mq_freeze_queue(q);
+
+			mutex_lock(&q->elevator_lock);
+			elevator_exit(q);
+			mutex_unlock(&q->elevator_lock);
+			blk_mq_unfreeze_queue(q, memflags);
+		}
+	}
+	return 0;
+}
+
 /*
  * Switch this queue to the given IO scheduler.
  */
@@ -698,7 +719,7 @@ int __elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 
 	if (!strncmp(elevator_name, "none", 4)) {
 		if (q->elevator)
-			elevator_disable(q);
+			elevator_disable(q, ctx);
 		return 0;
 	}
 
@@ -742,6 +763,9 @@ static int elevator_change(struct request_queue *q,
 	ret = __elevator_change(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+	if (!ret)
+		ret = elevator_change_done(q, ctx);
+
 exit:
 	srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
 	return ret;
diff --git a/block/elevator.h b/block/elevator.h
index 16d8888fa2b2..486be0690499 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -129,6 +129,11 @@ struct elv_change_ctx {
 	bool force;
 	bool uevent;
 	bool init;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
 };
 
 /*
-- 
2.47.0

