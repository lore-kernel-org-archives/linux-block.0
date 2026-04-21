Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8813BE643
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773803; cv=none; b=c8gBrsN21TAkt0VUkiGvZDky3qWYFB+5tHXFcByEcN2d4PFPIqGAdfJUvv6b1W47K07x4L6nXU3/OkHF2w9tNVt4ZVhM5RmHPRpb/PNg4CBerflwL50g0JsPX0eBnav3o+gdrdrtarSnSCV7R+e8HpDvlrdNxeIRE2s+9Lfh15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773803; c=relaxed/simple;
	bh=yQJQB/l54vycNoNGy/3OE0/3ou0HbdUNcc5tdjcARNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1D6pdq/bQIe++qVyxvbPsxQuVTD07iHq7/MumGK4ejsvYSn84K0WjrJUrek7UjF4dLeWwUkBnJL7CiugEI3lSEzX/BvgE3rdlx8JoR+IsZIh1YXxim5smwkRK5OhST27BkOTVHMp5nIjv1aV+XFBn+76uZkAUKD+g3aTaJjMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD6189Ud; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD6189Ud"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f351ca23cso2027862b3a.2
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773801; x=1777378601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yjoi/ADx361WB7o/C1DRNygxoHsfgIft6bO7Dodrjv4=;
        b=MD6189UdxlZR5HE48zVm2wQoDqo1n4rJrBJLy2SUXrzgY0DeayLHRc13rf82mtduv6
         stxvNm4+k6/OBii6xKVotG+nyg8RhZDWDyygMhm99YqLobLoSW8TVuFIqxvQvHSH24PC
         O6CD5TL5mT5Z7PJ2SbNSBQFlmvfi44SKCzfn/2K+QDX0+zlv8TIGRtB61Ya8jRL6rCZY
         Kq4k/ATkAWw7ZMeTcjQc0p7GhV9FjKR+dLrnWIYMcaU3gikhVFbJddA78TMxLrxrd6Ql
         XEOrb1wAV/uxvMvyzFu+ZDD5CqxhfonoBlre3z3l6SeewiNj64tcJBk3Ws2jV0jqkJsI
         /MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773801; x=1777378601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yjoi/ADx361WB7o/C1DRNygxoHsfgIft6bO7Dodrjv4=;
        b=Be6Pm6Gg1c90Ax0Y4zKIQTJ5SB+JuLiu2K4ER/bwiyjKAhS0CenGzFsiT4NCROXkhf
         nWTAZ7fAQf2PGofkVvRlWJS/fVnfqm6g9jFdyUKXcA6BYr9OxQIwzdzTXIEYEPgEWMXB
         5WaWOVhjD/dWREeAHt0OIRZA6dzS+hPPkCrr0Ia4zQFp8GFLXCwMo2Fdrs+q+pQcd9zj
         jTn0/4Xz0kYPYJSkeZqi9D23zoUwpvCxNYZP13pODSRj+8UViqKvvQznLBBI4detYtmE
         h3dNLe3w88kOOlq8UM1SXb3GukCdef2/CJfiYLqRzTHjeBjiJbXmk3Ca+H4uCAJo7v/3
         fqjg==
X-Forwarded-Encrypted: i=1; AFNElJ8+KctQi21rI+8dR2c6vJdOLHgFG6YvjZVLbpHwoag879NIgfVhODDebbKn6LqhCIoEK/j/multAg0C/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIYYRQMTE1LhxBRb9PNONQCdYuVmiS+PAw0s2fKlVgXxeoCLz
	oK41SXQweuhiPuj67mdtBIDjGIdqTaQJZ2Kvl+Eq+4k+TQ++TCeT9U7Z
X-Gm-Gg: AeBDievpcLlyv5r0VyEX4oXh+Akm+irAJ2gOT5IKeq8HYVSVkm0oQuXS5X4CNRb8iQp
	tuzEbuJNlm2M8hhhbACxaKII9xLFAx9+VUjJp7X96FFmGpvMokiLEEkQLmfdNsv3VtEwuw24yJN
	N2BO1iOx68VAv3AHw+UiwZ1rBrRAj/jj9PrqeKtd40PIetWl18X6lLitKrMQCBE7Nh6CtaapVKw
	SRPrhCm630b4HtlRo00b/FeBJgjpFTZuRhtkYCnfOqYIT8Xq+GuNrXLBeKIuy5D1A6w2Xm2MmxK
	gTtLJt6Ro6vVo/fblYhEOlMChYOegmrZn5nAW1smMBxBVI/BhzGLgMzeJUElxVpLAoN5I57jS/L
	2jbPwkhiVN9KEymcxRltDNjpdr1QBgL3HG4autlkQzVSIL3T/6N0P2EuXN3bHstyFcfFNCnwDAP
	Oem/NKykeI64ELlCokPsx/GITS3iCD/jG3D+BNLqufo4Mu41CgH3Kt5Ghg2w==
