Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6FC13D28F
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103664; cv=none; b=Xe6LExMiZQMG3PFL8Z20mWkadyAAg46Edlh8n79ge022nlwh76xcq+uIY3poDNdgajg5F1bhMCrKqEm8CVDtOwUgz/z0gghQ1WWonlmRE9xStwJqUxGbj9E4aGo5R2obxFqzzGwPOJLB1MzAipETzNcODTmo3FaNuHJHICKAY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103664; c=relaxed/simple;
	bh=DEdkhJoaZa9Oip23tyYq6N6EVlLfc2dj47FH++LaxYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1EAKIaOKeFA2hMErKx/29V6YELFft7LwFpH/hrHTvhHDXnpZQ/rDJARbDg654y5271qHCgTMat/nuy0G5L+crIV4NWd+yeE74uNME4a1ywJZjspvTamxgIFjB3WCqFsuxx/T00/ZMVEgFm9htmOBc2aqlJLwxwDN6flZbWEacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExDbVtAn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExDbVtAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739103661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlbW6NkLpKRKs2CyKKIo+1aczqF1MbmxnRxNQ1PFD90=;
	b=ExDbVtAnVk8eG4vTQ0hF4qUWVg/dknLamK5+fsqSg9XB+0VbAH4+zJsWHFUol4xwxtT9KW
	Wy01R8GlzwHm6CpopiEGtQKaB3QouOtaCJuOjvPJBfvmvW+BdWHwX5+UXZe9n/tG7iZEto
	bI/K+jG/IeTaBvoM/qoEcUr1wDeAtc0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-ezgko9HpOqGv-2P6Zbwl1g-1; Sun,
 09 Feb 2025 07:20:57 -0500
X-MC-Unique: ezgko9HpOqGv-2P6Zbwl1g-1
X-Mimecast-MFC-AGG-ID: ezgko9HpOqGv-2P6Zbwl1g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EC37195608C;
	Sun,  9 Feb 2025 12:20:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D918B1800267;
	Sun,  9 Feb 2025 12:20:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/7] block: remove hctx->debugfs_dir
Date: Sun,  9 Feb 2025 20:20:25 +0800
Message-ID: <20250209122035.1327325-2-ming.lei@redhat.com>
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

For each hctx, its debugfs path is fixed, which can be queried from
its parent dentry and hctx queue num, so it isn't necessary to cache
it in hctx structure because it isn't used in fast path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 47 ++++++++++++++++++++++++++++++++----------
 include/linux/blk-mq.h |  5 -----
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index adf5f0697b6b..16260bba4d11 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -633,8 +633,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx->debugfs_dir)
-			blk_mq_debugfs_register_hctx(q, hctx);
+		blk_mq_debugfs_register_hctx(q, hctx);
 		if (q->elevator && !hctx->sched_debugfs_dir)
 			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
@@ -649,14 +648,28 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	}
 }
 
+static __must_check struct dentry *blk_mq_get_hctx_entry(
+		struct blk_mq_hw_ctx *hctx)
+{
+	char name[20];
+
+	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
+	return debugfs_lookup(name, hctx->queue->debugfs_dir);
+}
+
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *ctx)
 {
+	struct dentry *hctx_dir = blk_mq_get_hctx_entry(hctx);
 	struct dentry *ctx_dir;
 	char name[20];
 
+	if (IS_ERR_OR_NULL(hctx_dir))
+		return;
+
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
-	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
+	ctx_dir = debugfs_create_dir(name, hctx_dir);
+	dput(hctx_dir);
 
 	debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
 }
@@ -664,6 +677,7 @@ static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 void blk_mq_debugfs_register_hctx(struct request_queue *q,
 				  struct blk_mq_hw_ctx *hctx)
 {
+	struct dentry *hctx_dir;
 	struct blk_mq_ctx *ctx;
 	char name[20];
 	int i;
@@ -672,9 +686,11 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 		return;
 
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
-	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
+	hctx_dir = debugfs_create_dir(name, q->debugfs_dir);
+	if (IS_ERR_OR_NULL(hctx_dir))
+		return;
 
-	debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
+	debugfs_create_files(hctx_dir, hctx, blk_mq_debugfs_hctx_attrs);
 
 	hctx_for_each_ctx(hctx, ctx, i)
 		blk_mq_debugfs_register_ctx(hctx, ctx);
@@ -682,11 +698,18 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 {
+	struct dentry *hctx_dir;
+
 	if (!hctx->queue->debugfs_dir)
 		return;
-	debugfs_remove_recursive(hctx->debugfs_dir);
+
+	hctx_dir = blk_mq_get_hctx_entry(hctx);
+	if (IS_ERR_OR_NULL(hctx_dir))
+		return;
+
+	debugfs_remove_recursive(hctx_dir);
 	hctx->sched_debugfs_dir = NULL;
-	hctx->debugfs_dir = NULL;
+	dput(hctx_dir);
 }
 
 void blk_mq_debugfs_register_hctxs(struct request_queue *q)
@@ -780,6 +803,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 					struct blk_mq_hw_ctx *hctx)
 {
+	struct dentry *hctx_dir = blk_mq_get_hctx_entry(hctx);
 	struct elevator_type *e = q->elevator->type;
 
 	lockdep_assert_held(&q->debugfs_mutex);
@@ -789,16 +813,17 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 	 * We will be called again later on with appropriate parent debugfs
 	 * directory from blk_register_queue()
 	 */
-	if (!hctx->debugfs_dir)
+	if (IS_ERR_OR_NULL(hctx_dir))
 		return;
 
 	if (!e->hctx_debugfs_attrs)
-		return;
+		goto exit;
 
-	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
-						     hctx->debugfs_dir);
+	hctx->sched_debugfs_dir = debugfs_create_dir("sched", hctx_dir);
 	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
 			     e->hctx_debugfs_attrs);
+exit:
+	dput(hctx_dir);
 }
 
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9ebb53f031cd..8c8682491403 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -427,11 +427,6 @@ struct blk_mq_hw_ctx {
 	struct kobject		kobj;
 
 #ifdef CONFIG_BLK_DEBUG_FS
-	/**
-	 * @debugfs_dir: debugfs directory for this hardware queue. Named
-	 * as cpu<cpu_number>.
-	 */
-	struct dentry		*debugfs_dir;
 	/** @sched_debugfs_dir:	debugfs directory for the scheduler. */
 	struct dentry		*sched_debugfs_dir;
 #endif
-- 
2.47.0

