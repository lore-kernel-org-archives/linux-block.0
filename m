Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8848D86B
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461262; cv=none; b=EC8ZZpDf3KnRKF+yeDR/4zBRyDjTrjfS/haEynqJB4BAagCurnS09obGdKrkL6PzlHD1r+5HQ2KDqUTcJl8Z0H1aCy0+D/5td5oNZsT0wX2C3GX/1gFv5Bkcp8KISeC7Wt1AVMHaRA9d2S/ClcPPqBZ0s6TAcaAZhbAwE3OBoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461262; c=relaxed/simple;
	bh=CKMbPuM6Yb1atG/NuM5NdV1aKcM8/wnznVYdm3QdpRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rW0qQyh3F8Jya7NI94FHMcC+6YwdT471plAUwISPVIbecFGMhap8WdtMmAHbMOO6ngIlcSsM8OYU+tNXJ66p3EJIUsoetilZUDITaD1U0XJXBwmTVT6xqeZSXviQ7Cpr9vFuvb0j8Q5NgxNzRptA8eqiOfugUzid5ZXoU9JpXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PfndbTSo; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PfndbTSo"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso1726775b3a.2
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789461260; x=1790066060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18B+mnf3gIsI3ZPyV0XbtWA76VI7+e4SAQ+2YXTfHcE=;
        b=PfndbTSo32sX+1EUWXt9mGcuuIsHlX/8F05V400v64wcwQUgKDW3R2kKf4ZIbK1ULR
         xhCaza+HmZOZrDqcKRcuX5bSRRovmqvytANWJIj3woKO5fCGTtQxPHSYIZrRv99dnSVH
         S1iG9KjkuHPqjcolPLCC6+YBSMNVGwMHbeA54EnjLVV8yIRhaCWvIqXRtNb3QNazTVdB
         umpJ3EN6fE3pUu9nrCi8kfy/LFx4ENJRiYjTwnm55x9XlCNZTgXv4E1VF++e756Ka0GB
         jBLGtpWOg/DeYBGR9wBNGhDJztgxh5Qdocz1xm47WT59QDIt1piWx79EgEJ5IeA/xZgH
         +Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461260; x=1790066060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=18B+mnf3gIsI3ZPyV0XbtWA76VI7+e4SAQ+2YXTfHcE=;
        b=sm7BBYPdzNZKdl+X/SqiDoE+df+Gl1O8zDkQ6Zbcw2WdRrFXYDltQzftDH9vEB+60y
         zeNP7h6HLB7+k1VCfc2vwtuG5qSqxC6AZ/9T8zYswA/YoqBbpHn+lVPVHb/ghJNn7ub3
         jJ6mItiJebMcCk4liqvemXYjl5ZweqCc0bkC1cHKk1hO98yFSgCDfkR9f+xEcdQN8l3H
         rOyX8Ngsri6DvFGd7itosoIfwWUVgQafxAqcP/JhsNGlG7ZUZNQ96HHcniTS9Z87fND8
         MiOE+D3V81CWlz3Y3TFU5EiJ/IpnvtBPNtlM4KvguwzTpfN8XHDcGFT2I8UxgxUYgzYX
         TZxA==
X-Gm-Message-State: AFuF++mDxsdN0o/Y0rMLkEo5YX3hJS7ZnBuEvmOOdeyv7oMzPmmwut5N
	2NwETcuUNw1JGOf7+mKxH4rMShkkltyodIIGGTU0XVmSMq4+CGB9KM8dcAbnJuOoWt3mr8MNXMw
	/pQ7W+Yk=
X-Gm-Gg: AYBFou2DyHveHdN9ksDhuOUxzIFGBgqYYJP0S4KBnsEGGx+w72s2DeRqxkSW4sWGquR
	Ral/CmQLKcDu8x4JQnEMnMsn8nfjdRTrNj7Knzi5sD+Jc+/6xyVVSfUACAPmEYFMFPKz1KJBze0
	70pqr8B8qpkL6JSQkuIJzuTUn7SFamPKl6Y63pWfEUCTXaavw2tdjW05cWcV37MyGhEe37pXjJC
	EkRnX9MLpBcvgfw8tTCBqJf/L6hrGWf71eh9aA9G4PvSjGDAddjFbFmXVN/y6RpihquJowAJx/n
	IOGkMvCpO9TJuBTQ5TOwXp1b7Rg31y8/y6Eimjjna2OYipwomWdamMsqz5h1FFoAxr3FrveanmK
	QMAWuByg6kBTIDHg/zT5FDbZbdl/SK1o1Zj2xUWOxeLrQVWQH9cCVgd43VSr8Zz5UuFr1w7GP92
	YwmWepHAIlXgeHEGzrB/XHaGtlAhKAJX6cW9OhM8mNeZW6KFyTHE3TovMfu5FxmfS4oD6V3PspN
	l4=
