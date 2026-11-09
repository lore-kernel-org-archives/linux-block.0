Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248748;
	b=1Er2zg7542b0hhps9lfsI1KCMgXLYFWLh6IpCwsih8rN16ED112t4lf7e/xfEWjDKSpp
	 acRwxqrC/LW0F7F2yZ1Fbhy/3yvqE15gIfLEkSOCRaWCfMlEiIOoII2c+RXYFjZZ5tC0Z
	 bjAklV7OVGAm5jLUfwdzSOyYqByWqIx1s93z9E1Oj/WCW09kvGkqETwt+xsl+XSZSble0
	 RuuOuQFIZqnrBYJxB8ZFZarwRjJWUJYq1cCC9nBnQryvWIl5dkRnvokDWeUeCDyFKfRTz
	 QSJH7+iw1JaF/YYw7eKu81631BZSsztpeJlv3jMe5y3lSabhIm01jvOwklozJGF2ugw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gdjHHHjkxMnS8Xe5zzoX8Nib91QKVtxe3qiH7UsiubI=;
	b=Yxb7c1PrwcyPB8M+TdqXQDIz0arKWC6htgaIvM7/kbCWljS0Lj19VN6zsvg/YNzEQ7Oo
	 1OptVT0p7bluEbSvS1zB3C3NXz3Nc01sB9/IZ0eyoyTNXm+ItV3u8ELTa4WxKNiqUbTJ4
	 rAA8dNgD2kgXB1amoTBDnyzXrLiYOmfGR/dpsz2gnXEHibtxLr8binFdqGHzJ57GLuatK
	 Nti9LTGeRJ5WYNfbjEd9L87Pog+7hEd6hR3cJXLIWGCD90fvIrKUilUbriNkCOOGWHxH7
	 Lmc3EfFH16kJSLYqIyi6eJph/jlaV9aiIFQi8AundMwlUJeBoa0qEQV3NkICLYmeLGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NPOfte81;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8360A6F44
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF8360A6F44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NPOfte81
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c4cd91204f4so96183866b.3
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248746; x=1794853546; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gdjHHHjkxMnS8Xe5zzoX8Nib91QKVtxe3qiH7UsiubI=;
        b=NPOfte8171quIJOIi79H7mGsvoWdF6oW35iFjrNN4a6oAXwpiN7UOmYMxrZzuM+Y7Y
         zQxlq37Tze01Uf40W+2LPHJ6194KhC/8MY2dykLOerQFMsT+7qhiYIJePcRCR8dDa7aS
         EyxKA8exSXJ8SAGpuQSQtBrox7ShzrvUWA0kkbrHKo2d4yDgpSC1htueVAF1OQ3ezc9K
         yIa7P5DS6akcR6J13N9HnslxpeDAJsaBEiG84+64pLa/d5UKkUFAdW8HD49Om8mhLQHa
         8cNkg5aRAfFBRMT/MtQuFCIhOoervgoUpmsBNHFABiCON61HtI1zBNX9/VM6jqq4Dd9I
         Lv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248746; x=1794853546;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gdjHHHjkxMnS8Xe5zzoX8Nib91QKVtxe3qiH7UsiubI=;
        b=A0fQTnmg9EAzDbN7w953c58vH5ioxQN4Z3z9PpYRwGZ3Y0uLxs+lxUVq7FxCibhCLf
         x1Lrp4s7tRJAzUf1X52Ur/NodG6TFjhrLW7Ol+eE9Wn4IaKizWxpkUiE6CPxydtjz5sR
         2V5+rE/5RZIIY0IVUXrkQJC3JbyoWXU6YOhRTJ1nMEHwfowSGNGJQoeM5ypnYfEShgS4
         9dZ4vX9ic4Ajz2xcq0Upqs+/JAFu0HLe+2bzzjRFLckj9gV8gmkwgHhtIgrcIVcVegCl
         2kL3Zp97u5zhiYILTBzyMhPB7ZTOHUytXzBT2ewSyx2Zr9nSGJ74J2pediNAIp6IMkjp
         922w==
