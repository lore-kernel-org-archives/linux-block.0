Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136832;
	b=fw5ccQ1AJrnxvMISqXJM/qdTXswkS/dDqLZoaBpgMV3fCyTG+bc0eTwSbduUhu294QyI
	 SdvrmASm2QOWNGDs+ZRvvVZXsi48WFYj5hTEn9TbySDbIP1Ne2z6NyXDn2ZxFreI4mjeQ
	 GCVDDmZH3TqeD7IW0iqKpDL6bHw1r8ztmF4RG+S7f2zbCn2NriykKlLuN32D70cgvLsEn
	 tf0HS8McOSTRJCBYYs8RWflO4dztrPEdVrpoNndasFRBXE83n6sk94ShV1cJSebX6FzBo
	 B+NxD67S8bawErc7kds6v5jgwnbLxZIOVgRaB15CXU4cvNzsiMgzNA0P4cU1+8TCH2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=X0ngOpQCLe4fhiy4ho/kMKKsap6PDXNJVd9RBGs3PiI=;
	b=JcfRTGK1UjXhMiZAIEYRkDza7P7D5LGx/B6rxVAaBi5jObkm2Z+a3SPZhCdyyl+2/AWE
	 1XUeM01qbLR0N4h0m69aJD7S4YQnsZi7BbVuZKYdJOgO3gmU8cVbZPgqTyf2puI4iT1mK
	 q1SXcF2qeSiozLu1Wcx7IyuV5h2kvjzL+uzlYoSjmWKQYC2vOpl19UZ/WdmwtjotDtro7
	 TyY9Kg7S0rn5WhTB9+HlPlKoMR0N7W9liBRAHKpQJ3kkP7yDKEwhp9JddCMRJ7Lvrq713
	 EtAcwOWbTyTvOLcLVoUadvrjxoQglV0b4eTzMfKcdCvO9n2I+62//ltYGFnwCqGmehg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7AFiaBI;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825460A6F75
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 01:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3825460A6F75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7AFiaBI
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so242014f8f.3
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 17:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136830; x=1795741630; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0ngOpQCLe4fhiy4ho/kMKKsap6PDXNJVd9RBGs3PiI=;
        b=e7AFiaBIcFZee/sIgPoeClK/gJpqMRdgppzk8CIrOy62wx2b/w79+dVyIcOmFiAUOj
         gO5iyJmBqHIbiBI2fAPN2MbC/hsCmo4Ks4WlqJeNGpD3NIRG2OyV1Bdc+E/w6NW0mUuQ
         oh1HqIG+qj00g+IS8/skSAax8m7GL/UJKimhX3mgN4RAHtYI+7+7Kl5uI40UsHY9gKym
         mc3z+aqiYVQTJDRlbgdZj/4AEiEiSoBiVxi5pA3g8VxHt+5XqdG31Aw+RfobhTezL3wI
         6owH288qhUflFSckRSOVRURPg8xdyEWgYBgsnuk49epx5nYD0kF7QqpVLvSqGJt4Qzm7
         7jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136830; x=1795741630;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0ngOpQCLe4fhiy4ho/kMKKsap6PDXNJVd9RBGs3PiI=;
        b=rdYxqiYMVkCe6yxwVAUXXRVTyOIQ9XiQ1qsjUHq4vPHAP5xBTeZj/s7EPcAHMvQgpH
         +lYFs2A/0BwtvN3Yc1Bz6QTDGMYQ98bIjthlp6LCDFm2UyrJ+RujI0d/u8OI49n94lT9
         3OnjmTZLhxslH1nqAz5UwsLO7FKr6m64esfeRB5vM2miDzcMVUPjRYZosjTAEhJ5ELvT
         hZHOmUTXNA3bG9e0x/1w+B1n2NjkwO1joc7y8kxBwcSyMN7aFnZhOJdSgR69mdHZ2eKi
         rP3a+9aN2Un3xnJyGSs6y6e8DfoiU7RONTDXp+LNOi/6sT0rsteJrWb8AI2M0NMgIq94
         BuEw==
X-Forwarded-Encrypted: i=1; AL+hErHLKNXHJq9ZlAf/vq7VEQnj1ibyns1VqVGvcjAKF6wazllk/2RDgk/NsVkgxnEBhcgw/SJQXTQBrEVBiQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+a+hU6FP8Orog2Aqs4M0nxm5CAuG2XsdYNHKMR5Ebfsy7nplkH
	RURodNRtsg+xOAZprx5feI+I29NvOo9jxtF+7n7tZCgMD9g0eLT6arCp/w88iCXtUIWsQv2zBk4
	06T4hRw==
