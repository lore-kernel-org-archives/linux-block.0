Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248750;
	b=2Ur4dIQPbGCm2OwTIUr42w6jj0HN6NaAJyAOA52EWGmPKXnIUEAuawdCj8UA3lG8PD8k
	 gGx0H/58ZUg0JixMmkG8NdkviDBU7TTty4ecUWNqAaqQsuBeXkyFcGrqSdhE+gdeeJpdI
	 mHb7qExli26ahWBA999ddpjDAnoQzxlUtUJ3umv9zgIBfKZ4OEDWCk8+8QRccwe4bNtnI
	 mQ7V4L7hfRt/403z6OJgo8nQWJor6R4cTIZ5J0BdkYrWYx/VBJhGjxALdCKsN6In0htak
	 sXwVQb1MWIhLWDPeMW3+vX8sIwbX6YXr9oMWC9L35i3IMkqgI5WZYpPuNG2fumZA1wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nKbnCwTfLzajXiNpupOHjxARAnB6qVXNJxTLmCpPRqc=;
	b=mPqMPAUUF3c8R+ZUCEa4WNSPchuIVHW/szWFR5a1qoLTTxwGOi9QUb3VVkbtsATBOV3O
	 UqGRcEtme+QgSJFiB+v7u+3DUMynFoNVf3SVlGzplU4y0v1otR75PYIfLqqQD9x/o8BPV
	 hKqv6oZQ0nHWNU5LOcwwn1qECnQIjbI/noV+17j8c+nxopdw17qJQ/burGoYvRVTM5YmT
	 orj5lVTdMddNQK2Ks/yV5AaEWpQfZGxlixfv+b1wLUfapZ3uuJCbFdZwY1nq98Z3uG/ZE
	 iU+8av4vXwmmokdLUqhYwfZDlLhTYHg7LeL9xdrIfZ4LWCaHNwP5A1L/jiaGojam5ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CBOfCFW9;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4B60A260E
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D4B60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CBOfCFW9
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c37b2763f1bso146244066b.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248747; x=1794853547; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKbnCwTfLzajXiNpupOHjxARAnB6qVXNJxTLmCpPRqc=;
        b=CBOfCFW9BCHBjXQAG41PvKQQ+STG811+rxmPzoybSMJ426P0wW0koSykG9DfcxuF/J
         QLdlfIJ/ih4Lr0Uo8ZCkjWxtOsvi4vdKRnG5ffdmcUvG6idNr9qfZdL/0yykC3Yjgz8E
         ifDH9z18sncJt3nhxsebM8+bOMXVBExjZ1tHWQYLlYe2AtIMV59zSyqZpRJmrpuCyeIM
         jcHK+FVEUKPaHwwGZhQhwXCIm6KH1FiO743dLJUtujdKTSFf18OIEWlZoRN6qBWAYCEO
         SQJUeYL+4cxPfCtwb1UinB/8PI4GJ6Ldj9gOuWCVDn02G+4nclNwLH0pxTaDwPfb3JqW
         fejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248747; x=1794853547;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKbnCwTfLzajXiNpupOHjxARAnB6qVXNJxTLmCpPRqc=;
        b=sAs/Od5UsaCyQ0+lxBeC03dt6rLmVQN6zYORVbu5+wR74UnfQuSNpsnqxA6hPZ8nMH
         17OLs4jjp+oV3tF2Gb17QI0HT2IihPcK/Jx/+wVbPlWafTvWZOvzdidWcwWdisV3QD5r
         +oDoJTP5wAkI9h5E+7ba/8bIQDwcNRmwO1fw1KmLVhqA1VkgAI6A/Orn2lFSPcu9Y9aT
         kIc53i8q3BJHgCjJihNk92htln0cOas93KBPSaO/zaB8zn+9y8Wv9045XP6fV5I0H51Q
         gEZ34yfF7zGeDItbvrviQ9HB8qpnSg8U10EtAFBmQaYfx0I8+qh9Pbm+7tCXk3yp7NLv
         4Ctg==