X-Received: by 2002:a05:6a00:3d16:b0:82d:24f:2511 with SMTP id d2e1a72fcca58-82f8c8522f9mr19548140b3a.12.1776773801023;
        Tue, 21 Apr 2026 05:16:41 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec037e1sm16371071b3a.54.2026.04.21.05.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:16:40 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Barry Song <baohua@kernel.org>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v2 2/4] mm/zsmalloc: introduce zs_free_deferred() for async handle freeing
Date: Tue, 21 Apr 2026 20:16:14 +0800
Message-Id: <20260421121616.3298845-3-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421121616.3298845-1-haowenchao@xiaomi.com>
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zs_free() is expensive due to internal locking (pool->lock, class->lock)
and potential zspage freeing. On the process exit path, the slow
zs_free() blocks memory reclamation, delaying overall memory release.
This has been reported to significantly impact Android low-memory
killing where slot_free() accounts for over 80% of the total swap
entry freeing cost.

Introduce zs_free_deferred() which queues handles into a fixed-size
per-pool array for later processing by a workqueue. This allows callers
to defer the expensive zs_free() and return quickly, so the process
exit path can release memory faster. The array capacity is derived from
a 128MB uncompressed data budget (128MB >> PAGE_SHIFT entries), which
scales naturally with PAGE_SIZE. When the array reaches half capacity,
the workqueue is scheduled to drain pending handles.

zs_free_deferred() uses spin_trylock() to access the deferred queue.
If the lock is contended (e.g. drain in progress) or the queue is full,
it falls back to synchronous zs_free() to guarantee correctness.

Also introduce zs_free_deferred_flush() for use during pool teardown to
ensure all pending handles are freed.

Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 include/linux/zsmalloc.h |   2 +
 mm/zsmalloc.c            | 111 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

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
index 40687c8a7469..defc892555e4 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -53,6 +53,10 @@
 
 #define ZS_HANDLE_SIZE (sizeof(unsigned long))
 
+#define ZS_DEFERRED_FREE_MAX_BYTES	(128 << 20)
+#define ZS_DEFERRED_FREE_CAPACITY	(ZS_DEFERRED_FREE_MAX_BYTES >> PAGE_SHIFT)
+#define ZS_DEFERRED_FREE_THRESHOLD	(ZS_DEFERRED_FREE_CAPACITY / 2)
+
 /*
  * Object location (<PFN>, <obj_idx>) is encoded as
  * a single (unsigned long) handle value.
@@ -217,6 +221,13 @@ struct zs_pool {
 	/* protect zspage migration/compaction */
 	rwlock_t lock;
 	atomic_t compaction_in_progress;
+
+	/* deferred free support */
+	spinlock_t deferred_lock;
+	unsigned long *deferred_handles;
+	unsigned int deferred_count;
+	unsigned int deferred_capacity;
+	struct work_struct deferred_free_work;
 };
 
 static inline void zpdesc_set_first(struct zpdesc *zpdesc)
@@ -579,6 +590,19 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(zs_stats_size);
 
