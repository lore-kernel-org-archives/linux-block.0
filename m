Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143500;
	b=5nrDQFgNTqGt8UgCI1g9Sd7kpgTGqZZBHAH/QCvBgb0sPN1Ql2rgG4tJAHSKKXbOIouZ
	 /bmnIiYS3rf42lEriiLcR/qOkxa5gmxgFCUV+V1dV39IefOvESPwB4HW2Otyt47dd8qfD
	 XnoRk2fCbOdPKJQYNUDQgOebbp4wmhWXAkLtFgXIYtieRJ67TP1HUlNv9D0u4zmSnOPuZ
	 TnpI/h8Xmokdpu2QO/fgdwvyCoiF5YKB6G752lf7lA1gcg+Jj7nT0MDwoQh2fMa1AMVKH
	 AtSO7JoikA4qnVLDOJuVlq27Yma2PnRssjPngoNdm4U+JUZU8iOCfGZ5nA/g+DB5JeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GItNRM5Gwx4ZrpXxGQ/srYtE9okvv9VZklFBQRdwF7A=;
	b=nIIZviS3+qUVrGs9TEjF/QuyMraczWUEMTIhEUH+Dv4UFp2lJp+ti2+FJgX70U6i58SO
	 vpsABrwcXpGgEQBCsQe7ZlyuqaMXu9/3hWgCvEkfeqhWe/x/CA4KHyosbCio1JmMNyB/F
	 WDftlLRif8C0T2FTiXAIfVZv8ksRAeOtw2xXYJObo79+HkRcONTAOPYcK0aGiqplgTIJB
	 z1MW/NV1rt0WPTVhamrxA5RHiSzflvKnrorZgGB6135uh9HhZpW9QpTaa0WCtmHvsHFEy
	 sph0c10QWiOTmAjqibaF1m7lLZZaXBrIuJLNdBmjgvLpJOrBLpW6NZI3W5g4aIp2IfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DKG4tUqs;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5583606A325
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5583606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DKG4tUqs
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso1017281b3a.0
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143499; x=1795748299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GItNRM5Gwx4ZrpXxGQ/srYtE9okvv9VZklFBQRdwF7A=;
        b=DKG4tUqs6g9Zc3zVC2z6Z38dtXfkImPTVH7SMnsl4ytfbukFIrpal+1BD/YDdf4x4r
         9SZNc+4f3IW9LpC/1qkkC/yS5Za/+pFzD1G/ZFZudEZxmRHiL9FCVQ1nPd+cCOZ9iJkN
         WPtKIhMk1tl24s0cuGo49qPTE+CWMki+JOekg3q4IDIn7WyQbVW/pMFIaJHb/77vhRK1
         edvCOEH1KkMM/KZFgQwTPN42EA2H6LEx3wsdAKikNZnQMlOB8cfRbINmOLu1aM5lxRDM
         e7w/vQJXro+TSzZkmlJovl7R1mSaM7rRcrj/tAM+R379MtTpSsQnVIGrDU+e1o3I7F1H
         a2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143499; x=1795748299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GItNRM5Gwx4ZrpXxGQ/srYtE9okvv9VZklFBQRdwF7A=;
        b=F0Vv34lTwpg2uCJ9HpVWJmCjSQ/1XjS0eZjFqZN9ViRaZq0kaXanbp7whm3KvuLZ55
         sCvhMnigw40XalMcbUCw395GbJEeF46Ei9/sDAuM8Lp0PYb52UtjuZAPEE5BIKTq5Nti
         Yhr2zVzW0siPYhJ2zCcropUqVJrXu1/Udkgq/wZFapzP66y2qJUQogp9/4HQwOXjF3Dg
         gNv5Mv6h49q9o1oOlDEKrL7TpN1ouidHH6mK9otNAT2NRWuNJ59IGtkHwwBHtRdnSwb0
         YmE5O3iiCQcjMJfaDLhGxkyOT6SSlqpanu/lKtxw2x1sFQyHA7Eb584uA/a/s2T75fgy
         18sA==
X-Gm-Message-State: APuU4Z+NL6ACUPNZVB67Tq2lR+5xzpPzzfjnLpzeY9ohCJmjQVTw9Xjv
	pX44SIGXu0wopDenTPsxno4yNkO6RV8Hliu/Y1Grpm2xMFkpV8UDjm8tJtC+EhwodOxIozKyU1G
	QMREEUvdmbqXv3/3i77jeDzTUQK0LIVGiQQhTQpbWHjVG5cl2AKtVFQw2tQ==
