Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A8DF59
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315974; cv=none; b=TTJuMP5maXJJRqSoBEgrgvlVrPH1vEUa4OHPdxrwkLmNws5TEk7LseXfx06ivve43Ghs9O8AVFm0T9TMtEpZvM1XWNzoXlsdDdPf+mqXfoxbEx1XNztPrSnfglMCpmotOSJmZobaY6KjcUhg0f2m7VLWm2zrXXWe5FaLESMfvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315974; c=relaxed/simple;
	bh=Tan5srxpRJlIc/4svKct8lGcKWi6GKeMpjnth+Ge6a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G00Appy1eOswj/7DXE6G1Mw2wtJlZ3oUkgiTmNKHJiu8vAOdnOVIfsFOOrYPwvlSzuwUW2vvrDCzxNFrwZA/ig5RNHlOmD4S4BwMNcNb8NuytnkiQsC3YT0gnMemUnw3vNqBJ6CsK4ioWJY/Iua8/4D/z9bzBCd8sMsVYRl/sbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmzhV4J0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmzhV4J0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36627a0ea23so1054891a91.0
        for <linux-block@vger.kernel.org>; Sat, 09 May 2026 01:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778315972; x=1778920772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWYASY6BZuBGzOxx/4aApTWOR4/wdjoaLtz5Jpeyx+k=;
        b=HmzhV4J0N0KkBfWoGeOGK0M6ED9yfTTc9SbtVPMQtltt4MnMM8DWDOkHGkj5AtfuDH
         uquxZyIv4VGdKt1QBUsjsqDoS68NdzYuB+lDB8qCPGjmdtkC+BW6w9RCVPFzqdLbMCA+
         rlv4vM7IZL5OsOXIz0dEZjmNK6P8zGz0j2itwril1IEfr1hpfjdMT+maYbOFDc/kCu5x
         0qJkREQhBuzUcJOUs12Ft0i+dk+uZCXV3G0Y3kFsjdfiO7Gju49wLEmhI0GMHRdAUrDu
         YuWFK+jNih/KUx3bDfCIDij5AYP2BLa6ugJXAieWAPYh9/ixsYPSt7QT/WAabfJyfxSb
         n5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778315972; x=1778920772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWYASY6BZuBGzOxx/4aApTWOR4/wdjoaLtz5Jpeyx+k=;
        b=AZH6gqwi1Z8Ru5dY9NEdjCveXgqFIOvvEN8wSiIKs7BhSoJ4GDJ/4FHy2MV5bpFE/7
         TsPpTBZs1QVbCfImLjTo4qxXO7ykcPHEJSRLZ4UYn7sq7S5Lt/YYHJzcaSfAi6QzWCzu
         7lrtT+Qh9Uj/66Fuq1BUsi5prUM7/LV43alicqGv4DziGs7bBDmI5QGOFakIew7Z8WNR
         DKCcOBXuAmcZE6AvwPDWY5uZbfXYqFHvYyNifpOVcM6aiwkk4eO+7CAvKv8RueWHH9eH
         Va3u9N4gQ2zqaxWaRg9J1zqhYuaQkuQmcLEZLLZOprDmfzMsmcePB8iWOsdLQk0NE7sP
         jwFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fs1GM9GjbsIwLRUqeqSjAH5NTRd8JoPjban/t0qZu02I2HZxkWObAPlO/mPr3EHmQ6C0vDpdR2Z0npA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sr4ZCJMIKOop3bY3/LZtgJczckK9oSYYx8CFgTTx9CJgRMUx
	6rDFBL6DJnucAf4LOt/J9Q5iyrxI+Z1/DimhMfk87B35f4y+7G0zreDD