X-Forwarded-Encrypted: i=1; AL+hErG5HA1wvIlvVuLEMv8OeYsZSbe3ATSHxmu6myQs9SiMJzuu4ej0QzK/ZZXT1URcRrxlP9Dpaz0GF156tA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ptvLBnBSMFLYAbSDV+30lz7AAaDbv7Yo/GuEId+ilq0/403Z+
	tmKOYNDMPPikWAtsua0m42GrMpFBzP3lYiX5dmL27K31k42OYZXGw9pnYEYr3cJtWKfgiAJZ8iS
	NWWHltg==
X-Received: from ejdlt8-n1.prod.google.com ([2002:a17:907:c648:10b0:c2e:34bc:d4b1])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e20:b0:c41:64c1:cc2d
 with SMTP id a640c23a62f3a-c50491bd62emr17857866b.2.1794248747203; Mon, 09
 Nov 2026 10:25:47 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:18 +0000
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
Message-ID: <20261109182533.3594984-11-lrizzo@google.com>
Subject: [RFC PATCH v2 10/25] iommu/dma: Use PISA for coherent DMA allocations
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

Coherent DMA allocations (e.g. TX/RX descriptor rings allocated via
dma_alloc_attrs() / dma_alloc_coherent()) are long-lived and accessed
on every packet or I/O operation, so they benefit from sharing 2MB IOMMU
leaf mappings.

When dev->pisa_coherent is enabled, serve coherent DMA allocations up
to 2MB from the device's per-NUMA-node order-0 read-write PISA
allocator.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/dma-iommu.c  |  10 +++
 drivers/iommu/pisa-alloc.c | 146 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c |  67 +++++++++++++++++
 include/linux/pisa.h       |  30 ++++++++
 kernel/dma/direct.c        |   9 +++
 5 files changed, 262 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index eb920ad77c783..a0c5ddab7a8b6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1658,6 +1658,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 	} else {
 		/* Lowmem means a coherent atomic or CMA allocation */
 		page = virt_to_page(cpu_addr);
+		if (pisa_free_coherent(page, alloc_size))
+			return;
 	}
 
 	if (pages)
@@ -1716,6 +1718,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		gfp_t gfp, unsigned long attrs)
 {
 	bool coherent = dev_is_dma_coherent(dev);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	bool is_alloc_cc_shared = attrs & __DMA_ATTR_ALLOC_CC_SHARED;
 	struct page *page = NULL;
@@ -1727,6 +1730,12 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	gfp |= __GFP_ZERO;
 
+	if (domain) {
+		cpu_addr = pisa_alloc_coherent(&page, dev, domain, size, gfp, attrs);
+		if (cpu_addr)
+			goto map;
+	}
+
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
 		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
@@ -1744,6 +1753,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			return NULL;
 	}
 
+map:
 	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
 			dev->coherent_dma_mask);
 	if (*handle == DMA_MAPPING_ERROR) {
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index b0d968aa9181c..25e4645310678 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -10,6 +10,8 @@
 #include <linux/bitops.h>
 #include <linux/cache.h>
 #include <linux/device.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
 #include <linux/pisa.h>
 #include <linux/export.h>
@@ -697,6 +699,150 @@ unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
 	return i;
 }
 
