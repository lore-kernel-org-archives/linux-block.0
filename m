Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248746;
	b=b2b09CQdB1vOy4DXU+Ee42OYSEYYBo1Kr1zXnS4WSJ9Z+AGrWFFsoXxj+4ZUzqaX/b7a
	 Ir7LmZc8IQChkFrZ/lMYR4qH6zGNNOiU4ADUf1s8mlPRI1FywsJlhmTAoDeW9KJp4z25x
	 1LK7vDz6EajY8sX7hE4N8IaxE56vJwbr4HytJjsi65KHvbV2/okGWcl+BLkdGR8iV6q8t
	 NjuogmREapzOJKZSETZNfPRoNtZ72b1EuSYaHXgXj0oX+ZOi//lmRotXsTVPT8AZX9jti
	 evsQMyj9nBAxZ98/9nqPBb3ij4spio/jZ6sbWM7TnExE2bQiZm9BonADF+uE6yc/v8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uNnpUKLFZFDZAIGfqh/0M8aoCDnLft+kz4dr3EpUusA=;
	b=m3FbU1bQeGMOiffyqEcR4D94QbzO+AyFOE9iEKNYKifsa2chWZ0wTFISi5b+p/7qtk0q
	 rRVVxDtFyCzvEvJ/HV0k+NnxVXq7VNExcDj5qlTe/FuupNtqWsFSDCiPnTnXN/mOXbbud
	 MqoEif2c+Kb8SpZyMTbJ16by75zNg/LzOCC1uan9rR02eeU/Wl02aNjs5kemROd9U9tlU
	 ZAoF6yx84nCQB+VzQPVBccrG0/fRSeacavm1LlbhHdVhlv9o3wirYzG5FPHW0gVnQXixY
	 hojwNDKM1oN+VijVlIyvOY8sDy1dyNPGUH8r9DW7jJrLciPaag5DUhbPIcvumVcf7rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="PlNhP/g6";
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2F60A5BC4
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA2F60A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PlNhP/g6
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c3613c35145so137717866b.3
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248743; x=1794853543; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uNnpUKLFZFDZAIGfqh/0M8aoCDnLft+kz4dr3EpUusA=;
        b=PlNhP/g64O4F/LV6s3lo6yAgzjtguT2ig6lN0S9xUQ6Xt5Lx+NO2QrUfCWeLWu52br
         dIrhvnLS3y1mg0enuPo2VHd7l1KVOW7FupSPKtP/LLOEHnyPFeYcAYZsOHP10kohMvjO
         kMuo0W+tG8Diy2uZP4ZxAvEJGh3a+CMQF390jb4Y+1XgDCprC8NYeFQAwp9qyyRBzt/f
         QXKVD7rZPaOQKzRnnbODYGDb8SYdTKpcs8+V8itZHNfdgcv/sAZpizivd7rZtBrIaFag
         54WKhu7ZB5UgGf5zqJHEpZbgLIklfRbmhRQcVqNTVcKHQY/yDkW6plAXweuzmHuDwo/N
         M/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248743; x=1794853543;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNnpUKLFZFDZAIGfqh/0M8aoCDnLft+kz4dr3EpUusA=;
        b=ldRoQVmu346SJkNYwEC1Gm+t/yZ+1GEfHUQJIfpwL4wMKpnUBbkVROKZhBymospirk
         6RNJWWqDByavknndXx8NtpE4Iq/xHOV+tEub+LEO2JoSL6TNfb1UFkyYW7MJ5EIVRG7C
         1BFA2RJZGiV7peuLvHLzm1Ic9OJeyRZefGeYk3bwHXfBiSLFrOBL9JwaTINIuba1Ng5T
         wbyLBZFxOFtShrjcogqGYBx8O7WNoaPxyZbhmxQzR8B2ARkFC0RDZ27iDZaFn5r2QmKH
         8IEYGpK9ubJdeNACEK66zeCrr9680H6636irNnp9aQKKplrsrugl5u/XUVV4KHsZLezS
         THNg==