X-Gm-Gg: Acq92OFhIiTEkiecwKdXQS35yQxb1mIWTBrBncQqAaT3zQcyfS6b5JxWNkfnEvGUSmT
	x6B4E313RHK7/92FywcwbIKsZAsvvfp7t6MBxze1G+J5yW6gnuuVNSI5NgEAZ9Z+RnSnpX+adDS
	FdyUaBLnlDWws4NKwcsIWCF/Bk9K+8hCujz5Ye6sQWejuFtc95pZ7+nGSVSZkP2IRO23rd3XpHq
	hHICq9v0RH8JvtMVPWlRnPSjWPxUGSywhWIiHiQPvim8CKv+3cuNUD0YAxJX4mpZb5ZzXm1WmBb
	pO2i7vRdzljqVM9mC/Ki7fkKVhzHgYsCoYTVdY97oACR2PpSQqQDfATHQ51SVcgbpk3dsyPaZaB
	yfXuFh/BLrqTaEU8MS7iM4sYwP5Y+w++ert1FDcerCm3nN+lrx6D4eVFcv6vaUDEZe3Ibr35NLt
	jXIp5vWerB7l/0vGDj2eDn6s6EPaIdAZdARCNmka0OWIrf3gzY
X-Received: by 2002:a17:90b:2fcf:b0:35f:bfdd:f5a1 with SMTP id 98e67ed59e1d1-3664ccca3d8mr6141448a91.13.1778315971588;
        Sat, 09 May 2026 01:39:31 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d629c17esm1378291a91.6.2026.05.09.01.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:39:31 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: haowenchao22@gmail.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	axboe@kernel.dk,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	haowenchao@xiaomi.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	senozhatsky@chromium.org,
	yosry@kernel.org
Subject: Re: [RFC PATCH v3 0/4] mm/zsmalloc: per-cpu deferred free to accelerate swap entry release
Date: Sat,  9 May 2026 16:38:24 +0800
Message-Id: <20260509083824.2408724-1-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAOptpSPY3YL5VFJW9KKP99Yb17+_rdXKsKj93FdEn3_Zb350ow@mail.gmail.com>
References: <CAOptpSPY3YL5VFJW9KKP99Yb17+_rdXKsKj93FdEn3_Zb350ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The three patches below implement the zsmalloc-only variant --
deferring just zs_free(). They partially depend on the pool->lock
removal series, and also reduce the number of class->lock
acquire/release pairs on the drain path.

----- [1/3] mm/zsmalloc: introduce per-cpu deferred free with page pool -----

Introduce zs_free_deferred() that enqueues handles into per-cpu
buffers backed by single pages (PAGE_SIZE/8 entries each).

A pre-allocated page pool provides fresh pages for buffer swap on the
hot path without any allocation.  When a per-cpu buffer fills up, the
producer swaps in a page from the pool, moves the full page to a drain
list, and resets count — all within preempt_disable, no waiting for the
worker.

The drain worker runs on a WQ_UNBOUND workqueue to avoid preempting
the producer on its CPU.  It picks pages off the drain list one at a
time, drains them using consecutive-class batching (holding class->lock
across runs of same-class handles), and returns drained pages to the
pool.  It processes at most pool_size/2 pages per invocation to avoid
monopolizing CPU, rescheduling itself if more pages remain.

Extract __zs_free_handle() from zs_free() as the locked free primitive
shared by both synchronous and deferred paths.  Empty zspages are
collected on a list and released after dropping class->lock.

Also introduce zs_free_deferred_flush() for use before zs_compact()
and zs_deferred_free_all() for pool teardown.

Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 include/linux/zsmalloc.h |   2 +
 mm/zsmalloc.c            | 342 +++++++++++++++++++++++++++++++++++----
 2 files changed, 316 insertions(+), 28 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 478410c880b1..1e5ac1a39d41 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -30,6 +30,8 @@ void zs_destroy_pool(struct zs_pool *pool);
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
 			const int nid);
 void zs_free(struct zs_pool *pool, unsigned long obj);
+void zs_free_deferred(struct zs_pool *pool, unsigned long handle);
+void zs_free_deferred_flush(struct zs_pool *pool);
 
 size_t zs_huge_class_size(struct zs_pool *pool);
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 176d3ad4f6e9..f483937cf34f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -42,6 +42,7 @@
 #include <linux/zsmalloc.h>
 #include <linux/fs.h>
 #include <linux/workqueue.h>
+#include <linux/percpu.h>
 #include "zpdesc.h"
 
 #define ZSPAGE_MAGIC	0x58