+/* Find and reserve @nblocks aligned contiguous blocks in @meta under @pa->lock. */
+static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblocks,
+				     unsigned long align_mask)
+{
+	DECLARE_BITMAP(busy, PISA_MAX_BLOCKS);
+	struct pisa_alloc *pa = meta->pa;
+	unsigned int bpp = PISA_BLOCKS(0), i;
+	bool poisoned = false;
+	unsigned long off;
+	struct page *page;
+
+	if (pisa_meta_avail(meta) < nblocks)
+		return NULL;
+
+	bitmap_or(busy, meta->clean_bitmap, meta->dirty_bitmap, bpp);
+	bitmap_complement(busy, busy, bpp);
+
+	off = 0;
+	for (;;) {
+		off = bitmap_find_next_zero_area(busy, bpp, off, nblocks, align_mask);
+		if (off >= bpp) {
+			if (poisoned) {
+				if (meta->on_list == PISA_LIST_IDLE_CLEAN ||
+				    meta->on_list == PISA_LIST_IDLE_DIRTY)
+					pa->num_idle_pages--;
+				pisa_place_meta(meta);
+			}
+			return NULL;
+		}
+
+		page = pfn_to_page(pisa_meta_to_pfn(meta) + off);
+		for (i = 0; i < nblocks; i++) {
+			if (!pisa_block_poisoned(pa, page + i))
+				continue;
+			if (__test_and_clear_bit(off + i, meta->clean_bitmap))
+				meta->nr_clean--;
+			else if (__test_and_clear_bit(off + i, meta->dirty_bitmap))
+				meta->nr_dirty--;
+			__set_bit(off + i, busy);
+			poisoned = true;
+			off += i + 1;
+			break;
+		}
+		if (i == nblocks)
+			break;
+	}
+
+	if (meta->on_list == PISA_LIST_IDLE_CLEAN ||
+	    meta->on_list == PISA_LIST_IDLE_DIRTY)
+		pa->num_idle_pages--;
+
+	for (i = 0; i < nblocks; i++) {
+		if (__test_and_clear_bit(off + i, meta->clean_bitmap)) {
+			meta->nr_clean--;
+		} else {
+			__clear_bit(off + i, meta->dirty_bitmap);
+			meta->nr_dirty--;
+		}
+		pisa_block_prep(page + i);
+		page_ref_unfreeze(page + i, 1);
+	}
+	pisa_place_meta(meta);
+	return page;
+}
+
+/*
+ * Specialized memory provider for iommu_dma_alloc() and dma_direct_alloc():
+ * allocate a zeroed, naturally aligned contiguous range of order-0 pages for
+ * @size bytes (<= PISA_SIZE) from @dev's per-node coherent allocator into
+ * *@pagep and return its kernel virtual address, or NULL.
+ */
+void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
+			  struct iommu_domain *domain, size_t size,
+			  gfp_t gfp, unsigned long attrs)
+{
+	bool should_release = false;
+	struct list_head *lists[3];
+	unsigned long align_mask, flags;
+	unsigned int nblocks, i;
+	struct pisa_meta *meta;
+	struct pisa_alloc *pa;
+	struct page *page = NULL;
+
+	size = PAGE_ALIGN(size);
+	if (!pagep || !dev || !READ_ONCE(dev->pisa_coherent) ||
+	    !dev_is_dma_coherent(dev) || !size || size > PISA_SIZE)
+		return NULL;
+	if (min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit) <= DMA_BIT_MASK(32))
+		return NULL;
+	if ((current_gfp_context(gfp) & ~(__GFP_ZERO | __GFP_NOWARN)) != GFP_KERNEL ||
+	    (attrs & ~DMA_ATTR_NO_WARN))
+		return NULL;
+
+	if (domain) {
+		struct pisa_window *win = pisa_dma_window(domain);
+
+		if (!win || pisa_window_declined(win) || !(domain->pgsize_bitmap & PISA_SIZE))
+			return NULL;
+	} else if (is_swiotlb_for_alloc(dev) ||
+		   force_dma_unencrypted(dev) ||
+		   !dma_coherent_ok(dev, PFN_PHYS(max_pfn) - 1, 1)) {
+		return NULL;
+	}
+
+	pa = pisa_node_pa(dev_to_node(dev), 0, false);
+	if (!pa)
+		return NULL;
+
+	nblocks = size >> PAGE_SHIFT;
+	align_mask = (1UL << get_order(size)) - 1;
+	lists[0] = &pa->partial;
+	lists[1] = &pa->partial_dirty;
+	lists[2] = &pa->idle;
+
+	spin_lock_irqsave(&pa->lock, flags);
+	for (i = 0; i < ARRAY_SIZE(lists) && !page; i++) {
+		list_for_each_entry(meta, lists[i], list) {
+			page = pisa_take_contig(meta, nblocks, align_mask);
+			if (page)
+				break;
+		}
+	}
+	if (!page) {
+		spin_unlock_irqrestore(&pa->lock, flags);
+		meta = pisa_alloc_split_page(0, gfp, pa->nid);
+		if (IS_ERR(meta))
+			return NULL;
+		spin_lock_irqsave(&pa->lock, flags);
+		meta->pa = pa;
+		meta->prot = pa->prot;
+		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
+		page = pisa_take_contig(meta, nblocks, align_mask);
+		if (unlikely(!page))
+			should_release = pisa_place_meta(meta);
+	}
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (should_release)
+		pisa_schedule_reclaim();
+	if (!page)
+		return NULL;
+	*pagep = page;
+	return memset(page_address(page), 0, size);
+}
 
 /**
  * __pisa_free_page - Recycle a freed block back into its PISA allocator
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index ab64657ad5c58..72ee8986b4802 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -352,6 +352,72 @@ static void test_map_and_domain_lifecycle(struct kunit *test)
 }
 #endif /* CONFIG_IOMMU_DMA */
 
