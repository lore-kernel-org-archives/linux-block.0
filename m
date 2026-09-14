Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55343B3E6
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381892; cv=none; b=Xw5i+zFD3scBxYRj31Rgtu2tXeRh07uk5rumefBwDoGtRkB3MRqrD39FkP2wKEhpv9Jo1JqLR0+iBHrrFaXj5SBxU/Bpe3Ge3FU7poXYW5Uj373oTz+N9KyMTZN+JfDM8MNh3zNR4NW0i5aeGDCCa1wRM5s0eaIA2QrC4d/Z20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381892; c=relaxed/simple;
	bh=n4GVYqrhV8B4z2UM8kWFXoO8SeI+JmSm6Iws5RWHH9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knNm8XkBs4G8J7hO2FtXNjFeHTC+NbtxJDWrR6kSJyjWqfqnjJzNysRSgEpN7RrpltjKzSuGlIJAs9olVpSSoh7V4WwXYrfoBVfvkEgYkZNmts2A84T1ghHTs77k66pi5RxuGf7U8emIfGA4PtkOAeY6kkIBMWEh2iW9IPjnl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fWLO6zDc; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fWLO6zDc"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so371021b3a.0
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789381890; x=1789986690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X1j3rdPcItkrb0A0V7aqmh+RRcAizWY1ryEbRr0PGbE=;
        b=fWLO6zDcbGq04Nej8/0ScBaePAJdP0oaaCYPUrZGazScC8hUE8IIZYq2p5rlPfDJse
         PREW6rvz7IFyvPw8ukypNW9HvWuuY1Dm8waLxV5pi5NZgt88si/Lo737z8eRH7HmEZ+j
         psc0UAdPq2nTN6PnZX8oKuOiKZevmsZvnDLX579Ga93srj5pSu9rTvtlUw/PL2h2n+DR
         1eJaPR4MlCVLTpd8TSYwlXsvlllbmSZ9//bHtkn9glURe6E4LjAvSqdbM08HUyHvc0j7
         S5eWKMD3iITSdSyKOeti4R5ykYuFHKEA8m8N+7ifqeaoPVUTWA1FaxMxEUAe9kqz6DSo
         cPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381890; x=1789986690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X1j3rdPcItkrb0A0V7aqmh+RRcAizWY1ryEbRr0PGbE=;
        b=FaEP7RHg17guljkou4I3qqr/X3yPxchRxp2unwlhULh03d1K2Y259lk15Xf+xHXSiQ
         60qb3CE0MrApoajx+xhBQjjF+p6ZKjf4CS93R16re4DoQBo5obA8EpajrJehb57bGmes
         lexF/IMHIt0/dkH+mpC1gcQ8OU4tbh0HdnHCK7TpicbgnUnigmBYcNZZ4q8VU4//92Pv
         SCuEmNgV8+Ev+6QJ9WcKl4Yuis4vDUgmminSEqyFCn5Eg/hly5nJ3Qp85MNJ4HWMcUK+
         znXcheRbAUrshMc/NiO+ZAUrcKFBAI4t5MRvdp1kS0+dIysIJgYB4IWMBAAxj4nFrAW8
         8gug==
X-Gm-Message-State: AFuF++mY8q/yFExn3mRkyL2L1h8ZfFYKVN272Dq99GQWtx5uVqI2wSpT
	Nn14gPIwfIjLJxWRyHyC0CuX7JYETPWo3JOj5wTHE83LfHcEUY4tvRqQXAqbzovgOvD66lczNfE
	B4zpS8jU=
X-Gm-Gg: AYBFou3mblvENz4/Fa6V/Kxmg3OSuG7ehjV6+LwCKS69Rh2Qo38l5VNfcdyDupAl/+U
	DsiqZO2YyEuQU9xBZWAA3JlU3YwpcZGc591mWRhNqVg7/Va2clq9fpq/tbutUn8RbvIs1AYN9yB
	VcMA3COr3kjbvQqfcDfA4JSLJ0hO0PTu5I4pS7KTBewRkgrEMijg9iI02nleun51ijk1aGYdr7G
	YguLa2HsqVZwIkQvGCtI3MpFv8e6HuFVAYizfRDOGbeMMHJIbrcCRZrgQMEame/i/SsmyqBTNqL
	2QMt44PK4mQUhZuVoefqSRWzv1EhUafz7ecxUedoMsX2tBkZQls79BoKWL5Vcqla4yZhslnIWrY
	C2AvmxyoIudWsrEU1AAkGg3T8R3Ncp/OfqpFbXyfmhB5S7HG8aPI4PNBBCFJ0Tplyfkeu9WinDZ
	/m0fX18PbdUyx940ZCGl83A7g/dR90Uyn3UmGa4qpW8UNf2dJYwnM1xbii0JU05VjuIditVKjsu
	g==
X-Received: by 2002:a05:6a21:3991:b0:3db:10ef:b389 with SMTP id adf61e73a8af0-3db3f0e7a40mr2742144637.6.1789381889630;
        Mon, 14 Sep 2026 03:31:29 -0700 (PDT)
Received: from localhost ([106.38.226.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6549d95sm4615702a12.12.2026.09.14.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:31:29 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	rostedt@goodmis.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v4 2/3] memcg,writeback: flush foreign bdev mappings separately from owner wbs
Date: Mon, 14 Sep 2026 18:31:18 +0800
Message-Id: <20260914103119.1708452-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260914103119.1708452-1-sunjunchao@bytedance.com>
References: <20260914103119.1708452-1-sunjunchao@bytedance.com>
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
index 7d1c0ce189a8..d44d3ce51b50 100644
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
+	/* Nests inside mapping->i_pages. */
+	spinlock_t frn_lock;
 #endif
 
 #ifdef CONFIG_LRU_GEN_WALKS_MMU
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1271d390b617..aac8c893d7d2 100644
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
+static struct workqueue_struct *memcg_bdev_frn_flusher __ro_after_init;
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
 
+	if (memcg_bdev_frn_flusher && bdev_inode &&
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
+			queue_work(memcg_bdev_frn_flusher, &ctx->work);
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
+	memcg_bdev_frn_flusher = alloc_workqueue("memcg_bdev_frn_flusher",
+					       WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	WARN_ON(!memcg_bdev_frn_flusher);
+#endif
+
 	for_each_possible_cpu(cpu) {
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_memcg_stock);
-- 
2.39.5

