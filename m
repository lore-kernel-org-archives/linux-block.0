Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76F2D7DC6
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220524; cv=none; b=LKOluth1/xeVctRPQf1XkMzVX0ga+GHNS3BTTnyLVLpdFntNKNGmCMRJ+zoNh/o7UY8atJ+etnHPjLE9dbFQvRkBDJAYzcQ8UjksZGEeRsVUk5JpS2LeNZ+IBWfmIuhObTMAU/SRelia8M76KSWY+cpFqfde2nAZSszxgN/at2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220524; c=relaxed/simple;
	bh=Usoh5lWjXatpqgQTm5AyAXJm7U5sj7zKAQ3IUH2LUhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUSwASsXd0rlbmAUTRWEh32OV7p8fzFtHNet2n6490BKkO3yh8Tm5DaaxJLt17uaW3K/j9KF1iT3pECHFXWCF6qJiWM/2dsmGgEeofKO/VODke9C2htPTJ8q+NkYsx3uuVmKr5LORHll0QZ4Jx++ZgBMiRvpqsJRiPYEO65kJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO8G6m9N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO8G6m9N"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso893001a91.1
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778220516; x=1778825316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daHGfdxKfsNdfAdW1qTjK0dkvxPd9/EICvnVIHa78Qk=;
        b=hO8G6m9Ng0J/R2TAAZwBTQG4xe9bFfPbxns9MkRLnBjiO3q3SbQtGC8VAjB5QOSodt
         BO4g8S0vT53LR73bm4nidva+H8jJTktb8ZJweB/JRyuwetNlBDH/3h+qaGiCSDKYvtHU
         phwPU8mG3otKvmsXVpYRXWOdehE84FubEWvLzDKWAJ6+6ENx6hKw8xO92QgWkGP4VCv1
         DL9MYVdSazLHN6i0nZNodKKrtANoKgFPfZD78skksp5g5VIeYPOoZc/L1exkYdOu+55P
         DWK84AiZ8+FtiRhQeyLhiUf4a474Bua0mZ2VW+xjTCXWCkZPMoOJlxChMreJJNtNGBLL
         qbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220516; x=1778825316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=daHGfdxKfsNdfAdW1qTjK0dkvxPd9/EICvnVIHa78Qk=;
        b=Gvj3TkbRRHdrVg+7/9Q3j21fUOEZdK/OCEjUYRJHiF0kJEhROseo9jzTaBJQX6f3FX
         SNuC/h8Q5x4Zm2qdBBGSSMMW6aPZAbVw/GodAttAFpffUVy58PCnjEdiu6y2a4wFKQ4H
         GOzkkRoxMgFXXszBxh8/rQJAppv1pi2PJOSl0K8fnKNTGZ+tYoAadkVejQ9SEgV2Uldi
         tqfawLnb026n2UYJRdV4T1Ei695yf10HesvdigP0PqwBjnwZk0dftmwGz+wWUcEc1Bb6
         oWggH9gQy20X9zuCulgCTM+Ay5rdKj4OSj+Hl5FkttdoWhrpTNZcV7QmzzCmEJ7cRcrb
         oh9A==
X-Forwarded-Encrypted: i=1; AFNElJ/WTyySEcRupUCCWSXIo9AyWDIx3mp91vYjz83Z677F19tOiEEfgCwyKjwhZTbJcDQEhgVedNw2DKIGhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6RvJshl46ENR4xMqsQBloMW1rWx3gsYp4I10W0T0BWchs1Ez
	XH5l6pkhVYc1mzCtWWfALpOuBT+ZzEPbukHdBaEl2Cvp6nc+ABpM+aS/
