Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504C243399
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048702; cv=none; b=XUh+iUuDoANhwaTjrM50Zl9JnuVzyB6zSVHVKgDxopM6WxNGJig2IFfzjqOgy7TyEnTtCdoeU7qQymK+xU1TWd7Y94xNm+UscoSi8gXJF+3SENOelIyKlN4J7barXCpF/+w8z3pPLjYC98GPeLhqwN/238K5HR2DVh9OyQU67ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048702; c=relaxed/simple;
	bh=vbLdLdVKNzAGe31pFEdsWxu5Y+c8SlgxS/h2sxkjwK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5Spg5OrPa+K2j7zrbZdJoRYp+saC+ePc09U0nlRj6L+XiKlAVXGz4GHFJ9wdQSnGu3IYiB6SSRO30JFq2P+Qbyo/HJ/mdCbXnjSH0s23M0pfBL5NrEPf8GyllP5vHELCMMVBGyKJuuYVlKwaSrPbc/rewnk0CUVZOaqmH7xXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxlCuFOn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxlCuFOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754048700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyGJhJjl0YAT45sukLEp1wd1uvjMStplQb6P+o70ybk=;
	b=KxlCuFOndHW+oGs5tyRbx/LjYxTZqOVRggdnebiB+RlrNmYM1J14mhrub2EdUhpX4DXusS
	3dVwerKOe/uFfmBjEL3yzgA/pES9yq2PUtImJWoX4siX+zi3rNvD4xnu3byPMSNrCor5T7
	FtkdCh7yIXzxKLHO7+pI6wpEwaaz+Xk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-CVbtX8DaOqG_yHBbbCB01g-1; Fri,
 01 Aug 2025 07:44:57 -0400
X-MC-Unique: CVbtX8DaOqG_yHBbbCB01g-1
X-Mimecast-MFC-AGG-ID: CVbtX8DaOqG_yHBbbCB01g_1754048696
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E419D19560B8;
	Fri,  1 Aug 2025 11:44:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDFF919373D9;
	Fri,  1 Aug 2025 11:44:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/5] blk-mq: Move flush queue allocation into blk_mq_init_hctx()
Date: Fri,  1 Aug 2025 19:44:33 +0800
Message-ID: <20250801114440.722286-2-ming.lei@redhat.com>
In-Reply-To: <20250801114440.722286-1-ming.lei@redhat.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move flush queue allocation into blk_mq_init_hctx() and its release into
blk_mq_exit_hctx(), and prepare for replacing tags->lock with SRCU to
draining inflight request walking. blk_mq_exit_hctx() is the last chance
for us to get valid `tag_set` reference, and we need to add one SRCU to
`tag_set` for freeing flush request via call_srcu().

It is safe to move flush queue & request release into blk_mq_exit_hctx(),
because blk_mq_clear_flush_rq_mapping() clears the flush request
reference int driver tags inflight request table, meantime inflight
request walking is drained.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c |  1 -
 block/blk-mq.c       | 20 +++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 24656980f443..c8dfed6c1c96 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -34,7 +34,6 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 
-	blk_free_flush_queue(hctx->fq);
 	sbitmap_free(&hctx->ctx_map);
 	free_cpumask_var(hctx->cpumask);
 	kfree(hctx->ctxs);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9692fa4c3ef2..c6a1366dbe77 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3939,6 +3939,9 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
+	blk_free_flush_queue(hctx->fq);
+	hctx->fq = NULL;
+
 	xa_erase(&q->hctx_table, hctx_idx);
 
 	spin_lock(&q->unused_hctx_lock);
@@ -3964,13 +3967,19 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
+	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
+
+	hctx->fq = blk_alloc_flush_queue(hctx->numa_node, set->cmd_size, gfp);
+	if (!hctx->fq)
+		goto fail;
+
 	hctx->queue_num = hctx_idx;
 
 	hctx->tags = set->tags[hctx_idx];
 
 	if (set->ops->init_hctx &&
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
-		goto fail;
+		goto fail_free_fq;
 
 	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
 				hctx->numa_node))
@@ -3987,6 +3996,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
+ fail_free_fq:
+	blk_free_flush_queue(hctx->fq);
+	hctx->fq = NULL;
  fail:
 	return -1;
 }
@@ -4038,16 +4050,10 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
 	INIT_LIST_HEAD(&hctx->dispatch_wait.entry);
 
-	hctx->fq = blk_alloc_flush_queue(hctx->numa_node, set->cmd_size, gfp);
-	if (!hctx->fq)
-		goto free_bitmap;
-
 	blk_mq_hctx_kobj_init(hctx);
 
 	return hctx;
 
- free_bitmap:
-	sbitmap_free(&hctx->ctx_map);
  free_ctxs:
 	kfree(hctx->ctxs);
  free_cpumask:
-- 
2.47.0

