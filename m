Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD147884F
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152607; cv=none; b=TznPnqf+LH83MXoUICUvfyb+V2DEvmHHRRXShUI5abH+Lo10Drg3s9S80vLSb1OrcSddL/vgpCPUa3l9ljhYTDZXpx92ovOjndLjXomjus5kkJdTtl/Sz9ukHaxZP3aKMJ7DN30sUyCAJhe3yRomcv6uV19O9MkmNhHfS58GazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152607; c=relaxed/simple;
	bh=OO/CgimJeS//PNAiuvFScdjA7H5LsP/0X7yItHI+emg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erE6nnB+bd+/QQraO4bmfWLoKmiVU9Uccs3w9OOvMFMdZtSwnnyvlmW/JnSX9ZqouVLDckTymY+PElpBh0ydbKtH5s3Moxk7eIra7Ppx5cmuVGhogrAR0CiDx3pki+Uhtpw9VmFzG9HVPNMYZOwcm4OUX4K1t5QnrtaO5xDmU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ6AxVmP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ6AxVmP"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so477020a12.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792152605; x=1792757405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qX4T5VNEZDCvos4GslZo2eKv8+vc1OatU8zENizVPSM=;
        b=FQ6AxVmPc2dHpb5Stm7SojG6mbighVco8cK0IEccLe1lGL4s0ZC93A0Yp5X4XuWPZ/
         Q2wfAqf613c1lB43szdhUP0IlxeM+BwftWPw0mcZMykrkj4vARJrr04qd2YjoE3HQrcv
         2CM18tmUc6aDrhSY/OF7Ok229QGZqCJPGrM53aQcJQf+/OorZkbBA8T7znSOcdCoheFy
         hk8+fSSL91xpuQORMgYvSUc/hH3HxNGlp2K+RfLgppjSOYiukp9J1BmwmeMYY92XPlua
         3ZU2h6qoum6EEU7qswx4LVo2XJbUZdMahi436tI6JSHrG7CSAn72LEmL5sMfcuf8lU4g
         TxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792152605; x=1792757405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qX4T5VNEZDCvos4GslZo2eKv8+vc1OatU8zENizVPSM=;
        b=2nS9o2qZKlmmtbqHZFk+1f/Bht6fTGBhjLs9ElnLJH2DbaEhT6wAhcEzVggVhnnJrU
         cxFBXbHhf7GGp3HQ1M2SsoX5r6vwxdrfjLQXJcE6UcNqO+GK9i4CwzdbsOMNU2G/dYP7
         Cdco9KECHeFvtL3etszBGHY5IPymzwRZinvvmRVAK7gfM2Da4MLdk27nbT09P9Zowgdt
         4edehrnOl+T81x7TVoMNympPJFHEWEIWwqpmHWHhxOE6openAd3XAgV3WaIPk5EeJs8Z
         wqCQvT/ZqbcdUy5Ucw9/8gozQqqn26SHqzhF0AXeSRoAmtE0mX8J85O7OdrCyPYu/u44
         XEPA==
X-Forwarded-Encrypted: i=1; AKwUvBw1SrTcyFwxysLGB0XBRMUIt28NMSR9fjtsGv1VIPhwHDLJx4/OpG4RRM8lh3WAMuWXifhd0lWRiJ8Gdg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLcfUfsR0dk47Q83acn+gnLnIMeMMloBVT6vvoIIgKQX3I+hgh0
	oF9MWa3uh2a1gBDuciWS7wryLD06ANEdQwgyiAVw7tPh1Z1kh4SHCcrU
