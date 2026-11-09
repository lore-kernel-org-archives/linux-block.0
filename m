Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248755;
	b=ZOJGvxZc58PDfZ5lnvnkssMXXlWV0F7Ee7UnN5dWiL2QJCGHJZ+0ySVDc056sfHmSZxl
	 9GXUaRjeCDUvcFYPpzY3ckBS52FCXwsuEiU5VlztEEGQ7Chw6NN/isUe/6uD+UH1Xr59L
	 Tf0gWxdyWggWn2M+4uuw3WeLr5/VXBjJ0oVugAzWXzqhLdZpN2SIDJhek8nYobFXG5ZxM
	 gxGjvJYtI2uTE+/a+gRMA5TZCskpwB0iWVCnfJQmU+Cj9w0ERh99nHuHhcAqVRMdzL4hQ
	 m+uuJyvAuQZYATHSVF1V7vYlq4HNhE+THS6mgdaZY4x/QjqHffKY/nppLSUN0ifJ2jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
	b=5s1G24EcaFq1aWlYOzG8GASu3Pm+RmEnK1zcKAHoTam11jKT/HlWyQ8NouyIkwKBkggE
	 LHsTk6HTvlpIJ+PGar+Fl9vmG/KqNep6mB0o+Hgr8V2cJ0MaXNpmY2qTI8mSA8Aye8Vfz
	 38pio5H11xgGv9/O3FI5+8AUoZZ2kIsI79JHgjYkgA3vQZgtyaUuq+qHOP4Ps4deYbWF/
	 IBCUIblB07xMefb88da1qxvrmAfMLI+a/pRqBB9L+MLuKP0N5bMEiQ5pfZ6H/UJ9YIM2C
	 VuC+x8v62+6feDEHNsfK569QOjOBJwffXoyicfuYLcd0CeMPDqJvfIaQmQ/bkIXpKOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PucykuzF;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D734606CC47
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D734606CC47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PucykuzF
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c37b2763f1bso146257266b.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248753; x=1794853553; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
        b=PucykuzF+kI0Fuxe+WUtPrHWdECLJ+HBRvHEY3hGmZsDV+Y42K8qiOX2BzVv79MI4I
         sp6z2uGUNfZO3DNfGXEfg5goMbKSqdSse3Kn4YQwJik9dK5GupSkGDDOHDQXyB8GeeOL
         oOHe117qlnkKsTiiH7yL78B5OhDmfU5ZVZX/HlY5HwmlHtalgSheh1MWEE1rxgowjPyI
         tpDzWcHNPO5WdwAqcxM/c8D2Qmwz14WYetq0bjBADOmHkecHo6oL2868rrbZ4xtWYlAv
         Q93ai98PFrO9ycqoBX092LG8WjGWH+ds/U9P++J5ww0ccv1NclFeVqZLDjUpTTUX2mTz
         T1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248753; x=1794853553;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
        b=oub+NjQ2NsD+Xh7B3QH1Jidt7GZP8hElqiYeG59Aqzap3xQ/ptwXLhj6wd8NZ9O1EU
         IITbtBHS+R56lYYf1heAVAT0EF5B3y0VEAA34UeRK9Bul2SBzpiSg5ZDc3EoSIG1LeRb
         ifeIp5fxHHANC1+xqDkmup8uL1XtzjLRnk/6qb5D+Cm109HsOkefAp3A1KREBVgyP0jP
         QnkjRJ4oc0pFCqH1eldW9VbidEF8AhjWjNqZEXBUwplfE5L4HRUQq1Thw0i9xcy4/B1f
         Yq7ff6W0Gp0hxicqhhldVBd1g/a0onXQhSgxLa7EgA3evbjp7/W8ESvJ3eDp84anbdBh
         eYlA==
X-Forwarded-Encrypted: i=1; AL+hErGbfT6MsRGVe4InLldVBJt0MnbMxJOVcBZEuYSo+zAGhFXqk1hH+0RZgQoos+wn46oM17+NqF6qwzX4Sw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Gw4/njWuiD7/AvAsEDeGLm8VmRLo5UMSqtql/GHFRJpghfmQC
	66dmDG2nNtXK4DJMcj0luCCYvctvFF7U2YjdOihkqdr5IJdNt8AY5NQgEaeL/ZoH521wz7A3Tvj
	jIMtoNw==
