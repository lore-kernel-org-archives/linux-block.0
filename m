Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A72222CA
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207563; cv=none; b=YIro5AdzEs1aCcFn7p4bf71vooPfzh7rxoZFwuZOyzrus0gZyDOZT2kbUqIhTH3jXk1rEoYN0Ljg9jls0+RgbFhRZD+LOZm5SSKbOX1qqOETDipSHdLuQWyekPjliNRBz4VuWG6hwIJPdXBes3VW2oLUyqEcYUqZHFSJLpzuXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207563; c=relaxed/simple;
	bh=AEgA5T1w7CEMS/DbQDFbX0kmKqf2XxD3qpDHAMF0kYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTyMi9CGR9eBOtDTO5gaWJ7TjNNSn2WF8W2QKlvLjjBo43QRj8wYT+5sEfTEFa9uRUxaWLov7CNfHJRUE0jxPLeSNJyMHkVpiBovmC7T9U5NoHoNsEoE3sSbWKf+u7U0vwY5laZ+GL1WYOtOdd7nF39jfBquzZxDYj4NlwzUONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqJ/DiMM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqJ/DiMM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295548467c7so4300615ad.2
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 17:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764207561; x=1764812361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5HExegE3LnF20kVAK/x9eM4NEaGmn6A4LbIaE5Osh0=;
        b=XqJ/DiMM3DGFbUMIi7/N/Db0Sw0C0Z9Op8okPZ6LFAySXRiGIJPnb7Yan1v1EgRSqb
         4Axr2XdoTdBvBvweY74n3QxYnCj5LmVFKFw5YNyJ4PGdUtaFQYCGGE6UHusxLoqJjL2T
         2k3YC6C4KP33K9X80vPJlJI5wKv00IUS7ZPi9FIDiEJtIxfmGu76K9n3+4wj/f2EjA8N
         +bqLUuEQ8QaCPpDII/1OsCHN7luVQE3i2gDQXHln4izPtl3NDIJHViAK4m8sEOXwEoZq
         f04Jh96IjyXxQcZlKMUG4s7m5GTCiFshWGnv5u+XlcCA66+VFJhk8HuDIkgQWOeLEevg
         O7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764207561; x=1764812361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5HExegE3LnF20kVAK/x9eM4NEaGmn6A4LbIaE5Osh0=;
        b=bfiSuCdthIUS7cx1IeMAWXE0wgY+cHCTTtdBMcq4vxyiBio6QT6JnTcdjSj3jpTBVI
         PdfortVgbldgd6D5buOsIeLFi2k8d1FN0ulVGRbnMxYNeErfKNl7P5MYvXRsQB2zuqg7
         +ImE0H7ICxI3SPeqLqU1PXd2DRIAyveXINp6KK3qhDPB5J3uMbYcr2hYSFyUDEE4ZqnI
         GI+rwK4hkYT5DG5mRuZK8T1LCRDbj5NqqRkeuc5PdDUFMeSMemBPFoRMr+0O8PUprswc
         dhbfFoLLRsVPsy4hgs1OCI/6L9gMs/RPKC4tbl4eRFIMwpbQ4wsi+L02hrtQ4MqbVtJD
         GLAw==
X-Forwarded-Encrypted: i=1; AJvYcCVYaVEirg6MyBq39tds8VIn7YJh3vxqiyYKoJrApILsDShxfoPp8KiFOMqIPPtwsVtI8lygrO5IzSalRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhgdF2h5h2tD+BGGQ7bGiQZfR/sCPTlwv/x7OvEXFp3mdtzKql
	+qKSFU+azQwNnimbwc4kAgDObG/2SwbvG2qGtmvFEmg03EaN4UqRRBvH
X-Gm-Gg: ASbGncsxJt5Z406/laUB/qGZV6EMUJcmW4/qEAeJ9xVBnzhUlHhASc71QzbA5ro/nk6
	uFp8tI/ceYhwART9u/t8pYQpLVB3UqV1b8ZjiQv6dDuX/V3e3cFzQIuVIoCCH7v2tZsAroQKLqL
	8v72VPBYbbUtLX+HJLHuK0XPvP701O5zXVOgtcrkX4pPICOET38J9ppaVLv7PiUa1bDH++82EY1
	TEvdajIMAIpGuxhiX10jDdRunMBtazH7chIV7qA03uEOstyVLU78pjqE2Ro4pbtq6eyMiC7lCM3
	SEXgAWPMHyjreLADQTLkvSKdQDdPeN6ZRuXxkIRfpMcg6Y6lnMdACUColjAAc4gwRVQcm8gVKm6
	0UXN8zM1yHb4gW/ZtTKKvtA97RkLdutjEGC6ywkIGe4KdNjUJlaf//Ip1IU4Q7Co6Wp2f33VxbA
	gx/M1i1ZJ2H6D+LpAFg4tpyfo3AG9PQ7P+nU8Myw==
X-Google-Smtp-Source: AGHT+IHmRWvSsFEJxgtJP6y1SrV/WgBkp04Kon3r66BbAv9QTjMw1keM4pId8Ydyx3/SE8dUmvJ1sw==
X-Received: by 2002:a17:903:11cd:b0:298:68e:4057 with SMTP id d9443c01a7336-29b6bfadca0mr238443405ad.59.1764207560777;
        Wed, 26 Nov 2025 17:39:20 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29b5b107cc2sm212427815ad.16.2025.11.26.17.39.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Nov 2025 17:39:20 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2 1/2] blk-mq: use array manage hctx map instead of xarray
Date: Thu, 27 Nov 2025 09:39:07 +0800
Message-Id: <20251127013908.66118-2-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251127013908.66118-1-fengnanchang@gmail.com>
References: <20251127013908.66118-1-fengnanchang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fengnan Chang <changfengnan@bytedance.com>

After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
an xarray instead of array to store hctx, but in poll mode, each time
in blk_mq_poll, we need use xa_load to find corresponding hctx, this
introduce some costs. In my test, xa_load may cost 3.8% cpu.

This patch revert previous change, eliminates the overhead of xa_load
and can result in a 3% performance improvement.

potential use-after-free on q->queue_hw_ctx can be fixed by use rcu to
avoid in next patch, same as Yu Kuai did in [1].

[1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/

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

