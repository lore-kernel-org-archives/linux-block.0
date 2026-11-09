Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248745;
	b=ZyTZVxINxckUHfu1Ylm0K4gp3IUjLYwCIgIXEV//4etuqsKIFbpLWo4OFPtTFZjawDIL
	 zsTg1ibiPlaa2fkZQtSiBBUiT9hLKXKOfgB2QVbwd8nved7ZKPz+ba4Rf195UMnUNHMOl
	 E6fXbHH/tenwSsLUAmB4dgAQt91G8n8M8TTuwDoaueKgwEU6fpafGSddL49t4R3g+0oAh
	 qKQBDIlqz1xTxtaUhD40DnUE0iNe7DvU5sw4EaHEikZXrfQ2YW57yR/KWnl6U3xfDlTtB
	 TM0nu6uC+IRRPBZzVC07KZngSWw37iYvG96ogZ9/0h8EQz+0H+SqEnS5GxY9FVnw9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=54ExQeOShcGppfyJua980qoDBOFtyYHHsHDIcQmw4W4=;
	b=HoaEHh0aEFwdZhH32IUt5NZWVOkDv2DlJoY2lfyZM4f+r0gp6eYPUBH5DyxbGkRHtv/7
	 +tCAFQ4P0VYOY01kda0s90nsS/wTTL+KZvFUEgtFKrhN8fe3pjxtT0PBcXB2Qf1JdBQ8W
	 hkQX1mLEM9++jXI81Jzp6eBYrPmRTqzj3yR/4JzGSq4YaA/VEAPDxWOjYhZnZ3ZsK23h+
	 xf9brWcqOMjsTEXDiB4lhbt7vGCDjYCxeENOUaCf8apHuAW2CGEP/u4ZvJW3sV/qYsgbG
	 rV0quMxlurrLtTgtXhQtDfggf7fdWkT1EwHM/SQBg/v7OkqI+/pto7u4X3shFiq0YJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p2jSV5qO;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011D60A382E
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3011D60A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p2jSV5qO
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b42827bb4bso820996a12.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248743; x=1794853543; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54ExQeOShcGppfyJua980qoDBOFtyYHHsHDIcQmw4W4=;
        b=p2jSV5qO0XBa1qgKeWrpSAaOlwovte9S4H8sptAoi/MFd2T/v6+jDkMxZdVEIzwA7Y
         Aw2NPfYCWLO0hjKZpPoGMMoKJuCBRrCj9GyykHMZpHcWEsWig0dSZ0vnvvzEGqs8WjPP
         4qOx2dORsulpFdpjIpi/nI+dJCoFRoc+0nbOUa/URO41gCsIobaQpGwawpJAXsSpMhwy
         FVKcIiqjbDtxkcdF0710b0VoBzmniP45mD7lqefgEZEO5oJzmOpNXd0x3ydA43MztdDJ
         UxvvD4nxs/pCPFMhvI9Nrbu1ExneZT2+IW5GzdmMIHxCwdWso4jnWxM+5aUVnMqY+y8i
         o07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248743; x=1794853543;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54ExQeOShcGppfyJua980qoDBOFtyYHHsHDIcQmw4W4=;
        b=FvclA/Jv39lpHj1zzF/27E03Dr9RK1jySsuHNzlLe6QD/V0vxLzt0pknZRskaDahyN
         YqoRajithnpUlIjHh5z9Xe/cPQSqgFfZuBf8UTzaPE3OqsrytKbWdRuouu/iDSLViW5L
         M5FvKikF3E2bgwcPz1CLeExwgte6zBxlgfPk7QcNyE5/eBUKVq4wcb30SXM8kdCNLUok
         JXe9wT9iMKGMpSEzhuVkiT23RWKJj1t7Wc5k1dD9Kokp76w+ALGklo1+CNytHfYAC2kP
         pZ8SRvrvCsMlURdV9sIdKAvIe4q14ZLRfzXdtSXPl3OjraXcbDqf110UT5vkZwv35ZiB
         WWvw==
X-Forwarded-Encrypted: i=1; AL+hErGVF8aflKjoahbWjTQQKkDuCE5wm2GpgjeDY2UvqysvelF+fg9uTLThRDKkdFt/vwP5EHYtJKFU16Jfyw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+FsDWyBy1q9wzZyoeP3NWU6XeTmM1m1/pquGdeDJIzcYKuwffK
	W+yv+68LGWn648a/OPocf84fOTcQqp9sT6UDdEUVCJOsSrZfFCIMg/FcdeC+8kfKjgaPt6i++xR
	ssKAUlQ==