X-Forwarded-Encrypted: i=1; AL+hErHEJgH/55iTmPR8F51+b5UuysAUMJQdGjqOVMy3JNcjD4gE5YRxLlY0UQZjhxPwJf+xKb+U9CUwKipmtQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z83Yogk6+BSvtV/sgu12x/NkAGhwnDnuMjOojDO8TlrFE0he1v3
	LeZPuKxq+ziGqmvT9k/CjGSIXSAq5PLjpY3DGKcC3U+gXnX0kiwU3KeC0sTK9p8HXT0Zoiv/yyv
	LcuFYYQ==
X-Received: from ejcxa26.prod.google.com ([2002:a17:907:b9da:b0:c46:b005:d96e])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:364f:b0:c2d:be57:f73a
 with SMTP id a640c23a62f3a-c504952c083mr12513166b.13.1794248745567; Mon, 09
 Nov 2026 10:25:45 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:16 +0000
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
Message-ID: <20261109182533.3594984-9-lrizzo@google.com>
Subject: [RFC PATCH v2 08/25] iommu/dma: Use per-domain IOVA window to map
 PISA memory
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

Intercept the DMA mapping and unmapping functions so that PISA
buffers are mapped within the reserved IOVA range.

This is implemented as follows:
- each domain that enables PISA (via per-device optin) is dynamically
  assigned an IOVA window and a compact index the first time it maps a
  PISA page.
  This way, one bit in pisa_meta suffices to record whether the domain
  has already mapped the page.
- The page is mapped in the domain at win->base + slot * 2MB on first
  use, and subsequent mappings reuse that translation.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/Kconfig      |   1 +
 drivers/iommu/dma-iommu.c  |  15 +++
 drivers/iommu/iommu.c      |   5 +-
 drivers/iommu/pisa-alloc.c |   5 +-
 drivers/iommu/pisa-kunit.c | 133 +++++++++++++++++++++++++++
 drivers/iommu/pisa-map.c   | 184 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-priv.h  |  35 ++++++-
 include/linux/pisa.h       |   3 +
 8 files changed, 377 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 15e06eaed0924..52cce0963525b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -428,6 +428,7 @@ config PISA
 	bool "Pre-mapped IOVA Superpage Allocator"
 	depends on X86_64 || ARM64
 	depends on !PREEMPT_RT
+	select NEED_SG_DMA_FLAGS
 	default y
 	help
 	  PISA is a specialized memory allocator with an API similar to
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 025bceebb2262..eb920ad77c783 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -837,6 +837,8 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	struct iommu_iotlb_gather iotlb_gather;
 	size_t unmapped;
 
+	if (is_pisa_iova(&cookie->win_pisa, dma_addr))
+		return;
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);
 	iommu_iotlb_gather_init(&iotlb_gather);
@@ -863,6 +865,8 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	    iommu_deferred_attach(dev, domain))
 		return DMA_MAPPING_ERROR;
 
+	if (!pisa_map_phys(&iova, dev, domain, phys, size, prot))
+		return iova;
 	/* If anyone ever wants this we'd need support in the IOVA allocator */
 	if (dev_WARN_ONCE(dev, dma_get_min_align_mask(dev) > iova_mask(iovad),
 	    "Unsupported alignment constraint\n"))