X-Gm-Gg: AYBFou1rZnu0NvHlbVnd7TrufYl6Q64kdCNSoW6Aj9Z0GbUkKCSNWX7K2Bv2y84lwGw
	Haea5bM0nBALPRvrrNVJ1+nWvqikOmDkftRZDk0SjzNdFFL2h3we1r6KtvEzAm3z5mengXgtebd
	MdT9/RZJaSMIVnVPRrmUstyCG8JQH40XEJwq3jf3921o1CDb5tUZO1DuhGcYP98g728KPJTKESi
	J/jAeYy7pEEpYIm8MmIw5Kpqn1sWtXe4NHm8CtF9PD71Jk/7MmN+jeT2GUj2oxoxMIF0z7H54Mb
	f9cxSNPRETIwk5pSzWsrjWBStkJSRDhu6FBdNrRNjOxHAlbGG+/UDiagzQ0nhIYcc+3l93NWCVh
	RiTngAt2ZbpbqBO7sa0zoAhvxlOaegpPpC0dehYm6BRFbM7pAJJ4WuBVxZM/8cYEPkeYhXg/VKN
	9vq6gSVrf7HeLpDY48d2VmPZtsoA2a67Bynmqg0FjsMEUa9Ca7fMKTuv0cccfWdVneV0GVMgDJV
	yh0r+umjNc=
X-Received: by 2002:a17:90a:2cc4:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3acbb86e111mr1340061a91.28.1792152604741;
        Fri, 16 Oct 2026 05:10:04 -0700 (PDT)