+static void test_coherent_alloc_and_free(struct kunit *test)
+{
+	struct device dev = { .init_name = "pisa_kunit", .numa_node = NUMA_NO_NODE,
+			      .coherent_dma_mask = DMA_BIT_MASK(64),
+			      .pisa_coherent = true };
+	struct page *p1, *p2, *p3;
+	void *v1, *v2, *v3;
+#ifdef CONFIG_IOMMU_DMA
+	struct pisa_window *win;
+	dma_addr_t d1, d2;
+#endif
+
+	dev.dma_mask = &dev.coherent_dma_mask;
+	/* NUMA_NO_NODE would follow the node of the CPU the test runs on. */
+	set_dev_node(&dev, first_memory_node);
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	dev.dma_coherent = true;
+#endif
+	KUNIT_EXPECT_NULL(test, pisa_alloc_coherent(&p1, NULL, NULL, SZ_4K, GFP_KERNEL, 0));
+	KUNIT_EXPECT_NULL(test, pisa_alloc_coherent(&p1, &dev, NULL, SZ_4K,
+						    GFP_KERNEL | __GFP_ACCOUNT, 0));
+	KUNIT_EXPECT_NULL(test, pisa_alloc_coherent(&p1, &dev, NULL, PISA_SIZE + SZ_4K,
+						    GFP_KERNEL, 0));
+
+#ifdef CONFIG_IOMMU_DMA
+	/* Uninitialized domain has no DMA cookie/window yet. */
+	KUNIT_EXPECT_NULL(test, pisa_alloc_coherent(&p1, &dev, &fake_domain, SZ_4K,
+						    GFP_KERNEL | __GFP_NOWARN, 0));
+
+	KUNIT_ASSERT_EQ(test, fake_domain_setup(test), 0);
+	win = pisa_dma_window(&fake_domain);
+
+	v1 = pisa_alloc_coherent(&p1, &dev, &fake_domain, SZ_64K, GFP_KERNEL, 0);
+	KUNIT_ASSERT_NOT_NULL(test, v1);
+	KUNIT_ASSERT_EQ(test,
+			pisa_map_phys(&d1, &dev, &fake_domain, page_to_phys(p1), SZ_64K,
+				      IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE), 0);
+	KUNIT_EXPECT_TRUE(test, is_pisa_iova(win, d1));
+
+	v2 = pisa_alloc_coherent(&p2, &dev, &fake_domain, SZ_64K, GFP_KERNEL, 0);
+	KUNIT_ASSERT_NOT_NULL(test, v2);
+	KUNIT_EXPECT_PTR_EQ(test, v2, v1 + SZ_64K);
+	KUNIT_ASSERT_EQ(test,
+			pisa_map_phys(&d2, &dev, &fake_domain, page_to_phys(p2), SZ_64K,
+				      IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE), 0);
+	KUNIT_EXPECT_EQ(test, d2, d1 + SZ_64K);
+#else
+	v1 = pisa_alloc_coherent(&p1, &dev, NULL, SZ_64K, GFP_KERNEL, 0);
+	KUNIT_ASSERT_NOT_NULL(test, v1);
+	v2 = pisa_alloc_coherent(&p2, &dev, NULL, SZ_64K, GFP_KERNEL, 0);
+	KUNIT_ASSERT_NOT_NULL(test, v2);
+	KUNIT_EXPECT_PTR_EQ(test, v2, v1 + SZ_64K);
+#endif
+
+	/* Freeing p1 returns its 16 order-0 pages; next 64K alloc reuses them. */
+	KUNIT_EXPECT_TRUE(test, pisa_free_coherent(p1, SZ_64K));
+	v3 = pisa_alloc_coherent(&p3, &dev, NULL, SZ_64K, GFP_KERNEL, 0);
+	KUNIT_ASSERT_NOT_NULL(test, v3);
+	KUNIT_EXPECT_PTR_EQ(test, p3, p1);
+
+	KUNIT_EXPECT_TRUE(test, pisa_free_coherent(p2, SZ_64K));
+	KUNIT_EXPECT_TRUE(test, pisa_free_coherent(p3, SZ_64K));
+}
+
 static void kunit_check_pisa_attr(struct kunit *test, struct device *dev,
 				  const char *name, bool *field)
 {
@@ -431,6 +497,7 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_window_helpers),
 	KUNIT_CASE(test_map_and_domain_lifecycle),
 #endif