X-Received: by 2002:a05:6a00:1950:b0:82f:38df:681c with SMTP id d2e1a72fcca58-86f82f524c7mr12906512b3a.6.1789461258753;
        Tue, 15 Sep 2026 01:34:18 -0700 (PDT)
Received: from localhost ([106.38.226.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29dc09d4sm5702332b3a.47.2026.09.15.01.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:34:18 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v5 2/3] memcg,writeback: flush foreign bdev mappings separately from owner wbs
Date: Tue, 15 Sep 2026 16:34:05 +0800
Message-Id: <20260915083406.3471036-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260915083406.3471036-1-sunjunchao@bytedance.com>
References: <20260915083406.3471036-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bdev inodes are routinely shared by multiple memcgs. Recording their
owner wb as foreign can flush unrelated file data when a source memcg
enters dirty throttling.

Record bdev device numbers separately and queue best-effort work on
memcg_bdev_frn_flusher to write only their mappings. Keep the existing
foreign-wb mechanism for non-bdev inodes.

Bdev foreign flushes can be triggered frequently. Use a dedicated
workqueue to avoid interfering with tasks on existing workqueues. If
allocation fails, retain the existing foreign-wb path.

Use fixed per-memcg slots, with a shared lock protecting device records
and in-flight state. Tracking is best effort: record only dev_t without
holding device or inode references. Skip closed devices or devices whose
open_mutex is busy. Device removal and device-number reuse may race with
lookup.

Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/linux/memcontrol.h |  15 ++++++
 mm/memcontrol.c            | 106 ++++++++++++++++++++++++++++++++++---
 2 files changed, 113 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7d1c0ce189a8..3cd90913773b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -176,6 +176,18 @@ struct memcg_cgwb_frn {
 	struct wb_completion done;	/* tracks in-flight foreign writebacks */
 };
 
+/*
+ * frn_lock protects dev and inflight.
+ * No extra memcg reference is taken: this work is embedded in the memcg,
+ * and mem_cgroup_css_free() waits for it to finish before freeing the memcg.
+ */
+struct bdev_frn_flush_ctx {
+	struct work_struct work;
+	dev_t dev;
+	bool inflight;
+	struct mem_cgroup *memcg;
+};
+
 /*
  * Bucket for arbitrarily byte-sized objects charged to a memory
  * cgroup. The bucket can be reparented in one piece when the cgroup
@@ -279,6 +291,9 @@ struct mem_cgroup {
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct wb_domain cgwb_domain;
 	struct memcg_cgwb_frn cgwb_frn[MEMCG_CGWB_FRN_CNT];
+	struct bdev_frn_flush_ctx bdev_frn[MEMCG_CGWB_FRN_CNT];
+	/* Nests inside mapping->i_pages in the dirty tracking path. */
+	spinlock_t frn_lock;
 #endif
 
 #ifdef CONFIG_LRU_GEN_WALKS_MMU
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1271d390b617..61ebe4ab744f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -39,6 +39,7 @@
 #include <linux/smp.h>
 #include <linux/page-flags.h>
 #include <linux/backing-dev.h>
+#include <linux/blkdev.h>
 #include <linux/bit_spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/limits.h>
@@ -104,6 +105,7 @@ static struct kmem_cache *memcg_pn_cachep;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
+static struct workqueue_struct *memcg_bdev_frn_wq __ro_after_init;
 #endif
 
 static inline bool task_is_dying(void)
@@ -3845,6 +3847,41 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	}
 }
 
