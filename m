Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248751;
	b=0UVpFWdUVgrfFrZdZWjemPAWJUWjoo8W5dijEVY75qImB4HgebUYSMiBAmgGM/ygNUg8
	 /T0ZJGiJBzUJDq009+T7bIqxV7MZ8WMm2oqKNOK4C/Nz+UteH8EaKwysO1ZpFblWnKOxm
	 Rr8aVeEyB9zDyqbO92P+wkgW0LnKc+hiynHpJ4ygSBjCEFdyLdo60rgSpE7SB5+6FwCCS
	 WayhsSCQa2jE2r+G+aE+57MLR5l26gOmmOxEu0onjWpKlREffl2Yoa+hhf3XXxDr7YL6e
	 Hw73CQMxj2FE34gloP4ieRin1diByL/08ifkBiOUy3X3tkIJvlRVJ16wXSC/8Ee11sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/X7nYrKappU5M+M14lx8cCjdoFlwBcGyVL/mgf8c7Co=;
	b=ppCiqUI/JvBF6DD3dKQe8RKz2PVsq7+1k8bPQ/iJ+OOwUX6bpz6ajF/o/J5oXMwLbqL0
	 mUcdzSmcLQUNdVgA7RAjpYFuwz1RnAaKrgVNEkjdeOoznpfgSp0IEMrDNgspt/lfPg5my
	 ArIjH7Yv3WJzGRNKMbkxmtiawXfu8x2/rG5sJkcabXkCVtWxWCBP4Zjmm0AX4EttiMHvq
	 GCJhp4H5HA4umTy0LMb/j3EuKe+RKHQzfkTKbkaMCnufNFodA680f44/8IKuJo8N44y6E
	 vICbXaLvWfnRjicBhZwpJpTcIU0Hp9ZANRmYbsiS27NpDxPeIjnP3mSsUH6kQpZQzqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WiqEoIvB;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8F606B590
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C8F606B590
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WiqEoIvB
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c40bbd26f74so106841766b.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248748; x=1794853548; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/X7nYrKappU5M+M14lx8cCjdoFlwBcGyVL/mgf8c7Co=;
        b=WiqEoIvBxn3UKDgIW/EQTGPPNQIVzP0bCaT7k89UBt5oCTY2LSFdhtRHsWMWue8kbk
         rTEyZU5nlYt9CuDELCzDO3Jnjhh8QYKmivvVtF8WGcYhJap5wo/u7avwePE3dkd4msca
         IryWETKlBZoiW/o80b+QGAdkfNjuKOb29MyOMMjBiisZSAcka6O56XbN28C09r7FX0/d
         EfKRkAz8jXcoBJBQOT+6Q+UoF73d54z/Jbs/rfRY4fVcGmTFTbRjT/t8fAzSv4LsGE8i
         or7cuX2/lATrvjAHpCzvlMX9jvPnaCMVXPbRx09/Bb5ehGUPSoV2ikkqkAYj9kJpOwcs
         5ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248748; x=1794853548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/X7nYrKappU5M+M14lx8cCjdoFlwBcGyVL/mgf8c7Co=;
        b=fTZItDTx23VhSHax1axzWpsu8Kga66ZQcfYkY4aKqIQ2N87K3XMArmuHzMghnfLg91
         IyAnlj3fAlvnL8h5kZo18o4vQo1w+IjffkuHJfiLPtvVzyaDqX2c9c7GDWdU+DjG/34O
         oLF7LcrTMb+Whu4nWWJYw/OE1dcjMyH0NyENpS43mVgGhMetOk9bO3anHQINdG0np7nu
         otG4qmbFt+a8hoDFBXqBCTHOxI+aPDgEPOzrNjkZsza2/MxvrJlSf1dNDsU3n9br6mmu
         C9DqY/8j8CJQ9hCfD54jABK1GF0gS9QDAGaTTKEAOx66yt8yebdpBeuPOVLAwOkHLsug
         i/hg==
X-Forwarded-Encrypted: i=1; AL+hErHRUK0HY3u2yF4b244xceADYjqv30ryPRvbtw1VKdfj1WsiSoXOQF3FSr1yEtd2wBX4lLw+9hRC2Qg9GQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZIuhk8Zoha3s58k335kYAG2YEsase+GhyiRgk0ORKYUWIlt+w
	LfFvzSJA1F3XxmtB1ayVwA1lluZCFjsHNJulCmhM9XcEuzROGb/SgYDJ/wQDiAdcgs2tK0ke5X5
	Px1Xncw==
