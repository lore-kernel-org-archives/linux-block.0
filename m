Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D92FD1B0
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320017; cv=none; b=u+Cu3vkXcQip7Gv2+sliDa9n9DaOzWDxz3VaXy5Y/LZmag04TTQ6lkQZ6Tou5Z+CKiO5lW2mnMdtpSZzWHCGodznKjQSFwYy2eBVGOZim7zp6m1thkvkUbMsjFHHVt2VuOTp71XIdyUPU6ZB41/XyDjjekL9p30HkofcBVBhujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320017; c=relaxed/simple;
	bh=087pSghEXNwiqV0+SRQSVXXGhNIrEP7JKTboD5g0WT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxprSPzUwIqH11I+4x5nO2Wjw6lL+osR976s1d8EF5sNdGGif94+vb2V3D4nUHA9NTBFlF3Q+h9da88wLRTA3F2DDDUKOwDeescU011eV3W89bn+yBl5tM6eaWwmztWWSwMlgBGWuiRxi1wST80W1u98ZmqgR/aIofC1zIZ08Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK9ZOO1b; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK9ZOO1b"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aab7623f42so1742337b3a.2
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764320015; x=1764924815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5NPcuOlzyo8bxbdGqfdaTnB97h00/OnVH5uGDAa/qM=;
        b=GK9ZOO1bCHWB/qeABAYX4JAdzaXT18AbrmLicedpOiDrpT8ZANh8rkdIyWuo+C7MvW
         7a4G9dsu5HiQ20SJ7DLLQWELw3fWHjjK9az6jY3AS9jh/Crr6iBWTOKfM1R4oInL6huM
         cyFaSdJpy4Wsj0Cs+DQ81r9xBTGau7C6IZ/nusEfk+l5eaFiT87i4KNXJwQVo6MTZKqL
         KWT1s4lkSRfXH860f0qhHTMJCnC7XS5Westdb9ow1KsI550AaVEPhuaw9O0bF7J0KWwI
         XG1Gs32PBPbus77h20POd7/+mGKbpoAXr4akniPhf3xeUgccHvi2IoYIHkwkN52Jz5XD
         5w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764320015; x=1764924815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c5NPcuOlzyo8bxbdGqfdaTnB97h00/OnVH5uGDAa/qM=;
        b=ZiuW49/fFakQG70IkXuaPkNJDbsSsMk6yE1XCpBvC5zumusA4TmV1oeFHuE37aK4Ym
         ubA6nryOBeumHBr75xmrCB5Ip5jN9MGaPHywBZtv80QVg6wGtwZjNjGP6gOcm5YlN1yW
         qUMh4AcjSzSzkzpO0NsMd64ZN68+fT64eu6a9W4bbpQgCewMEkTIhTXsH4ghD+8EF1n3
         B3ILs0Zh5RELkhyGFRgX4GS9x3c3478g8NRw7HonW9rpGO2OZh68n3izU/6L/HGSXki6
         12mOzax6qtV8NvAxO685omprWusErkejAHdcc0+9lYIWUpVkVM6FTLGIUf3o3do0hyoQ
         BM9A==
X-Forwarded-Encrypted: i=1; AJvYcCVqJohjnsPouy5k6/PaMEwFFqS/wXh2/hk54T5RQzidT7TdvAGHRMpI7IovuLhrG7u1UAz9lsel017ZdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6BiP9MOU0SgGa9I55FciQOfq6rT3sOVhDyjxiiv78id+1lwo
	tdcMuN3+WRtqJWwgxmp58EBj4yZkDSu41Pe/IpMAxMax81FW/po6F63N
