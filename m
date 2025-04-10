Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F92857F1
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291909; cv=none; b=Pkyy9WflBOagjFeGQqTI/FqedkUUD9V8EvI33sQUbHw5XU1ZTjtt3yNtJvUilLOqcxq+qsb3O/zhz3mq9hCsYiJWswmSLkdfLuV0Lv/kNeeeXGdX4LhBD9GSkkV6oaryi3pAHKf7A73ComJv2NE38r6UMAeSeT+a/+Bi2bCDh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291909; c=relaxed/simple;
	bh=sQzBRb6djE14fXxwyoanIqkwnJlxILhasCQNJ3/imu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1vmmCcFSonCKX2Y0HgGgVXGD7kC6wRLKn5z6jvr11S3rbTKYCSekSjnMoJ+n51TQOCAxWeTdCjpQ6LGc2TTI/BibFkYJEElmGyyLf2RABac65hC+L5akWSU7Tl5ENY7S9BEsMFkljJYXJ8jEoT7indEajlpOSFfJq94nFBdLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDe0wmkJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDe0wmkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a29raZsIKbstEY4RZDUaY5m2siILLtua0KYgV7Zwkfs=;
	b=GDe0wmkJEu6mBhr9nm9zm4bM2FW53QI1Sa7EoKilQYJCAXEPUzLfseGiSxiv5k+H5lteZh
	X0M0Rsv+pUFnurRt54CaZ9rZnsxEDrhOgnZxTvdq3Bx8INStMSCwWRpk7xv+WyQ0+Zf76A
	Njjt3o69UZUyfoZVeWjUWxKeaV19eiA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-rXAxqA58PsOpBQxGmTj_Tg-1; Thu,
 10 Apr 2025 09:31:43 -0400
X-MC-Unique: rXAxqA58PsOpBQxGmTj_Tg-1
X-Mimecast-MFC-AGG-ID: rXAxqA58PsOpBQxGmTj_Tg_1744291901
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E6061800361;
	Thu, 10 Apr 2025 13:31:41 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 880D5180174E;
	Thu, 10 Apr 2025 13:31:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 11/15] block: move elv_register[unregister]_queue out of elevator_lock
Date: Thu, 10 Apr 2025 21:30:23 +0800
Message-ID: <20250410133029.2487054-12-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
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

elv_register[unregister]_queue() is serialized, and just dealing with
sysfs/debugfs things, no need to be done with queue frozen.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c   |  9 ++++----
 block/blk.h      |  1 +
 block/elevator.c | 58 ++++++++++++++++++++++++++++++++++--------------
 block/elevator.h |  5 +++++
 4 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 608a74e3a87c..7219b01764da 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4990,16 +4990,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			.force	= 1,
 			.uevent	= 1,
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
index 4626beedfdce..634cebd7a7b4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -321,6 +321,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 bool blk_insert_flush(struct request *rq);
 
 int __elevator_change(struct request_queue *q, struct elev_change_ctx *ctx);
+int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index 238b8d47cc2b..1cc640a9db3e 100644
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
@@ -461,8 +467,6 @@ static int elv_register_queue(struct request_queue *q,
 {
 	int error;
 
-	lockdep_assert_held(&q->elevator_lock);
-
 	if (test_bit(ELEVATOR_FLAG_REGISTERED, &e->flags))
 		return 0;
 
@@ -488,8 +492,6 @@ static int elv_register_queue(struct request_queue *q,
 static void elv_unregister_queue(struct request_queue *q,
 				 struct elevator_queue *e)
 {
-	lockdep_assert_held(&q->elevator_lock);
-
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
@@ -629,19 +631,15 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
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
@@ -655,15 +653,16 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e,
 	return ret;
 }
 
-static void elevator_disable(struct request_queue *q)
+static void elevator_disable(struct request_queue *q,
+			     struct elev_change_ctx *ctx)
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
@@ -672,6 +671,28 @@ static void elevator_disable(struct request_queue *q)
 	blk_mq_unquiesce_queue(q);
 }
 
+int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx)
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
@@ -683,7 +704,7 @@ int __elevator_change(struct request_queue *q, struct elev_change_ctx *ctx)
 
 	if (!strncmp(elevator_name, "none", 4)) {
 		if (q->elevator)
-			elevator_disable(q);
+			elevator_disable(q, ctx);
 		return 0;
 	}
 
@@ -728,6 +749,9 @@ static int elevator_change(struct request_queue *q,
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
index 86b4977cf772..87848fdc8a52 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -128,6 +128,11 @@ struct elev_change_ctx {
 	const char *name;
 	unsigned int force:1;
 	unsigned int uevent:1;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
 };
 
 /*
-- 
2.47.0

