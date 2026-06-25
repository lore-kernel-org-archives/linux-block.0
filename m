Received: from mailrelay-egress5.pub.mailoutpod3-cph3.one.com (mailrelay-egress5.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EA335081
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417042; cv=none; b=LXznDN7ySL0AEhOcKkUPmJVyYajnTJLkVvkC0ol30/9XzJgIKv18/9VpjgUBqLgUszk2NsgRdAN2sh87/mSO54S4sRJ0lp3maol5OkLCsw/v7FjLNo0Bt9FZaBAtRzFssbmVuU7IxSYt9AoNrXh63OLakXDU1NwXSqHnLDzBi5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417042; c=relaxed/simple;
	bh=xqcDbxuRsB0g/DIZIjRRk2phsTwCsnSmuU2pbz5KJf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u+YHon6vrBUukHI/+xS7BSzJXDVVQ4/2j5rXyBwCzofA0shgIVuoE+VUoUQPKuQ+oxwb+gxYQs9kCwF9yhP2ApMSMhPyFhBv1uAtiDw5sAnxE5Ny0pHXdtaDxiqL99AN/autUr7PD3pqTJwWvoB/GIlBsHvsO7dzHiixMTfDqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=MINZwvd0; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=A2GsQQfL; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="MINZwvd0";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="A2GsQQfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782416967; x=1783021767;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=m4MCUcDOc2byyVN+sA2eSmtkMViFdmPHXyLdmgmeAEI=;
	b=MINZwvd0J/0d93f+jOHD4CnUt9y+MfQJdIU3xUZTpDp2Sv0ZyB2rvvir75/1yvQvGAX6ROeT9VMdA
	 ZRjUesdDCEuSB6PcrC1FXZtIKun0NqAkwgTLSuSdISFnqfoBHAFFEN6MBHY8+ijUQsBCCEUE5pTg31
	 aMrnitwBHHWcpo23ZsEUp/lqLAIPJ90lXAX3JqU2JzGs6syafvm3jIqpFWuTQvuSy7YqhYEEA7eHns
	 CS+BJAhqlfpxR9kFZY7ZhEwOSENFUNyaWW3gJ1Mzd0qnbZg7HSd+MewARIq658bdk8WtiHjlGh1eah
	 8nSmRmxP36Fzk9/fgbfqJxZkGAntIXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782416967; x=1783021767;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=m4MCUcDOc2byyVN+sA2eSmtkMViFdmPHXyLdmgmeAEI=;
	b=A2GsQQfLv3hKNaeoyeJKVdWiNWzdpYjMZFIsiZLmpwi4LcYEb2bIUtFZFdAa0Eer8QVu0i8fx/8Yq
	 M/bUlozAQ==
X-HalOne-ID: f8861944-70ce-11f1-8940-314137fccf3e
Received: from localhost.localdomain (c213-102-77-204.bredband.tele2.se [213.102.77.204])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id f8861944-70ce-11f1-8940-314137fccf3e;
	Thu, 25 Jun 2026 19:49:26 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-mm@kvack.org,
	Vitaly Vul <vitaly.vul@partner.samsung.com>
Subject: [PATCH] mempool: optimize mempool resizing
Date: Thu, 25 Jun 2026 21:49:15 +0200
Message-Id: <20260625194915.387663-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Vul <vitaly.vul@partner.samsung.com>

Resizing mempool to a bigger size currently requires a new allocation and a
data copy to a new larger elements array which doesn't go well with the
idea of having a fast and deadlock free memory allocations during exreme VM
load.

This patch introduces a new parameter max_nr for a part of the mempool API,
which denotes the maximum size of the pool. With it in place we can avoid
any allocations in mempool_resize() since we can either grant the resizing
request or reject it basing on thr maximum allowed size of the elements
array. For those few users of the mempool API that actually use
mempool_resize() it is a clear upgrade because the maximum number of
elements is known upfront.

Derivative APIs (like mempool_init_kmalloc_pool()) are mostly left intact,
substituted by the new mempool_init_kmalloc_resizable_pool() API where the
pool is actually meant to be resizable.

Signed-off-by: Vitaly Vul <vitaly.vul@partner.samsung.com>
---
 block/blk-zoned.c       |  6 ++--
 drivers/nvme/host/pci.c |  2 +-
 include/linux/mempool.h | 18 +++++++---
 mm/mempool.c            | 75 +++++++++++------------------------------
 4 files changed, 38 insertions(+), 63 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6a221c180889..5d31597f2fe6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1918,8 +1918,10 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++)
 		INIT_HLIST_HEAD(&disk->zone_wplugs_hash[i]);
 
-	disk->zone_wplugs_pool = mempool_create_kmalloc_pool(pool_size,
-						sizeof(struct blk_zone_wplug));
+	disk->zone_wplugs_pool = mempool_create_kmalloc_resizable_pool(
+					pool_size,
+					BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE,
+					sizeof(struct blk_zone_wplug));
 	if (!disk->zone_wplugs_pool)
 		goto free_hash;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b5f846200678..eaa4804ab3c3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3349,7 +3349,7 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
 	size_t alloc_size = sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
 