X-Received: from ejzp25.prod.google.com ([2002:a17:906:b219:b0:c4d:3341:eee2])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:948a:b0:c4d:28ba:f221
 with SMTP id a640c23a62f3a-c50496e271bmr16130666b.42.1794248748043; Mon, 09
 Nov 2026 10:25:48 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:19 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-12-lrizzo@google.com>
Subject: [RFC PATCH v2 11/25] iommu/dma: Add per-CPU block caches to PISA allocators
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Every block allocation and free takes the allocator's lock. Highly
concurrent users e.g. socket tx fragments, can cause significant lock
contention.

Add pisa_enable_pcp(), an opt-in per-CPU front cache, similar
to the page allocator's per-CPU lists:

- Each per-CPU cache keeps up to 64 free blocks, and refills it from
  the main allocator in batches of 32.
- returned blocks belonging to the local NUMA node are kept in the local
  cache.
- returned blocks belonging to a remote NUMA node are returned to the
  proper per-node allocator.
The cache is fully integrated with the shrinker and CPU offlining to
drain the cache.

Enable per-CPU caches for the per-node order-0 RW and SKB_FRAG_PAGE_ORDER
RO allocators.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 342 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/pisa-kunit.c |  78 +++++++++
 drivers/iommu/pisa-priv.h  |  35 +++-
 include/linux/pisa.h       |   6 +
 4 files changed, 448 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 25e4645310678..913706a503341 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cache.h>
+#include <linux/cpuhotplug.h>
 #include <linux/device.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
@@ -24,6 +25,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/page_owner.h>
+#include <linux/percpu.h>
 #include <linux/pgalloc_tag.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/mm.h>
@@ -60,6 +62,10 @@ module_param_named(max_idle, pisa_max_idle, uint, 0644);
 static unsigned int pisa_idle_ms __read_mostly = 200;
 module_param_named(idle_ms, pisa_idle_ms, uint, 0644);
 
+/* Stop recycling partial-page blocks when free blocks exceed @pisa_compact PISA pages. */
+static unsigned int pisa_compact __read_mostly;
+module_param_named(compact, pisa_compact, uint, 0644);
+
 /* All live allocators, protected by pisa_allocs_lock. */
 static LIST_HEAD(pisa_allocs);
 static DEFINE_RWLOCK(pisa_allocs_lock);
@@ -90,7 +96,11 @@ static void pisa_release_page_rcu(struct rcu_head *head)
 	struct pisa_meta *meta = container_of(head, struct pisa_meta, rcu);
 	struct page *block, *page = pfn_to_page(pisa_meta_to_pfn(meta));
 	unsigned int i, order = meta->pa->order, slot = meta->slot;
+	unsigned long flags;
 
+	spin_lock_irqsave(&meta->pa->lock, flags);
+	meta->pa->stats.page_free_cnt++;
+	spin_unlock_irqrestore(&meta->pa->lock, flags);
 	WRITE_ONCE(meta->pa, NULL);
 
 	/* Possibly still mapped by a device: leak it, still charged. */
@@ -355,9 +365,223 @@ static void pisa_return_block_locked(struct pisa_alloc *pa, struct page *block,
 		__set_bit(idx, meta->dirty_bitmap);
 		meta->nr_dirty++;
 	}
+	pa->blocks_in_use--;
 	*release |= pisa_place_meta(meta);
 }
 
