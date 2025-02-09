Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14618132A
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103666; cv=none; b=GyKHl6w57SAYLUfPaGCBwzGDcBof6TjIeYmhcZuG9dNeEXOCRJ534wF/6rQ6nBB5qHUvzwuvcaTpwhb0zGWy7/LznNZw8bbvwMP0wU9HlYmDtP30W48u5x1GcTjbVHXPUCFBkmWWwirjXyv2zMbgJG7+X//e7BPZ+QscPMYiCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103666; c=relaxed/simple;
	bh=SSXGUU8ButB/RNBdttiqvE0/fHfOdEpqLf8EipzIjME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quADGdLQesHo9H/QI7Xm0E29lhQufAZOfKXv48fF1SIyJkS2r3wYCOPAcCO73x5j8IVkIbC1b9sh+ibssy5nwomfddfoyOt67vGqok0Yuuq5M10VgOJecYcmS+POzYsXSO8t+tptN13pDXHI42Au1by2UOnHMzCKKJ5RbH9HLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICnLDgyS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICnLDgyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739103663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ir8Tsi10g9Su1R1sfRreEALH3yhmQaDXa9ngfyHmWwo=;
	b=ICnLDgyS7/PO5pVOT3riNEL3KzlG0Alc+mob2KeV7s60NIk/S7goJooU2Swukq8w3tvWOZ
	uB5vHAwNlwme741fiqwNmjN3sXkDy8zi6v2PakubuWWGjgcXylW/VZmg8FMVjvSPJEvFxq
	IeBykMv9FYAfZ2YcN/fOJDuSsu5zaTs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-kRFkwGODNvu2RQJDYVcdUw-1; Sun,
 09 Feb 2025 07:21:02 -0500
X-MC-Unique: kRFkwGODNvu2RQJDYVcdUw-1
X-Mimecast-MFC-AGG-ID: kRFkwGODNvu2RQJDYVcdUw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E24AF1800876;
	Sun,  9 Feb 2025 12:21:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2B2630001AB;
	Sun,  9 Feb 2025 12:20:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/7] block: remove hctx->sched_debugfs_dir
Date: Sun,  9 Feb 2025 20:20:26 +0800
Message-ID: <20250209122035.1327325-3-ming.lei@redhat.com>
In-Reply-To: <20250209122035.1327325-1-ming.lei@redhat.com>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

For each hctx, its sched debugfs path is fixed, which can be queried from
its parent dentry directly, so it isn't necessary to cache it in hctx
instance because it isn't used in fast path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
 include/linux/blk-mq.h |  5 -----
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 16260bba4d11..3abb38ea2577 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -634,7 +634,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
 	queue_for_each_hw_ctx(q, hctx, i) {
 		blk_mq_debugfs_register_hctx(q, hctx);
-		if (q->elevator && !hctx->sched_debugfs_dir)
+		if (q->elevator)
 			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
@@ -657,6 +657,19 @@ static __must_check struct dentry *blk_mq_get_hctx_entry(
 	return debugfs_lookup(name, hctx->queue->debugfs_dir);
 }
 
+static __must_check struct dentry *blk_mq_get_hctx_sched_entry(
+		struct blk_mq_hw_ctx *hctx)
+{
+	struct dentry *hctx_dir = blk_mq_get_hctx_entry(hctx);
+	struct dentry *sched_dir = NULL;
+
+	if (hctx_dir) {
+		sched_dir = debugfs_lookup("sched", hctx_dir);
+		dput(hctx_dir);
+	}
+	return sched_dir;
+}
+
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *ctx)
 {
@@ -708,7 +721,6 @@ void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 		return;
 
 	debugfs_remove_recursive(hctx_dir);
-	hctx->sched_debugfs_dir = NULL;
 	dput(hctx_dir);
 }
 
@@ -805,6 +817,7 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 {
 	struct dentry *hctx_dir = blk_mq_get_hctx_entry(hctx);
 	struct elevator_type *e = q->elevator->type;
+	struct dentry *sched_dir;
 
 	lockdep_assert_held(&q->debugfs_mutex);
 
@@ -819,19 +832,23 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 	if (!e->hctx_debugfs_attrs)
 		goto exit;
 
-	hctx->sched_debugfs_dir = debugfs_create_dir("sched", hctx_dir);
-	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
-			     e->hctx_debugfs_attrs);
+	sched_dir = debugfs_create_dir("sched", hctx_dir);
+	debugfs_create_files(sched_dir, hctx, e->hctx_debugfs_attrs);
 exit:
 	dput(hctx_dir);
 }
 
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 {
+	struct dentry *sched_dir;
+
 	lockdep_assert_held(&hctx->queue->debugfs_mutex);
 
 	if (!hctx->queue->debugfs_dir)
 		return;
-	debugfs_remove_recursive(hctx->sched_debugfs_dir);
-	hctx->sched_debugfs_dir = NULL;
+	sched_dir = blk_mq_get_hctx_sched_entry(hctx);
+	if (sched_dir) {
+		debugfs_remove_recursive(sched_dir);
+		dput(sched_dir);
+	}
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8c8682491403..965aeea75ddd 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -426,11 +426,6 @@ struct blk_mq_hw_ctx {
 	/** @kobj: Kernel object for sysfs. */
 	struct kobject		kobj;
 
-#ifdef CONFIG_BLK_DEBUG_FS
-	/** @sched_debugfs_dir:	debugfs directory for the scheduler. */
-	struct dentry		*sched_debugfs_dir;
-#endif
-
 	/**
 	 * @hctx_list: if this hctx is not in use, this is an entry in
 	 * q->unused_hctx_list.
-- 
2.47.0