X-Received: from ejpg23.prod.google.com ([2002:a17:906:7c57:b0:c3f:d175:ee6a])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e20:b0:c41:64c1:cc2d
 with SMTP id a640c23a62f3a-c50491bd62emr17871766b.2.1794248752661; Mon, 09
 Nov 2026 10:25:52 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:24 +0000
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
Message-ID: <20261109182533.3594984-17-lrizzo@google.com>
Subject: [RFC PATCH v2 16/25] mm/slub: Add SLAB_CACHE_PISA_RO for PISA-backed
 slab caches
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

skb heads are provided by a slab allocator that is fed by alloc_pages().

Add SLAB_CACHE_PISA_RO so that a slab cache can back its slabs with
zeroed, read-only PISA folios (__GFP_PISA_RO | __GFP_ZERO) via
pisa_alloc_folio(), clamping the slab order to
[2, PAGE_ALLOC_COSTLY_ORDER].
Slabs are still released with free_frozen_pages(), so pages from PISA
return to their allocator via __free_pages_prepare(). Caches with
SLAB_CACHE_PISA_RO skip KFENCE and are never merged.

Existing caches are unaffected.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 27 +++++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c | 19 +++++++++++++++++++
 include/linux/pisa.h       |  7 +++++++
 include/linux/slab.h       | 10 ++++++++++
 mm/slab.h                  |  3 ++-
 mm/slab_common.c           |  5 ++++-
 mm/slub.c                  | 14 +++++++++++++-
 7 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 4b61ec84ed6d1..3b5c49d143a7e 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -848,6 +848,33 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred
 	return pisa_alloc_bulk(pa, gfp & ~__GFP_PISA_RW, nr_pages, page_array, frozen);
 }
 
+/**
+ * pisa_alloc_folio - Allocate a frozen folio for SLUB (SLAB_CACHE_PISA_RO)
+ * @gfp: GFP flags (must have __GFP_PISA_RW or __GFP_PISA_RO set)
+ * @order: Folio order
+ * @nid: Target NUMA node (or NUMA_NO_NODE)
+ *
+ * Drops __GFP_THISNODE before calling the per-node allocator and verifies
+ * node placement afterwards.
+ *
+ * Return: Frozen folio of @order, or NULL.
+ */
+struct folio *pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid)
+{
+	struct page *page;
+
+	page = pisa_alloc_pages(gfp & ~__GFP_THISNODE, order, nid, NULL);
+	if (!page)
+		return NULL;
+	if (unlikely((gfp & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
+		     page_to_nid(page) != nid)) {
+		page_ref_unfreeze(page, 1);
+		__free_pages(page, order);
+		return NULL;
+	}
+	return page_folio(page);
+}
+
 /**
  * pisa_has_free_blocks_rx - Check if @dev has free PISA RX blocks of @order on @nid
  * @dev: Device to check
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 40bf7801183da..9cc1328893ace 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/shrinker.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <net/sock.h>
 
 #include "dma-iommu.h"
@@ -621,6 +622,23 @@ static void test_reservoir_and_scrubber(struct kunit *test)
 	WRITE_ONCE(pisa_scrub_max, old_scrub);
 }
 
+static void test_slub_page_alloc(struct kunit *test)
+{
+	struct kmem_cache *s;
+	void *obj;
+
+	s = kmem_cache_create("pisa_kunit_slab", 1024, NULL,
+			      SLAB_NO_MERGE | SLAB_CACHE_PISA_RO);
+	KUNIT_ASSERT_NOT_NULL(test, s);
+
+	obj = kmem_cache_alloc(s, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+	KUNIT_EXPECT_TRUE(test, is_pisa_page(virt_to_page(obj)));
+	kmem_cache_free(s, obj);
+
+	kmem_cache_destroy(s);
+}
+
 static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_meta_init_and_roundtrip),
 	KUNIT_CASE(test_meta_invalid_phys),
@@ -635,6 +653,7 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_pcp_cache),
 	KUNIT_CASE(test_gfp_pisa),
 	KUNIT_CASE(test_reservoir_and_scrubber),
+	KUNIT_CASE(test_slub_page_alloc),
 	{}
 };
 
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index 89eb0722d90bc..b9c5197f2d88d 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -110,6 +110,7 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order,
 				    int nr_pages, struct page **page_array,
 				    bool frozen);
 
+struct folio *pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid);
 bool pisa_has_free_blocks_rx(const struct device *dev, unsigned int order, int nid);
 bool pisa_page_can_recycle(const struct page *page);
 
@@ -181,6 +182,12 @@ pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred_nid,
 	return 0;
 }
 
+static inline struct folio *
+pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid)
+{
+	return NULL;
+}
+
 static inline gfp_t pisa_rx_gfp(const struct device *dev)
 {
 	return 0;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index cda126def67af..df19c5898e9fe 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -66,6 +66,9 @@ enum _slab_flag_bits {
 #endif
 #endif
 	_SLAB_NO_SHEAVES,
+#ifdef CONFIG_PISA
+	_SLAB_CACHE_PISA_RO,
+#endif
 	_SLAB_FLAGS_LAST_BIT
 };
 
@@ -260,6 +263,13 @@ enum _slab_flag_bits {
 #define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
 #endif
 
+/* Back slabs with zeroed read-only PISA folios (__GFP_PISA_RO | __GFP_ZERO) */
+#ifdef CONFIG_PISA
+#define SLAB_CACHE_PISA_RO	__SLAB_FLAG_BIT(_SLAB_CACHE_PISA_RO)
+#else
+#define SLAB_CACHE_PISA_RO	__SLAB_FLAG_UNUSED
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab.h b/mm/slab.h
index e94ac63d10dc0..53620e40b216b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -473,7 +473,8 @@ void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
 			 SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
 			 SLAB_TEMPORARY | SLAB_ACCOUNT | \
-			 SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE)
+			 SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE | \
+			 SLAB_CACHE_PISA_RO)
 
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 01c64ef661e7f..d6c00047b1623 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -49,7 +49,7 @@ struct kmem_cache *kmem_cache;
  */
 #define SLAB_NEVER_MERGE (SLAB_DEBUG_FLAGS | SLAB_TYPESAFE_BY_RCU | \
 		SLAB_NOLEAKTRACE | SLAB_FAILSLAB | SLAB_NO_MERGE | \