X-Gm-Gg: ASbGncsU7UgqYJDoPCfnh+xJckIB2R0LlRi+A9ypG9ECZKkPeGk9ogWx8yGM9669QFM
	Bac9yRxWpKgdx/KE+Q+JtoVpx8l788duGkeaLk4oEtqYrR82ZuZRpKD01vJjmjarY5/AbSDi882
	muRSL57tv5Y1G5tzn+ZQ8kgW/NG/Hdw/P7+fJTwVyJ/v4XLCL/voZMkT5wL0LCz+srIzjvU4q/u
	ali5UONCo7mWcJL8D+UtYMjPHDCmmVEaGDJN40TgnFWjASYj8yOlJy0UY4dn7d+8ls02rSMEJ0N
	4d+gt18LZE90Nw5iAzkfFDXujDnAt8wbBUp5xrV5XXcc/IKvxLkz424WxXND/yVwM2XZ3KGnrjU
	cmau2cBmJFcRb3DLn8ETSDaGp3YrFEAx2nHRNFaydnbZJ1cHW+S4HU5CAPC1JvvJDtWFKUYmcPB
	IzGZfRTD26Qlu+yJju8zJTbU12FaL2RoDq/rV7KCJowkE=
X-Google-Smtp-Source: AGHT+IGuUge9NE95P5M/C2/cX6JlVfbZ7E5N/MJ3iJLHABTm/MyPH1zLpqH0d2Ztu58DEl4OqMntNQ==
X-Received: by 2002:a05:6a20:7f86:b0:351:9401:c2b0 with SMTP id adf61e73a8af0-3614eda8485mr28959154637.31.1764320015417;
        Fri, 28 Nov 2025 00:53:35 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-be5093b5b79sm3999943a12.25.2025.11.28.00.53.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Nov 2025 00:53:35 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
X-Google-Original-From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai@fnnas.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v3 1/2] blk-mq: use array manage hctx map instead of xarray
Date: Fri, 28 Nov 2025 16:53:13 +0800
Message-Id: <20251128085314.8991-2-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251128085314.8991-1-changfengnan@bytedance.com>
References: <20251128085314.8991-1-changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
an xarray instead of array to store hctx, but in poll mode, each time
in blk_mq_poll, we need use xa_load to find corresponding hctx, this
introduce some costs. In my test, xa_load may cost 3.8% cpu.

This patch revert previous change, eliminates the overhead of xa_load
and can result in a 3% performance improvement.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/blk-mq-tag.c     |  2 +-
 block/blk-mq.c         | 58 +++++++++++++++++++++++++++---------------
 block/blk-mq.h         |  2 +-
 include/linux/blk-mq.h |  3 ++-
 include/linux/blkdev.h |  2 +-
 5 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 5b664dbdf655..33946cdb5716 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -499,7 +499,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 	int srcu_idx;
 
 	/*
-	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
+	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
 	 * racing with it.
 	 */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..eed12fab3484 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -723,7 +723,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * If not tell the caller that it should skip this queue.
 	 */
 	ret = -EXDEV;
-	data.hctx = xa_load(&q->hctx_table, hctx_idx);
+	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
@@ -3935,8 +3935,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 			blk_free_flush_queue_callback);
 	hctx->fq = NULL;
 
-	xa_erase(&q->hctx_table, hctx_idx);
-
 	spin_lock(&q->unused_hctx_lock);
 	list_add(&hctx->hctx_list, &q->unused_hctx_list);
 	spin_unlock(&q->unused_hctx_lock);
@@ -3978,14 +3976,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 				hctx->numa_node))
 		goto exit_hctx;
 
-	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
-		goto exit_flush_rq;
-
 	return 0;
 
- exit_flush_rq:
-	if (set->ops->exit_request)
-		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
@@ -4374,7 +4366,7 @@ void blk_mq_release(struct request_queue *q)
 		kobject_put(&hctx->kobj);
 	}
 