X-Received: from ejblh15.prod.google.com ([2002:a17:906:f8cf:b0:c34:bb1f:3bc4])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:c155:b0:c2d:fade:e089
 with SMTP id a640c23a62f3a-c5048c88b3cmr21975766b.0.1794248742269; Mon, 09
 Nov 2026 10:25:42 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:13 +0000
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
Message-ID: <20261109182533.3594984-6-lrizzo@google.com>
Subject: [RFC PATCH v2 05/25] iommu/dma: Add global cap and shrinker for PISA pages
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

Add two mechanisms to bound the number of unused PISA pages:

 - a global ceiling, pisa.max_pages, on the number of PISA pages pinned
   across all allocators and reservoirs, defaulting to one eighth of RAM,
   with a floor for small machines.

 - a shrinker that, under reclaim, drains the per-node reservoirs first
   and then completely idle pages across all allocators.
   Idle pages are detached under the allocator lock but retired outside
   it, to avoid holding the lock during the expensive unmaps/iotlb flush.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 91 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c | 15 +++++++
 drivers/iommu/pisa-node.c  | 25 +++++++++++
 drivers/iommu/pisa-priv.h  | 15 +++++++
 4 files changed, 146 insertions(+)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 1f1b99023094c..de8009fd6fff3 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -4,6 +4,7 @@
  * See Documentation/core-api/pisa.rst for the architecture overview.
  */
 
+#include <kunit/visibility.h>
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
@@ -22,6 +23,7 @@
 #include <linux/pgalloc_tag.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/mm.h>
+#include <linux/shrinker.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -40,6 +42,11 @@ static LLIST_HEAD(pisa_free_list);
 /* Dedicated WQ_MEM_RECLAIM workqueue, can run without allocations. */
 static struct workqueue_struct *pisa_wq __ro_after_init;
 
+/* Global count and ceiling on PISA pages across all allocators and reservoirs (0 = 1/8 RAM). */
+atomic_long_t pisa_nr_pages __cacheline_aligned_in_smp;
+unsigned long pisa_max_pages __read_mostly;
+module_param_named(max_pages, pisa_max_pages, ulong, 0644);
+
 /* Max completely idle PISA pages kept per allocator before async release. */
 static unsigned int pisa_max_idle __read_mostly = 1;
 module_param_named(max_idle, pisa_max_idle, uint, 0644);
@@ -81,6 +88,7 @@ static void pisa_release_page_rcu(struct rcu_head *head)
 
 	WRITE_ONCE(meta->pa, NULL);
 