@@ -1277,6 +1281,10 @@ void iommu_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
 {
 	phys_addr_t phys;
 
+	/* PISA mapped buffer: nothing to unmap or release. */
+	if (is_pisa_iova(&iommu_get_dma_domain(dev)->iova_cookie->win_pisa, dma_handle))
+		return;
+
 	if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT)) {
 		__iommu_dma_unmap(dev, dma_handle, size);
 		return;
@@ -1478,6 +1486,13 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 			 */
 			break;
 		case PCI_P2PDMA_MAP_NONE:
+			/* Map PISA pages and mark as bus addresses to skip IOVA alloc and unmap. */
+			if (!pisa_map_phys(&s->dma_address, dev, domain,
+					   sg_phys(s), s_length, prot)) {
+				sg_dma_len(s) = s_length;
+				sg_dma_mark_bus_address(s);
+				continue;
+			}
 			break;
 		case PCI_P2PDMA_MAP_BUS_ADDR:
 			/*
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dfba3d5c277c2..068eaf262c7f6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2867,8 +2867,9 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 
 	while (i <= nents) {
 		phys_addr_t s_phys = sg_phys(sg);
+		bool is_bus = i < nents && sg_dma_is_bus_address(sg);
 
-		if (len && s_phys != start + len) {
+		if (len && (is_bus || s_phys != start + len)) {
 			ret = iommu_map_nosync(domain, iova + mapped, start,
 					len, prot, gfp);
 			if (ret)
@@ -2878,7 +2879,7 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			len = 0;
 		}
 
-		if (sg_dma_is_bus_address(sg))
+		if (is_bus)
 			goto next;
 
 		if (len) {
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index dd90aad296edf..f98142882519c 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -299,9 +299,11 @@ struct pisa_alloc *pisa_create(int nid, unsigned int order, enum dma_data_direct
 
 	spin_lock_init(&pa->lock);
 	pa->order = order;
-	pa->nid = pisa_sanitize_nid(nid);
+	pa->prot = (dir != DMA_FROM_DEVICE ? IOMMU_READ : 0) |
+		     (dir != DMA_TO_DEVICE ? IOMMU_WRITE : 0);
 	pa->max_idle_pages = READ_ONCE(pisa_max_idle) ? : 1;
 	pisa_set_name(pa, "%ps", (void *)_RET_IP_);
+	pa->nid = pisa_sanitize_nid(nid);
 	INIT_LIST_HEAD(&pa->partial);
 	INIT_LIST_HEAD(&pa->partial_dirty);
 	INIT_LIST_HEAD(&pa->idle);
@@ -607,6 +609,7 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 			goto out;
 		spin_lock_irqsave(&pa->lock, flags);
 		meta->pa = pa;
+		meta->prot = pa->prot;
 		/* Set PISA_ACTIVE after @meta is fully set up. */
 		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
 	}
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index f0775aa45a058..e16268d55f3de 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -6,6 +6,7 @@
 #include <linux/gfp.h>
 #include <linux/pisa.h>
 #include <linux/iommu.h>
+#include <linux/iova.h>
 #include <linux/mm.h>
 #include <linux/shrinker.h>
 #include <linux/skbuff.h>
@@ -184,8 +185,10 @@ static void test_alloc_and_recycle(struct kunit *test)
 #ifdef CONFIG_IOMMU_DMA
 static void test_window_helpers(struct kunit *test)
 {
+	struct device dev = { .numa_node = NUMA_NO_NODE };
 	struct iommu_domain dummy_domain = {};
 	struct pisa_window win = {};
+	dma_addr_t d;
 
 	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
 
@@ -212,10 +215,139 @@ static void test_window_helpers(struct kunit *test)
 	win.idx_gen--;
 	KUNIT_EXPECT_EQ(test, pisa_window_declined(&win), 0);
 
+	/* A device without an IOMMU group has no PISA window. */
+	KUNIT_EXPECT_NE(test, pisa_map_phys(&d, NULL, NULL, 0, PAGE_SIZE, 0), 0);
+	KUNIT_EXPECT_NE(test, pisa_map_phys(&d, &dev, NULL, 0, PAGE_SIZE, 0), 0);
 	/* Releasing an unregistered domain with an active allocator is a safe no-op. */
 	pisa_domain_release(&dummy_domain);
 }
 
