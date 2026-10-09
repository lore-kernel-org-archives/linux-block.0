Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB64AEEF
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514921; cv=none; b=d/SB5JV0xEBwmnthbBl+U93MoOY1nJ7+hhq3FceUGLaWBDtq7IFLyODa01iRD8PGAo8YPF/AJ4aq2IILdI4qj5DcoGdydq5oZqneStUW5EsK0B3xi9PK5ri4ajJAAPXA+BZe2ZuT73/7eLgeanmm7tBZOSCGuNX8A6a6BxoJW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514921; c=relaxed/simple;
	bh=B7jI/Ig9Y0jE+4zf3/j3VC+OK5vOUXZ3LtRn8jfaBgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnPqjY6q7+98Vw9ZnceTQCHWedmPTzDEhLspYJxzuWt61x4n+1cX6OvibKY0ZomqibHVLFo41CaWkzLr2FtkI2HRZaHk25ihVMX/G7FrZx9c+dduD9UPGg/WAhhZE2tFHyJ1GYxoT+tvWzX9ZrvOcZ1j/rg388l7nkPTQfUuXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=EkxPt+Qp; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="EkxPt+Qp"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30b6dad2382so8449981eec.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791514918; x=1792119718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GItNRM5Gwx4ZrpXxGQ/srYtE9okvv9VZklFBQRdwF7A=;
        b=EkxPt+QpFD6nnU0RZalxXr5aIHYSCDM+VATWsesorrisJuMb+O6Z/U0lIyNeHrDnf1
         3fGCPjaHwf3fCJDnxbwGF4B2M0OrVgvgj0/8HsFywB1QRe23wlN/eqozzNQHGEO+iY0G
         pEOMFV6vg0rziuZ+9dWzWImKB4ENHcSaqf3mTZ2UgRjTssyZAoGk09rYBYhfAlVhuY8P
         Blhp4YOys4hn4TMc2IJlRXO2KEVa5UXFS62VP2sLKxVAxJN28BrG0qNeDHNddk8SvInK
         SnUejwSfqj5h+Qsg4I1Q1D0hWVdcMQAage9ceUggyiU5pTA/JBcOHIppw6j3RPPj0H5m
         2Ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514918; x=1792119718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GItNRM5Gwx4ZrpXxGQ/srYtE9okvv9VZklFBQRdwF7A=;
        b=1xHNibt2Zu9g65K/WcVBGllnXN+AtA0OJ26tN1lrs1L7CE3r6PBYyiw1uXlZycFEUL
         lytfrMf2m4z/pDIJrIuF1QGQain3+NgKwSpylcpzR9vbgSgg5jN2reOcBjxpeS46wbC0
         3kQWiWNEbNVpbXYsJ0FQBkjTTknns9ysQOwnvT+DuAsIzy+y/PfSDCQDQwpiKNErWkRG
         k/RSrAGp+QfhVoq5vBzF6oyHddpQsKwk7f6YCkmJstN3KNbcA03ktonjA+CHEjJCALIS
         h65X0kd83s4EhbXozuiGS9NVWqAIkYe8jRWROl5YsxWBpmnQgU5t0H8AzEHywA8K9cy4
         kV4w==
X-Gm-Message-State: AFq9FYI/lfO3mrrvFtAvpvEDacCoALx5rYyjjeszIidEaOfWmMGlRGsp
	Pn3bOOKNBbmbh00FBpOWAPymhC6ULGGNs9FN/fik5UF0iRFizFqIudfpn7w+f3J1SeJtNu3t4RK
	yXvU7bxon3QuxPIy6YrE6z5mkaz31hZHlFtcHwsckqn5cgabM3n2vphQZmA==
X-Gm-Gg: AYBFou1muBNvKbzIzZ99qiD3CXgmp2FNBoKDlPP7Dc09EFzZvC/DuZQKFN9eRiwiPHC
	whWVCjOSGf5EFN4APvPB9UvCDeg/9U04JUsKE2FJ5YomABtPdkjY6+JfGaCMPPvniHRwo59Wqyw
	aEneEOmcISdMryliaoYjKzTjkYi0kGz1Ldk0/q5/t17XE9TATFrdyKsP4QYr3CdueexKe8L4hLz
	C3sbsepE3kPfgtGWApVRGZqNTnGWRCWA6emJgk1hd4Qn6KCSWX9tqrH7cprIJxCye2kFARdVSGZ
	/X+7bFHTUDyKlQjKKOH0AfHjKF13OFa2lVJAX0obWSOu+RyFR2euY34auiREMJIvt/g5I38na4T
	lmOmuYrx8h83h6A7nvRPUc5xJarV89rjkiW8H3cV6tRhNHz87x8NWUZ+9SOCaEdUXeJJNcC8Kv/
	Zy23Vf3TOaHIQZq+F2AZCwTUd7+5tmPdCwijpSBfShWYH2DNZvX7KEsoUhrBVzcQpxURC2s++Yl
	IZ6gwcZR3s=
X-Received: by 2002:a05:7301:fd8c:b0:351:2cc8:523d with SMTP id 5a478bee46e88-3537e248993mr1219667eec.35.1791514918100;
        Thu, 08 Oct 2026 20:01:58 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm2427626eec.27.2026.10.08.20.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:01:57 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v1 2/4] blk-mq: manage driver tags at the tag set level
Date: Fri,  9 Oct 2026 11:01:09 +0800
Message-ID: <20261009030111.57784-3-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009030111.57784-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
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