@@ -56,6 +57,9 @@
 
 #define ZS_HANDLE_SIZE (sizeof(unsigned long))
 
+#define ZS_DEFERRED_BUF_ENTRIES	(PAGE_SIZE / sizeof(unsigned long))
+#define ZS_DEFERRED_POOL_SIZE	(256 * 1024 / PAGE_SIZE)
+
 /*
  * Object location (<PFN>, <obj_idx>) is encoded as
  * a single (unsigned long) handle value.
@@ -174,6 +178,7 @@ static_assert(_PFN_BITS + OBJ_CLASS_BITS_NEEDED + OBJ_IDX_BITS_NEEDED
 #define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
 				      ZS_SIZE_CLASS_DELTA) + 1)
 
+
 /*
  * Pages are distinguished by the ratio of used memory (that is the ratio
  * of ->inuse objects to all objects that page can store). For example,
@@ -246,6 +251,11 @@ struct link_free {
 	};
 };
 
+struct zs_deferred_percpu {
+	unsigned int count;
+	unsigned long *handles;
+};
+
 static struct kmem_cache *handle_cachep;
 static struct kmem_cache *zspage_cachep;
 
@@ -270,6 +280,20 @@ struct zs_pool {
 	/* protect zspage migration/compaction */
 	rwlock_t lock;
 	atomic_t compaction_in_progress;
+
+	/* per-cpu deferred free */
+	struct zs_deferred_percpu __percpu *deferred;
+	struct work_struct deferred_drain_work;
+	struct workqueue_struct *drain_wq;
+
+	/* page pool: free pages available for buffer swap */
+	struct list_head page_pool;
+	unsigned int page_pool_count;
+	spinlock_t page_pool_lock;
+
+	/* drain list: full pages waiting to be drained */
+	struct list_head drain_list;
+	spinlock_t drain_list_lock;
 };
 
 static inline void zpdesc_set_first(struct zpdesc *zpdesc)
@@ -788,12 +812,6 @@ static unsigned int obj_to_class_idx(unsigned long obj)
 	return (obj >> OBJ_IDX_BITS) & OBJ_CLASS_MASK;
 }
 
-/**
- * location_to_obj - encode (<zpdesc>, <obj_idx>, <class_idx>) into obj value
- * @zpdesc: zpdesc object resides in zspage
- * @obj_idx: object index
- * @class_idx: size class index
- */
 static unsigned long location_to_obj(struct zpdesc *zpdesc, unsigned int obj_idx,
 				     unsigned int class_idx)
 {
@@ -1454,23 +1472,14 @@ static void obj_free(int class_size, unsigned long obj)
 	mod_zspage_inuse(zspage, -1);
 }
 
-void zs_free(struct zs_pool *pool, unsigned long handle)
+static void __zs_free_handle(struct zs_pool *pool, struct size_class *class,
+			     unsigned long handle, struct list_head *free_list)
 {
-	struct zspage *zspage;
-	struct zspage *zspage_to_free = NULL;
 	struct zpdesc *f_zpdesc;
+	struct zspage *zspage;
 	unsigned long obj;
-	struct size_class *class;
 	int fullness;
 
-	if (IS_ERR_OR_NULL((void *)handle))
-		return;
-
-	obj = handle_to_obj(handle);
-	class = pool->size_class[obj_to_class_idx(obj)];
-
-	spin_lock(&class->lock);
-
 	obj = handle_to_obj(handle);
 	obj_to_zpdesc(obj, &f_zpdesc);
 	zspage = get_zspage(f_zpdesc);
@@ -1480,31 +1489,231 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 
 	fullness = fix_fullness_group(class, zspage);
 	if (fullness == ZS_INUSE_RATIO_0) {
-		/*
-		 * Perform bookkeeping under class->lock, but defer the
-		 * actual page release (which may contend on zone->lock)
-		 * until after dropping class->lock.
-		 */
 		if (trylock_zspage(zspage)) {
 			remove_zspage(class, zspage);
 			class_stat_sub(class, ZS_OBJS_ALLOCATED,
 				       class->objs_per_zspage);
 			atomic_long_sub(class->pages_per_zspage,
 					&pool->pages_allocated);
-			zspage_to_free = zspage;
+			list_add(&zspage->list, free_list);
 		} else {
 			kick_deferred_free(pool);
 		}
 	}
+}
 