+/*
+ * Fake DMA domain for the mapping and coherent allocation tests, backed by a
+ * real iommu_dma_cookie and no-op page table ops.
+ */
+static int fake_map_pages(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			  int prot, gfp_t gfp, size_t *mapped)
+{
+	*mapped = pgsize * pgcount;
+	return 0;
+}
+
+static size_t fake_unmap_pages(struct iommu_domain *domain, unsigned long iova,
+			       size_t pgsize, size_t pgcount,
+			       struct iommu_iotlb_gather *iotlb_gather)
+{
+	return pgsize * pgcount;
+}
+
+static const struct iommu_domain_ops fake_domain_ops = {
+	.map_pages = fake_map_pages,
+	.unmap_pages = fake_unmap_pages,
+};
+
+static struct iommu_domain fake_domain = {
+	.type = IOMMU_DOMAIN_DMA,
+	.pgsize_bitmap = SZ_4K | PISA_SIZE,
+	.ops = &fake_domain_ops,
+};
+
+static void fake_domain_teardown(void *unused)
+{
+	iommu_put_dma_cookie(&fake_domain);
+	fake_domain.cookie_type = IOMMU_COOKIE_NONE;
+	fake_domain.iova_cookie = NULL;
+	iova_cache_put();
+}
+
+static int fake_domain_setup(struct kunit *test)
+{
+	int ret = iova_cache_get();
+
+	if (ret)
+		return ret;
+	ret = iommu_get_dma_cookie(&fake_domain);
+	if (ret) {
+		iova_cache_put();
+		return ret;
+	}
+	init_iova_domain(pisa_dma_iovad(&fake_domain), SZ_4K, 1);
+	return kunit_add_action_or_reset(test, fake_domain_teardown, NULL);
+}
+
+static void test_map_and_domain_lifecycle(struct kunit *test)
+{
+	struct device dev = { .init_name = "pisa_map_kunit", .numa_node = NUMA_NO_NODE,
+			      .coherent_dma_mask = DMA_BIT_MASK(64) };
+	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
+	struct pisa_window *win;
+	struct pisa_meta *meta;
+	struct pisa_alloc *pa;
+	unsigned int domain_idx;
+	dma_addr_t d1, d2;
+	struct page *p;
+	phys_addr_t phys;
+
+	dev.dma_mask = &dev.coherent_dma_mask;
+	set_dev_node(&dev, first_memory_node);
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	dev.dma_coherent = true;
+#endif
+	KUNIT_ASSERT_EQ(test, fake_domain_setup(test), 0);
+	win = pisa_dma_window(&fake_domain);
+
+	pa = pisa_node_pa(first_memory_node, 2, true);
+	KUNIT_ASSERT_NOT_NULL(test, pa);
+	p = pisa_alloc(pa, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+
+	phys = page_to_phys(p);
+	meta = pisa_meta_of_pfn(page_to_pfn(p));
+	KUNIT_EXPECT_TRUE(test, is_pisa_phys(phys));
+
+	/* TX-only allocator declines IOMMU_WRITE mappings. */
+	KUNIT_EXPECT_EQ(test,
+			pisa_map_phys(&d1, &dev, &fake_domain, phys, PAGE_SIZE,
+				      IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE), -EACCES);
+
+	/* First map assigns the window and installs the 2MB PTE. */
+	KUNIT_ASSERT_EQ(test,
+			pisa_map_phys(&d1, &dev, &fake_domain, phys, PAGE_SIZE,
+				      IOMMU_READ | IOMMU_CACHE), 0);
+	KUNIT_EXPECT_TRUE(test, is_pisa_iova(win, d1));
+	domain_idx = win->domain_idx - PISA_IDX_FIRST;
+	KUNIT_EXPECT_TRUE(test, test_bit(domain_idx, meta->domains_mapped));
+
+	/* Second map at an offset hits the lockless fast path. */
+	KUNIT_ASSERT_EQ(test,
+			pisa_map_phys(&d2, &dev, &fake_domain, phys + 128, 256,
+				      IOMMU_READ | IOMMU_CACHE), 0);
+	KUNIT_EXPECT_EQ(test, d2, d1 + 128);
+
+	/* Quiescing the domain unmaps the PISA page but keeps the window. */
+	pisa_domain_quiesce(&fake_domain);
+	KUNIT_EXPECT_FALSE(test, test_bit(domain_idx, meta->domains_mapped));
+	KUNIT_ASSERT_EQ(test,
+			pisa_map_phys(&d2, &dev, &fake_domain, phys, PAGE_SIZE,
+				      IOMMU_READ | IOMMU_CACHE), 0);
+	KUNIT_EXPECT_EQ(test, d2, d1);
+	KUNIT_EXPECT_TRUE(test, test_bit(domain_idx, meta->domains_mapped));
+
+	/* Releasing the domain forgets the mapping bit across allocators. */
+	pisa_domain_release(&fake_domain);
+	KUNIT_EXPECT_FALSE(test, test_bit(domain_idx, meta->domains_mapped));
+
+	/* Re-map into a fresh window so shrinking exercises pisa_unmap_all(). */
+	*win = (struct pisa_window){};
+	KUNIT_EXPECT_EQ(test,
+			pisa_map_phys(&d1, &dev, &fake_domain, phys, PAGE_SIZE,
+				      IOMMU_READ | IOMMU_CACHE), 0);
+
+	__free_pages(p, 2);
+	pisa_shrink_scan(NULL, &sc);
+}
 #endif /* CONFIG_IOMMU_DMA */
 
 static void test_reservoir_and_scrubber(struct kunit *test)
@@ -231,6 +363,7 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_alloc_and_recycle),
 #ifdef CONFIG_IOMMU_DMA
 	KUNIT_CASE(test_window_helpers),