+/**
+ * pisa_page_can_recycle - Check if a block can stay cached in a caller pool
+ * @page: Block head page
+ *
+ * Called on the recycle fast path (per-CPU cache, TX page_frag, page_pool).
+ * Fast-path cost is a static-key branch plus a READ_ONCE() of module parameters
+ * (~1-2 ns when compaction is off); when enabled, it does a lockless RCU +
+ * metadata array lookup (~5-10 ns).
+ *
+ * Return: true if @page can be recycled in place, false if it should be
+ * released back to its allocator so sparse 2MB pages can drain.
+ */
+bool pisa_page_can_recycle(const struct page *page)
+{
+	unsigned long bpp, in_use, free_blocks, pfn;
+	const struct pisa_meta *meta;
+	const struct pisa_alloc *pa;
+	unsigned int compact;
+	bool ret = true;
+	u8 on_list;
+	long held;
+
+	if (!static_branch_unlikely(&pisa_key))
+		return true;
+
+	compact = READ_ONCE(pisa_compact);
+	if (!compact)
+		return true;
+
+	pfn = page_to_pfn(page);
+	rcu_read_lock();
+	if (!is_pisa_pfn(pfn))
+		goto out;
+
+	meta = pisa_meta_of_pfn(pfn);
+	on_list = READ_ONCE(meta->on_list);
+	if (on_list == PISA_LIST_FULL || on_list == PISA_LIST_NONE)
+		goto out;
+
+	pa = meta->pa;
+	if (!pa)
+		goto out;
+
+	/* Do not drain the partial page currently being filled at list head. */
+	if (READ_ONCE(pa->partial_dirty.next) == &meta->list ||
+	    READ_ONCE(pa->partial.next) == &meta->list)
+		goto out;
+
+	bpp = PISA_BLOCKS(pa->order);
+	/* Do not drain dense pages that still have more than half their blocks in use. */
+	if (READ_ONCE(meta->nr_clean) + READ_ONCE(meta->nr_dirty) < (bpp >> 1))
+		goto out;
+
+	held = pisa_alloc_held_pages(pa);
+	in_use = READ_ONCE(pa->blocks_in_use);
+	free_blocks = held > 0 && (unsigned long)held * bpp > in_use ?
+		      (unsigned long)held * bpp - in_use : 0;
+
+	ret = free_blocks <= (unsigned long)compact * bpp;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pisa_page_can_recycle);
+
+/* Return @n freed blocks to @pa under a single acquisition of @pa->lock. */
+static void pisa_free_bulk(struct pisa_alloc *pa, struct page **blocks, unsigned int n)
+{
+	bool release = false;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&pa->lock, flags);
+	for (i = 0; i < n; i++) {
+		if (likely(!pisa_block_poisoned(pa, blocks[i])))
+			pisa_return_block_locked(pa, blocks[i], &release);
+	}
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (release)
+		pisa_schedule_reclaim();
+}
+
+/*
+ * Per-CPU block cache: each CPU caches up to PISA_PCP_HIGH free blocks
+ * (refcount 0, not in bitmaps), refilling and flushing in PISA_PCP_BATCH
+ * batches. Drained by the shrinker and CPU hotplug.
+ */
+
+/* Max blocks moved per per-CPU cache refill or flush (1..PISA_PCP_BATCH). */
+static unsigned int pisa_pcp_batch __read_mostly = PISA_PCP_BATCH;
+
+static int pisa_pcp_batch_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 1, PISA_PCP_BATCH);
+}
+
+static const struct kernel_param_ops pisa_pcp_batch_ops = {
+	.set = pisa_pcp_batch_set,
+	.get = param_get_uint,
+};
+module_param_cb(pcp_batch, &pisa_pcp_batch_ops, &pisa_pcp_batch, 0644);
+
+/* Cache @n blocks at refcount 0 on this CPU, @n <= PISA_PCP_BATCH. */
+static void pisa_pcp_push(struct pisa_alloc *pa, struct page **blocks, unsigned int n)
+{
+	unsigned int i, batch = READ_ONCE(pisa_pcp_batch);
+	struct pisa_pcp *pcp;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	pcp = this_cpu_ptr(pa->pcp);
+	spin_lock(&pcp->lock);
+	for (i = 0; i < n; i++) {
+		if (pcp->count == PISA_PCP_HIGH) {
+			/* Keep the most recently freed, likely still in cache. */
+			pisa_free_bulk(pa, pcp->blocks, batch);
+			pcp->count -= batch;
+			memmove(pcp->blocks, pcp->blocks + batch,
+				pcp->count * sizeof(*pcp->blocks));
+		}
+		pcp->blocks[pcp->count++] = blocks[i];
+	}
+	spin_unlock(&pcp->lock);
+	local_irq_restore(flags);
+}
+
+/* Take up to @nr blocks, at refcount 0, from this CPU's cache. */
+static unsigned int pisa_pcp_pop(struct pisa_alloc *pa, unsigned int nr, struct page **out)
+{
+	struct pisa_pcp *pcp;
+	unsigned int got = 0;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	pcp = this_cpu_ptr(pa->pcp);
+	spin_lock(&pcp->lock);
+	while (got < nr && pcp->count)
+		out[got++] = pcp->blocks[--pcp->count];
+	spin_unlock(&pcp->lock);
+	local_irq_restore(flags);
+
+	return got;
+}
+
+/* Return the blocks @cpu caches for @pa. Process context. */
+static void pisa_pcp_drain_cpu(struct pisa_alloc *pa, int cpu)
+{
+	struct pisa_pcp *pcp = per_cpu_ptr(pa->pcp, cpu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pcp->lock, flags);
+	if (pcp->count) {
+		pisa_free_bulk(pa, pcp->blocks, pcp->count);
+		pcp->count = 0;
+	}
+	spin_unlock_irqrestore(&pcp->lock, flags);
+}
+
+/* Drain every non-empty CPU cache of @pa. */
+void pisa_pcp_drain(struct pisa_alloc *pa)
+{
+	int cpu;
+
+	/* Pairs with smp_store_release() in pisa_enable_pcp(). */
+	if (!smp_load_acquire(&pa->pcp))
+		return;
+	for_each_possible_cpu(cpu) {
+		if (!READ_ONCE(per_cpu_ptr(pa->pcp, cpu)->count))
+			continue;
+		pisa_pcp_drain_cpu(pa, cpu);
+	}
+}
+
+/* Blocks in @pa's caches, for shrinker and debugfs. */
+static unsigned long pisa_pcp_count(struct pisa_alloc *pa)
+{
+	unsigned long n = 0;
+	int cpu;
+
+	if (!pa->pcp)
+		return 0;
+	for_each_possible_cpu(cpu) {
+		/* A racy sum is good enough for reclaim and statistics. */
+		n += data_race(per_cpu_ptr(pa->pcp, cpu)->count);
+	}
+	return n;
+}
+
+/**
+ * pisa_enable_pcp - Put per-CPU block caches in front of an allocator
+ * @pa: Allocator to cache
+ *
+ * Return: 0, or -ENOMEM; @pa works without the cache.
+ */
+int pisa_enable_pcp(struct pisa_alloc *pa)
+{
+	struct pisa_pcp __percpu *pcp;
+	int cpu;
+
+	if (!pa || pa->pcp)
+		return 0;
+	pcp = alloc_percpu(struct pisa_pcp);
+	if (!pcp)
+		return -ENOMEM;
+	for_each_possible_cpu(cpu)
+		spin_lock_init(&per_cpu_ptr(pcp, cpu)->lock);
+	/* Publish initialized locks; readers depend on the pointer. */
+	if (cmpxchg_release(&pa->pcp, NULL, pcp))
+		free_percpu(pcp);
+	return 0;
+}
+
 /*
  * Return the predefined per-node allocator for (@nid, @order, @ro), or NULL.
  */