+	atomic_long_dec(&pisa_nr_pages);
 	for (i = 0; i < PISA_BLOCKS(order); i++) {
 		block = page + (i << order);
 		page_ref_unfreeze(block, 1);
@@ -93,6 +101,7 @@ void pisa_release_page(struct pisa_meta *meta)
 {
 	if (!meta->pa) {
 		__free_pages(pfn_to_page(pisa_meta_to_pfn(meta)), PISA_ORDER);
+		atomic_long_dec(&pisa_nr_pages);
 		return;
 	}
 
@@ -688,6 +697,72 @@ bool __pisa_free_page(struct page *page)
 	return true;
 }
 
+/* Shrinker: releases reservoir pages first, then idle allocator pages. */
+static unsigned long pisa_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	unsigned long nr = pisa_reservoir_count();
+	struct pisa_alloc *pa;
+
+	read_lock(&pisa_allocs_lock);
+	list_for_each_entry(pa, &pisa_allocs, node)
+		nr += READ_ONCE(pa->num_idle_pages);
+	read_unlock(&pisa_allocs_lock);
+
+	return nr << PISA_ORDER;
+}
+
+/* Detach PISA pages from @list onto @release_list up to @nr_to_scan base pages. */
+unsigned long pisa_shrink_list(spinlock_t *lock, struct list_head *list,
+			       unsigned int *nr, struct list_head *release_list,
+			       unsigned long nr_to_scan)
+{
+	unsigned long freed = 0, flags;
+
+	spin_lock_irqsave(lock, flags);
+	while (freed < nr_to_scan && !list_empty(list)) {
+		list_move(list->next, release_list);
+		(*nr)--;
+		freed += 1UL << PISA_ORDER;
+	}
+	spin_unlock_irqrestore(lock, flags);
+
+	return freed;
+}
+
+VISIBLE_IF_KUNIT unsigned long pisa_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	struct pisa_meta *meta, *tmp;
+	struct pisa_alloc *pa;
+	unsigned long freed;
+	LIST_HEAD(release_list);
+
+	freed = pisa_reservoir_shrink(&release_list, sc->nr_to_scan);
+
+	if (freed < sc->nr_to_scan) {
+		read_lock(&pisa_allocs_lock);
+		list_for_each_entry(pa, &pisa_allocs, node) {
+			freed += pisa_shrink_list(&pa->lock, &pa->idle,
+						  &pa->num_idle_pages, &release_list,
+						  sc->nr_to_scan - freed);
+
+			if (freed >= sc->nr_to_scan)
+				break;
+		}
+		read_unlock(&pisa_allocs_lock);
+	}
+
+	/* Retiring must not run under @pa->lock. */
+	list_for_each_entry_safe(meta, tmp, &release_list, list) {
+		list_del_init(&meta->list);
+		pisa_release_page(meta);
+	}
+
+	/* Charge do_shrink_slab() for the full PISA pages reclaimed. */
+	sc->nr_scanned = freed;
+
+	return freed ?: SHRINK_STOP;
+}
+
 static int __init pisa_init(void)
 {
 	const struct {
@@ -698,10 +773,15 @@ static int __init pisa_init(void)
 		{ 2, true },
 		{ SKB_FRAG_PAGE_ORDER, true },
 	};
+	struct shrinker *shrink;
 	int nid, i;
 
 	pisa_node_init();
 
+	/* Default ceiling is 1/8th of RAM (floor of 16 PISA pages). */
+	if (!pisa_max_pages)
+		pisa_max_pages = max(totalram_pages() >> (PISA_ORDER + 3), 16UL);
+
 	/* Preallocate the supported per-node allocators. */
 	for_each_node_state(nid, N_MEMORY) {
 		for (i = 0; i < ARRAY_SIZE(cfg); i++) {
@@ -724,6 +804,17 @@ static int __init pisa_init(void)
 	if (!pisa_wq)
 		pr_warn("pisa: no reclaim workqueue, falling back to system_wq\n");
 
+	shrink = shrinker_alloc(0, "pisa");
+	if (!shrink) {
+		pr_warn("pisa: shrinker registration failed\n");
+		return 0;
+	}
+
+	shrink->count_objects = pisa_shrink_count;
+	shrink->scan_objects = pisa_shrink_scan;
+	shrink->seeks = DEFAULT_SEEKS;
+	shrinker_register(shrink);
+
 	return 0;
 }
 subsys_initcall(pisa_init);
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index bdc52e6497b05..96bc8dbc38fb4 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -6,6 +6,7 @@
 #include <linux/gfp.h>
 #include <linux/pisa.h>
 #include <linux/mm.h>
+#include <linux/shrinker.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 
@@ -98,8 +99,10 @@ static void test_alloc_and_recycle(struct kunit *test)
 		{ 2, true },
 		{ SKB_FRAG_PAGE_ORDER, true },
 	};
+	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
 	struct page *p1, *p2, *bulk[3];
 	struct pisa_alloc *pa;
+	unsigned long old_max;
 	unsigned int i;
 
 	KUNIT_EXPECT_NULL(test, pisa_create(first_memory_node, 0, DMA_NONE));
@@ -115,6 +118,7 @@ static void test_alloc_and_recycle(struct kunit *test)
 
 		pa = pisa_node_pa(first_memory_node, order, cases[i].ro);
 		KUNIT_ASSERT_NOT_NULL(test, pa);
+		pisa_shrink_scan(NULL, &sc);
 		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_ACCOUNT));
 		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_DMA32));
 		KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL | __GFP_THISNODE));
@@ -155,6 +159,7 @@ static void test_alloc_and_recycle(struct kunit *test)
 
 		if (p2)
 			__free_pages(p2, order);
+		pisa_shrink_scan(NULL, &sc);
 	}
 
 	/* Plain alloc_page() without __GFP_PISA_* comes from the buddy allocator. */
@@ -162,6 +167,16 @@ static void test_alloc_and_recycle(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, p1);
 	KUNIT_EXPECT_FALSE(test, is_pisa_page(p1));
 	__free_pages(p1, 0);