+	KUNIT_CASE(test_map_and_domain_lifecycle),
 #endif
 	KUNIT_CASE(test_reservoir_and_scrubber),
 	{}
diff --git a/drivers/iommu/pisa-map.c b/drivers/iommu/pisa-map.c
index 2ba977bb68734..2c481e514575c 100644
--- a/drivers/iommu/pisa-map.c
+++ b/drivers/iommu/pisa-map.c
@@ -12,6 +12,8 @@
 #include <linux/pisa.h>
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <linux/iova.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
@@ -103,6 +105,7 @@ void __init pisa_slots_init(void)
 static struct {
 	struct iommu_domain *domain;
 	dma_addr_t base;
+	spinlock_t map_lock;	/* serialises iommu_map() in __pisa_map_phys() */
 } pisa_domains[PISA_MAX_DOMAINS] __read_mostly;
 static DEFINE_SPINLOCK(pisa_domains_lock);
 
@@ -300,3 +303,184 @@ void pisa_domain_quiesce(struct iommu_domain *domain)
 		pr_debug("pisa: unmapped %u PISA pages from idle domain %p (index %d)\n",
 			 done, domain, idx);
 }
+
+/* Allocate a PISA_SIZE-aligned IOVA window of @size bytes from @domain. */
+static dma_addr_t pisa_dma_window_alloc(struct device *dev, struct iommu_domain *domain, u64 size)
+{
+	u64 limit = min_not_zero(dma_get_mask(dev), dev->bus_dma_limit);
+	struct iova_domain *iovad = pisa_dma_iovad(domain);
+	unsigned long shift, iova_len;
+	struct iova *new_iova;
+
+	limit = min_not_zero(limit, dev->coherent_dma_mask);
+
+	if (!iovad)
+		return 0;
+
+	if (domain->geometry.force_aperture)
+		limit = min_t(u64, limit, domain->geometry.aperture_end);
+
+	/* Ignore devices with too many constraints. */
+	if (limit <= DMA_BIT_MASK(32) || size > limit - PISA_SIZE)
+		return 0;
+
+	shift = iova_shift(iovad);
+	iova_len = (size + PISA_SIZE) >> shift;
+
+	/* Ignore advisory dev->iommu->pci_32bit_workaround preference. */
+	new_iova = alloc_iova(iovad, iova_len, limit >> shift, false);
+	if (!new_iova)
+		return 0;
+
+	return ALIGN((dma_addr_t)new_iova->pfn_lo << shift, PISA_SIZE);
+}
+
+/*
+ * Assign @domain an IOVA window and dense domain index on first use, recording
+ * permanent or retryable failures in @win->domain_idx.
+ */
+int pisa_window_assign(struct device *dev, struct iommu_domain *domain, struct pisa_window *win)
+{
+	u64 limit = min_not_zero(dma_get_mask(dev), dev->bus_dma_limit);
+	u64 size = pisa_window_size;
+	unsigned long flags;
+	dma_addr_t base = 0;
+	int idx, ret;
+
+	limit = min_not_zero(limit, dev->coherent_dma_mask);
+
+	if (!dev_is_dma_coherent(dev))
+		return -EOPNOTSUPP;
+
+	if (limit <= DMA_BIT_MASK(32) || size > limit - PISA_SIZE)
+		return -ENOSPC;
+
+	if (!(domain->pgsize_bitmap & PISA_SIZE)) {
+		if (cmpxchg(&win->domain_idx, PISA_IDX_NONE, PISA_IDX_NOHUGE) == PISA_IDX_NONE)
+			dev_warn_ratelimited(dev, "pisa: domain lacks a %luKB page size, not PISA\n",
+					     (unsigned long)(PISA_SIZE >> 10));
+		return -EOPNOTSUPP;
+	}
+
+	spin_lock_irqsave(&pisa_domains_lock, flags);
+
+	/* Bail if another CPU got here first, or if declined earlier. */
+	ret = win->base ? 0 : pisa_window_declined(win);
+	if (win->base || ret) {
+		spin_unlock_irqrestore(&pisa_domains_lock, flags);
+		return ret;
+	}
+
+	for (idx = 0; idx < PISA_MAX_DOMAINS; idx++) {
+		if (!pisa_domains[idx].domain && !pisa_domains[idx].base)
+			break;
+	}
+	if (idx == PISA_MAX_DOMAINS) {
+		win->idx_gen = pisa_idx_gen;
+		WRITE_ONCE(win->domain_idx, PISA_IDX_NOIDX);
+		ret = -EBUSY;
+	} else {
+		base = pisa_dma_window_alloc(dev, domain, size);
+		if (!base) {
+			WRITE_ONCE(win->domain_idx, PISA_IDX_NOWINDOW);
+			ret = -ENOSPC;
+		} else {
+			pisa_domains[idx].domain = domain;
+			pisa_domains[idx].base = base;
+			spin_lock_init(&pisa_domains[idx].map_lock);
+			WRITE_ONCE(win->domain_idx, idx + PISA_IDX_FIRST);
+			/* Publish .domain_idx before .base (paired with is_pisa_iova()). */
+			smp_store_release(&win->base, base);
+		}
+	}
+	spin_unlock_irqrestore(&pisa_domains_lock, flags);
+
+	if (ret == -EBUSY)
+		pr_warn_ratelimited("pisa: all %d domain indices in use, not PISA for domain %p until one is released\n",
+				    PISA_MAX_DOMAINS, domain);
+	else if (ret == -ENOSPC)
+		dev_warn_ratelimited(dev,
+				     "pisa: no free %llu MB IOVA range for a PISA window\n",
+				     size >> 20);
+	else
+		dev_info(dev, "pisa: domain %p index %d window %pad + %llu MB\n",
+			 domain, idx, &base, size >> 20);
+	return ret;
+}
+
+/*
+ * Compute the window IOVA of active address @phys for @dev and store it in
+ * *@iova. On first use in a domain, reserves @win via alloc_iova(), and on
+ * first use of a PISA page in that domain, installs its 2MB leaf PTE via
+ * iommu_map(..., GFP_ATOMIC) under spinlocks.
+ * Returns 0 on success, or negative errno if @phys/@prot/@dev cannot use the window.
+ */
+int __pisa_map_phys(dma_addr_t *iova, struct device *dev,
+		    struct iommu_domain *domain, phys_addr_t phys,
+		    size_t size, int prot)
+{
+	struct pisa_window *win = pisa_dma_window(domain);
+	unsigned long pfn = phys >> PAGE_SHIFT, flags;
+	struct pisa_meta *meta;
+	unsigned int domain_idx;
+	int block_prot, ret;
+	dma_addr_t addr;
+	u64 limit;
+
+	if (unlikely(!iova || !dev || !win || !dev_is_dma_coherent(dev) ||
+		     (phys & (PISA_SIZE - 1)) + size > PISA_SIZE))
+		return -EINVAL;
+
+	meta = pisa_meta_of_pfn(pfn);
+
+	/* Every leaf PTE of the page carries IOMMU_CACHE | @meta->prot. */
+	block_prot = IOMMU_CACHE | meta->prot;
+	if (unlikely(prot & ~block_prot))
+		return -EACCES;
+
+	/* Acquire pairs with the .base release in pisa_window_assign(). */
+	if (unlikely(!smp_load_acquire(&win->base))) {
+		/* Test cached decline in @domain_idx before taking @pisa_domains_lock. */
+		ret = pisa_window_declined(win);
+		if (likely(!ret))
+			ret = pisa_window_assign(dev, domain, win);
+
+		if (ret)
+			return ret;
+	}
+
+	addr = pisa_phys_to_iova(win, meta, phys);
+
+	/* Check @dev's own DMA mask and bus limit against the window IOVA. */
+	limit = min_not_zero(dma_get_mask(dev), dev->bus_dma_limit);
+	limit = min_not_zero(limit, dev->coherent_dma_mask);
+	if (unlikely(addr + size - 1 > limit))
+		return -ENOSPC;
+
+	domain_idx = win->domain_idx - PISA_IDX_FIRST;
+	if (likely(test_bit(domain_idx, meta->domains_mapped))) {
+		*iova = addr;
+		return 0;
+	}
+
+	/* First use of this PISA page in this domain: install the leaf PTE. */
+	ret = 0;
+	spin_lock_irqsave(&pisa_domains[domain_idx].map_lock, flags);
+	if (!test_bit(domain_idx, meta->domains_mapped)) {
+		phys_addr_t pisa_phys = phys & PISA_MASK;
+
+		ret = iommu_map(domain, pisa_phys_to_iova(win, meta, pisa_phys),
+				pisa_phys, PISA_SIZE, block_prot, GFP_ATOMIC);
+		if (likely(!ret)) {
+			/* Ensure leaf PTE is visible before setting the domain bit. */
+			smp_mb__before_atomic();
+			set_bit(domain_idx, meta->domains_mapped);
+		}
+	}
+	spin_unlock_irqrestore(&pisa_domains[domain_idx].map_lock, flags);
+	if (unlikely(ret))
+		return ret;
+
+	*iova = addr;
+	return 0;
+}
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index f97f69a13d1a9..8d83ec09c19a9 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -2,7 +2,7 @@
 #ifndef _DRIVERS_IOMMU_PISA_PRIV_H
 #define _DRIVERS_IOMMU_PISA_PRIV_H
 