@@ -412,7 +636,9 @@ bool pisa_has_free_blocks_rx(const struct device *dev, unsigned int order, int n
 		return false;
 	pa = pisa_node_pa(nid, order, false);
 	return pa &&
-	       (!list_empty_careful(&pa->partial) ||
+	       /* Pairs with cmpxchg_release() in pisa_enable_pcp(). */
+	       ((smp_load_acquire(&pa->pcp) && raw_cpu_read(pa->pcp->count)) ||
+		!list_empty_careful(&pa->partial) ||
 		!list_empty_careful(&pa->partial_dirty) ||
 		!list_empty_careful(&pa->idle));
 }
@@ -532,6 +758,7 @@ static unsigned int pisa_scan_bitmap(struct pisa_meta *meta, bool dirty,
 			break;
 	}
 	*countp -= used;
+	pa->blocks_in_use += used;
 	return got;
 }
 
@@ -638,6 +865,7 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 		meta->prot = pa->prot;
 		/* Set PISA_ACTIVE after @meta is fully set up. */
 		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
+		pa->stats.page_alloc_cnt++;
 	}
 	spin_unlock_irqrestore(&pa->lock, flags);
 
@@ -656,6 +884,49 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 	return n;
 }
 
+/* Allocate @nr_pages blocks through this CPU's cache, refilling in batches on miss. */
+static unsigned long pisa_pcp_alloc(struct pisa_alloc *pa, gfp_t gfp, unsigned long nr_pages,
+				    struct page **page_array, bool frozen)
+{
+	unsigned int pcp_batch = READ_ONCE(pisa_pcp_batch);
+	unsigned long got, n, i, j;
+
+	got = pisa_pcp_pop(pa, nr_pages, page_array);
+	if (got < nr_pages) {
+		if (nr_pages - got >= pcp_batch) {
+			got += __pisa_alloc_bulk(pa, gfp, nr_pages - got,
+						 page_array + got, false, true);
+		} else {
+			struct page *batch[PISA_PCP_BATCH];
+
+			n = __pisa_alloc_bulk(pa, gfp, pcp_batch, batch, false, true);
+			for (i = 0; i < n && got < nr_pages; i++)
+				page_array[got++] = batch[i];
+			if (i < n)
+				pisa_pcp_push(pa, batch + i, n - i);
+		}
+	}
+
+	for (i = j = 0; i < got; i++) {
+		struct page *block = page_array[i];
+
+		page_array[i] = NULL;
+		/* Poisoned while cached: leak it, as pisa_scan_bitmap() does. */
+		if (pisa_block_poisoned(pa, block))
+			continue;
+		pisa_block_prep(block);
+		if (want_init_on_alloc(gfp)) {
+			memset(page_address(block), 0, PAGE_SIZE << pa->order);
+			if (frozen) /* Order zeroing before caller publishes the page. */
+				smp_wmb();
+		}
+		if (!frozen)
+			page_ref_unfreeze(block, 1);
+		page_array[j++] = block;
+	}
+	return j;
+}
+
 /**
  * pisa_alloc_bulk - Allocate up to @nr_pages blocks from @pa
  * @pa: Allocator to allocate from
@@ -681,11 +952,16 @@ unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
 			i++;
 			continue;
 		}
+
 		/* Fill the run of @n NULL entries at @i. */
 		for (n = 1; i + n < nr_pages && !page_array[i + n]; n++)
 			;