X-Forwarded-Encrypted: i=1; AL+hErG9fpwYV5aIa0mCY1zR5N84uqZe38WNxsazfcApO/zd9ldw9QMDl/rgqLQgeszzlGna7mtXU0Jw4HgDjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+GcvgGiEWaQISu/3QHBMKPQF8CBcoms8piBDQmhLW+SLH8K+P5
	ZNwY9l9p9imhQwBUfcEPmRotq+iPbSFGy855yDxa3WxFIiTIqXtVsHFmdAfwdL1jHZ9/Ny8V+U9
	bPKpC/w==
X-Received: from ejet13.prod.google.com ([2002:a17:906:178d:b0:c3a:bb3c:9317])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:794f:b0:c49:a539:aa45
 with SMTP id a640c23a62f3a-c50496b6556mr13388266b.42.1794248743157; Mon, 09
 Nov 2026 10:25:43 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:14 +0000
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
Message-ID: <20261109182533.3594984-7-lrizzo@google.com>
Subject: [RFC PATCH v2 06/25] iommu/dma: Reserve a per-domain IOVA window for
 PISA pages
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

PISA buffers need to be quickly identified from their iova, and may need
to be mapped in multiple domains. We can achieve both by reserving an IOVA
range for PISA pages in each domain.

Add per-domain PISA IOVA window descriptors in struct iommu_dma_cookie
and a global slot allocator (pisa_slot_alloc() / pisa_slot_free()).
The window is sized to twice the maximum allowed PISA buffer space,
defaulting to max(64MB, 1/4 of physical RAM).

A buffer is mapped at the same slot offset in all windows for the domains
that need to access it. IOVA allocation is done with a bitmap (1 bit
per 2MB buffer, hence a 4KB bitmap supports 64GB of buffer space) at
negligible cost.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/Makefile     |  3 ++
 drivers/iommu/dma-iommu.c  | 18 ++++++++
 drivers/iommu/dma-iommu.h  | 16 +++++++
 drivers/iommu/pisa-alloc.c | 12 ++++-
 drivers/iommu/pisa-kunit.c | 24 ++++++++++
 drivers/iommu/pisa-map.c   | 90 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-priv.h  | 58 ++++++++++++++++++++++++
 7 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/pisa-map.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index bc58166f9303a..125cf7e813cdc 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -12,6 +12,9 @@ obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_PISA) += pisa-meta.o pisa-alloc.o pisa-node.o
+ifeq ($(CONFIG_IOMMU_DMA),y)
+obj-$(CONFIG_PISA) += pisa-map.o
+endif
 obj-$(CONFIG_PISA_META_KUNIT_TEST) += pisa-kunit.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932d..fba6084feac81 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -36,6 +36,7 @@
 #include <trace/events/swiotlb.h>
 
 #include "dma-iommu.h"
+#include "pisa-priv.h"
 #include "iommu-pages.h"
 #include "iommu-priv.h"
 
@@ -76,6 +77,8 @@ struct iommu_dma_cookie {
 	struct iommu_domain *fq_domain;
 	/* Options for dma-iommu use */
 	struct iommu_dma_options options;
+	/* IOVA window reserved for PISA pages. Nothing else can go here. */
+	struct pisa_window win_pisa;
 };
 
 struct iommu_dma_msi_cookie {
@@ -1215,6 +1218,21 @@ static inline size_t iova_unaligned(struct iova_domain *iovad, phys_addr_t phys,
 	return iova_offset(iovad, phys | size);
 }
 
+/* Return @domain's PISA window, or NULL if @domain cannot use PISA. */
+struct pisa_window *pisa_dma_window(struct iommu_domain *domain)
+{
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) ||
+	    !domain || domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
+		return NULL;
+
+	return &domain->iova_cookie->win_pisa;
+}
+
+struct iova_domain *pisa_dma_iovad(struct iommu_domain *domain)
+{
+	return pisa_dma_window(domain) ? &domain->iova_cookie->iovad : NULL;
+}
+
 dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 040d002525632..f112b47396984 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -7,6 +7,9 @@
 
 #include <linux/iommu.h>
 
+struct pisa_window;
+struct iova_domain;
+
 #ifdef CONFIG_IOMMU_DMA
 
 void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
@@ -22,6 +25,9 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 		     phys_addr_t msi_addr);
 
