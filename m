Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E052848BE
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608609; cv=none; b=uQWuK/sKx5juMpv/1sPZfDTRSY12/Rde9kSoIU7howEQsORKp0PUt4duhSV3OfMiuRx03+zWkYkBr5vh9JWT3j+Za8+5R8WLUs3WOa+j9nrzR7JgZmdSIWUcvEKxVeY3zAs0yLqShvJTnSCc7RFeTD5lCamjasWsvTo7JVgyYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608609; c=relaxed/simple;
	bh=BVNkzop/9HmymaVPamRajvVujXjv/aJfzwuDk2WKAdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHV+LiJpUV6t7mctAT8aSpP+lSvJfgOI2TPkfU2bbfXwKzvlDeAWrnKdVhgQnNWegqcdqZ+e/0EJHACbg3MWBryPb7+faTeuKrexC6Op1RZXHZ7Rw8ch9a8pryMxs6YKRfWRi7bWETl+qWqRZe/yuZA1f8AbdJLJxV6+uSdEVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHKwgCW5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHKwgCW5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so485336b3a.3
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763608607; x=1764213407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfPTpfsdcR276rTedyRT8IVgbzGXp5zIfBn/p9nmp5Q=;
        b=IHKwgCW5ZoeUPdLJDBWklYEvSkdSFDZMJH/PRqSa3UxUk0cMJsLaOgCXmAsg/jKC2l
         AApUKcRzsYeyxV4KfQ1nGLJeAOz2DbJ8rXNJCq4E7R8LCgSkGXfQt8Pnm41w6dD80smw
         I3ktpTzklY3ae///8kge0sjV3jbVSWEdrSxFalmSfrpdRbz0wRbjoQhCEaTUBQombwW0
         p16ZzbTdF4LubXaPkmnbtl4Uj8Nux2h9aZwQEjNizKfY2MR+dDUYyQyq1zNFjQ/cOBl9
         AykETJzSQfRMcOsWtHrCAakQ17b2CVTe/BHrVAQ9xS5UDqnOUPirP0+5MPXXICYqJOeW
         sWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763608607; x=1764213407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfPTpfsdcR276rTedyRT8IVgbzGXp5zIfBn/p9nmp5Q=;
        b=LCmP+r9TKyWNJ8sA4WiCcgDbN00fOAkV7inZlR7VM8eHAqBp3fetx6wHJ1n0hG3Zox
         4jSAlojEbr1PF1rTg4IBck0rkZ5GJzeS7q8BzNvEY+1m7DSMIuOplF8eEuZ9aAJk/Vrn
         CTY839kcReGPFp/+Mu/ty/ILjYXiSH0nJe/zosm5DVL8a9CSKPE41z+ifW4r1JwxQB7J
         7nL026aN6UpmuJFj8Ay6AqInLwHVNlLusnySbFo99z2HkvYdUwVYaDV/WilTBELf3VPq
         SSOpjlz31WKMg7vLdM/EuJBTQKfkjgeUIRQOC1FKeNUJ5UvpP25kc4nuA2WvbgEysGPA
         LB1w==
X-Forwarded-Encrypted: i=1; AJvYcCWuofmfTOjSn2Dg86o4oaq6Y/VbFnVfkwTqF9AjlAVxeVbXc9IBIng0MIhbNAQDlTNFqOEU6unGYZpB8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8ILtA5+RzOfa+Vp8Btu7UO/7QPkH90et+BXQ9jFYqV8RC4+S
	wk4YqJnlh3Rc2oWnE1gl3unxfV2UufFt9yH9kY2h4fbmP6Ob9ch3p+nd
X-Gm-Gg: ASbGncvy0kZ2pGVQ2r0XjtgLf1zO55/9ZfWxVjMErnOd2ff+eJu7DnlZohN5YwKO1+5
	SNB/v3BC23gorlSkSmp4DDeA/BVmFkdHjCWTLakmQCNQ/CvhgOatMFhXXg/XlXLGrzu9GIaGDtv
	TEixE6MXxWijfmvwr+Kd3/T8YQRUB/NzT1VLV65X3dO/2rJ7VJ+lnHghsnPTKcNnJqOC9kWboB3
	n0HrTvNhbVbRKxiLtnA3SpxMY/+QBYAxlGvAgFx0O8GDcC94G6e/nCq/h1lcvQCaC6+Q6vd5hGV
	ZWBVNNU0R8Yzrb3Y6TEsX6YEu/Ron44giJJ7zzDmnwPeUKxeDz1lVv5A71bHik5Tk/0aAY4gZz1
	6AO6zjy+QoWNljDIrR0Hj7rmXTKz8obcBl0/gUmqFBBO8ZpCkOVQh3paQu33z8FQ6QZOo9+za9t
	NTO/VVBksN3d9XptEJoqG3vnM+gyFAeLYNO2EgyGOTXWlPz8iD
X-Google-Smtp-Source: AGHT+IGwrBNYUMnvfiTo0y21n7ACZ9G1keoFf35Yq/aYUyB+6B6zCN/SEZTkWoPPeLvSEwlNv2jyRA==
X-Received: by 2002:a05:6a00:17a9:b0:7b6:1c9b:28c with SMTP id d2e1a72fcca58-7c3f471b244mr1669372b3a.5.1763608607001;
        Wed, 19 Nov 2025 19:16:47 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7c29asm879890b3a.9.2025.11.19.19.16.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Nov 2025 19:16:46 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH 1/2] blk-mq: use array manage hctx map instead of xarray
Date: Thu, 20 Nov 2025 11:16:25 +0800
Message-Id: <20251120031626.92425-2-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251120031626.92425-1-fengnanchang@gmail.com>
References: <20251120031626.92425-1-fengnanchang@gmail.com>
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

use-after-free on q->queue_hw_ctx can be fixed by use rcu to avoid in
next patch, same as Yu Kuai did in [1],

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