-		got = __pisa_alloc_bulk(pa, gfp, n, page_array + i,
-					want_init_on_alloc(gfp), frozen);
+		/* Pairs with smp_store_release() in pisa_enable_pcp(). */
+		if (smp_load_acquire(&pa->pcp))
+			got = pisa_pcp_alloc(pa, gfp, n, page_array + i, frozen);
+		else
+			got = __pisa_alloc_bulk(pa, gfp, n, page_array + i,
+						want_init_on_alloc(gfp), frozen);
 		i += got;
 		if (got < n)
 			break;
@@ -733,10 +1009,13 @@ static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblock
 		for (i = 0; i < nblocks; i++) {
 			if (!pisa_block_poisoned(pa, page + i))
 				continue;
-			if (__test_and_clear_bit(off + i, meta->clean_bitmap))
+			if (__test_and_clear_bit(off + i, meta->clean_bitmap)) {
 				meta->nr_clean--;
-			else if (__test_and_clear_bit(off + i, meta->dirty_bitmap))
+				pa->blocks_in_use++;
+			} else if (__test_and_clear_bit(off + i, meta->dirty_bitmap)) {
 				meta->nr_dirty--;
+				pa->blocks_in_use++;
+			}
 			__set_bit(off + i, busy);
 			poisoned = true;
 			off += i + 1;
@@ -760,6 +1039,7 @@ static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblock
 		pisa_block_prep(page + i);
 		page_ref_unfreeze(page + i, 1);
 	}
+	pa->blocks_in_use += nblocks;
 	pisa_place_meta(meta);
 	return page;
 }
@@ -806,6 +1086,7 @@ void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
 	pa = pisa_node_pa(dev_to_node(dev), 0, false);
 	if (!pa)
 		return NULL;
+	pisa_pcp_drain(pa);
 
 	nblocks = size >> PAGE_SHIFT;
 	align_mask = (1UL << get_order(size)) - 1;
@@ -830,6 +1111,7 @@ void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
 		meta->pa = pa;
 		meta->prot = pa->prot;
 		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
+		pa->stats.page_alloc_cnt++;
 		page = pisa_take_contig(meta, nblocks, align_mask);
 		if (unlikely(!page))
 			should_release = pisa_place_meta(meta);
@@ -876,6 +1158,17 @@ bool __pisa_free_page(struct page *page)
 	if (want_init_on_free())
 		memset(page_address(page), 0, PAGE_SIZE << pa->order);
 
+	/* Pairs with cmpxchg_release() in pisa_enable_pcp(). */
+	if (smp_load_acquire(&pa->pcp) && pa->nid == numa_mem_id() &&
+	    page_to_nid(page) == numa_mem_id()) {
+		if (pisa_page_can_recycle(page)) {
+			pisa_pcp_push(pa, &page, 1);
+			return true;
+		}
+		if (this_cpu_read(pa->pcp->count))
+			pisa_pcp_drain_cpu(pa, raw_smp_processor_id());
+	}
+
 	spin_lock_irqsave(&pa->lock, flags);
 	pisa_return_block_locked(pa, page, &should_release);
 	spin_unlock_irqrestore(&pa->lock, flags);
@@ -889,15 +1182,17 @@ bool __pisa_free_page(struct page *page)
 /* Shrinker: releases reservoir pages first, then idle allocator pages. */
 static unsigned long pisa_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	unsigned long nr = pisa_reservoir_count();
+	unsigned long nr = pisa_reservoir_count() << PISA_ORDER;
 	struct pisa_alloc *pa;
 
 	read_lock(&pisa_allocs_lock);