+
+	/* Global budget cap (pisa_max_pages = 0) refuses new PISA pages. */
+	pa = pisa_node_pa(first_memory_node, 2, true);
+	KUNIT_ASSERT_NOT_NULL(test, pa);
+	old_max = READ_ONCE(pisa_max_pages);
+	WRITE_ONCE(pisa_max_pages, 0);
+	WRITE_ONCE(pisa_reservoir_max, 0);
+	KUNIT_EXPECT_NULL(test, pisa_alloc(pa, GFP_KERNEL));
+	WRITE_ONCE(pisa_reservoir_max, 16);
+	WRITE_ONCE(pisa_max_pages, old_max);
 }
 
 static void test_reservoir_and_scrubber(struct kunit *test)
diff --git a/drivers/iommu/pisa-node.c b/drivers/iommu/pisa-node.c
index 524f0d4457ad7..0f23b94a7a6f8 100644
--- a/drivers/iommu/pisa-node.c
+++ b/drivers/iommu/pisa-node.c
@@ -74,6 +74,10 @@ static struct pisa_meta *__pisa_page_alloc(gfp_t gfp, int nid, bool can_block,
 			return ERR_PTR(-EAGAIN);
 	}
 
+	/* Racy check against global ceiling across allocators and reservoirs. */
+	if (atomic_long_read(&pisa_nr_pages) >= READ_ONCE(pisa_max_pages))
+		return ERR_PTR(-ENOSPC);
+
 	/*
 	 * Long-lived active pages must be unmovable, lowmem, non-compound, and
 	 * must not dip into emergency reserves or trigger OOM/warnings.
@@ -102,6 +106,8 @@ static struct pisa_meta *__pisa_page_alloc(gfp_t gfp, int nid, bool can_block,
 
 	meta = pisa_meta_of_pfn(page_to_pfn(page));
 	memset(meta, 0, sizeof(*meta));
+
+	atomic_long_inc(&pisa_nr_pages);
 	*clean = (gfp & __GFP_ZERO) || want_init_on_alloc(0) || want_init_on_free();
 
 	return meta;
@@ -256,6 +262,25 @@ unsigned long pisa_reservoir_count(void)
 	return nr;
 }
 
+/* Detach up to @nr_to_scan base pages from reservoirs onto @release_list. */
+unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan)
+{
+	unsigned long freed = 0;
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct pisa_node *res = &pisa_nodes[nid];
+
+		if (!READ_ONCE(res->nr_pages))
+			continue;
+		freed += pisa_shrink_list(&res->lock, &res->pages, &res->nr_pages,
+					  release_list, nr_to_scan - freed);
+		if (freed >= nr_to_scan)
+			break;
+	}
+	return freed;
+}
+
 void __init pisa_node_init(void)
 {
 	int nid;
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index f15934ccdeea4..d5ea83745ba47 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -115,6 +115,16 @@ int pisa_meta_ensure_pfn(unsigned long pfn, bool can_block);
 struct pisa_meta *pisa_meta_of_pfn(unsigned long pfn);
 unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta);
 
+struct shrink_control;
+struct shrinker;
+#if IS_ENABLED(CONFIG_KUNIT)
+unsigned long pisa_shrink_scan(struct shrinker *shrink, struct shrink_control *sc);
+#endif
+
+/* Global PISA page budget across all allocators and per-node reservoirs. */
+extern atomic_long_t pisa_nr_pages;
+extern unsigned long pisa_max_pages;
+
 static inline int pisa_sanitize_nid(int nid)
 {
 	if ((unsigned int)nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
@@ -149,12 +159,17 @@ static inline struct page *pisa_alloc(struct pisa_alloc *pa, gfp_t gfp)
 	return page;
 }
 
+unsigned long pisa_shrink_list(spinlock_t *lock, struct list_head *list,
+			       unsigned int *nr, struct list_head *release_list,
+			       unsigned long nr_to_scan);
+
 /* pisa-node.c: per-NUMA-node PISA page reservoir and work item */
 extern unsigned int pisa_reservoir_max;
 void pisa_node_init(void);
 void pisa_schedule_reservoir(void);
 struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool *clean);
 unsigned long pisa_reservoir_count(void);
+unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan);
 
 #endif /* CONFIG_PISA */
 #endif /* _DRIVERS_IOMMU_PISA_PRIV_H */
-- 
2.56.0.542.g3ef89b7020-goog