X-Gm-Gg: AYBFou22zPKs5vjHNEpmb6SRQvRzuMt/X7I0GzJv5+GtNdauAPmlliQaTVm4qR5mht/
	cyXpv2Fqcqx82Ka9B5+GqW8oAyk4WzjRz2CrLVYpyJQiLj8IrhPqGa4+gmQvG9XFHbcMeidRHIu
	5mbJTPyKU4ZEz6Ehv9uZhiQS176DjhwVoVH9OoSedbTWNzNyUW8LqfRdiv5xs/7olmOE9lFO9uL
	qlsXatk2lzY3Ec9EVR1SmZthikmwCD7Cel5jtoci0xoGHqVSUzzSm/3L2jFqxRb1c9fIbnxzGIf
	nwdIERnbJwhOqS+d3+b6X86HfJQsbbLd9dDkDgvoA6HiuPw9Tkd6CvfQ0mnuMjanHEvMeqnDF51
	bEz0J1HJBqkt5ym9udnm3A3upwY/Wcn/oEXNzhXKbzxyyNmNopeoOEagiA14cwD/n4IHy/SmFvZ
	XmTe+JKHhoVsI2qjCcDMLUvBAjT+PxHEmKYIDipKD55SIa9zVZTzgGTDZ10/N52qdz/rLUV4ZPw
	Um8WqxisOYgqugLpAeC0sCA7avzM9N7yFVha3iJesSXOyMVUyT/TdYzOuWrThhpCwEPh9c4O9iY
	TU4QjUP+lhHvS/w3zi30pU5o/6bdfyxEcbKaxQ==
X-Received: by 2002:a05:6300:404c:b0:3e2:26fc:2e01 with SMTP id adf61e73a8af0-4014ec3e2f2mr1102176637.40.1795143499258;
        Thu, 19 Nov 2026 18:58:19 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm749647b3a.31.2026.11.19.18.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:58:18 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [RESEND PATCH v1 2/4] blk-mq: manage driver tags at the tag set level
Date: Fri, 20 Nov 2026 10:58:04 +0800
Message-ID: <20261120025806.1065295-3-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120025806.1065295-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
 <20261120025806.1065295-1-lei.chen@smartx.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_map_swqueue() allocates and frees driver tags while initializing
an individual request queue, even though those tags are shared by all
queues using the tag set. Which hardware queues need tags is determined
by the tag set's CPU maps, so manage their lifetime at that level.

Move tag allocation and reclamation out of blk_mq_map_swqueue(). Reclaim
unmapped tags before returning a newly allocated tag set. When updating
the hardware queue count, allocate missing tags after rebuilding the CPU
maps and before rebuilding hardware contexts. Free unused tags only after
all request queues have been remapped, while they are still frozen, since
old hardware contexts may still reference them during teardown. Serialize
these runtime changes with update_nr_hwq_lock.

Track hardware queue indices referenced by the CPU maps in a bitmap to
avoid rescanning every CPU and map for each tag being reclaimed. Keep
queue 0's tags for allocation failure fallback and rebuild the bitmap
when fallback changes the mappings.

This leaves request queue initialization to associate software and
hardware contexts without changing the shared driver tags or CPU maps.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq.c         | 129 ++++++++++++++++++++++++++++++++---------
 include/linux/blk-mq.h |   5 ++
 2 files changed, 108 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 59452b855afe..12e28d779e2c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/backing-dev.h>
 #include <linux/bio.h>
+#include <linux/bitmap.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
 #include <linux/kmemleak.h>
@@ -4159,9 +4160,74 @@ static void __blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 	set->tags[hctx_idx] = NULL;
 }
 