-		SLAB_OBJ_EXT_IN_OBJ)
+		SLAB_OBJ_EXT_IN_OBJ | SLAB_CACHE_PISA_RO)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT | SLAB_MAY_ACCOUNT)
@@ -377,6 +377,9 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 	if (s)
 		goto out_unlock;
 
+	if (flags & SLAB_CACHE_PISA_RO)
+		flags |= SLAB_SKIP_KFENCE;
+
 	cache_name = kstrdup_const(name, GFP_KERNEL);
 	if (!cache_name) {
 		err = -ENOMEM;
diff --git a/mm/slub.c b/mm/slub.c
index 45e077c7526c2..63609768f4e3f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -46,6 +46,7 @@
 #include <linux/prandom.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <linux/pisa.h>
 #include <linux/sort.h>
 #include <linux/irq_work.h>
 #include <linux/kprobes.h>
@@ -3378,6 +3379,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	if (unlikely(!allow_spin))
 		page = alloc_frozen_pages_nolock(0/* __GFP_COMP is implied */,
 								  node, order);
+	else if (unlikely(flags & __GFP_PISA_RO))
+		page = (struct page *)pisa_alloc_folio(flags, order, node);
 	else if (node == NUMA_NO_NODE)
 		page = alloc_frozen_pages(flags, order);
 	else
@@ -3484,7 +3487,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 	gfp_t alloc_gfp;
 	void *start;
 
-	flags &= gfp_allowed_mask;
+	flags &= gfp_allowed_mask & ~__GFP_PISA_RW;
 
 	flags |= s->allocflags;
 
@@ -3495,9 +3498,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 	alloc_gfp = (flags | __GFP_NOWARN | __GFP_NORETRY) & ~__GFP_NOFAIL;
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
+	if (unlikely(s->flags & SLAB_CACHE_PISA_RO))
+		alloc_gfp = (flags | __GFP_NOWARN) & ~__GFP_NOFAIL;
 
 	slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
 	if (unlikely(!slab)) {
+		if (s->flags & SLAB_CACHE_PISA_RO)
+			return NULL;
 		oo = s->min;
 		alloc_gfp = flags;
 		/*
@@ -8182,6 +8189,11 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
+	if (s->flags & SLAB_CACHE_PISA_RO) {
+		s->allocflags |= __GFP_PISA_RO | __GFP_ZERO;
+		order = clamp_t(unsigned int, order, 2, PAGE_ALLOC_COSTLY_ORDER);
+	}
+
 	/*
 	 * For kmalloc caches we enable sheaves later by
 	 * bootstrap_kmalloc_sheaves() to avoid recursion.
-- 
2.56.0.542.g3ef89b7020-goog