+struct iova_domain *pisa_dma_iovad(struct iommu_domain *domain);
+struct pisa_window *pisa_dma_window(struct iommu_domain *domain);
+
 extern bool iommu_dma_forcedac;
 
 #else /* CONFIG_IOMMU_DMA */
@@ -59,5 +65,15 @@ static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline struct iova_domain *pisa_dma_iovad(struct iommu_domain *domain)
+{
+	return NULL;
+}
+
+static inline struct pisa_window *pisa_dma_window(struct iommu_domain *domain)
+{
+	return NULL;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index de8009fd6fff3..d7b73c3a6c0b6 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -84,10 +84,12 @@ static void pisa_release_page_rcu(struct rcu_head *head)
 	/* Read @meta before freeing blocks; the frame can be reused immediately. */
 	struct pisa_meta *meta = container_of(head, struct pisa_meta, rcu);
 	struct page *block, *page = pfn_to_page(pisa_meta_to_pfn(meta));
-	unsigned int i, order = meta->pa->order;
+	unsigned int i, order = meta->pa->order, slot = meta->slot;
 
 	WRITE_ONCE(meta->pa, NULL);
 
+	/* The page has been unmapped from every domain by pisa_release_page() */
+	pisa_slot_free(slot);
 	atomic_long_dec(&pisa_nr_pages);
 	for (i = 0; i < PISA_BLOCKS(order); i++) {
 		block = page + (i << order);
@@ -426,10 +428,16 @@ static struct pisa_meta *pisa_alloc_split_page(unsigned int order, gfp_t gfp, in
 	if (IS_ERR(meta))
 		return meta;
 
+	if (unlikely(pisa_slot_alloc(meta))) {
+		pisa_release_page(meta);
+		return ERR_PTR(-ENOSPC);
+	}
+
 	page = pfn_to_page(pisa_meta_to_pfn(meta));
 
 	/* Fails with -EBUSY if a concurrent PFN walker holds a speculative ref. */
 	if (split_page_compound(page, PISA_ORDER, order)) {
+		pisa_slot_free(meta->slot);
 		pisa_release_page(meta);
 		pisa_alloc_backoff(nid, can_block);
 		return ERR_PTR(-EBUSY);
@@ -782,6 +790,8 @@ static int __init pisa_init(void)
 	if (!pisa_max_pages)
 		pisa_max_pages = max(totalram_pages() >> (PISA_ORDER + 3), 16UL);
 
+	pisa_slots_init();
+
 	/* Preallocate the supported per-node allocators. */
 	for_each_node_state(nid, N_MEMORY) {
 		for (i = 0; i < ARRAY_SIZE(cfg); i++) {
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 96bc8dbc38fb4..5a2e806e74654 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <net/sock.h>
 
+#include "dma-iommu.h"
 #include "pisa-priv.h"
 
 static void test_meta_init_and_roundtrip(struct kunit *test)
@@ -179,6 +180,26 @@ static void test_alloc_and_recycle(struct kunit *test)
 	WRITE_ONCE(pisa_max_pages, old_max);
 }
 
+#ifdef CONFIG_IOMMU_DMA
+static void test_window_helpers(struct kunit *test)
+{
+	struct pisa_window win = {};
+
+	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
+
+	/* Empty window (base == 0) never owns any IOVA. */
+	KUNIT_EXPECT_FALSE(test, is_pisa_iova(&win, 0));
+	KUNIT_EXPECT_FALSE(test, is_pisa_iova(&win, SZ_4G));
+
+	win.base = SZ_4G;
+	KUNIT_EXPECT_FALSE(test, is_pisa_iova(&win, SZ_4G - 1));
+	KUNIT_EXPECT_TRUE(test, is_pisa_iova(&win, SZ_4G));
+	KUNIT_EXPECT_TRUE(test, is_pisa_iova(&win, SZ_4G + pisa_window_size - 1));
+	KUNIT_EXPECT_FALSE(test, is_pisa_iova(&win, SZ_4G + pisa_window_size));
+}
+
+#endif /* CONFIG_IOMMU_DMA */
+
 static void test_reservoir_and_scrubber(struct kunit *test)
 {
 	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
@@ -190,6 +211,9 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_meta_invalid_phys),
 	KUNIT_CASE(test_meta_active_toggle),
 	KUNIT_CASE(test_alloc_and_recycle),
+#ifdef CONFIG_IOMMU_DMA
+	KUNIT_CASE(test_window_helpers),
+#endif
 	KUNIT_CASE(test_reservoir_and_scrubber),
 	{}
 };
diff --git a/drivers/iommu/pisa-map.c b/drivers/iommu/pisa-map.c
new file mode 100644
index 0000000000000..2e8d635dec34c
--- /dev/null
+++ b/drivers/iommu/pisa-map.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * PISA per-domain IOVA window management and IOMMU mapping.
+ * See Documentation/core-api/pisa.rst for the architecture overview.
+ */
+
+#include <linux/bitops.h>
+#include <linux/cache.h>
+#include <linux/mm.h>
+#include <linux/moduleparam.h>
+#include <linux/pisa.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "dma-iommu.h"
+#include "pisa-priv.h"
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "pisa."
+
+/* Optional module param override for pisa_nr_slots (0 = auto: 2 * max_pages). */
+static unsigned int pisa_cfg_slots __read_mostly;
+module_param_named(slots, pisa_cfg_slots, uint, 0444);
+
+/*
+ * Number of 2MB IOVA slots in each domain's window (computed at init from
+ * pisa_cfg_slots or 2 * max_pages). Each active PISA page holds one slot
+ * in [0, pisa_nr_slots) and maps at slot * PISA_SIZE in every domain's window.
+ */
+unsigned int pisa_nr_slots __read_mostly;
+u64 pisa_window_size __read_mostly;
+/* One bit per IOVA slot, set while an active PISA page holds the slot. */
+static unsigned long *pisa_slot_bitmap __read_mostly;
+/* Metadata of the PISA page backing each active slot, or NULL. */
+static struct pisa_meta **pisa_slot2meta __read_mostly;
+static unsigned int pisa_slot_hint;	/* no free slot below this */
+/* Protects pisa_slot_bitmap and pisa_slot_hint. */
+static DEFINE_SPINLOCK(pisa_slot_lock);
+
+/* Cost is typically low though the bitmap can be up to O(100K) bits on large systems. */
+int pisa_slot_alloc(struct pisa_meta *meta)
+{
+	unsigned long flags;
+	unsigned int slot;
+
+	spin_lock_irqsave(&pisa_slot_lock, flags);
+	slot = find_next_zero_bit(pisa_slot_bitmap, pisa_nr_slots, pisa_slot_hint);
+	if (slot < pisa_nr_slots) {
+		__set_bit(slot, pisa_slot_bitmap);
+		pisa_slot_hint = slot + 1;
+		WRITE_ONCE(meta->slot, slot);
+		WRITE_ONCE(pisa_slot2meta[slot], meta);
+	}
+	spin_unlock_irqrestore(&pisa_slot_lock, flags);
+
+	if (slot >= pisa_nr_slots)
+		return -ENOSPC;
+	return 0;
+}
+
+/* Return @slot once no domain can translate it any more. */
+void pisa_slot_free(unsigned int slot)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pisa_slot_lock, flags);
+	WRITE_ONCE(pisa_slot2meta[slot], NULL);
+	__clear_bit(slot, pisa_slot_bitmap);
+	if (slot < pisa_slot_hint)
+		pisa_slot_hint = slot;
+	spin_unlock_irqrestore(&pisa_slot_lock, flags);
+}
+
+void __init pisa_slots_init(void)
+{
+	/* Fixed at boot: sizes every domain's window (default 2 * max_pages). */
+	pisa_nr_slots = pisa_cfg_slots ?: min_t(unsigned long, 2 * pisa_max_pages, UINT_MAX >> 1);
+	pisa_slot_bitmap = kvcalloc(BITS_TO_LONGS(pisa_nr_slots),
+				    sizeof(unsigned long), GFP_KERNEL);
+	pisa_slot2meta = kvcalloc(pisa_nr_slots, sizeof(*pisa_slot2meta), GFP_KERNEL);
+	if (!pisa_slot_bitmap || !pisa_slot2meta) {
+		kvfree(pisa_slot_bitmap);
+		kvfree(pisa_slot2meta);
+		pisa_slot_bitmap = NULL;
+		pisa_slot2meta = NULL;
+		pisa_nr_slots = 0;
+	}
+	/* Size of every domain's window: one 2MB page per slot. */
+	pisa_window_size = (u64)pisa_nr_slots << PISA_SHIFT;
+}
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index d5ea83745ba47..3ef6e51402ceb 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -13,12 +13,35 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+/**
+ * struct pisa_window - A domain's IOVA window reserved for PISA pages
+ * @base: Window base IOVA (PISA_SIZE aligned), or 0 if unassigned
+ * @domain_idx: Dense index + PISA_IDX_FIRST, or PISA_IDX_* sentinel while @base == 0
+ * @idx_gen: Value of pisa_idx_gen when @domain_idx was set to NOIDX
+ *
+ * Lives in iommu_dma_cookie. Active PISA pages map at @base + slot * PISA_SIZE.
+ */
+struct pisa_window {
+	dma_addr_t base;
+	u16 domain_idx;
+	u32 idx_gen;
+};
+
 #ifdef CONFIG_PISA
 
 #define PISA_MAX_BLOCKS		512U
 
 #define PISA_BLOCKS(order)	(1U << (PISA_ORDER - (order)))
 
+/* Sentinel values of pisa_window.domain_idx below PISA_IDX_FIRST. */
+enum {
+	PISA_IDX_NONE,	/* not attempted yet */
+	PISA_IDX_NOHUGE,	/* @domain can never use PISA */
+	PISA_IDX_NOWINDOW,	/* no IOVA range for the window */
+	PISA_IDX_NOIDX,	/* all domain indices were in use */
+	PISA_IDX_FIRST,	/* first valid domain index */
+};
+
 /*
  * Lock hierarchy:
  * - pisa_allocs_lock (rwlock): outermost; protects pisa_allocs list.
@@ -32,6 +55,7 @@
  * @nr_clean:	Zeroed available blocks in @clean_bitmap
  * @nr_dirty:	Dirty available blocks in @dirty_bitmap
  * @on_list:	Current placement in @pa (enum pisa_meta_list)
+ * @slot:	Dense IOVA slot index in every domain's window
  * @pa:		Owning pisa_alloc (NULL for reservoir pages)
  * @list:	Node in @pa lists or per-node reservoir (pisa_node.pages)
  * @llnode:	Node in lockless pisa_free_list for async release to the buddy allocator
@@ -44,6 +68,7 @@ struct pisa_meta {
 	u16 nr_clean;
 	u16 nr_dirty;
 	u8 on_list;
+	u32 slot;
 	struct pisa_alloc *pa;
 	struct list_head list;
 
@@ -172,4 +197,37 @@ unsigned long pisa_reservoir_count(void);
 unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan);
 
 #endif /* CONFIG_PISA */
+
+#if defined(CONFIG_PISA) && defined(CONFIG_IOMMU_DMA)
+
+/* Size in bytes of every domain's PISA IOVA window, fixed at boot. */
+extern u64 pisa_window_size;
+extern unsigned int pisa_nr_slots;
+
+void pisa_slots_init(void);
+int pisa_slot_alloc(struct pisa_meta *meta);
+void pisa_slot_free(unsigned int slot);
+
+/* Return true if @dma falls within @win's reserved PISA IOVA window. */
+static inline bool is_pisa_iova(const struct pisa_window *win, dma_addr_t dma)
+{
+	/* Acquire pairs with the release of @base in pisa_window_assign(). */
+	dma_addr_t base = smp_load_acquire(&win->base);
+
+	return base && dma - base < pisa_window_size;
+}
+
+#else /* !CONFIG_PISA || !CONFIG_IOMMU_DMA */
+
+#define pisa_nr_slots 0U
+static inline void pisa_slots_init(void) {}
+static inline int pisa_slot_alloc(struct pisa_meta *meta) { return 0; }
+static inline void pisa_slot_free(unsigned int slot) {}
+
+static inline bool is_pisa_iova(const struct pisa_window *win, dma_addr_t dma)
+{
+	return false;
+}
+
+#endif /* CONFIG_PISA && CONFIG_IOMMU_DMA */
 #endif /* _DRIVERS_IOMMU_PISA_PRIV_H */
-- 
2.56.0.542.g3ef89b7020-goog