+static void blk_mq_update_mapped_tags_bitmap(struct blk_mq_tag_set *set)
+{
+	unsigned int i, cpu;
+
+	bitmap_zero(set->mapped_tags_bitmap, set->nr_hw_queues);
+	if (set->nr_hw_queues == 1) {
+		__set_bit(0, set->mapped_tags_bitmap);
+		return;
+	}
+
+	for (i = 0; i < set->nr_maps; i++) {
+		struct blk_mq_queue_map *map = &set->map[i];
+
+		if (!map->nr_queues)
+			continue;
+		for_each_possible_cpu(cpu)
+			__set_bit(map->mq_map[cpu], set->mapped_tags_bitmap);
+	}
+}
+
+static void blk_mq_alloc_mapped_tags(struct blk_mq_tag_set *set)
+{
+	unsigned int cpu, i;
+	bool remapped = false;
+
+	lockdep_assert_held_write(&set->update_nr_hwq_lock);
+
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < set->nr_maps; i++) {
+			struct blk_mq_queue_map *map = &set->map[i];
+			unsigned int hctx_idx;
+
+			if (!map->nr_queues)
+				continue;
+			hctx_idx = map->mq_map[cpu];
+			if (!set->tags[hctx_idx] &&
+			    !__blk_mq_alloc_map_and_rqs(set, hctx_idx)) {
+				/* Queue 0 always has tags available for fallback. */
+				map->mq_map[cpu] = 0;
+				remapped = true;
+			}
+		}
+	}
+	if (remapped)
+		blk_mq_update_mapped_tags_bitmap(set);
+}
+
+static bool blk_mq_tagset_tags_mapped(struct blk_mq_tag_set *set,
+				      unsigned int hctx_idx)
+{
+	return test_bit(hctx_idx, set->mapped_tags_bitmap);
+}
+
+/* The queue maps must be stable and the unused tags no longer in use. */
+static void blk_mq_free_unmapped_tags(struct blk_mq_tag_set *set)
+{
+	unsigned int i;
+
+	/* Keep queue 0 as a fallback if a later tag allocation fails. */
+	for (i = 1; i < set->nr_hw_queues; i++) {
+		if (set->tags[i] && !blk_mq_tagset_tags_mapped(set, i))
+			__blk_mq_free_map_and_rqs(set, i);
+	}
+}
+
 static void blk_mq_map_swqueue(struct request_queue *q)
 {
-	unsigned int j, hctx_idx;
+	unsigned int j;
 	unsigned long i;
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
@@ -4183,19 +4249,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 						HCTX_TYPE_DEFAULT, i);
 				continue;
 			}
-			hctx_idx = set->map[j].mq_map[i];
-			/* unmapped hw queue can be remapped after CPU topo changed */
-			if (!set->tags[hctx_idx] &&
-			    !__blk_mq_alloc_map_and_rqs(set, hctx_idx)) {
-				/*
-				 * If tags initialization fail for some hctx,
-				 * that hctx won't be brought online.  In this
-				 * case, remap the current ctx to hctx[0] which
-				 * is guaranteed to always have tags allocated
-				 */
-				set->map[j].mq_map[i] = 0;
-			}
-
 			hctx = blk_mq_map_queue_type(q, j, i);
 			ctx->hctxs[j] = hctx;
 			/*
@@ -4226,18 +4279,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		int cpu;
 
-		/*
-		 * If no software queues are mapped to this hardware queue,
-		 * disable it and free the request entries.
-		 */
+		/* Disable hardware queues with no mapped software queues. */
 		if (!hctx->nr_ctx) {
-			/* Never unmap queue 0.  We need it as a
-			 * fallback in case of a new remap fails
-			 * allocation
-			 */
-			if (i)
-				__blk_mq_free_map_and_rqs(set, i);
-
 			hctx->tags = NULL;
 			continue;
 		}
@@ -4778,12 +4821,18 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		BUG_ON(set->nr_maps > 1);
 		blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 	}
+	blk_mq_update_mapped_tags_bitmap(set);
 }
 