X-Received: from wrsh4.prod.google.com ([2002:adf:fd44:0:b0:4ac:7cc3:5b5])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2313:b0:490:50c1:f359
 with SMTP id ffacd0b85a97d-4abb4d70071mr2576330f8f.39.1795136830018; Thu, 19
 Nov 2026 17:07:10 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:38 +0000
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261120010655.467825-9-lrizzo@google.com>
Subject: [RFC PATCH v3 08/25] iommu/dma: Use PISA for coherent DMA allocations
From: Luigi Rizzo <lrizzo@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Naman Gulati <namangulati@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Coherent DMA allocations (e.g. TX/RX descriptor rings allocated via
dma_alloc_attrs() / dma_alloc_coherent()) are long-lived and accessed
on every packet or I/O operation, so they benefit from sharing 2MB IOMMU
leaf mappings.

When dev->pisa_coherent is enabled, serve coherent DMA allocations
(dma_alloc_attrs()) up to 2MB with contiguous memory from PISA pages.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/dma-iommu.c  |   6 ++
 drivers/iommu/pisa-map.c   |  16 +++
 include/linux/pisa-iommu.h |   7 ++
 include/linux/pisa.h       |  38 +++++++
 kernel/dma/direct.c        |   7 ++
 mm/pisa-alloc.c            | 205 +++++++++++++++++++++++++++++++++++++
 mm/pisa-kunit.c            |  71 +++++++++++++
 mm/pisa-priv.h             |   3 +
 8 files changed, 353 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9b26d0aee9a97..45e9432d2a020 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1653,6 +1653,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 		dma_common_free_remap(cpu_addr, alloc_size);
 	} else {
 		/* Lowmem means a coherent atomic or CMA allocation */
+		if (pisa_free_coherent(cpu_addr, alloc_size))
+			return;
 		page = virt_to_page(cpu_addr);
 	}
 
@@ -1723,6 +1725,10 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	gfp |= __GFP_ZERO;
 
+	cpu_addr = pisa_alloc_map_coherent(dev, size, handle, gfp, attrs);
+	if (cpu_addr)
+		return cpu_addr;
+
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
 		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
diff --git a/drivers/iommu/pisa-map.c b/drivers/iommu/pisa-map.c
index 3ff9f1a6c5b85..bbf330877f824 100644
--- a/drivers/iommu/pisa-map.c
+++ b/drivers/iommu/pisa-map.c
@@ -10,6 +10,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/iommu-dma.h>
 #include <linux/iova.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
@@ -18,6 +19,8 @@
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
 
+#include "iommu-priv.h"
+
 
 /*
  * Registry of PISA IOMMU domains. Each slot is FREE (!domain && !base),
@@ -191,6 +194,19 @@ void __pisa_domain_quiesce(struct iommu_domain *domain)
 			 done, domain, idx);
 }
 
+/*
+ * Set *@domain to the DMA domain of @dev, or to NULL if @dev does not use
+ * dma-iommu. Returns an error if a deferred attach of @dev fails.
+ */
+int pisa_dev_dma_domain(struct device *dev, struct iommu_domain **domain)
+{
+	*domain = NULL;
+	if (!use_dma_iommu(dev))
+		return 0;
+	*domain = iommu_get_dma_domain(dev);
+	return iommu_deferred_attach(dev, *domain);
+}
+
 /* Return negative errno if @pi's domain was permanently/currently declined, or 0. */
 int pisa_iova_declined(const struct pisa_iova *pi)
 {
diff --git a/include/linux/pisa-iommu.h b/include/linux/pisa-iommu.h
index d4c01207dca72..568108747f575 100644
--- a/include/linux/pisa-iommu.h
+++ b/include/linux/pisa-iommu.h
@@ -96,6 +96,7 @@ static inline dma_addr_t pisa_phys_to_iova(const struct pisa_iova *pi,
 extern unsigned int pisa_domains_generation;
 
 void pisa_unmap_all_domains(struct pisa_meta *meta);
+int pisa_dev_dma_domain(struct device *dev, struct iommu_domain **domain);
 int pisa_iova_declined(const struct pisa_iova *pi);
 
 #else /* !CONFIG_PISA || !CONFIG_IOMMU_DMA */
@@ -103,5 +104,11 @@ int pisa_iova_declined(const struct pisa_iova *pi);
 static inline void pisa_unmap_all_domains(struct pisa_meta *meta) {}
 static inline int pisa_iova_declined(const struct pisa_iova *pi) { return -EOPNOTSUPP; }
 
+static inline int pisa_dev_dma_domain(struct device *dev, struct iommu_domain **domain)
+{
+	*domain = NULL;
+	return 0;
+}
+
 #endif /* CONFIG_PISA && CONFIG_IOMMU_DMA */
 #endif /* _LINUX_PISA_IOMMU_H */
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index 5222cb207257f..edd34771ad1c4 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -84,6 +84,9 @@ static inline u64 pisa_iova_size(void)
 }
 
 int pisa_meta_init(void);
+void *__pisa_alloc_map_coherent_dev(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs);
 bool __pisa_has_free_blocks_rx(unsigned int order, int nid);
 bool __pisa_page_can_recycle(const struct page *page);
 
@@ -143,6 +146,29 @@ static inline struct page *pisa_virt_to_page(const void *addr)
 	return is_pisa_page(page) ? page : NULL;
 }
 