Received: from hongfeng.mioffice.cn ([43.224.245.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f4cadsm3908912a91.12.2026.10.16.05.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:10:04 -0700 (PDT)
From: Hongfeng Chen <chenhongfeng0212@gmail.com>
X-Google-Original-From: Hongfeng Chen <hongfengchen@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Wenchao Hao <haowenchao@xiaomi.com>,
	Wenchao Hao <haowenchao22@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hongfeng Chen <hongfengchen@xiaomi.com>
Subject: [RFC PATCH v4 1/2] mm/zsmalloc: defer object free to per-cpu batches and a drain worker
Date: Fri, 16 Oct 2026 20:09:26 +0800
Message-ID: <20261016120927.3191690-2-hongfengchen@xiaomi.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unmapping a VMA full of swap entries makes the unmapping task free every
compressed object itself, one zs_free() call per page. On Android this
slows down the exit of a task killed to reclaim memory.

Instead of freeing the object right away, zs_free() appends its handle to
a per-cpu batch of 64 handles. A full batch goes to an unbound drain worker
through a lockless list, and the worker frees the objects. This batches the
release and moves it off the unmapping path, and the change stays within
zsmalloc.

Freeing empty zspages is left to the worker too: it does that directly when
it can take the page locks, and reuses kick_deferred_free() to free them
asynchronously when it cannot.

Failing to allocate the per-cpu state is not fatal: pool->defer stays NULL
and zs_free() keeps its old path.

Signed-off-by: Hongfeng Chen <hongfengchen@xiaomi.com>
---
 mm/zsmalloc.c | 182 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 154 insertions(+), 28 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7ef80e0da626..eacd771bd542 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -43,6 +43,7 @@
 #include <linux/zsmalloc.h>
 #include <linux/fs.h>
 #include <linux/workqueue.h>
+#include <linux/llist.h>
 #include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
@@ -267,6 +268,21 @@ struct link_free {
 static struct kmem_cache *handle_cachep;
 static struct kmem_cache *zspage_cachep;
 
+#define ZS_DEFER_BATCH	64
+
+struct zs_defer_batch {
+	struct llist_node node;
+	unsigned int count;
+	unsigned long handles[ZS_DEFER_BATCH];
+};
+
+struct zs_defer_percpu {
+	struct zs_defer_batch *active;
+	struct llist_head pending;
+	struct work_struct drain_work;
+	struct zs_pool *pool;
+};
+
 struct zs_pool {
 	const char *name;
 
@@ -282,12 +298,12 @@ struct zs_pool {
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
 #endif
-#ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
-#endif
 	/* protect zspage migration/compaction */
 	rwlock_t lock;
 	atomic_t compaction_in_progress;
+
+	struct zs_defer_percpu __percpu *defer;
 };
 
 static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
@@ -428,13 +444,11 @@ static bool ZsHugePage(struct zspage *zspage)
 	return zspage->huge;
 }
 
-#ifdef CONFIG_COMPACTION
 static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
+#ifdef CONFIG_COMPACTION
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static void kick_deferred_free(struct zs_pool *pool) {}
-static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 #endif
 
@@ -684,7 +698,6 @@ static inline void zs_pool_stat_destroy(struct zs_pool *pool)
 }
 #endif
 
-
 /*
  * For each size class, zspages are divided into different groups
  * depending on their usage ratio. This function returns fullness
@@ -1293,7 +1306,6 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	return obj;
 }
 
-
 /**
  * zs_malloc - Allocate block of given size from pool.
  * @pool: pool to allocate from
@@ -1371,7 +1383,6 @@ static void obj_free(int class_size, unsigned long obj)
 	unsigned int f_objidx;
 	void *vaddr;
 
-
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
 	f_offset = offset_in_page(class_size * f_objidx);
 	zspage = get_zspage(f_zpdesc);
@@ -1447,7 +1458,7 @@ static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long ha
 }
 #endif
 
-void zs_free(struct zs_pool *pool, unsigned long handle)
+static void __zs_free_one(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
 	unsigned long obj;
@@ -1455,9 +1466,6 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	int fullness;
 	struct zspage *zspage_to_free = NULL;
 
-	if (IS_ERR_OR_NULL((void *)handle))
-		return;
-
 	obj_class_get_and_lock(pool, handle, &obj, &zspage, &class);
 
 	class_stat_sub(class, ZS_OBJS_INUSE, 1);
@@ -1483,6 +1491,78 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	}
 	cache_free_handle(handle);
 }
+
+static void zs_defer_drain(struct zs_defer_percpu *defer)
+{
+	struct zs_pool *pool = defer->pool;
+	struct zs_defer_batch *batch, *n;
+	struct llist_node *first;
+
+	first = llist_del_all(&defer->pending);
+	llist_for_each_entry_safe(batch, n, first, node) {
+		unsigned int i;
+
+		for (i = 0; i < batch->count; i++)
+			__zs_free_one(pool, batch->handles[i]);
+		kfree(batch);
+		cond_resched();
+	}
+}
+
+static void zs_defer_drain_work(struct work_struct *work)
+{
+	zs_defer_drain(container_of(work, struct zs_defer_percpu, drain_work));
+}
+
+static bool zs_defer_push(struct zs_pool *pool, unsigned long handle)
+{
+	struct zs_defer_batch *new_batch = NULL, *batch;
+	struct zs_defer_percpu *defer;
+	bool queue = false;
+
+	if (!pool->defer)
+		return false;
+
+	defer = get_cpu_ptr(pool->defer);
+	if (!defer->active) {
+		put_cpu_ptr(pool->defer);
+		new_batch = kmalloc_obj(*new_batch, GFP_NOWAIT | __GFP_NOWARN);
+		if (!new_batch)
+			return false;
+		new_batch->count = 0;
+
+		defer = get_cpu_ptr(pool->defer);
+		if (!defer->active) {
+			defer->active = new_batch;
+			new_batch = NULL;
+		}
+	}
+
+	batch = defer->active;
+	batch->handles[batch->count++] = handle;
+	if (batch->count == ZS_DEFER_BATCH) {
+		llist_add(&batch->node, &defer->pending);
+		defer->active = NULL;
+		queue = true;
+	}
+	put_cpu_ptr(pool->defer);
+
+	if (unlikely(new_batch))
+		kfree(new_batch);
+
+	if (queue)
+		queue_work(system_dfl_wq, &defer->drain_work);
+	return true;
+}
+
+void zs_free(struct zs_pool *pool, unsigned long handle)
+{
+	if (IS_ERR_OR_NULL((void *)handle))
+		return;
+
+	if (!zs_defer_push(pool, handle))
+		__zs_free_one(pool, handle);
+}
 EXPORT_SYMBOL_GPL(zs_free);
 
 static void zs_object_copy(struct size_class *class, unsigned long dst,
@@ -1671,7 +1751,6 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
 	return fullness;
 }
 
-#ifdef CONFIG_COMPACTION
 /*
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
@@ -1714,6 +1793,8 @@ static void lock_zspage(struct zspage *zspage)
 	zspage_read_unlock(zspage);
 }
 
+#ifdef CONFIG_COMPACTION
+
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct zpdesc *newzpdesc, struct zpdesc *oldzpdesc)
 {
@@ -1866,6 +1947,18 @@ const struct movable_operations zsmalloc_mops = {
 	.putback_page = zs_page_putback,
 };
 
+static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
+{
+	struct zpdesc *zpdesc = get_first_zpdesc(zspage);
+
+	do {
+		WARN_ON(!zpdesc_trylock(zpdesc));
+		__zpdesc_set_movable(zpdesc);
+		zpdesc_unlock(zpdesc);
+	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
+}
+#endif /* CONFIG_COMPACTION */
+
 /*
  * Caller should hold page_lock of all pages in the zspage
  * In here, we cannot use zspage meta data.
@@ -1904,7 +1997,7 @@ static void async_free_zspage(struct work_struct *work)
 
 static void kick_deferred_free(struct zs_pool *pool)
 {
-	schedule_work(&pool->free_work);
+	queue_work(system_dfl_wq, &pool->free_work);
 }
 
 static void zs_flush_migration(struct zs_pool *pool)
@@ -1917,20 +2010,6 @@ static void init_deferred_free(struct zs_pool *pool)
 	INIT_WORK(&pool->free_work, async_free_zspage);
 }
 
-static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
-{
-	struct zpdesc *zpdesc = get_first_zpdesc(zspage);
-
-	do {
-		WARN_ON(!zpdesc_trylock(zpdesc));
-		__zpdesc_set_movable(zpdesc);
-		zpdesc_unlock(zpdesc);
-	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
-}
-#else
-static inline void zs_flush_migration(struct zs_pool *pool) { }
-#endif
-
 /*
  *
  * Based on the number of unused allocated objects calculate
@@ -2127,6 +2206,48 @@ static int calculate_zspage_chain_size(int class_size)
 	return chain_size;
 }
 
+static void zs_defer_destroy(struct zs_pool *pool)
+{
+	struct zs_defer_percpu __percpu *defer_pcp = pool->defer;
+	int cpu;
+
+	if (!defer_pcp)
+		return;
+
+	pool->defer = NULL;
+	for_each_possible_cpu(cpu) {
+		struct zs_defer_percpu *defer = per_cpu_ptr(defer_pcp, cpu);
+
+		cancel_work_sync(&defer->drain_work);
+		if (defer->active) {
+			llist_add(&defer->active->node, &defer->pending);
+			defer->active = NULL;
+		}
+		zs_defer_drain(defer);
+	}
+	free_percpu(defer_pcp);
+}
+
+static int zs_defer_init(struct zs_pool *pool)
+{
+	int cpu;
+
+	pool->defer = alloc_percpu(struct zs_defer_percpu);
+	if (!pool->defer)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct zs_defer_percpu *defer = per_cpu_ptr(pool->defer, cpu);
+
+		defer->active = NULL;
+		init_llist_head(&defer->pending);
+		defer->pool = pool;
+		INIT_WORK(&defer->drain_work, zs_defer_drain_work);
+	}
+
+	return 0;
+}
+
 /**
  * zs_create_pool - Creates an allocation pool to work from.
  * @name: pool name to be created
@@ -2151,6 +2272,10 @@ struct zs_pool *zs_create_pool(const char *name)
 	rwlock_init(&pool->lock);
 	atomic_set(&pool->compaction_in_progress, 0);
 
+	if (zs_defer_init(pool))
+		pr_info("deferred free unavailable for <%s>, freeing synchronously\n",
+			name);
+
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
 		goto err;
@@ -2253,6 +2378,7 @@ void zs_destroy_pool(struct zs_pool *pool)
 	int i;
 
 	zs_unregister_shrinker(pool);
+	zs_defer_destroy(pool);
 	zs_flush_migration(pool);
 	zs_pool_stat_destroy(pool);
 
-- 
2.54.0