+/*
+ * On successful growth, also install a larger mapped_tags_bitmap. The caller
+ * rebuilds its contents when updating the queue maps under update_nr_hwq_lock.
+ */
 static struct blk_mq_tags **blk_mq_prealloc_tag_set_tags(
 				struct blk_mq_tag_set *set,
 				int new_nr_hw_queues)
 {
+	unsigned long *new_mapped_tags_bitmap;
 	struct blk_mq_tags **new_tags;
 	int i;
 
@@ -4795,6 +4844,13 @@ static struct blk_mq_tags **blk_mq_prealloc_tag_set_tags(
 	if (!new_tags)
 		return ERR_PTR(-ENOMEM);
 
+	new_mapped_tags_bitmap = bitmap_zalloc_node(new_nr_hw_queues, GFP_KERNEL,
+						    set->numa_node);
+	if (!new_mapped_tags_bitmap) {
+		kfree(new_tags);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	if (set->tags)
 		memcpy(new_tags, set->tags, set->nr_hw_queues *
 		       sizeof(*set->tags));
@@ -4811,12 +4867,15 @@ static struct blk_mq_tags **blk_mq_prealloc_tag_set_tags(
 		cond_resched();
 	}
 
+	bitmap_free(set->mapped_tags_bitmap);
+	set->mapped_tags_bitmap = new_mapped_tags_bitmap;
 	return new_tags;
 out_unwind:
 	while (--i >= set->nr_hw_queues) {
 		if (!blk_mq_is_shared_tags(set->flags))
 			blk_mq_free_map_and_rqs(set, new_tags[i], i);
 	}
+	bitmap_free(new_mapped_tags_bitmap);
 	kfree(new_tags);
 	return ERR_PTR(-ENOMEM);
 }
@@ -4880,9 +4939,17 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		if (ret)
 			goto out_free_srcu;
 	}
+
+	set->mapped_tags_bitmap = bitmap_zalloc_node(set->nr_hw_queues, GFP_KERNEL,
+						     set->numa_node);
+	if (!set->mapped_tags_bitmap) {
+		ret = -ENOMEM;
+		goto out_cleanup_srcu;
+	}
+
 	ret = init_srcu_struct(&set->tags_srcu);
 	if (ret)
-		goto out_cleanup_srcu;
+		goto out_free_mapped_tags_bitmap;
 
 	init_rwsem(&set->update_nr_hwq_lock);
 
@@ -4907,6 +4974,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	ret = blk_mq_alloc_set_map_and_rqs(set);
 	if (ret)
 		goto out_free_mq_map;
+	blk_mq_free_unmapped_tags(set);
 
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
@@ -4922,6 +4990,9 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	set->tags = NULL;
 out_cleanup_tags_srcu:
 	cleanup_srcu_struct(&set->tags_srcu);
+out_free_mapped_tags_bitmap:
+	bitmap_free(set->mapped_tags_bitmap);
+	set->mapped_tags_bitmap = NULL;
 out_cleanup_srcu:
 	if (set->flags & BLK_MQ_F_BLOCKING)
 		cleanup_srcu_struct(set->srcu);
@@ -4968,6 +5039,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 	kfree(set->tags);
 	set->tags = NULL;
 
+	bitmap_free(set->mapped_tags_bitmap);
+	set->mapped_tags_bitmap = NULL;
+
 	srcu_barrier(&set->tags_srcu);
 	cleanup_srcu_struct(&set->tags_srcu);
 	if (set->flags & BLK_MQ_F_BLOCKING) {
@@ -5158,6 +5232,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 fallback:
 	blk_mq_update_queue_map(set);
+	blk_mq_alloc_mapped_tags(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		__blk_mq_realloc_hw_ctxs(set, q);
 
@@ -5174,6 +5249,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		}
 		blk_mq_map_swqueue(q);
 	}
+	/* All queues have stopped using tags excluded by the new maps. */
+	blk_mq_free_unmapped_tags(set);
 switch_back:
 	/* The blk_mq_elv_switch_back unfreezes queue for us. */
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index af878597afb8..3ef989dc4f99 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -517,6 +517,10 @@ enum hctx_type {
  *		   tag set.
  * @tags:	   Tag sets. One tag set per hardware queue. Has @nr_hw_queues
  *		   elements.
+ * @mapped_tags_bitmap: Bitmap of hardware queue indices referenced by active
+ *		   CPU maps. Rebuilt before publication or with update_nr_hwq_lock
+ *		   held for writing. Tags for index 0 are retained as a fallback
+ *		   even when its bit is clear.
  * @shared_tags:
  *		   Shared set of tags. Has @nr_hw_queues elements. If set,
  *		   shared by all @tags.
@@ -545,6 +549,7 @@ struct blk_mq_tag_set {
 	void			*driver_data;
 
 	struct blk_mq_tags	**tags;
+	unsigned long		*mapped_tags_bitmap;
 
 	struct blk_mq_tags	*shared_tags;
 
-- 
2.43.0