+/*
+ * Bdev inodes are commonly shared by many memcgs. Flushing their owner wb
+ * can write unrelated file data, so record device numbers separately and
+ * flush only the bdev mappings. Tracking is best effort: record only dev_t
+ * without holding device or inode references, so it may race with device
+ * removal and re-addition.
+ */
+static void mem_cgroup_track_foreign_bdev(struct mem_cgroup *memcg, dev_t dev)
+{
+	struct bdev_frn_flush_ctx *ctx;
+	unsigned long flags;
+	int i;
+
+	/*
+	 * __folio_mark_dirty() takes mapping->i_pages with xa_lock_irqsave()
+	 * before reaching this helper. Use irqsave here as well so frn_lock's
+	 * IRQ protection does not depend on that outer locking.
+	 */
+	spin_lock_irqsave(&memcg->frn_lock, flags);
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		if (memcg->bdev_frn[i].dev == dev)
+			goto out;
+	}
+
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		ctx = &memcg->bdev_frn[i];
+		if (ctx->inflight)
+			continue;
+		ctx->dev = dev;
+		break;
+	}
+out:
+	spin_unlock_irqrestore(&memcg->frn_lock, flags);
+}
+
 /*
  * Foreign dirty flushing
  *
@@ -3875,17 +3912,17 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
  * most recent foreign dirtying events and initiating remote flushes on
  * them when local writeback isn't enough to keep the memory clean enough.
  *
- * The following two functions implement such mechanism.  When a foreign
- * page - a page whose memcg and writeback ownerships don't match - is
- * dirtied, mem_cgroup_track_foreign_dirty() records the inode owning
- * bdi_writeback on the page owning memcg.  When balance_dirty_pages()
- * decides that the memcg needs to sleep due to high dirty ratio, it calls
+ * For non-bdev inodes, when a foreign page - a page whose memcg and
+ * writeback ownerships don't match - is dirtied,
+ * mem_cgroup_track_foreign_dirty() records the inode owning bdi_writeback
+ * on the page owning memcg. When balance_dirty_pages() decides that the
+ * memcg needs to sleep due to high dirty ratio, it calls
  * mem_cgroup_flush_foreign() which queues writeback on the recorded
  * foreign bdi_writebacks which haven't expired.  Both the numbers of
  * recorded bdi_writebacks and concurrent in-flight foreign writebacks are
  * limited to MEMCG_CGWB_FRN_CNT.
  *
- * The mechanism only remembers IDs and doesn't hold any object references.
+ * These wb records only remember IDs and don't hold any object references.
  * As being wrong occasionally doesn't matter, updates and accesses to the
  * records are lockless and racy.
  */
@@ -3898,9 +3935,17 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 	u64 oldest_at = now;
 	int oldest = -1;
 	int i;
+	struct address_space *mapping = folio_mapping(folio);
+	struct inode *bdev_inode = mapping ? mapping->host : NULL;
 
 	trace_track_foreign_dirty(folio, wb);
 
+	if (memcg_bdev_frn_wq && bdev_inode &&
+	    sb_is_blkdev_sb(bdev_inode->i_sb)) {
+		mem_cgroup_track_foreign_bdev(memcg, bdev_inode->i_rdev);
+		return;
+	}
+
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
 	 * using it.  If not replace the oldest one which isn't being
@@ -3941,6 +3986,25 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 	}
 }
 
+static void bdev_frn_flush_work(struct work_struct *work)
+{
+	struct bdev_frn_flush_ctx *ctx =
+		container_of(work, struct bdev_frn_flush_ctx, work);
+	unsigned long flags;
+
+	bdev_flush_by_dev(ctx->dev);
+
+	/*
+	 * The dirty tracking path takes frn_lock while holding mapping->i_pages.
+	 * Disable local IRQs here to avoid deadlocks with I/O completion
+	 * handlers that also take mapping->i_pages.
+	 */
+	spin_lock_irqsave(&ctx->memcg->frn_lock, flags);
+	ctx->inflight = false;
+	ctx->dev = 0;
+	spin_unlock_irqrestore(&ctx->memcg->frn_lock, flags);
+}
+
 /* issue foreign writeback flushes for recorded foreign dirtying events */
 void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 {
@@ -3949,6 +4013,18 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 	u64 now = jiffies_64;
 	int i;
 
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct bdev_frn_flush_ctx *ctx = &memcg->bdev_frn[i];
+		unsigned long flags;
+
+		spin_lock_irqsave(&memcg->frn_lock, flags);
+		if (!ctx->inflight && ctx->dev) {
+			ctx->inflight = true;
+			queue_work(memcg_bdev_frn_wq, &ctx->work);
+		}
+		spin_unlock_irqrestore(&memcg->frn_lock, flags);
+	}
+
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
 		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
 
@@ -4202,9 +4278,15 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	memcg->kmemcg_id = -1;
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct bdev_frn_flush_ctx *ctx = &memcg->bdev_frn[i];
+
 		memcg->cgwb_frn[i].done =
 			__WB_COMPLETION_INIT(&memcg_cgwb_frn_waitq);
+		INIT_WORK(&ctx->work, bdev_frn_flush_work);
+		ctx->memcg = memcg;
+	}
+	spin_lock_init(&memcg->frn_lock);
 #endif
 	lru_gen_init_memcg(memcg);
 	return memcg;
@@ -4386,8 +4468,10 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
 		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+		flush_work(&memcg->bdev_frn[i].work);
+	}
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
@@ -5703,6 +5787,12 @@ int __init mem_cgroup_init(void)
 	memcg_wq = alloc_workqueue("memcg", WQ_PERCPU, 0);
 	WARN_ON(!memcg_wq);
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+	memcg_bdev_frn_wq = alloc_workqueue("memcg_bdev_frn_flusher",
+					    WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	WARN_ON(!memcg_bdev_frn_wq);
+#endif
+
 	for_each_possible_cpu(cpu) {
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_memcg_stock);
-- 
2.39.5