-#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
 #include <linux/pisa.h>
 #include <linux/jiffies.h>
 #include <linux/list.h>
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+struct device;
 struct iommu_domain;
 struct iommu_iotlb_gather;
 
@@ -53,6 +54,7 @@ enum {
  * - pisa_allocs_lock (rwlock): outermost; protects pisa_allocs list.
  * - pisa_meta_mutex (mutex): serializes pisa_meta_init() and page-table alloc.
  * - pa->lock (spinlock, irqsave): per-allocator lists, bitmaps, and stats.
+ * - pisa_domains[].map_lock (spinlock, irqsave): first-time iommu_map() in __pisa_map_phys().
  * - pisa_domains_lock (spinlock, irqsave): leaf lock over pisa_domains[]/windows.
  * - pisa_srcu: protects pisa_domains[] readers against pisa_domain_release().
  */
@@ -60,6 +62,7 @@ enum {
 /**
  * struct pisa_meta - Metadata for a single PISA page in @pisa_meta_array
  * @flags:	PISA_ACTIVE / PISA_QUARANTINED
+ * @prot:	Owning allocator's IOMMU_READ/WRITE protection bits
  * @nr_clean:	Zeroed available blocks in @clean_bitmap
  * @nr_dirty:	Dirty available blocks in @dirty_bitmap
  * @on_list:	Current placement in @pa (enum pisa_meta_list)
@@ -74,6 +77,7 @@ enum {
  */
 struct pisa_meta {
 	u8 flags;
+	u8 prot;
 	u16 nr_clean;
 	u16 nr_dirty;
 	u8 on_list;
@@ -105,6 +109,7 @@ static inline unsigned int pisa_meta_avail(const struct pisa_meta *meta)
  * struct pisa_alloc - Allocator managing 2MB-backed blocks of a fixed order
  * @lock:	Spinlock protecting lists and block bitmaps
  * @order:	Block order managed by this allocator (<= PISA_ORDER)
+ * @prot:	IOMMU_READ and/or IOMMU_WRITE from @dir passed to pisa_create()
  * @partial:	Partially used PISA pages with @nr_clean > 0
  * @partial_dirty: Partially used PISA pages with @nr_clean == 0 and @nr_dirty > 0
  * @idle:	Completely free PISA pages (reclaimable under pressure)
@@ -120,6 +125,7 @@ struct pisa_alloc {
 	/* First cacheline: hot fields touched on block alloc and free. */
 	spinlock_t		lock;
 	u8			order;
+	u8			prot;
 	struct list_head	partial;
 	struct list_head	partial_dirty;
 	struct list_head	idle;
@@ -148,6 +154,14 @@ struct pisa_node {
 /* Per-NUMA-node PISA state (ring/TX/user allocators, reservoir). */
 extern struct pisa_node pisa_nodes[MAX_NUMNODES];
 
+/* IOVA of @phys inside active RAM page @meta in @win. */
+static inline dma_addr_t pisa_phys_to_iova(const struct pisa_window *win,
+					  const struct pisa_meta *meta, phys_addr_t phys)
+{
+	return win->base + ((dma_addr_t)meta->slot << PISA_SHIFT) +
+	       (phys & (PISA_SIZE - 1));
+}
+
 /* Offset of @meta from the start of a domain's window. */
 static inline dma_addr_t pisa_meta_win_offset(const struct pisa_meta *meta)
 {
@@ -228,6 +242,18 @@ void pisa_slots_init(void);
 int pisa_slot_alloc(struct pisa_meta *meta);
 void pisa_slot_free(unsigned int slot);
 int pisa_unmap_all(struct pisa_meta *meta);
+int pisa_window_assign(struct device *dev, struct iommu_domain *domain, struct pisa_window *win);
+int __pisa_map_phys(dma_addr_t *iova, struct device *dev,
+		    struct iommu_domain *domain, phys_addr_t phys,
+		    size_t size, int prot);
+
+static inline int pisa_map_phys(dma_addr_t *iova, struct device *dev,
+				struct iommu_domain *domain, phys_addr_t phys,
+				size_t size, int prot)
+{
+	return is_pisa_phys(phys) ?
+	       __pisa_map_phys(iova, dev, domain, phys, size, prot) : -EINVAL;
+}
 
 /* Return negative errno if @win's domain was permanently/currently declined, or 0. */
 static inline int pisa_window_declined(const struct pisa_window *win)
@@ -265,6 +291,13 @@ static inline int pisa_slot_alloc(struct pisa_meta *meta) { return 0; }
 static inline void pisa_slot_free(unsigned int slot) {}
 static inline int pisa_unmap_all(struct pisa_meta *meta) { return 0; }
 
+static inline int pisa_map_phys(dma_addr_t *iova, struct device *dev,
+				struct iommu_domain *domain, phys_addr_t phys,
+				size_t size, int prot)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int pisa_window_declined(const struct pisa_window *win)
 {
 	return -EOPNOTSUPP;
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index ab1c32e065bbb..c64689b81befe 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -5,11 +5,14 @@
 
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 #include <linux/jump_label.h>
 #include <linux/mm.h>
 #include <linux/numa.h>
 #include <linux/rcupdate.h>
 
+struct device;
+
 #ifdef CONFIG_PISA
 
 #define PISA_SHIFT		21U
-- 
2.56.0.542.g3ef89b7020-goog