+/* Hook for iommu_dma_alloc() and dma_direct_alloc() (guarded by @pisa_key). */
+static inline void *pisa_alloc_map_coherent(struct device *dev, size_t size,
+					    dma_addr_t *dma_handle, gfp_t gfp,
+					    unsigned long attrs)
+{
+	if (!pisa_enabled() || !READ_ONCE(dev->pisa_coherent))
+		return NULL;
+	return __pisa_alloc_map_coherent_dev(dev, size, dma_handle, gfp, attrs);
+}
+
+/* Hook for __iommu_dma_free() and dma_direct_free() (guarded by @pisa_key). */
+static inline bool pisa_free_coherent(const void *cpu_addr, size_t size)
+{
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct page *page = pisa_virt_to_page(cpu_addr);
+
+	if (!page)
+		return false;
+	while (count--)
+		__free_page(page++);
+	return true;
+}
+
 /* Hook for __page_pool_alloc_netmems_slow() (guarded by @pisa_key). */
 static inline gfp_t pisa_rx_gfp(const struct device *dev)
 {
@@ -174,6 +200,18 @@ static inline bool is_pisa_page(const struct page *page) { return false; }
 static inline bool is_pisa_phys(phys_addr_t phys) { return false; }
 static inline struct page *pisa_virt_to_page(const void *addr) { return NULL; }
 
+static inline void *pisa_alloc_map_coherent(struct device *dev, size_t size,
+					    dma_addr_t *dma_handle, gfp_t gfp,
+					    unsigned long attrs)
+{
+	return NULL;
+}
+
+static inline bool pisa_free_coherent(const void *cpu_addr, size_t size)
+{
+	return false;
+}
+
 static inline gfp_t pisa_rx_gfp(const struct device *dev)
 {
 	return 0;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25e9a86835fd3..9ac4912e4a0a1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/cc_platform.h>
+#include <linux/pisa.h>
 
 #include "direct.h"
 
@@ -244,6 +245,10 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
+	cpu_addr = pisa_alloc_map_coherent(dev, size, dma_handle, gfp, attrs);
+	if (cpu_addr)
+		return cpu_addr;
+
 	if (dma_direct_use_no_mapping(dev, attrs))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
@@ -424,6 +429,8 @@ void dma_direct_free(struct device *dev, size_t size,
 
 	if (is_vmalloc_addr(cpu_addr)) {
 		vunmap(cpu_addr);
+	} else if (pisa_free_coherent(cpu_addr, size)) {
+		return;
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
diff --git a/mm/pisa-alloc.c b/mm/pisa-alloc.c
index ff8565c3206ad..eda12d475c9a7 100644
--- a/mm/pisa-alloc.c
+++ b/mm/pisa-alloc.c
@@ -10,11 +10,14 @@
 #include <linux/bitops.h>
 #include <linux/cache.h>
 #include <linux/device.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
 #include <linux/pisa.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/iommu.h>
+#include <linux/iommu-dma.h>
 #include <linux/kasan.h>
 #include <linux/list.h>
 #include <linux/llist.h>
@@ -25,6 +28,7 @@
 #include <linux/page_owner.h>
 #include <linux/pgalloc_tag.h>
 #include <linux/page_table_check.h>
+#include <linux/pci.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/mm.h>
 #include <linux/shrinker.h>
@@ -673,6 +677,207 @@ unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
 	return i;
 }
 
+/* Find and reserve @nblocks aligned contiguous blocks in @meta under @pa->lock. */
+static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblocks,
+				     unsigned long align_mask, bool *clean)
+{
+	DECLARE_BITMAP(busy, _PISA_MAX_BLOCKS);
+	struct pisa_alloc *pa = meta->pa;
+	unsigned int bpp = PISA_BLOCKS(0), dirty = 0;
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
+		unsigned int i;
+
+		off = bitmap_find_next_zero_area(busy, bpp, off, nblocks, align_mask);
+		if (off >= bpp) {
+			if (poisoned) {
+				if (meta->on_list & PISA_LIST_IDLE) {
+					pa->num_idle_pages--;
+					WRITE_ONCE(meta->alloc_jiffies, jiffies);
+				}
+				pisa_place_meta(meta);
+			}
+			return NULL;
+		}
+
+		page = pisa_meta_to_page(meta) + off;
+		for (i = 0; i < nblocks; i++) {
+			if (!is_pisa_block_poisoned(pa, page + i))
+				continue;
+			if (__test_and_clear_bit(off + i, meta->clean_bitmap)) {
+				meta->nr_clean--;
+				pa->blocks_in_use++;
+			} else if (__test_and_clear_bit(off + i, meta->dirty_bitmap)) {
+				meta->nr_dirty--;
+				pa->blocks_in_use++;
+			}
+			__set_bit(off + i, busy);
+			poisoned = true;
+			off += i + 1;
+			break;
+		}
+		if (i == nblocks)
+			break;
+	}
+
+	if (meta->on_list & PISA_LIST_IDLE) {
+		pa->num_idle_pages--;
+		WRITE_ONCE(meta->alloc_jiffies, jiffies);
+	}
+
+	for (unsigned int i = 0; i < nblocks; i++) {
+		if (__test_and_clear_bit(off + i, meta->clean_bitmap)) {
+			meta->nr_clean--;
+		} else {
+			__clear_bit(off + i, meta->dirty_bitmap);
+			meta->nr_dirty--;
+			dirty++;
+		}
+		pisa_block_prep(page + i);
+		page_ref_unfreeze(page + i, 1);
+	}
+	pa->blocks_in_use += nblocks;
+	*clean = !dirty;
+	pisa_place_meta(meta);
+	return page;
+}
+
+/* The device checks of pisa_domain_init() and __pisa_map_phys(), before allocating. */
+static bool pisa_coherent_dev_fits(struct device *dev, const struct pisa_iova *pi)
+{
+	u64 limit = min_not_zero(dma_get_mask(dev), dev->bus_dma_limit);
+	/* Pairs with smp_store_release() in pisa_domain_init(). */
+	dma_addr_t base = smp_load_acquire(&pi->base);
+
+	limit = min_not_zero(limit, dev->coherent_dma_mask);
+	if (limit <= DMA_BIT_MASK(32))
+		return false;
+	return base ? base + pisa_iova_size() - 1 <= limit :
+		      pisa_iova_size() <= limit - PISA_SIZE;
+}
+
+/*
+ * Specialized memory provider for iommu_dma_alloc() and dma_direct_alloc():
+ * allocate a zeroed, naturally aligned contiguous range of order-0 pages for
+ * @size bytes (<= PISA_SIZE) from @dev's per-node coherent allocator, map it
+ * into *@dma_handle, and return its kernel virtual address, or NULL.
+ */
+VISIBLE_IF_KUNIT void *
+__pisa_alloc_map_coherent(struct device *dev, struct iommu_domain *domain,
+			  size_t size, dma_addr_t *dma_handle, gfp_t gfp,
+			  unsigned long attrs)
+{
+	bool should_release = false, clean = false;
+	struct list_head *lists[3];
+	unsigned long align_mask, flags;
+	struct pisa_meta *meta, *tmp;
+	unsigned int nblocks;
+	struct pisa_alloc *pa;
+	struct page *page = NULL;
+
+	size = PAGE_ALIGN(size);
+	if (!dev_is_dma_coherent(dev) || !size || size > PISA_SIZE)
+		return NULL;
+	/* As in pisa_domain_init(): no shared PISA pages for untrusted devices. */
+	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+		return NULL;
+	if (min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit) <= DMA_BIT_MASK(32))
+		return NULL;
+	if ((current_gfp_context(gfp) & ~(__GFP_ZERO | __GFP_NOWARN)) != GFP_KERNEL ||
+	    (attrs & ~(DMA_ATTR_NO_WARN | __DMA_ATTR_ALLOC_CC_SHARED)))
+		return NULL;
+
+	if (domain) {
+		struct pisa_iova *pi = pisa_dma_iova(domain);
+
+		if (!pi || pisa_iova_declined(pi) || !pisa_domain_pgsize_ok(domain) ||
+		    !pisa_coherent_dev_fits(dev, pi))
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
+	for (unsigned int i = 0; i < ARRAY_SIZE(lists) && !page; i++) {
+		list_for_each_entry_safe(meta, tmp, lists[i], list) {
+			page = pisa_take_contig(meta, nblocks, align_mask, &clean);
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
+		WRITE_ONCE(meta->alloc_jiffies, jiffies);
+		pisa_meta_set_flags(meta, PISA_ACTIVE);
+		pa->stats.page_alloc++;
+		page = pisa_take_contig(meta, nblocks, align_mask, &clean);
+		if (unlikely(!page))
+			should_release = pisa_place_meta(meta);
+	}
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (should_release)
+		pisa_schedule_reclaim();
+	if (!page)
+		return NULL;
+	if (!domain && unlikely(!dma_coherent_ok(dev, page_to_phys(page), size))) {
+		/* E.g. a hole in dev->dma_range_map, or RAM hotplugged above max_pfn. */
+		pisa_free_coherent(page_address(page), size);
+		return NULL;
+	}
+	if (domain) {
+		if (!pisa_map_phys(dma_handle, dev, domain, page_to_phys(page),
+				   size, IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE)) {
+			pisa_free_coherent(page_address(page), size);
+			return NULL;
+		}
+	} else {
+		*dma_handle = phys_to_dma(dev, page_to_phys(page));
+	}
+	if (!clean)
+		memset(page_address(page), 0, size);
+	return page_address(page);
+}
+
+void *__pisa_alloc_map_coherent_dev(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs)
+{
+	struct iommu_domain *domain;
+
+	if (pisa_dev_dma_domain(dev, &domain))
+		return NULL;
+	return __pisa_alloc_map_coherent(dev, domain, size, dma_handle, gfp, attrs);
+}
+
 /**
  * __pisa_free_page - Recycle a freed block back into its PISA allocator
  * @page: Block being freed (called from __free_pages_prepare() under RCU)
diff --git a/mm/pisa-kunit.c b/mm/pisa-kunit.c
index 2adaeb1ffe43e..1040786330cef 100644
--- a/mm/pisa-kunit.c
+++ b/mm/pisa-kunit.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/shrinker.h>
 #include <linux/skbuff.h>
+#include <linux/swiotlb.h>
 #include <net/sock.h>
 
 #include "pisa-priv.h"
@@ -445,6 +446,75 @@ static void test_map_and_domain_lifecycle(struct kunit *test)
 }
 #endif /* CONFIG_IOMMU_DMA */
 
+static void test_coherent_alloc_and_free(struct kunit *test)
+{
+	struct device dev = { .init_name = "pisa_kunit", .numa_node = NUMA_NO_NODE,
+			      .coherent_dma_mask = DMA_BIT_MASK(64),
+			      .pisa_coherent = true };
+	dma_addr_t d1, d2, d3;
+	void *v1, *v2, *v3 = NULL;
+#ifdef CONFIG_IOMMU_DMA
+	struct pisa_iova *pi;
+#endif
+
+	dev.dma_mask = &dev.coherent_dma_mask;
+	/* NUMA_NO_NODE would follow the node of the CPU the test runs on. */
+	set_dev_node(&dev, first_memory_node);
+	/* is_swiotlb_for_alloc() dereferences dev->dma_io_tlb_mem. */
+	swiotlb_dev_init(&dev);
+	dev_set_dma_coherent(&dev);
+	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
+	KUNIT_EXPECT_NULL(test, pisa_alloc_map_coherent(&dev, SZ_4K, &d1,
+							GFP_KERNEL | __GFP_ACCOUNT, 0));
+	KUNIT_EXPECT_NULL(test, pisa_alloc_map_coherent(&dev, PISA_SIZE + SZ_4K, &d1,
+							GFP_KERNEL, 0));
+
+#ifdef CONFIG_IOMMU_DMA
+	/* Uninitialized domain has no DMA cookie/window yet. */
+	KUNIT_EXPECT_NULL(test, __pisa_alloc_map_coherent(&dev, &fake_domain, SZ_4K,
+							  &d1, GFP_KERNEL | __GFP_NOWARN, 0));
+
+	KUNIT_ASSERT_EQ(test, fake_domain_setup(test), 0);
+	pi = pisa_dma_iova(&fake_domain);
+
+	v1 = __pisa_alloc_map_coherent(&dev, &fake_domain, SZ_64K, &d1, GFP_KERNEL, 0);
+	KUNIT_ASSERT_NOT_NULL(test, v1);
+	KUNIT_EXPECT_TRUE(test, is_pisa_iova(pi, d1));
+
+	v2 = __pisa_alloc_map_coherent(&dev, &fake_domain, SZ_64K, &d2, GFP_KERNEL, 0);
+	KUNIT_EXPECT_NOT_NULL(test, v2);
+	if (v2) {
+		KUNIT_EXPECT_PTR_EQ(test, v2, v1 + SZ_64K);
+		KUNIT_EXPECT_EQ(test, d2, d1 + SZ_64K);
+	}
+
+	KUNIT_EXPECT_TRUE(test, pisa_free_coherent(v1, SZ_64K));
+	v3 = __pisa_alloc_map_coherent(&dev, &fake_domain, SZ_64K, &d3, GFP_KERNEL, 0);
+	KUNIT_EXPECT_NOT_NULL(test, v3);
+	if (v3)
+		KUNIT_EXPECT_PTR_EQ(test, v3, v1);
+#else
+	v1 = pisa_alloc_map_coherent(&dev, SZ_64K, &d1, GFP_KERNEL, 0);
+	KUNIT_ASSERT_NOT_NULL(test, v1);
+	v2 = pisa_alloc_map_coherent(&dev, SZ_64K, &d2, GFP_KERNEL, 0);
+	KUNIT_EXPECT_NOT_NULL(test, v2);
+	if (v2)
+		KUNIT_EXPECT_PTR_EQ(test, v2, v1 + SZ_64K);
+
+	/* Freeing v1 returns its 16 order-0 pages; next 64K alloc reuses them. */
+	KUNIT_EXPECT_TRUE(test, pisa_free_coherent(v1, SZ_64K));
+	v3 = pisa_alloc_map_coherent(&dev, SZ_64K, &d3, GFP_KERNEL, 0);
+	KUNIT_EXPECT_NOT_NULL(test, v3);
+	if (v3)
+		KUNIT_EXPECT_PTR_EQ(test, v3, v1);
+#endif
+
+	if (v2)
+		KUNIT_EXPECT_TRUE(test, pisa_free_coherent(v2, SZ_64K));
+	if (v3)
+		KUNIT_EXPECT_TRUE(test, pisa_free_coherent(v3, SZ_64K));
+}
+
 static void kunit_check_pisa_attr(struct kunit *test, struct device *dev,
 				  const char *name, bool *field)
 {
@@ -529,6 +599,7 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_iova_helpers),
 	KUNIT_CASE(test_map_and_domain_lifecycle),
 #endif
+	KUNIT_CASE(test_coherent_alloc_and_free),
 	KUNIT_CASE(test_dev_pisa_attrs),
 	KUNIT_CASE(test_reservoir_and_scrubber),
 	{}
diff --git a/mm/pisa-priv.h b/mm/pisa-priv.h
index 8736b8d168727..fb26eb3aa9b37 100644
--- a/mm/pisa-priv.h
+++ b/mm/pisa-priv.h
@@ -165,6 +165,9 @@ struct shrink_control;
 struct shrinker;
 #if IS_ENABLED(CONFIG_KUNIT)
 unsigned long pisa_shrink_scan(struct shrinker *shrink, struct shrink_control *sc);
+void *__pisa_alloc_map_coherent(struct device *dev, struct iommu_domain *domain,
+				size_t size, dma_addr_t *dma_handle, gfp_t gfp,
+				unsigned long attrs);
 #endif
 
 /* Global PISA page budget across all allocators and per-node reservoirs. */
-- 
2.56.1.809.ga0b61035b5-goog

