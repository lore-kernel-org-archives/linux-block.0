Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E58633A
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291872; cv=none; b=sYAggPYgaGFIP5JfJOS/rE/YAao/ZQR0Crx+WkZXuJ/0XhqdlB7GJzUuY7b3/vFnP4Naq6fEMvtRk96dDY6sMNoTw/tzWoYkVBHZPfQQK83bqiZ3UPJtWMbcCrVmn7rrJ49kwbYemu5O+QHsTC+MKuem8XFuimCSgK1x2EFNb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291872; c=relaxed/simple;
	bh=tfSKemNfw6WoQTadT5wtSUDxFOMrG+XuReDHe6NKuto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVj3od9wHuhambJ18cn2KX2XaOun4TXuWzvLpVdEuqSfXx30aqly1Cmea8w8yG0zz1i0OB8WmPLXyZVYTXPB3TKPv6VG5K/L8X+AtlXAx7DmSlCG0MTprLCIjcX/OcM4hBR+ONk8zfG74lCgzxbbgNFSA8J5jfeQUL3gHtfESCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4jW2hfn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4jW2hfn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIYWmJnTkyV3sXs2FJyBB4Kxj3WbPutyEvPCf0slPFA=;
	b=F4jW2hfnJd6cx2SrdJJxSxLGFBm87yMNe1guqqsj4U8YUymNANxPi+6NG0Z3ZZPRo2B57R
	yj+VypHPDzXZToEyBrVFek0vmgDaWHRxXZiNKmTl4B1mYYi+CqE377NTB/ilEasPgPoa3Y
	Vj4mNvv9nHL7LgkTBBY+5YXWzussevw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-oR4zlVMCPE2_ZEOs3uz1sA-1; Thu,
 10 Apr 2025 09:31:06 -0400
X-MC-Unique: oR4zlVMCPE2_ZEOs3uz1sA-1
X-Mimecast-MFC-AGG-ID: oR4zlVMCPE2_ZEOs3uz1sA_1744291865
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69E041800EC5;
	Thu, 10 Apr 2025 13:31:04 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CC7E1956094;
	Thu, 10 Apr 2025 13:31:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 03/15] block: move sched debugfs register into elvevator_register_queue
Date: Thu, 10 Apr 2025 21:30:15 +0800
Message-ID: <20250410133029.2487054-4-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

sched debugfs shares same lifetime with scheduler's kobject, and same
lock(elevator lock), so move sched debugfs register/unregister into
elevator_register_queue() and elevator_unregister_queue().

Then we needn't blk_mq_debugfs_register() for us to register sched
debugfs any more.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 12 ------------
 block/blk-mq-sched.c   |  7 ++-----
 block/elevator.c       |  6 ++++++
 block/elevator.h       |  3 +++
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3421b5521fe2..c308699ded58 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -624,22 +624,10 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
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
-
 	if (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index f66abaa25430..14552c58c4e8 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -436,7 +436,7 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
 	return 0;
 }
 
-static void blk_mq_sched_reg_debugfs(struct request_queue *q)
+void blk_mq_sched_reg_debugfs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
@@ -448,7 +448,7 @@ static void blk_mq_sched_reg_debugfs(struct request_queue *q)
 	mutex_unlock(&q->debugfs_mutex);
 }
 
-static void blk_mq_sched_unreg_debugfs(struct request_queue *q)
+void blk_mq_sched_unreg_debugfs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
@@ -505,7 +505,6 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 			}
 		}
 	}
-	blk_mq_sched_reg_debugfs(q);
 
 	return 0;
 
@@ -544,8 +543,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	unsigned long i;
 	unsigned int flags = 0;
 
-	blk_mq_sched_unreg_debugfs(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->type->ops.exit_hctx && hctx->sched_data) {
 			e->type->ops.exit_hctx(hctx, i);
diff --git a/block/elevator.c b/block/elevator.c
index 5051a98dc08c..cf48613c6e62 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -459,6 +459,9 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 
 	lockdep_assert_held(&q->elevator_lock);
 
+	if (test_bit(ELEVATOR_FLAG_REGISTERED, &e->flags))
+		return 0;
+
 	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
 	if (!error) {
 		const struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -472,6 +475,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 		if (uevent)
 			kobject_uevent(&e->kobj, KOBJ_ADD);
 
+		blk_mq_sched_reg_debugfs(q);
 		set_bit(ELEVATOR_FLAG_REGISTERED, &e->flags);
 	}
 	return error;
@@ -486,6 +490,8 @@ void elv_unregister_queue(struct request_queue *q)
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
+
+		blk_mq_sched_unreg_debugfs(q);
 	}
 }
 
diff --git a/block/elevator.h b/block/elevator.h
index e4e44dfac503..80ff9b28a66f 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -182,4 +182,7 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 #define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 #define rq_fifo_clear(rq)	list_del_init(&(rq)->queuelist)
 
+void blk_mq_sched_reg_debugfs(struct request_queue *q);
+void blk_mq_sched_unreg_debugfs(struct request_queue *q);
+
 #endif /* _ELEVATOR_H */
-- 
2.47.0

