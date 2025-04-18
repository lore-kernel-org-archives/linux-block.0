Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71985213E71
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994270; cv=none; b=pqEH/a+WFjnSA6KtKbXEjeCMet8w8Eo12gEdd6/BhPB9q3omX6cxwEfg6BHPdBuh8LI15xbcMBUv3hirm3SJ1vDxqZ/eLfpZItfckkz9HKtg2O0S4sL8QPR8BdgBsS9y5yUjsKCkC7W8IOzzJs6YFv6cbNQHdYWSWeru5N6/RA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994270; c=relaxed/simple;
	bh=dBS/j8Rw0TlgkqwNXurMc0QN3YOINorYTIJ6hFVUIYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp2sqj7xhqnLSwUbD+/w2iWpma3F7PdIpvxeUI6cw1vWFTdBMe52G6yb4UaGtci8xI4tIs0jIlXehn6NAXKqWVe59uuEPieIkb0OT5UIEOqQeXZZbQSeECyWsXqL3G7ZMqcEiM2ojXdzQEycmRMdjh2dDRTECvpRb1f8RpfzhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIkK2y4M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIkK2y4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQNGHwXdkGsB87pTkvJtPUoq1bBw6AOdCjyb1IuON4g=;
	b=CIkK2y4Mz1t8pH5Q0mqNv8zpx5BauHxYes32c/SV+kS6CQAcpBXJNDxZJ8MsB18dE7s3MF
	4aXk1Awe1asGkmWH2l/46x+5brgVsRFZJS6snO928qeifKJRoVxB2OoUIs6iB6uL6/vC0p
	J7gL4cM07eSOs0SdMAUXje8BuWCGAKU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-U_v6r0zlNPSJt7CNoy7bBA-1; Fri,
 18 Apr 2025 12:37:44 -0400
X-MC-Unique: U_v6r0zlNPSJt7CNoy7bBA-1
X-Mimecast-MFC-AGG-ID: U_v6r0zlNPSJt7CNoy7bBA_1744994263
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCE6D1800ECA;
	Fri, 18 Apr 2025 16:37:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B04A219560BA;
	Fri, 18 Apr 2025 16:37:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 05/20] block: move sched debugfs register into elvevator_register_queue
Date: Sat, 19 Apr 2025 00:36:46 +0800
Message-ID: <20250418163708.442085-6-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

sched debugfs shares same lifetime with scheduler's kobject, and same
lock(elevator lock), so move sched debugfs register/unregister into
elevator_register_queue() and elevator_unregister_queue().

Then we needn't blk_mq_debugfs_register() for us to register sched
debugfs any more.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 11 -----------
 block/blk-mq-sched.c   | 11 ++---------
 block/elevator.c       |  8 ++++++++
 block/elevator.h       |  3 +++
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 31e249a18407..0fa0f8836b7d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -625,20 +625,9 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
-	/*
-	 * blk_mq_init_sched() attempted to do this already, but q->debugfs_dir
-	 * didn't exist yet (because we don't know what to name the directory
-	 * until the queue is registered to a gendisk).
-	 */
-	if (q->elevator && !q->sched_debugfs_dir)
-		blk_mq_debugfs_register_sched(q);
-
-	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
 			blk_mq_debugfs_register_hctx(q, hctx);
-		if (q->elevator && !hctx->sched_debugfs_dir)
-			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
 	if (q->rq_qos) {
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2abc5e0704e8..336a15ffecfa 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -434,7 +434,7 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
 	return 0;
 }
 
-static void blk_mq_sched_reg_debugfs(struct request_queue *q)
+void blk_mq_sched_reg_debugfs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
@@ -446,7 +446,7 @@ static void blk_mq_sched_reg_debugfs(struct request_queue *q)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
-static void blk_mq_sched_unreg_debugfs(struct request_queue *q)
+void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
@@ -503,10 +503,6 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 			}
 		}
 	}
-
-	/* sched is initialized, it is ready to export it via debugfs */
-	blk_mq_sched_reg_debugfs(q);
-
 	return 0;
 
 err_free_map_and_rqs:
@@ -544,9 +540,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	unsigned long i;
 	unsigned int flags = 0;
 
-	/* unexport via debugfs before exiting sched */
-	blk_mq_sched_unreg_debugfs(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->type->ops.exit_hctx && hctx->sched_data) {
 			e->type->ops.exit_hctx(hctx, i);
diff --git a/block/elevator.c b/block/elevator.c
index 5051a98dc08c..d25b9cc6c509 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -472,6 +472,11 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 		if (uevent)
 			kobject_uevent(&e->kobj, KOBJ_ADD);
 
+		/*
+		 * Sched is initialized, it is ready to export it via
+		 * debugfs
+		 */
+		blk_mq_sched_reg_debugfs(q);
 		set_bit(ELEVATOR_FLAG_REGISTERED, &e->flags);
 	}
 	return error;
@@ -486,6 +491,9 @@ void elv_unregister_queue(struct request_queue *q)
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
+
+		/* unexport via debugfs before exiting sched */
+		blk_mq_sched_unreg_debugfs(q);
 	}
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index e27af5492cdb..9198676644a9 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -181,4 +181,7 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 #define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 #define rq_fifo_clear(rq)	list_del_init(&(rq)->queuelist)
 
+void blk_mq_sched_reg_debugfs(struct request_queue *q);
+void blk_mq_sched_unreg_debugfs(struct request_queue *q);
+
 #endif /* _ELEVATOR_H */
-- 
2.47.0