+	KUNIT_CASE(test_coherent_alloc_and_free),
 	KUNIT_CASE(test_dev_pisa_attrs),
 	KUNIT_CASE(test_reservoir_and_scrubber),
 	{}
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index 92482fce943e9..a6556aa403a09 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -13,6 +13,7 @@
 #include <linux/rcupdate.h>
 
 struct device;
+struct iommu_domain;
 
 #ifdef CONFIG_PISA
 
@@ -78,6 +79,21 @@ static inline bool pisa_free_page(struct page *page)
 	return ret;
 }
 
+void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
+			  struct iommu_domain *domain, size_t size,
+			  gfp_t gfp, unsigned long attrs);
+
+static inline bool pisa_free_coherent(struct page *page, size_t size)
+{
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	if (!page || !is_pisa_page(page))
+		return false;
+	while (count--)
+		__free_page(page++);
+	return true;
+}
+
 unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order,
 				    int preferred_nid, nodemask_t *nodemask,
 				    int nr_pages, struct page **page_array,
@@ -109,6 +125,20 @@ static inline bool pisa_free_page(struct page *page)
 	return false;
 }
 
+static inline void *pisa_alloc_coherent(struct page **pagep,
+					struct device *dev,
+					struct iommu_domain *domain,
+					size_t size, gfp_t gfp,
+					unsigned long attrs)
+{
+	return NULL;
+}
+
+static inline bool pisa_free_coherent(struct page *page, size_t size)
+{
+	return false;
+}
+
 static inline unsigned long
 pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred_nid,
 		      nodemask_t *nodemask, int nr_pages,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25e9a86835fd3..11052b65e573b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/cc_platform.h>
+#include <linux/pisa.h>
 
 #include "direct.h"
 
@@ -244,6 +245,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
+	cpu_addr = pisa_alloc_coherent(&page, dev, NULL, size, gfp, attrs);
+	if (cpu_addr) {
+		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), false);
+		return cpu_addr;
+	}
+
 	if (dma_direct_use_no_mapping(dev, attrs))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
@@ -424,6 +431,8 @@ void dma_direct_free(struct device *dev, size_t size,
 
 	if (is_vmalloc_addr(cpu_addr)) {
 		vunmap(cpu_addr);
+	} else if (pisa_free_coherent(virt_to_page(cpu_addr), size)) {
+		return;
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-- 
2.56.0.542.g3ef89b7020-goog