-	xa_destroy(&q->hctx_table);
+	kfree(q->queue_hw_ctx);
 
 	/*
 	 * release .mq_kobj and sw queue's kobject now because
@@ -4518,26 +4510,44 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned long i, j;
+	int i, j, end;
+	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
+
+	if (q->nr_hw_queues < set->nr_hw_queues) {
+		struct blk_mq_hw_ctx **new_hctxs;
+
+		new_hctxs = kcalloc_node(set->nr_hw_queues,
+				       sizeof(*new_hctxs), GFP_KERNEL,
+				       set->numa_node);
+		if (!new_hctxs)
+			return;
+		if (hctxs)
+			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
+			       sizeof(*hctxs));
+		q->queue_hw_ctx = new_hctxs;
+		kfree(hctxs);
+		hctxs = new_hctxs;
+	}
 
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
-		struct blk_mq_hw_ctx *old_hctx = xa_load(&q->hctx_table, i);
+		struct blk_mq_hw_ctx *old_hctx = hctxs[i];
 
 		if (old_hctx) {
 			old_node = old_hctx->numa_node;
 			blk_mq_exit_hctx(q, set, old_hctx, i);
 		}
 
-		if (!blk_mq_alloc_and_init_hctx(set, q, i, node)) {
+		hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i, node);
+		if (!hctxs[i]) {
 			if (!old_hctx)
 				break;
 			pr_warn("Allocate new hctx on node %d fails, fallback to previous one on node %d\n",
 					node, old_node);
-			hctx = blk_mq_alloc_and_init_hctx(set, q, i, old_node);
-			WARN_ON_ONCE(!hctx);
+			hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i,
+					old_node);
+			WARN_ON_ONCE(!hctxs[i]);
 		}
 	}
 	/*
@@ -4546,13 +4556,21 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	 */
 	if (i != set->nr_hw_queues) {
 		j = q->nr_hw_queues;
+		end = i;
 	} else {
 		j = i;
+		end = q->nr_hw_queues;
 		q->nr_hw_queues = set->nr_hw_queues;
 	}
 
-	xa_for_each_start(&q->hctx_table, j, hctx, j)
-		blk_mq_exit_hctx(q, set, hctx, j);
+	for (; j < end; j++) {
+		struct blk_mq_hw_ctx *hctx = hctxs[j];
+
+		if (hctx) {
+			blk_mq_exit_hctx(q, set, hctx, j);
+			hctxs[j] = NULL;
+		}
+	}
 }
 
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
@@ -4588,8 +4606,6 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->unused_hctx_list);
 	spin_lock_init(&q->unused_hctx_lock);
 
-	xa_init(&q->hctx_table);
-
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
@@ -5168,7 +5184,7 @@ int blk_mq_poll(struct request_queue *q, blk_qc_t cookie,
 {
 	if (!blk_mq_can_poll(q))
 		return 0;
-	return blk_hctx_poll(q, xa_load(&q->hctx_table, cookie), iob, flags);
+	return blk_hctx_poll(q, q->queue_hw_ctx[cookie], iob, flags);
 }
 
 int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index c4fccdeb5441..80a3f0c2bce7 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -84,7 +84,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 							  enum hctx_type type,
 							  unsigned int cpu)
 {
-	return xa_load(&q->hctx_table, q->tag_set->map[type].mq_map[cpu]);
+	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
 }
 
 static inline enum hctx_type blk_mq_get_hctx_type(blk_opf_t opf)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b25d12545f46..0795f29dd65d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1000,7 +1000,8 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 }
 
 #define queue_for_each_hw_ctx(q, hctx, i)				\
-	xa_for_each(&(q)->hctx_table, (i), (hctx))
+	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
+	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 70b671a9a7f7..56328080ca09 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -493,7 +493,7 @@ struct request_queue {
 
 	/* hw dispatch queues */
 	unsigned int		nr_hw_queues;
-	struct xarray		hctx_table;
+	struct blk_mq_hw_ctx	**queue_hw_ctx;
 
 	struct percpu_ref	q_usage_counter;
 	struct lock_class_key	io_lock_cls_key;
-- 
2.39.5 (Apple Git-154)

