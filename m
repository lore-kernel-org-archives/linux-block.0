Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65D221FDA
	for <linux-block@vger.kernel.org>; Sat, 30 Aug 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520343; cv=none; b=rRm+TSurRUwLUoCVEIRYDg6xWdovMEaddjTbU1OY9NJDg180/ejr7BcyFudjGDkNcPTjgsKT7rAsW5lmmJONgv+ooxMHGAIBqUt0Qxum2XP6YH5QyBxdZTHd+1zcxMT0R242X1ZFebTpCR9otv1cm52uf2TIs7Nlmg4EPXsgpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520343; c=relaxed/simple;
	bh=es+V7TP22q8mblzrhwqeB/n/dpkx016MjsCbZkCT1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCRGdfu8PnNA9faHm1I/VCgALi8K9Ddvr7Z0MtGrn2R5I/kZOgkr6B05FGFM4DPtw/oVlhPhWI9uEH8sE0ehiD17vaHAqLlfK5ayu8mHxdsFp8KeQyXlUdycoQm2W8+WPt17S2SulAQJGz3Hh+4qjMUN1eaBhNMLwxbxwHP1oXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzaPnqxK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzaPnqxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756520340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0rOLSJwyerjlhOc2RTEThakzUC/PrySZEcWnp9kemw=;
	b=GzaPnqxKRuYpuf/hXb/hvk8M9faWrcep2fLWExd43bPUfeiOoU21zSm8TLB9T12qb76wFf
	TzsLz2dXiWzKkHvHsggbJcs3flrQUFdnZQ5TbPbiu+cyiDKxDsqeemSslmSWiaRQjuKm1L
	qVfPcbz8FO3S1OHDhSdFTiZu9zQm80E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-NiAjLiuJNzSOEdnQOjtrJw-1; Fri,
 29 Aug 2025 22:18:56 -0400
X-MC-Unique: NiAjLiuJNzSOEdnQOjtrJw-1
X-Mimecast-MFC-AGG-ID: NiAjLiuJNzSOEdnQOjtrJw_1756520335
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F21EC19560B1;
	Sat, 30 Aug 2025 02:18:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D089919560B4;
	Sat, 30 Aug 2025 02:18:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/5] blk-mq: Replace tags->lock with SRCU for tag iterators
Date: Sat, 30 Aug 2025 10:18:23 +0800
Message-ID: <20250830021825.2859325-6-ming.lei@redhat.com>
In-Reply-To: <20250830021825.2859325-1-ming.lei@redhat.com>
References: <20250830021825.2859325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
around the tag iterators.

This is done by:

- Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().

- Removing the now-redundant tags->lock from blk_mq_find_and_get_req().

This change fixes lockup issue in scsi_host_busy() in case of shost->host_blocked.

Also avoids big tags->lock when reading disk sysfs attribute `inflight`.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 12 ++++++++----
 block/blk-mq.c     | 24 ++++--------------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 6c2f5881e0de..7ae431077a32 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -256,13 +256,10 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 		unsigned int bitnr)
 {
 	struct request *rq;
-	unsigned long flags;
 
-	spin_lock_irqsave(&tags->lock, flags);
 	rq = tags->rqs[bitnr];
 	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
 		rq = NULL;
-	spin_unlock_irqrestore(&tags->lock, flags);
 	return rq;
 }
 
@@ -440,7 +437,9 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	unsigned int flags = tagset->flags;
-	int i, nr_tags;
+	int i, nr_tags, srcu_idx;
+
+	srcu_idx = srcu_read_lock(&tagset->tags_srcu);
 
 	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
 
@@ -449,6 +448,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
 					      BT_TAG_ITER_STARTED);
 	}
+	srcu_read_unlock(&tagset->tags_srcu, srcu_idx);
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
@@ -499,6 +499,8 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
 {
+	int srcu_idx;
+
 	/*
 	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
@@ -507,6 +509,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
+	srcu_idx = srcu_read_lock(&q->tag_set->tags_srcu);
 	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
 		struct blk_mq_tags *tags = q->tag_set->shared_tags;
 		struct sbitmap_queue *bresv = &tags->breserved_tags;
@@ -536,6 +539,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 			bt_for_each(hctx, q, btags, fn, priv, false);
 		}
 	}
+	srcu_read_unlock(&q->tag_set->tags_srcu, srcu_idx);
 	blk_queue_exit(q);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c9c6e954bfbc..8191ffac998e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3415,7 +3415,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
 				    struct blk_mq_tags *tags)
 {
 	struct page *page;
-	unsigned long flags;
 
 	/*
 	 * There is no need to clear mapping if driver tags is not initialized
@@ -3439,15 +3438,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
 			}
 		}
 	}
-
-	/*
-	 * Wait until all pending iteration is done.
-	 *
-	 * Request reference is cleared and it is guaranteed to be observed
-	 * after the ->lock is released.
-	 */
-	spin_lock_irqsave(&drv_tags->lock, flags);
-	spin_unlock_irqrestore(&drv_tags->lock, flags);
 }
 
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
@@ -3670,8 +3660,12 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	struct rq_iter_data data = {
 		.hctx	= hctx,
 	};
+	int srcu_idx;
 
+	srcu_idx = srcu_read_lock(&hctx->queue->tag_set->tags_srcu);
 	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
+	srcu_read_unlock(&hctx->queue->tag_set->tags_srcu, srcu_idx);
+
 	return data.has_rq;
 }
 
@@ -3891,7 +3885,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
 		unsigned int queue_depth, struct request *flush_rq)
 {
 	int i;
-	unsigned long flags;
 
 	/* The hw queue may not be mapped yet */
 	if (!tags)
@@ -3901,15 +3894,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
 
 	for (i = 0; i < queue_depth; i++)
 		cmpxchg(&tags->rqs[i], flush_rq, NULL);
-
-	/*
-	 * Wait until all pending iteration is done.
-	 *
-	 * Request reference is cleared and it is guaranteed to be observed
-	 * after the ->lock is released.
-	 */
-	spin_lock_irqsave(&tags->lock, flags);
-	spin_unlock_irqrestore(&tags->lock, flags);
 }
 
 static void blk_free_flush_queue_callback(struct rcu_head *head)
-- 
2.47.0