+static void free_zspage_list(struct zs_pool *pool, struct list_head *list)
+{
+	struct zspage *zspage, *tmp;
+
+	list_for_each_entry_safe(zspage, tmp, list, list) {
+		list_del(&zspage->list);
+		free_zspage_pages(pool, zspage);
+	}
+}
+
+void zs_free(struct zs_pool *pool, unsigned long handle)
+{
+	struct size_class *class;
+	unsigned long obj;
+	LIST_HEAD(free_list);
+
+	if (IS_ERR_OR_NULL((void *)handle))
+		return;
+
+	obj = handle_to_obj(handle);
+	class = pool->size_class[obj_to_class_idx(obj)];
+	spin_lock(&class->lock);
+
+	__zs_free_handle(pool, class, handle, &free_list);
 	spin_unlock(&class->lock);
 
-	if (zspage_to_free)
-		free_zspage_pages(pool, zspage_to_free);
+	free_zspage_list(pool, &free_list);
 	cache_free_handle(handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
 
+static void zs_deferred_drain_batch(struct zs_pool *pool,
+				    unsigned long *handles, unsigned int count)
+{
+	struct size_class *class = NULL;
+	unsigned int cur_cls = UINT_MAX;
+	LIST_HEAD(free_list);
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		unsigned long obj = handle_to_obj(handles[i]);
+		unsigned int cls = obj_to_class_idx(obj);
+
+		if (cls != cur_cls) {
+			if (class) {
+				spin_unlock(&class->lock);
+				free_zspage_list(pool, &free_list);
+				cond_resched();
+			}
+			cur_cls = cls;
+			class = pool->size_class[cls];
+			spin_lock(&class->lock);
+		}
+		__zs_free_handle(pool, class, handles[i], &free_list);
+	}
+
+	if (class) {
+		spin_unlock(&class->lock);
+		free_zspage_list(pool, &free_list);
+	}
+
+	for (i = 0; i < count; i++)
+		cache_free_handle(handles[i]);
+}
+
+static struct page *deferred_pool_get(struct zs_pool *pool)
+{
+	struct page *page = NULL;
+
+	spin_lock(&pool->page_pool_lock);
+	if (!list_empty(&pool->page_pool)) {
+		page = list_first_entry(&pool->page_pool, struct page, lru);
+		list_del(&page->lru);
+		pool->page_pool_count--;
+	}
+	spin_unlock(&pool->page_pool_lock);
+	return page;
+}
+
+static void deferred_pool_put(struct zs_pool *pool, struct page *page)
+{
+	spin_lock(&pool->page_pool_lock);
+	list_add_tail(&page->lru, &pool->page_pool);
+	pool->page_pool_count++;
+	spin_unlock(&pool->page_pool_lock);
+}
+
+static void deferred_drain_enqueue(struct zs_pool *pool, struct page *page)
+{
+	spin_lock(&pool->drain_list_lock);
+	list_add_tail(&page->lru, &pool->drain_list);
+	spin_unlock(&pool->drain_list_lock);
+}
+
+static struct page *deferred_drain_dequeue(struct zs_pool *pool)
+{
+	struct page *page = NULL;
+
+	spin_lock(&pool->drain_list_lock);
+	if (!list_empty(&pool->drain_list)) {
+		page = list_first_entry(&pool->drain_list, struct page, lru);
+		list_del(&page->lru);
+	}
+	spin_unlock(&pool->drain_list_lock);
+	return page;
+}
+
+static void zs_deferred_drain_work(struct work_struct *work)
+{
+	struct zs_pool *pool = container_of(work, struct zs_pool,
+					    deferred_drain_work);
+	struct page *page;
+	unsigned int drained = 0;
+	unsigned int max_drain = ZS_DEFERRED_POOL_SIZE / 2;
+
+	while (drained < max_drain) {
+		page = deferred_drain_dequeue(pool);
+		if (!page)
+			break;
+
+		zs_deferred_drain_batch(pool, page_address(page),
+					ZS_DEFERRED_BUF_ENTRIES);
+		deferred_pool_put(pool, page);
+		drained++;
+		cond_resched();
+	}
+
+	/* If drain list still has pages, reschedule */
+	spin_lock(&pool->drain_list_lock);
+	if (!list_empty(&pool->drain_list))
+		queue_work(pool->drain_wq, &pool->deferred_drain_work);
+	spin_unlock(&pool->drain_list_lock);
+}
+
+void zs_free_deferred(struct zs_pool *pool, unsigned long handle)
+{
+	struct zs_deferred_percpu *def;
+	struct page *new_page, *full_page;
+	bool queued = false;
+
+	if (IS_ERR_OR_NULL((void *)handle))
+		return;
+
+	def = get_cpu_ptr(pool->deferred);
+
+	if (likely(def->count < ZS_DEFERRED_BUF_ENTRIES)) {
+		def->handles[def->count++] = handle;
+		queued = true;
+		if (def->count < ZS_DEFERRED_BUF_ENTRIES) {
+			put_cpu_ptr(pool->deferred);
+			return;
+		}
+	}
+
+	/* Buffer is full, try to swap in a fresh page */
+	new_page = deferred_pool_get(pool);
+	if (new_page) {
+		full_page = virt_to_page(def->handles);
+		def->handles = page_address(new_page);
+		def->count = 0;
+		if (!queued)
+			def->handles[def->count++] = handle;
+		put_cpu_ptr(pool->deferred);
+		deferred_drain_enqueue(pool, full_page);
+		queue_work(pool->drain_wq, &pool->deferred_drain_work);
+		return;
+	}
+	put_cpu_ptr(pool->deferred);
+
+	if (!queued)
+		zs_free(pool, handle);
+}
+EXPORT_SYMBOL_GPL(zs_free_deferred);
+
+/*
+ * Called only from zs_destroy_pool() when no producers are running.
+ * Drains all per-cpu buffers regardless of whether they are full.
+ */
+static void zs_deferred_free_all(struct zs_pool *pool)
+{
+	struct page *page;
+	int cpu;
+
+	flush_work(&pool->deferred_drain_work);
+
+	/* Drain remaining pages on drain list */
+	while ((page = deferred_drain_dequeue(pool)) != NULL) {
+		zs_deferred_drain_batch(pool, page_address(page),
+					ZS_DEFERRED_BUF_ENTRIES);
+		deferred_pool_put(pool, page);
+	}
+
+	/* Drain partially-filled per-cpu buffers */
+	for_each_possible_cpu(cpu) {
+		struct zs_deferred_percpu *def;
+		unsigned int count;
+
+		def = per_cpu_ptr(pool->deferred, cpu);
+		count = def->count;
+		if (!count)
+			continue;
+		zs_deferred_drain_batch(pool, def->handles, count);
+		def->count = 0;
+	}
+}
+
+void zs_free_deferred_flush(struct zs_pool *pool)
+{
+	flush_work(&pool->deferred_drain_work);
+}
+EXPORT_SYMBOL_GPL(zs_free_deferred_flush);
+
 static void zs_object_copy(struct size_class *class, unsigned long dst,
 				unsigned long src)
 {
@@ -2053,6 +2262,8 @@ unsigned long zs_compact(struct zs_pool *pool)
 	if (atomic_xchg(&pool->compaction_in_progress, 1))
 		return 0;
 
+	zs_free_deferred_flush(pool);
+
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
 		if (class->index != i)
@@ -2161,9 +2372,11 @@ static int calculate_zspage_chain_size(int class_size)
  */
 struct zs_pool *zs_create_pool(const char *name)
 {
-	int i;
+	int i, cpu;
+	unsigned int pg_idx;
 	struct zs_pool *pool;
 	struct size_class *prev_class = NULL;
+	struct page *page, *tmp;
 
 	pool = kzalloc_obj(*pool);
 	if (!pool)
@@ -2172,11 +2385,67 @@ struct zs_pool *zs_create_pool(const char *name)
 	init_deferred_free(pool);
 	rwlock_init(&pool->lock);
 	atomic_set(&pool->compaction_in_progress, 0);
+	INIT_WORK(&pool->deferred_drain_work, zs_deferred_drain_work);
+
+	pool->drain_wq = alloc_workqueue("zs_drain", WQ_UNBOUND, 0);
+	if (!pool->drain_wq) {
+		kfree(pool);
+		return NULL;
+	}
+
+	/* Initialize page pool and drain list */
+	INIT_LIST_HEAD(&pool->page_pool);
+	spin_lock_init(&pool->page_pool_lock);
+	pool->page_pool_count = 0;
+	INIT_LIST_HEAD(&pool->drain_list);
+	spin_lock_init(&pool->drain_list_lock);
+
+	for (pg_idx = 0; pg_idx < ZS_DEFERRED_POOL_SIZE; pg_idx++) {
+		page = alloc_page(GFP_KERNEL);
+		if (!page)
+			goto err_pool_pages;
+		list_add_tail(&page->lru, &pool->page_pool);
+		pool->page_pool_count++;
+	}
+
+	pool->deferred = alloc_percpu(struct zs_deferred_percpu);
+	if (!pool->deferred)
+		goto err_pool_pages;
+	for_each_possible_cpu(cpu) {
+		struct zs_deferred_percpu *def = per_cpu_ptr(pool->deferred, cpu);
+
+		page = deferred_pool_get(pool);
+		if (!page) {
+			for_each_possible_cpu(cpu) {
+				def = per_cpu_ptr(pool->deferred, cpu);
+				if (def->handles)
+					deferred_pool_put(pool,
+						virt_to_page(def->handles));
+			}
+			free_percpu(pool->deferred);
+			goto err_pool_pages;
+		}
+		def->handles = page_address(page);
+		def->count = 0;
+	}
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
 		goto err;
 
+	goto pool_init_done;
+
+err_pool_pages:
+	list_for_each_entry_safe(page, tmp, &pool->page_pool, lru) {
+		list_del(&page->lru);
+		__free_page(page);
+	}
+	destroy_workqueue(pool->drain_wq);
+	kfree(pool);
+	return NULL;
+
+pool_init_done:
+
 	/*
 	 * Iterate reversely, because, size of size_class that we want to use
 	 * for merging should be larger or equal to current size.
@@ -2272,9 +2541,11 @@ EXPORT_SYMBOL_GPL(zs_create_pool);
 
 void zs_destroy_pool(struct zs_pool *pool)
 {
-	int i;
+	int i, cpu;
+	struct page *page, *tmp;
 
 	zs_unregister_shrinker(pool);
+	zs_deferred_free_all(pool);
 	zs_flush_migration(pool);
 	zs_pool_stat_destroy(pool);
 
@@ -2298,6 +2569,21 @@ void zs_destroy_pool(struct zs_pool *pool)
 		kfree(class);
 	}
 
+	/* Return per-cpu buffers to page pool */
+	for_each_possible_cpu(cpu) {
+		struct zs_deferred_percpu *def = per_cpu_ptr(pool->deferred, cpu);
+
+		if (def->handles)
+			deferred_pool_put(pool, virt_to_page(def->handles));
+	}
+
+	/* Free all pages in page pool */
+	list_for_each_entry_safe(page, tmp, &pool->page_pool, lru) {
+		list_del(&page->lru);
+		__free_page(page);
+	}
+	free_percpu(pool->deferred);
+	destroy_workqueue(pool->drain_wq);
 	kfree(pool->name);
 	kfree(pool);
 }


----- [2/3] mm/zswap: use zs_free_deferred() in entry free path -----

Replace zs_free() with zs_free_deferred() in zswap_entry_free() to
avoid the overhead of zsmalloc class->lock and potential zone->lock
contention in the zswap invalidation/reclaim hot path.

The store failure path still uses zs_free() directly since it is not
performance critical.

Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 4b5149173b0e..f2a38c07579f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -765,7 +765,7 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zs_free(entry->pool->zs_pool, entry->handle);
+	zs_free_deferred(entry->pool->zs_pool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);


----- [3/3] zram: defer zs_free() in swap slot free notification path -----

zram_slot_free_notify() is called on the process exit path when
unmapping swap entries.  The zs_free() it invokes accounts for ~87%
of slot_free() cost due to zsmalloc locking, blocking memory release
during Android low-memory killing.

Split slot_free() into slot_free_extract() and the actual zs_free():

  slot_free_extract() handles slot metadata cleanup (flags, stats,
  handle/size zeroing) and returns the zsmalloc handle.

  The returned handle is passed to zs_free_deferred() in the
  notification path, deferring the expensive zs_free() to a
  workqueue so the exit path can release anon folios faster.

All other slot_free() callers (write, discard, meta_free) continue
to use synchronous zs_free() through the unchanged slot_free().

Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 drivers/block/zram/zram_drv.c | 41 ++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..c67a7442d283 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2000,24 +2000,26 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	return true;
 }
 
-static void slot_free(struct zram *zram, u32 index)
+/*
+ * Clear slot metadata and extract the zsmalloc handle that needs freeing.
+ * Returns the handle, or 0 if no zsmalloc free is required (e.g. same-filled
+ * or writeback slots).
+ */
+#define ZRAM_SLOT_CLEAR_MASK \
+	(BIT(ZRAM_IDLE) | BIT(ZRAM_INCOMPRESSIBLE) | BIT(ZRAM_PP_SLOT) | \
+	 (ZRAM_COMP_PRIORITY_MASK << ZRAM_COMP_PRIORITY_BIT1))
+
+static unsigned long slot_free_extract(struct zram *zram, u32 index)
 {
-	unsigned long handle;
+	unsigned long handle = 0;
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].attr.ac_time = 0;
 #endif
 
-	clear_slot_flag(zram, index, ZRAM_IDLE);
-	clear_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
-	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
-	set_slot_comp_priority(zram, index, 0);
+	zram->table[index].attr.flags &= ~ZRAM_SLOT_CLEAR_MASK;
 
 	if (test_slot_flag(zram, index, ZRAM_HUGE)) {
-		/*
-		 * Writeback completion decrements ->huge_pages but keeps
-		 * ZRAM_HUGE flag for deferred decompression path.
-		 */
 		if (!test_slot_flag(zram, index, ZRAM_WB))
 			atomic64_dec(&zram->stats.huge_pages);
 		clear_slot_flag(zram, index, ZRAM_HUGE);
@@ -2029,10 +2031,6 @@ static void slot_free(struct zram *zram, u32 index)
 		goto out;
 	}
 
-	/*
-	 * No memory is allocated for same element filled pages.
-	 * Simply clear same page flag.
-	 */
 	if (test_slot_flag(zram, index, ZRAM_SAME)) {
 		clear_slot_flag(zram, index, ZRAM_SAME);
 		atomic64_dec(&zram->stats.same_pages);
@@ -2041,9 +2039,7 @@ static void slot_free(struct zram *zram, u32 index)
 
 	handle = get_slot_handle(zram, index);
 	if (!handle)
-		return;
-
-	zs_free(zram->mem_pool, handle);
+		return 0;
 
 	atomic64_sub(get_slot_size(zram, index),
 		     &zram->stats.compr_data_size);
@@ -2051,6 +2047,15 @@ static void slot_free(struct zram *zram, u32 index)
 	atomic64_dec(&zram->stats.pages_stored);
 	set_slot_handle(zram, index, 0);
 	set_slot_size(zram, index, 0);
+
+	return handle;
+}
+
+static void slot_free(struct zram *zram, u32 index)
+{
+	unsigned long handle = slot_free_extract(zram, index);
+
+	zs_free(zram->mem_pool, handle);
 }
 
 static int read_same_filled_page(struct zram *zram, struct page *page,
@@ -2797,7 +2802,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 		return;
 	}
 
-	slot_free(zram, index);
+	zs_free_deferred(zram->mem_pool, slot_free_extract(zram, index));
 	slot_unlock(zram, index);
 }