X-Gm-Gg: Acq92OHqDDo72m4Lt5IfmJjClx0is/Gki4UH9zt+RXnhYELmrUOcxZ8KCI5blaVegBN
	1K0xTPU8q8sxsZqzPtE04fpM4j/D08cg7NSna1jLl4Y+Q7SLvdj7KUCVziNqfADlkv3tt0WwzJB
	m+1s11L1719KmDc/bCxUYT9s9n7knkIvshjm5gx4Rmr6dnDOcKqRzxeakvAVtCukvEZRAw8QNn/
	Y7rJP+AxbFLgFzQfrKwzf88AQFpnVYEaXQ+NduJB6+0Sf3jrcRkdt9y5WmNz0RnT53A034CCRwe
	VoBZlbJnNbyD5uOLKD2FCSnU06rrupkTiEl8+Bboop5TW29Y8SujZCBEYk7qTEnynfsHGeo2xhD
	H78PgTD/fvYWhU7eHG3Gd4atEvH8FrLRzJD593poShiX7heLXUlBhd7a6OyM0+84hlTqPJxnIJQ
	1JeYqDv/iuhOkU4nCXjW2IedgdqLaFQek4T/Q+ucjmhcnUyhqT
X-Received: by 2002:a17:90b:5486:b0:35f:b230:5889 with SMTP id 98e67ed59e1d1-366053e90a9mr5119623a91.6.1778220515779;
        Thu, 07 May 2026 23:08:35 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36645bb9c02sm673651a91.1.2026.05.07.23.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:08:35 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Cc: Wenchao Hao <haowenchao22@gmail.com>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v3 1/4] mm/zsmalloc: introduce deferred free framework with callback ops
Date: Fri,  8 May 2026 14:07:21 +0800
Message-Id: <20260508060724.3810904-2-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508060724.3810904-1-haowenchao@xiaomi.com>
References: <20260508060724.3810904-1-haowenchao@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a per-cpu deferred free mechanism to zsmalloc with a callback
interface that lets callers (zram, zswap) customize push and drain
behavior.

Each CPU owns a single-page buffer. The hot path (zs_free_deferred)
writes a value into the current CPU's buffer via the push callback
with preemption disabled — no locks, no atomics. When the buffer
fills, it is swapped with a fresh page from a pre-allocated page
pool and the full page is queued to a WQ_UNBOUND worker for drain.

The drain worker invokes the drain callback which performs the actual
expensive work (zs_free, slot_free, etc.) in batch, away from the
original hot path.

Page pool management:
  - Pool is pre-allocated at enable time (ZS_DEFERRED_POOL_SIZE pages)
  - Full buffers are drained and returned to the pool
  - If no free page is available when buffer is full, the push falls
    back to synchronous processing by the caller

Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 include/linux/zsmalloc.h |  16 +++
 mm/zsmalloc.c            | 208 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 478410c880b1..8d6c675b10dc 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -24,12 +24,28 @@ struct zs_pool_stats {
 struct zs_pool;
 struct scatterlist;
 
+enum zs_push_ret {
+	ZS_PUSH_OK = 0,
+	ZS_PUSH_FULL,
+	ZS_PUSH_FULL_QUEUED,
+};
+
+struct zs_deferred_ops {
+	enum zs_push_ret (*push)(void *buf, unsigned int count,
+					  unsigned long value);
+	void (*drain)(void *private, void *buf, unsigned int count);
+};
+
 struct zs_pool *zs_create_pool(const char *name);
 void zs_destroy_pool(struct zs_pool *pool);
 
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
 			const int nid);
 void zs_free(struct zs_pool *pool, unsigned long obj);