-	dev->dmavec_mempool = mempool_create_node(1,
+	dev->dmavec_mempool = mempool_create_node(1, 2,
 			mempool_kmalloc, mempool_kfree,
 			(void *)alloc_size, GFP_KERNEL,
 			dev_to_node(dev->dev));
diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index e8e440e04a06..8b950efded18 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -18,6 +18,7 @@ typedef void (mempool_free_t)(void *element, void *pool_data);
 typedef struct mempool {
 	spinlock_t lock;
 	int min_nr;		/* nr of elements at *elements */
+	int max_nr;		/* max nr of elements at *elements */
 	int curr_nr;		/* Current nr of elements at *elements */
 	void **elements;
 
@@ -38,7 +39,7 @@ static inline bool mempool_is_saturated(struct mempool *pool)
 }
 
 void mempool_exit(struct mempool *pool);
-int mempool_init_node(struct mempool *pool, int min_nr,
+int mempool_init_node(struct mempool *pool, int min_nr, int max_nr,
 		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
 		void *pool_data, gfp_t gfp_mask, int node_id);
 int mempool_init_noprof(struct mempool *pool, int min_nr,
@@ -49,15 +50,15 @@ int mempool_init_noprof(struct mempool *pool, int min_nr,
 
 struct mempool *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 		mempool_free_t *free_fn, void *pool_data);
-struct mempool *mempool_create_node_noprof(int min_nr,
+struct mempool *mempool_create_node_noprof(int min_nr, int max_nr,
 		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
 		void *pool_data, gfp_t gfp_mask, int nid);
 #define mempool_create_node(...)					\
 	alloc_hooks(mempool_create_node_noprof(__VA_ARGS__))
 
-#define mempool_create(_min_nr, _alloc_fn, _free_fn, _pool_data)	\
-	mempool_create_node(_min_nr, _alloc_fn, _free_fn, _pool_data,	\
-			    GFP_KERNEL, NUMA_NO_NODE)
+#define mempool_create(_min_nr, _alloc_fn, _free_fn, _data)	\
+	mempool_create_node(_min_nr, (_min_nr)*2, _alloc_fn, _free_fn,	\
+			    _data, GFP_KERNEL, NUMA_NO_NODE)
 
 int mempool_resize(struct mempool *pool, int new_min_nr);
 void mempool_destroy(struct mempool *pool);
@@ -102,6 +103,13 @@ void mempool_kfree(void *element, void *pool_data);
 	mempool_create((_min_nr), mempool_kmalloc, mempool_kfree,	\
 		       (void *)(unsigned long)(_size))
 
+#define mempool_init_kmalloc_resizable_pool(_pool, _min_nr, _max_nr, _size)		\
+	mempool_init_node(_pool, _min_nr, _max_nr, mempool_kmalloc, mempool_kfree,	\
+		     (void *)(unsigned long)(_size), GFP_KERNEL, NUMA_NO_NODE)
+#define mempool_create_kmalloc_resizable_pool(_min_nr, _max_nr, _size)			\
+	mempool_create_node(_min_nr, _max_nr, mempool_kmalloc, mempool_kfree,		\
+		       (void *)(unsigned long)(_size), GFP_KERNEL, NUMA_NO_NODE)
+
 /*
  * A mempool_alloc_t and mempool_free_t for a simple page allocator that
  * allocates pages of the order specified by pool_data
diff --git a/mm/mempool.c b/mm/mempool.c
index db23e0eef652..4675405c0bd8 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -207,7 +207,7 @@ void mempool_exit(struct mempool *pool)
 		void *element = remove_element(pool);
 		pool->free(element, pool->pool_data);
 	}
-	kfree(pool->elements);
+	kvfree(pool->elements);
 	pool->elements = NULL;
 }
 EXPORT_SYMBOL(mempool_exit);
@@ -230,22 +230,22 @@ void mempool_destroy(struct mempool *pool)
 }
 EXPORT_SYMBOL(mempool_destroy);
 
-int mempool_init_node(struct mempool *pool, int min_nr,
+int mempool_init_node(struct mempool *pool, int min_nr, int max_nr,
 		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
 		void *pool_data, gfp_t gfp_mask, int node_id)
 {
 	spin_lock_init(&pool->lock);
 	pool->min_nr	= min_nr;
+	pool->max_nr	= max_nr;
 	pool->pool_data = pool_data;
 	pool->alloc	= alloc_fn;
 	pool->free	= free_fn;
 	init_waitqueue_head(&pool->wait);
-	/*
-	 * max() used here to ensure storage for at least 1 element to support
-	 * zero minimum pool
-	 */
-	pool->elements = kmalloc_array_node(max(1, min_nr), sizeof(void *),
-					    gfp_mask, node_id);
+
+	if (WARN_ON(max_nr < 1 || min_nr < 0))
+		return -EINVAL;
+
+	pool->elements = kvmalloc_array_node_noprof(max_nr, sizeof(void *), gfp_mask, node_id);
 	if (!pool->elements)
 		return -ENOMEM;
 
@@ -253,7 +253,7 @@ int mempool_init_node(struct mempool *pool, int min_nr,
 	 * First pre-allocate the guaranteed number of buffers,
 	 * also pre-allocate 1 element for zero minimum pool.
 	 */
-	while (pool->curr_nr < max(1, pool->min_nr)) {
+	while (pool->curr_nr < pool->min_nr) {
 		void *element;
 
 		element = pool->alloc(gfp_mask, pool->pool_data);
@@ -286,7 +286,7 @@ int mempool_init_noprof(struct mempool *pool, int min_nr,
 		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
 		void *pool_data)
 {
-	return mempool_init_node(pool, min_nr, alloc_fn, free_fn,
+	return mempool_init_node(pool, min_nr, min_nr * 2, alloc_fn, free_fn,
 				 pool_data, GFP_KERNEL, NUMA_NO_NODE);
 
 }
@@ -296,6 +296,7 @@ EXPORT_SYMBOL(mempool_init_noprof);
  * mempool_create_node - create a memory pool
  * @min_nr:    the minimum number of elements guaranteed to be
  *             allocated for this pool.
+ * @max_nr:    the maximum capacity of the pool
  * @alloc_fn:  user-defined element-allocation function.
  * @free_fn:   user-defined element-freeing function.
  * @pool_data: optional private data available to the user-defined functions.
@@ -310,7 +311,7 @@ EXPORT_SYMBOL(mempool_init_noprof);
  *
  * Return: pointer to the created memory pool object or %NULL on error.
  */
-struct mempool *mempool_create_node_noprof(int min_nr,
+struct mempool *mempool_create_node_noprof(int min_nr, int max_nr,
 		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
 		void *pool_data, gfp_t gfp_mask, int node_id)
 {
@@ -320,7 +321,7 @@ struct mempool *mempool_create_node_noprof(int min_nr,
 	if (!pool)
 		return NULL;
 
-	if (mempool_init_node(pool, min_nr, alloc_fn, free_fn, pool_data,
+	if (mempool_init_node(pool, min_nr, max_nr, alloc_fn, free_fn, pool_data,
 			      gfp_mask, node_id)) {
 		kfree(pool);
 		return NULL;
@@ -338,9 +339,8 @@ EXPORT_SYMBOL(mempool_create_node_noprof);
  *              allocated for this pool.
  *
  * This function shrinks/grows the pool. In the case of growing,
- * it cannot be guaranteed that the pool will be grown to the new
- * size immediately, but new mempool_free() calls will refill it.
- * This function may sleep.
+ * the pool will be grown to the new size immediately, but new mempool_free()
+ * calls will refill it.
  *
  * Note, the caller must guarantee that no mempool_destroy is called
  * while this function is running. mempool_alloc() & mempool_free()
@@ -351,11 +351,13 @@ EXPORT_SYMBOL(mempool_create_node_noprof);
 int mempool_resize(struct mempool *pool, int new_min_nr)
 {
 	void *element;
-	void **new_elements;
 	unsigned long flags;
 
-	BUG_ON(new_min_nr <= 0);
-	might_sleep();
+	if (WARN_ON(new_min_nr < 0))
+		return -EINVAL;
+
+	if (new_min_nr > pool->max_nr)
+		return -ENOSPC;
 
 	spin_lock_irqsave(&pool->lock, flags);
 	if (new_min_nr <= pool->min_nr) {
@@ -366,45 +368,8 @@ int mempool_resize(struct mempool *pool, int new_min_nr)
 			spin_lock_irqsave(&pool->lock, flags);
 		}
 		pool->min_nr = new_min_nr;
-		goto out_unlock;
-	}
-	spin_unlock_irqrestore(&pool->lock, flags);
-
-	/* Grow the pool */
-	new_elements = kmalloc_objs(*new_elements, new_min_nr);
-	if (!new_elements)
-		return -ENOMEM;
-
-	spin_lock_irqsave(&pool->lock, flags);
-	if (unlikely(new_min_nr <= pool->min_nr)) {
-		/* Raced, other resize will do our work */
-		spin_unlock_irqrestore(&pool->lock, flags);
-		kfree(new_elements);
-		goto out;
-	}
-	memcpy(new_elements, pool->elements,
-			pool->curr_nr * sizeof(*new_elements));
-	kfree(pool->elements);
-	pool->elements = new_elements;
-	pool->min_nr = new_min_nr;
-
-	while (pool->curr_nr < pool->min_nr) {
-		spin_unlock_irqrestore(&pool->lock, flags);
-		element = pool->alloc(GFP_KERNEL, pool->pool_data);
-		if (!element)
-			goto out;
-		spin_lock_irqsave(&pool->lock, flags);
-		if (pool->curr_nr < pool->min_nr) {
-			add_element(pool, element);
-		} else {
-			spin_unlock_irqrestore(&pool->lock, flags);
-			pool->free(element, pool->pool_data);	/* Raced */
-			goto out;
-		}
 	}
-out_unlock:
 	spin_unlock_irqrestore(&pool->lock, flags);
-out:
 	return 0;
 }
 EXPORT_SYMBOL(mempool_resize);
-- 
2.39.2