-	list_for_each_entry(pa, &pisa_allocs, node)
-		nr += READ_ONCE(pa->num_idle_pages);
+	list_for_each_entry(pa, &pisa_allocs, node) {
+		nr += (unsigned long)READ_ONCE(pa->num_idle_pages) << PISA_ORDER;
+		nr += pisa_pcp_count(pa) << pa->order;
+	}
 	read_unlock(&pisa_allocs_lock);
 
-	return nr << PISA_ORDER;
+	return nr;
 }
 
 /* Detach PISA pages from @list onto @release_list up to @nr_to_scan base pages. */
@@ -930,6 +1225,8 @@ VISIBLE_IF_KUNIT unsigned long pisa_shrink_scan(struct shrinker *shrink, struct
 	if (freed < sc->nr_to_scan) {
 		read_lock(&pisa_allocs_lock);
 		list_for_each_entry(pa, &pisa_allocs, node) {
+			/* Cached blocks keep PISA pages from going idle. */
+			pisa_pcp_drain(pa);
 			freed += pisa_shrink_list(&pa->lock, &pa->idle,
 						  &pa->num_idle_pages, &release_list,
 						  sc->nr_to_scan - freed);
@@ -952,15 +1249,30 @@ VISIBLE_IF_KUNIT unsigned long pisa_shrink_scan(struct shrinker *shrink, struct
 	return freed ?: SHRINK_STOP;
 }
 
+/* Return the blocks a dead CPU cached, which nothing else would. */
+static int pisa_cpu_dead(unsigned int cpu)
+{
+	struct pisa_alloc *pa;
+
+	read_lock(&pisa_allocs_lock);
+	list_for_each_entry(pa, &pisa_allocs, node)
+		/* Pairs with smp_store_release() in pisa_enable_pcp(). */
+		if (smp_load_acquire(&pa->pcp))
+			pisa_pcp_drain_cpu(pa, cpu);
+	read_unlock(&pisa_allocs_lock);
+	return 0;
+}
+
 static int __init pisa_init(void)
 {
 	const struct {
 		u8 order;
 		bool ro;
+		bool pcp;
 	} cfg[] = {
-		{ 0, false },
-		{ 2, true },
-		{ SKB_FRAG_PAGE_ORDER, true },
+		{ 0, false, true },
+		{ 2, true, false },
+		{ SKB_FRAG_PAGE_ORDER, true, true },
 	};
 	struct shrinker *shrink;
 	int nid, i;
@@ -986,6 +1298,8 @@ static int __init pisa_init(void)
 			if (!pa)
 				continue;
 			pisa_set_name(pa, "pisa%s_o%u_n%d", ro ? "_ro" : "", order, nid);
+			if (cfg[i].pcp)
+				pisa_enable_pcp(pa);
 			pisa_nodes[nid].pa[ro][order] = pa;
 		}
 	}
@@ -995,6 +1309,10 @@ static int __init pisa_init(void)
 	if (!pisa_wq)
 		pr_warn("pisa: no reclaim workqueue, falling back to system_wq\n");
 
+	if (cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN, "iommu/pisa:dead", NULL,
+				      pisa_cpu_dead) < 0)
+		pr_warn("pisa: no CPU hotplug callback, offline CPUs keep cached blocks\n");
+
 	shrink = shrinker_alloc(0, "pisa");
 	if (!shrink) {
 		pr_warn("pisa: shrinker registration failed\n");
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 72ee8986b4802..5bbb540eb505e 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -482,6 +482,82 @@ static void test_dev_pisa_attrs(struct kunit *test)
 	device_unregister(dev);
 }
 
+static void test_pcp_cache(struct kunit *test)
+{
+	struct page *blocks[PISA_PCP_HIGH + 1];
+	struct pisa_alloc *pa;
+	struct page *p1, *p2;
+	unsigned int i, n = 0;
+
+	KUNIT_EXPECT_EQ(test, pisa_enable_pcp(NULL), 0);
+	pa = pisa_node_pa(first_memory_node, 0, false);
+	KUNIT_ASSERT_NOT_NULL(test, pa);
+	KUNIT_ASSERT_EQ(test, pisa_enable_pcp(pa), 0);
+
+	p1 = pisa_alloc(pa, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, p1);
+	__free_page(p1);
+	p2 = pisa_alloc(pa, GFP_KERNEL | __GFP_ZERO);
+	KUNIT_EXPECT_PTR_EQ(test, p2, p1);
+	if (p2)
+		__free_page(p2);
+
+	/* Overflowing PISA_PCP_HIGH flushes a batch back to the allocator. */
+	for (i = 0; i < ARRAY_SIZE(blocks); i++) {
+		blocks[i] = pisa_alloc(pa, GFP_KERNEL);
+		if (!blocks[i])
+			break;
+		n++;
+	}
+	KUNIT_EXPECT_EQ(test, n, (unsigned int)ARRAY_SIZE(blocks));
+	for (i = 0; i < n; i++)
+		__free_page(blocks[i]);
+}
+
+static void test_gfp_pisa(struct kunit *test)
+{
+	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
+	struct device dev = { .numa_node = first_memory_node };
+	struct page *p, *p_ro, *bulk[4] = {};
+	unsigned long n;
+	int i;
+
+	pisa_shrink_scan(NULL, &sc);
+	KUNIT_EXPECT_EQ(test, pisa_rx_gfp(NULL), 0);
+	KUNIT_EXPECT_EQ(test, pisa_rx_gfp(&dev), 0);
+	KUNIT_EXPECT_FALSE(test, pisa_has_free_blocks_rx(&dev, 0, first_memory_node));
+
+	dev.pisa_rx_bufs = true;
+	KUNIT_EXPECT_EQ(test, pisa_rx_gfp(&dev), __GFP_PISA_RW);
+
+	p = alloc_pages_node(first_memory_node, GFP_KERNEL | pisa_rx_gfp(&dev), 0);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	if (p) {
+		KUNIT_EXPECT_TRUE(test, is_pisa_page(p));
+		KUNIT_EXPECT_EQ(test, pisa_meta_of_pfn(page_to_pfn(p))->prot,
+				IOMMU_READ | IOMMU_WRITE);
+		__free_page(p);
+		KUNIT_EXPECT_TRUE(test, pisa_has_free_blocks_rx(&dev, 0, first_memory_node));
+	}
+
+	p_ro = alloc_pages(GFP_KERNEL | __GFP_COMP | __GFP_PISA_RO, 3);
+	KUNIT_ASSERT_NOT_NULL(test, p_ro);
+	if (p_ro) {
+		KUNIT_EXPECT_TRUE(test, is_pisa_page(p_ro));
+		KUNIT_EXPECT_EQ(test, pisa_meta_of_pfn(page_to_pfn(p_ro))->prot,
+				IOMMU_READ);
+		__free_pages(p_ro, 3);
+	}
+
+	n = alloc_pages_bulk_node(GFP_KERNEL | __GFP_PISA_RW, first_memory_node,
+				  ARRAY_SIZE(bulk), bulk);
+	KUNIT_EXPECT_EQ(test, n, ARRAY_SIZE(bulk));
+	for (i = 0; i < n; i++) {
+		KUNIT_EXPECT_TRUE(test, is_pisa_page(bulk[i]));
+		__free_page(bulk[i]);
+	}
+}
+
 static void test_reservoir_and_scrubber(struct kunit *test)
 {
 	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
@@ -499,6 +575,8 @@ static struct kunit_case pisa_meta_test_cases[] = {
 #endif
 	KUNIT_CASE(test_coherent_alloc_and_free),
 	KUNIT_CASE(test_dev_pisa_attrs),
+	KUNIT_CASE(test_pcp_cache),
+	KUNIT_CASE(test_gfp_pisa),
 	KUNIT_CASE(test_reservoir_and_scrubber),
 	{}
 };
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index e5ca95d2654cd..8f87bdf7d4ee2 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -53,6 +53,7 @@ enum {
  * Lock hierarchy:
  * - pisa_allocs_lock (rwlock): outermost; protects pisa_allocs list.
  * - pisa_meta_mutex (mutex): serializes pisa_meta_init() and page-table alloc.
+ * - pcp->lock (spinlock, irqsave): per-CPU block cache.
  * - pa->lock (spinlock, irqsave): per-allocator lists, bitmaps, and stats.
  * - pisa_domains[].map_lock (spinlock, irqsave): first-time iommu_map() in __pisa_map_phys().
  * - pisa_domains_lock (spinlock, irqsave): leaf lock over pisa_domains[]/windows.
@@ -105,11 +106,28 @@ static inline unsigned int pisa_meta_avail(const struct pisa_meta *meta)
 	return meta->nr_clean + meta->nr_dirty;
 }
 
+/* Per-CPU front cache of free blocks at refcount 0, see pisa_enable_pcp(). */
+#define PISA_PCP_HIGH	64U	/* blocks cached per CPU at most */
+#define PISA_PCP_BATCH	32U	/* blocks moved per refill or flush */
+
+struct pisa_pcp {
+	spinlock_t	lock;	/* by this CPU, or by a drain from any CPU */
+	unsigned int	count;
+	struct page	*blocks[PISA_PCP_HIGH];
+};
+
+/* Per-allocator statistics, see pisa_allocs_show(). */
+struct pisa_alloc_stats {
+	u64		page_alloc_cnt;
+	u64		page_free_cnt;
+};
+
 /**
  * struct pisa_alloc - Allocator managing 2MB-backed blocks of a fixed order
- * @lock:	Spinlock protecting lists and block bitmaps
+ * @lock:	Spinlock protecting lists, block bitmaps, and u64 @stats
  * @order:	Block order managed by this allocator (<= PISA_ORDER)
  * @prot:	IOMMU_READ and/or IOMMU_WRITE from @dir passed to pisa_create()
+ * @pcp:	Per-CPU block caches, or NULL (see pisa_enable_pcp())
  * @partial:	Partially used PISA pages with @nr_clean > 0
  * @partial_dirty: Partially used PISA pages with @nr_clean == 0 and @nr_dirty > 0
  * @idle:	Completely free PISA pages (reclaimable under pressure)
@@ -117,15 +135,18 @@ static inline unsigned int pisa_meta_avail(const struct pisa_meta *meta)
  * @num_idle_pages: Length of @idle
  * @max_idle_pages: High watermark of @idle before async release to the buddy allocator
  * @idle_jiffies: Timestamp (jiffies) when @idle last exceeded @max_idle_pages
+ * @blocks_in_use: Blocks handed out and not yet freed
  * @nid:	NUMA node id
  * @node:	Node in the global pisa_allocs list
  * @name:	Debug name (defaults to caller of pisa_create())
+ * @stats:	Per-allocator statistics
  */
 struct pisa_alloc {
 	/* First cacheline: hot fields touched on block alloc and free. */
 	spinlock_t		lock;
 	u8			order;
 	u8			prot;
+	struct pisa_pcp __percpu *pcp;
 	struct list_head	partial;
 	struct list_head	partial_dirty;
 	struct list_head	idle;
@@ -133,12 +154,22 @@ struct pisa_alloc {
 	unsigned int		num_idle_pages;
 	unsigned int		max_idle_pages;
 	unsigned long		idle_jiffies;
+	unsigned long		blocks_in_use;
 	/* Cold. */
 	int			nid;
 	struct list_head	node;
 	char			name[48];
+	struct pisa_alloc_stats	stats;
 } ____cacheline_aligned;
 
+/* Active non-idle PISA pages held by @pa, for soft compaction checks. */
+static inline long pisa_alloc_held_pages(const struct pisa_alloc *pa)
+{
+	return (long)(READ_ONCE(pa->stats.page_alloc_cnt) -
+		      READ_ONCE(pa->stats.page_free_cnt)) -
+	       READ_ONCE(pa->num_idle_pages);
+}
+
 /* Per-NUMA-node PISA state. */
 struct pisa_node {
 	unsigned long		next_alloc;	/* atomic alloc backoff jiffies */
@@ -202,6 +233,8 @@ struct pisa_alloc *pisa_create(int nid, unsigned int order, enum dma_data_direct
 struct pisa_alloc *pisa_node_pa(int nid, unsigned int order, bool ro);
 __printf(2, 3)
 void pisa_set_name(struct pisa_alloc *pa, const char *fmt, ...);
+int pisa_enable_pcp(struct pisa_alloc *pa);
+void pisa_pcp_drain(struct pisa_alloc *pa);
 void pisa_release_page(struct pisa_meta *meta);
 unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
 			      unsigned long nr_pages, struct page **page_array, bool frozen);
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index a6556aa403a09..cdf176464d74a 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -100,6 +100,7 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order,
 				    bool frozen);
 
 bool pisa_has_free_blocks_rx(const struct device *dev, unsigned int order, int nid);
+bool pisa_page_can_recycle(const struct page *page);
 
 static inline gfp_t pisa_rx_gfp(const struct device *dev)
 {
@@ -139,6 +140,11 @@ static inline bool pisa_free_coherent(struct page *page, size_t size)
 	return false;
 }
 
+static inline bool pisa_page_can_recycle(const struct page *page)
+{
+	return true;
+}
+
 static inline unsigned long
 pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred_nid,
 		      nodemask_t *nodemask, int nr_pages,
-- 
2.56.0.542.g3ef89b7020-goog