+static int zs_stats_deferred_show(struct seq_file *s, void *v)
+{
+	struct zs_pool *pool = s->private;
+
+	spin_lock(&pool->deferred_lock);
+	seq_printf(s, "pending: %u\n", pool->deferred_count);
+	seq_printf(s, "capacity: %u\n", pool->deferred_capacity);
+	spin_unlock(&pool->deferred_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(zs_stats_deferred);
+
 static void zs_pool_stat_create(struct zs_pool *pool, const char *name)
 {
 	if (!zs_stat_root) {
@@ -590,6 +614,9 @@ static void zs_pool_stat_create(struct zs_pool *pool, const char *name)
 
 	debugfs_create_file("classes", S_IFREG | 0444, pool->stat_dentry, pool,
 			    &zs_stats_size_fops);
+	debugfs_create_file("deferred_free", S_IFREG | 0444,
+			    pool->stat_dentry, pool,
+			    &zs_stats_deferred_fops);
 }
 
 static void zs_pool_stat_destroy(struct zs_pool *pool)
@@ -1432,6 +1459,76 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 }
 EXPORT_SYMBOL_GPL(zs_free);
 
+static void zs_deferred_free_work(struct work_struct *work)
+{
+	struct zs_pool *pool = container_of(work, struct zs_pool,
+					    deferred_free_work);
+	unsigned long handle;
+
+	while (1) {
+		spin_lock(&pool->deferred_lock);
+		if (pool->deferred_count == 0) {
+			spin_unlock(&pool->deferred_lock);
+			break;
+		}
+		handle = pool->deferred_handles[--pool->deferred_count];
+		spin_unlock(&pool->deferred_lock);
+
+		zs_free(pool, handle);
+		cond_resched();
+	}
+}
+
+/**
+ * zs_free_deferred - queue a handle for asynchronous freeing
+ * @pool: pool to free from
+ * @handle: handle to free
+ *
+ * Place @handle into a deferred free queue for later processing by a
+ * workqueue.  This is intended for callers that are in atomic context
+ * (e.g. under a spinlock) and cannot afford the cost of zs_free()
+ * directly.  When the queue reaches a threshold the work is scheduled.
+ * Falls back to synchronous zs_free() if the lock is contended (drain
+ * in progress) or if the queue is full.
+ */
+void zs_free_deferred(struct zs_pool *pool, unsigned long handle)
+{
+	if (IS_ERR_OR_NULL((void *)handle))
+		return;
+
+	if (!spin_trylock(&pool->deferred_lock))
+		goto sync_free;
+
+	if (pool->deferred_count >= pool->deferred_capacity) {
+		spin_unlock(&pool->deferred_lock);
+		goto sync_free;
+	}
+
+	pool->deferred_handles[pool->deferred_count++] = handle;
+	if (pool->deferred_count >= ZS_DEFERRED_FREE_THRESHOLD)
+		queue_work(system_wq, &pool->deferred_free_work);
+	spin_unlock(&pool->deferred_lock);
+	return;
+
+sync_free:
+	zs_free(pool, handle);
+}
+EXPORT_SYMBOL_GPL(zs_free_deferred);
+
+/**
+ * zs_free_deferred_flush - flush all pending deferred frees
+ * @pool: pool to flush
+ *
+ * Wait for any scheduled work to complete, then drain any remaining
+ * handles.  Must be called from process context.
+ */
+void zs_free_deferred_flush(struct zs_pool *pool)
+{
+	flush_work(&pool->deferred_free_work);
+	zs_deferred_free_work(&pool->deferred_free_work);
+}
+EXPORT_SYMBOL_GPL(zs_free_deferred_flush);
+
 static void zs_object_copy(struct size_class *class, unsigned long dst,
 				unsigned long src)
 {
@@ -2099,6 +2196,18 @@ struct zs_pool *zs_create_pool(const char *name)
 	rwlock_init(&pool->lock);
 	atomic_set(&pool->compaction_in_progress, 0);
 
+	spin_lock_init(&pool->deferred_lock);
+	pool->deferred_capacity = ZS_DEFERRED_FREE_CAPACITY;
+	pool->deferred_handles = kvmalloc_array(pool->deferred_capacity,
+						sizeof(unsigned long),
+						GFP_KERNEL);
+	if (!pool->deferred_handles) {
+		kfree(pool);
+		return NULL;
+	}
+	pool->deferred_count = 0;
+	INIT_WORK(&pool->deferred_free_work, zs_deferred_free_work);
+
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
 		goto err;
@@ -2201,6 +2310,7 @@ void zs_destroy_pool(struct zs_pool *pool)
 	int i;
 
 	zs_unregister_shrinker(pool);
+	zs_free_deferred_flush(pool);
 	zs_flush_migration(pool);
 	zs_pool_stat_destroy(pool);
 
@@ -2224,6 +2334,7 @@ void zs_destroy_pool(struct zs_pool *pool)
 		kfree(class);
 	}
 
+	kvfree(pool->deferred_handles);
 	kfree(pool->name);
 	kfree(pool);
 }
-- 
2.34.1