+int zs_pool_enable_deferred_free(struct zs_pool *pool,
+				 const struct zs_deferred_ops *ops,
+				 void *private);
+bool zs_free_deferred(struct zs_pool *pool, unsigned long value);
 
 size_t zs_huge_class_size(struct zs_pool *pool);
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 63128ddb7959..d8220a8753a7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -196,6 +196,13 @@ struct link_free {
 static struct kmem_cache *handle_cachep;
 static struct kmem_cache *zspage_cachep;
 
+#define ZS_DEFERRED_POOL_SIZE	(256 * 1024 / PAGE_SIZE)
+
+struct zs_deferred_percpu {
+	unsigned int count;
+	void *buf;
+};
+
 struct zs_pool {
 	const char *name;
 
@@ -217,6 +224,18 @@ struct zs_pool {
 	/* protect zspage migration/compaction */
 	rwlock_t lock;
 	atomic_t compaction_in_progress;
+
+	/* per-cpu deferred free */
+	const struct zs_deferred_ops *deferred_ops;
+	void *deferred_private;
+	struct zs_deferred_percpu __percpu *deferred;
+	struct work_struct deferred_work;
+	struct workqueue_struct *deferred_wq;
+	struct list_head deferred_pool;
+	unsigned int deferred_pool_count;
+	spinlock_t deferred_pool_lock;
+	struct list_head deferred_drain_list;
+	spinlock_t deferred_drain_lock;
 };
 
 static inline void zpdesc_set_first(struct zpdesc *zpdesc)
@@ -1416,6 +1435,171 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 }
 EXPORT_SYMBOL_GPL(zs_free);
 
+static struct page *deferred_pool_get(struct zs_pool *pool)
+{
+	struct page *page = NULL;
+
+	spin_lock(&pool->deferred_pool_lock);
+	if (!list_empty(&pool->deferred_pool)) {
+		page = list_first_entry(&pool->deferred_pool, struct page, lru);
+		list_del(&page->lru);
+		pool->deferred_pool_count--;
+	}
+	spin_unlock(&pool->deferred_pool_lock);
+	return page;
+}
+
+static void deferred_pool_put(struct zs_pool *pool, struct page *page)
+{
+	spin_lock(&pool->deferred_pool_lock);
+	list_add_tail(&page->lru, &pool->deferred_pool);
+	pool->deferred_pool_count++;
+	spin_unlock(&pool->deferred_pool_lock);
+}
+
+static void zs_deferred_work_fn(struct work_struct *work)
+{
+	struct zs_pool *pool = container_of(work, struct zs_pool, deferred_work);
+	struct page *page;
+
+	while (true) {
+		unsigned int count;
+
+		spin_lock(&pool->deferred_drain_lock);
+		if (list_empty(&pool->deferred_drain_list)) {
+			spin_unlock(&pool->deferred_drain_lock);
+			break;
+		}
+		page = list_first_entry(&pool->deferred_drain_list,
+					struct page, lru);
+		list_del(&page->lru);
+		count = page_private(page);
+		spin_unlock(&pool->deferred_drain_lock);
+
+		pool->deferred_ops->drain(pool->deferred_private,
+					  page_address(page), count);
+		deferred_pool_put(pool, page);
+		cond_resched();
+	}
+}
+
+bool zs_free_deferred(struct zs_pool *pool, unsigned long value)
+{
+	struct zs_deferred_percpu *def;
+	struct page *new_page, *full_page;
+	enum zs_push_ret ret;
+
+	if (!pool->deferred)
+		return false;
+
+	def = get_cpu_ptr(pool->deferred);
+
+	ret = pool->deferred_ops->push(def->buf, def->count, value);
+	if (ret == ZS_PUSH_OK) {
+		def->count++;
+		put_cpu_ptr(pool->deferred);
+		return true;
+	}
+
+	if (ret == ZS_PUSH_FULL_QUEUED)
+		def->count++;
+
+	new_page = deferred_pool_get(pool);
+	if (new_page) {
+		full_page = virt_to_page(def->buf);
+		set_page_private(full_page, def->count);
+		def->buf = page_address(new_page);
+		def->count = 0;
+
+		if (ret == ZS_PUSH_FULL) {
+			pool->deferred_ops->push(def->buf, 0, value);
+			def->count = 1;
+		}
+		put_cpu_ptr(pool->deferred);
+
+		spin_lock(&pool->deferred_drain_lock);
+		list_add_tail(&full_page->lru, &pool->deferred_drain_list);
+		spin_unlock(&pool->deferred_drain_lock);
+		queue_work(pool->deferred_wq, &pool->deferred_work);
+		return true;
+	}
+	put_cpu_ptr(pool->deferred);
+
+	/* ret==2: value already queued, will be drained eventually */
+	if (ret == 2)
+		return true;
+
+	/* ret==1: value not queued, caller must fallback */
+	return false;
+}
+EXPORT_SYMBOL_GPL(zs_free_deferred);
+
+int zs_pool_enable_deferred_free(struct zs_pool *pool,
+				 const struct zs_deferred_ops *ops,
+				 void *private)
+{
+	int cpu;
+	unsigned int pg_idx;
+	struct page *page, *tmp;
+
+	pool->deferred_ops = ops;
+	pool->deferred_private = private;
+
+	INIT_WORK(&pool->deferred_work, zs_deferred_work_fn);
+	pool->deferred_wq = alloc_workqueue("zs_drain", WQ_UNBOUND, 0);
+	if (!pool->deferred_wq)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&pool->deferred_pool);
+	spin_lock_init(&pool->deferred_pool_lock);
+	pool->deferred_pool_count = 0;
+	INIT_LIST_HEAD(&pool->deferred_drain_list);
+	spin_lock_init(&pool->deferred_drain_lock);
+
+	for (pg_idx = 0; pg_idx < ZS_DEFERRED_POOL_SIZE; pg_idx++) {
+		page = alloc_page(GFP_KERNEL);
+		if (!page)
+			goto err_pages;
+		list_add_tail(&page->lru, &pool->deferred_pool);
+		pool->deferred_pool_count++;
+	}
+
+	pool->deferred = alloc_percpu(struct zs_deferred_percpu);
+	if (!pool->deferred)
+		goto err_pages;
+
+	for_each_possible_cpu(cpu) {
+		struct zs_deferred_percpu *def = per_cpu_ptr(pool->deferred, cpu);
+
+		page = deferred_pool_get(pool);
+		if (!page)
+			goto err_percpu;
+		def->buf = page_address(page);
+		def->count = 0;
+	}
+
+	return 0;
+
+err_percpu:
+	for_each_possible_cpu(cpu) {
+		struct zs_deferred_percpu *def = per_cpu_ptr(pool->deferred, cpu);
+
+		if (def->buf)
+			deferred_pool_put(pool, virt_to_page(def->buf));
+	}
+	free_percpu(pool->deferred);
+	pool->deferred = NULL;
+err_pages:
+	list_for_each_entry_safe(page, tmp, &pool->deferred_pool, lru) {
+		list_del(&page->lru);
+		__free_page(page);
+	}
+	destroy_workqueue(pool->deferred_wq);
+	pool->deferred_wq = NULL;
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(zs_pool_enable_deferred_free);
+
 static void zs_object_copy(struct size_class *class, unsigned long dst,
 				unsigned long src)
 {
@@ -2182,9 +2366,31 @@ EXPORT_SYMBOL_GPL(zs_create_pool);
 
 void zs_destroy_pool(struct zs_pool *pool)
 {
-	int i;
+	int i, cpu;
+	struct page *page, *tmp;
 
 	zs_unregister_shrinker(pool);
+
+	if (pool->deferred) {
+		flush_work(&pool->deferred_work);
+		for_each_possible_cpu(cpu) {
+			struct zs_deferred_percpu *def =
+				per_cpu_ptr(pool->deferred, cpu);
+
+			if (def->buf && def->count)
+				pool->deferred_ops->drain(pool->deferred_private,
+							  def->buf, def->count);
+			if (def->buf)
+				deferred_pool_put(pool, virt_to_page(def->buf));
+		}
+		free_percpu(pool->deferred);
+		list_for_each_entry_safe(page, tmp, &pool->deferred_pool, lru) {
+			list_del(&page->lru);
+			__free_page(page);
+		}
+		destroy_workqueue(pool->deferred_wq);
+	}
+
 	zs_flush_migration(pool);
 	zs_pool_stat_destroy(pool);
 
-- 
2.34.1

