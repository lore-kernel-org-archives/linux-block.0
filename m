Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248740;
	b=DDlrICxZCRkfYv8H35IuC7NbKe6PFLOhd6flzx/rsxCNHU8lNTPWf31d9kh6uEFv1H9D
	 fQZfpHAfbYonrCzWCYaFYoWBu7iTN1kB2wEhw3olxnATSkfqfROUoGeWfTOTpMeO+BbwC
	 6YugLiPq6crA+ZakKY72ruZ50BFo+9DEByv9u48H7GlxaPARY1TycqjRbxsz62F4D0JrY
	 BCNEnJLcdHryIa3+DoPRhCxsM+R9u+49f67mF6QHt6IfmIvKqBNzi0iTlGSYw+0LX/iSo
	 XuD8f1ptU6NQTg/N3phQzDgOEYP7ovhd0XsS4iycQHVziJ3fkuDBkkUaR3s2Lo5FLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wHhmhY6cRdeQR3uTF+o2IxUToxKZc/w8lJFloEvagjc=;
	b=FRF2K+h7g8SsnA8p5tjWXdb/CnnDvBhRx83DxZj80QdsGMxuE10vGz8+1uld2HHn7GLl
	 MG8caS7v0xvId6IlAPbaIpNf6q4Y8ziNxewWkpt5FgG2DgMh+pzvOQ4ih2/yg7B+KlRWA
	 DLVJ0Z+5qLhaAix2PVl1FYizvX2HCvIYxTxX1gx1at0V0rcgwLcUNLpgpK7n/HUhN9WVO
	 ydOdCmdabfwgqBHkqpKxnR7t0alAUSpyECJiTcz6Ew3lM048sN+9aMwoQ6FywGP/vwuud
	 7mgge5+sgxBLRGjezlk4+2Xfm6dampiAoPkrlzTX9Wd4ejPBLiA5402Quq+i4DcT23A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=be9UfR7V;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAC2606A33D
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EAC2606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=be9UfR7V
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b596e9b1caso1282013a12.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248738; x=1794853538; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHhmhY6cRdeQR3uTF+o2IxUToxKZc/w8lJFloEvagjc=;
        b=be9UfR7VzO40gF4mogOesTwNgamOxgls37lY3DEesH7y9ZUal3LbTbQJqEdr1/QIMh
         N8IvrXQA/hxAAYzdAFH7O9GdpUkLta69O3LLpzlliYOItQ33HIuB/SDRK60qmPIkPyK/
         1vEQrYic4+0QhoWIjNwlSD1mXZOQlSQvn4I/g5h0ul65UWITWqK6w7QXc3Eue5WIZY9B
         CVaEPW/CdSOp3My8IWAUQT2b6bI0wd8j+eI8GGbfldwOIsVl5y5Xtjhe0nqHqEwaK74n
         lxnBs1R96V/Ug7IwkAqFFGMF0GxaRR23MMqevc1+mSSzhhT2Y7219tngVOf2Ayg+dnxC
         2gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248738; x=1794853538;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHhmhY6cRdeQR3uTF+o2IxUToxKZc/w8lJFloEvagjc=;
        b=DPXEqf3crAFhNURrYatwlcEkh/IdnQGCArC6i3wUyCvSzJrfvjBTiH2BPjjKmj2K8m
         QFuQQswuJt0CRE4VEPfii963qyXnt7y0bZ0aJTKIke0BuH+vPRIOzn/KaEncfbAAoGq0
         hMoSAcGPihrDO3QxyFxnVSNO2LiLOtAGLScbdfTBEeg1qjybqyzs0LpGPN/iuifYJ1Sl
         xI86iDPyBMWgp6hKoCNSh5RGuu0KOQ1l0RwwxugtfWf882sl1kziDFkiRg3rfWvDq4cf
         w0sLCwIxf3RExE9gOrNMxhvw1iZjkHYmyUcDiEJtQrMrQlC9wf8rmGvZNsZKtryLuQKp
         mo8A==
X-Forwarded-Encrypted: i=1; AL+hErGvpSJfXWf0GlvdfHmz4jE6lwvkgJE963pjnb0vQZJeURk6bdeGXxucZJFBnf+LNRfrrYZulnhqtQ4v4g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+R8ge8ip9NtuZSUKbyEfArfDJ+8cZ0/+VzfS7vc3rEH6BwWy+f
	cuXMf0QdtLSq5sMGKcIBZqfnEtSqBt4oxYEniDLM3vc+vtTNiGFq6Lzt7aGbS+BEetOwVDzIdws
	UnN4ghw==
X-Received: from edag25.prod.google.com ([2002:a05:6402:3219:b0:6b5:70a4:c77d])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1ed3:b0:6b5:6116:e333
 with SMTP id 4fb4d7f45d1cf-6b756ae9459mr377929a12.31.1794248738070; Mon, 09
 Nov 2026 10:25:38 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:09 +0000
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
Message-ID: <20261109182533.3594984-2-lrizzo@google.com>
Subject: [RFC PATCH v2 01/25] iommu/dma: Introduce CONFIG_PISA and metadata table
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

PISA ("Pre-mapped IOVA Superpage Allocator") is a memory allocator
that provides devices which opt in with DMA-able memory backed by large
physically contiguous pages (typically 2MB, but fully configurable),
and mapped by IOMMU leaves of the same size.

PISA has the following features:
- greatly reduces IOTLB pressure by using fewer, much larger IOMMU
  entries.

- greatly reduces DMA map/unmap cost. Mapping only happens when the
  first block from a 2MB page is used. Unmapping is a no-op for the
  caller, and happens in a separate task when no blocks from the 2MB
  page are in use and the page should be returned to the buddy
  allocator.

- much better security than DMA-FQ, because buffers are not returned to
  the buddy allocator until the mappings have been removed and the IOTLB
  flushed.

- removes the cost of copying into bounce buffers, e.g. for
  overcommitted or Confidential Computing VMs.

- fine-grained opt-in selection (each device can opt in selectively for
  descriptors, transmit and/or receive data buffers and headers) permits
  choosing the correct security and performance tradeoffs.

- default is to use the base IOMMU mode (DMA or DMA-FQ) of the device.

PISA is integrated with the main IO APIs (dma_alloc_attrs,
dma_map/unmap, page_pool, TX socket buffers and disk IO buffers) so that
no device driver modifications should be necessary.

Add a CONFIG_PISA option, enabled only on supported kernels (64bit,
!PREEMPT_RT) and introduce a sparse metadata table to hold per-2MB buffer
state (similar to pageblock_flags).
The metadata table is initialized on first use, consumes 4KB of RAM
and 2MB of virtual address space for each 16GB of physical RAM.

Also add a built-in KUnit test suite (CONFIG_PISA_META_KUNIT_TEST)
exercising initialization idempotency, PFN/physical round-trip lookups,
out-of-bounds physical address handling, and PISA membership toggling.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/Kconfig      |  33 +++++
 drivers/iommu/Makefile     |   2 +
 drivers/iommu/pisa-kunit.c | 102 +++++++++++++
 drivers/iommu/pisa-meta.c  | 286 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-priv.h  |  31 ++++
 include/linux/pisa.h       |  79 ++++++++++
 6 files changed, 533 insertions(+)
 create mode 100644 drivers/iommu/pisa-kunit.c
 create mode 100644 drivers/iommu/pisa-meta.c
 create mode 100644 drivers/iommu/pisa-priv.h
 create mode 100644 include/linux/pisa.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 85a8d7fdfa30b..15e06eaed0924 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -423,4 +423,37 @@ config IOMMU_DEBUG_PAGEALLOC
 	  If unsure, say N.
 endif # IOMMU_SUPPORT
 
+# Pre-mapped IOVA Superpage Allocator
+config PISA
+	bool "Pre-mapped IOVA Superpage Allocator"
+	depends on X86_64 || ARM64
+	depends on !PREEMPT_RT
+	default y
+	help
+	  PISA is a specialized memory allocator with an API similar to
+	  alloc_pages(). For devices that opt-in, it provides DMA-able
+	  pages backed by 2MB physically contiguous pages, and mapped in
+	  the IOMMU maps with a single leaf PTE of the same size. Mapping,
+	  unmapping and IOTLB flushing are done lazily to reduce CPU overhead.
+	  The large mappings greatly reduce IOTLB usage. As in strict iommu
+	  mode, pages are returned to the buddy allocator only when any existing
+	  mappings have been removed and IOTLB flushed.
+	  Uses 4KB of metadata for each 32MB of PISA buffers, allocated on demand.
+
+	  The config option enforces requirements (2MB large pages and !PREEMPT_RT) at compile
+	  time. Other constraints (e.g. dma-coherent devices) are verified at runtime.
+
+	  If unsure, say Y.
+
+config PISA_META_KUNIT_TEST
+	bool "KUnit test for PISA metadata table (built-in)" if !KUNIT_ALL_TESTS
+	depends on PISA && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit unit tests for the sparse, per-PISA-frame metadata table,
+	  and PISA page allocators in drivers/iommu/pisa-*.c, verifying metadata
+	  lookup, allocator recycling, and coherent block allocation.
+
+	  If unsure, say N.
+
 source "drivers/iommu/generic_pt/Kconfig"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 29a26d2a3af12..b5d3be1df3eda 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
+obj-$(CONFIG_PISA) += pisa-meta.o
+obj-$(CONFIG_PISA_META_KUNIT_TEST) += pisa-kunit.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
new file mode 100644
index 0000000000000..0633f3238e012
--- /dev/null
+++ b/drivers/iommu/pisa-kunit.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for the opaque struct pisa_meta table API.
+ */
+#include <kunit/test.h>
+#include <linux/gfp.h>
+#include <linux/pisa.h>
+#include <linux/mm.h>
+
+#include "pisa-priv.h"
+
+static void test_meta_init_and_roundtrip(struct kunit *test)
+{
+	unsigned long pfn, base_pfn;
+	struct pisa_meta *m_pfn;
+	struct page *page;
+
+	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
+	/* Second call must be idempotent. */
+	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
+
+	page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+
+	pfn = page_to_pfn(page);
+	base_pfn = ALIGN_DOWN(pfn, 1UL << PISA_ORDER);
+	__free_page(page);
+
+	KUNIT_ASSERT_EQ(test, pisa_meta_ensure_pfn(pfn, true), 0);
+	m_pfn = pisa_meta_of_pfn(pfn);
+	KUNIT_EXPECT_EQ(test, pisa_meta_to_pfn(m_pfn), base_pfn);
+}
+
+static void test_meta_invalid_phys(struct kunit *test)
+{
+	struct pisa_meta *meta;
+
+	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
+
+	meta = pisa_meta_of_pfn(PHYS_PFN(PHYS_ADDR_MAX));
+	KUNIT_ASSERT_NOT_NULL(test, meta);
+	KUNIT_EXPECT_EQ(test, pisa_meta_to_pfn(meta), ULONG_MAX);
+	KUNIT_EXPECT_FALSE(test, is_pisa_pfn(ULONG_MAX >> PAGE_SHIFT));
+	KUNIT_EXPECT_NE(test, pisa_meta_ensure_pfn(ULONG_MAX >> PAGE_SHIFT, false), 0);
+}
+
+static void pisa_meta_set_active(struct pisa_meta *meta, bool active)
+{
+	WRITE_ONCE(meta->flags, active ? PISA_ACTIVE : 0);
+}
+
+static void test_meta_active_toggle(struct kunit *test)
+{
+	unsigned long pfn, base_pfn;
+	struct pisa_meta *meta;
+	struct page *page;
+
+	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
+
+	page = alloc_pages(GFP_KERNEL, PISA_ORDER);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+
+	pfn = page_to_pfn(page);
+	base_pfn = ALIGN_DOWN(pfn, 1UL << PISA_ORDER);
+	/* The buddy allocator returns naturally aligned blocks. */
+	KUNIT_EXPECT_EQ(test, pfn, base_pfn);
+	if (pisa_meta_ensure_pfn(pfn, true)) {
+		__free_pages(page, PISA_ORDER);
+		KUNIT_FAIL(test, "pisa_meta_ensure_pfn(%lu) failed", pfn);
+		return;
+	}
+	KUNIT_EXPECT_EQ(test, pisa_meta_ensure_pfn(pfn, false), 0);
+	meta = pisa_meta_of_pfn(pfn);
+
+	KUNIT_EXPECT_FALSE(test, is_pisa_pfn(pfn));
+
+	pisa_meta_set_active(meta, true);
+	KUNIT_EXPECT_TRUE(test, is_pisa_pfn(base_pfn));
+	KUNIT_EXPECT_TRUE(test, is_pisa_pfn(pfn));
+	KUNIT_EXPECT_TRUE(test, is_pisa_pfn(base_pfn + (1UL << PISA_ORDER) - 1));
+
+	pisa_meta_set_active(meta, false);
+	KUNIT_EXPECT_FALSE(test, is_pisa_pfn(pfn));
+
+	__free_pages(page, PISA_ORDER);
+}
+
+static struct kunit_case pisa_meta_test_cases[] = {
+	KUNIT_CASE(test_meta_init_and_roundtrip),
+	KUNIT_CASE(test_meta_invalid_phys),
+	KUNIT_CASE(test_meta_active_toggle),
+	{}
+};
+
+static struct kunit_suite pisa_meta_test_suite = {
+	.name = "pisa_meta",
+	.test_cases = pisa_meta_test_cases,
+};
+
+kunit_test_suite(pisa_meta_test_suite);
+MODULE_DESCRIPTION("KUnit tests for struct pisa_meta table");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/iommu/pisa-meta.c b/drivers/iommu/pisa-meta.c
new file mode 100644
index 0000000000000..5ceea91e4d5e8
--- /dev/null
+++ b/drivers/iommu/pisa-meta.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * PISA sparse per-PISA-frame metadata table.
+ * See Documentation/core-api/pisa.rst for the architecture overview.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/cache.h>
+#include <linux/cacheflush.h>
+#include <linux/pisa.h>
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/memblock.h>
+#include <linux/memory.h>
+#include <linux/moduleparam.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/pgtable.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/vmalloc.h>
+
+#include "pisa-priv.h"
+
+static_assert(PISA_META_SIZE <= PAGE_SIZE);
+static_assert(PISA_SIZE <= SZ_2M);
+static_assert(PISA_BLOCKS(0) <= PISA_MAX_BLOCKS);
+static_assert(PISA_ORDER <= MAX_PAGE_ORDER);
+static_assert(PISA_SHIFT <= SUBSECTION_SHIFT);
+
+/* Enabled by pisa_meta_init() to activate fast-path hooks. */
+DEFINE_STATIC_KEY_FALSE(pisa_key);
+EXPORT_SYMBOL(pisa_key);
+
+/* Parameters are pisa.<name> at boot and in /sys/module/pisa/parameters/. */
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "pisa."
+
+/* Physical address bits covered by @pisa_meta_array (0 = max_possible_pfn). */
+static unsigned int pisa_max_bits __read_mostly;
+module_param_named(max_bits, pisa_max_bits, uint, 0444);
+
+/*
+ * Metadata is in a sparse @pisa_meta_array[pfn >> PISA_ORDER] in vmalloc space
+ * (256B per 2MB frame). Each 4KB backing page covers a chunk of 16 entries (32MB)
+ * and is tracked in @pisa_chunk_bitmap, 1 bit per chunk, 4KB per 1TB, 1MB for 48bit
+ * of address space. The total address space is @pisa_meta_nframes, all the variables
+ * are set and memory allocated before enabling @pisa_key.
+ */
+
+/* Sparse per-PISA-frame metadata table, indexed by pfn >> PISA_ORDER */
+struct pisa_meta *pisa_meta_array __read_mostly;
+EXPORT_SYMBOL(pisa_meta_array);
+
+/* Number of PISA frames covered by @pisa_meta_array. */
+unsigned long pisa_meta_nframes __read_mostly;
+EXPORT_SYMBOL(pisa_meta_nframes);
+
+/* One bit per 32MB chunk, set once its metadata page is backed. */
+unsigned long *pisa_chunk_bitmap __read_mostly;
+EXPORT_SYMBOL(pisa_chunk_bitmap);
+
+/* Shared sink entry returned for unbacked or out-of-range PFNs */
+static struct pisa_meta pisa_meta_nil __read_mostly;
+
+/* Protects init and page-table allocation */
+static DEFINE_MUTEX(pisa_meta_mutex);
+
+/* Return metadata for @pfn, or shared sink @pisa_meta_nil (flags == 0) if unbacked. */
+struct pisa_meta *pisa_meta_of_pfn(unsigned long pfn)
+{
+	unsigned long frame = pfn >> PISA_ORDER;
+
+	if (unlikely(!static_branch_unlikely(&pisa_key) || frame >= pisa_meta_nframes ||
+		     !test_bit_acquire(pfn >> PISA_CHUNK_ORDER, pisa_chunk_bitmap)))
+		return &pisa_meta_nil;
+
+	return &pisa_meta_array[frame];
+}
+
+/* Base PFN of @meta's PISA frame, or ULONG_MAX if out-of-range/sink. */
+unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta)
+{
+	unsigned long frame = meta - pisa_meta_array;
+
+	if (unlikely(frame >= pisa_meta_nframes))
+		return ULONG_MAX;
+
+	return frame << PISA_ORDER;
+}
+
+/* PTE for @addr in the array, or NULL if its page table was not allocated. */
+static pte_t *pisa_meta_pte(unsigned long addr)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (pgd_none(pgdp_get(pgd)))
+		return NULL;
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(p4dp_get(p4d)))
+		return NULL;
+	pud = pud_offset(p4d, addr);
+	if (pud_none(pudp_get(pud)))
+		return NULL;
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(pmdp_get(pmd)))
+		return NULL;
+	return pte_offset_kernel(pmd, addr);
+}
+
+/* Back chunk of @pfn in @pisa_meta_array with a zeroed page and set its bitmap bit. */
+static int pisa_meta_back(unsigned long pfn, gfp_t gfp)
+{
+	/* Protects lazy installation of backing pages into preallocated page tables. */
+	static DEFINE_SPINLOCK(pisa_meta_pte_lock);
+	unsigned long idx = pfn >> PISA_CHUNK_ORDER;
+	unsigned long addr = (unsigned long)pisa_meta_array + (idx << PAGE_SHIFT), flags;
+	struct page *online = pfn_to_online_page(pfn);
+	int nid = online ? page_to_nid(online) : NUMA_NO_NODE;
+	pte_t *ptep = pisa_meta_pte(addr);
+	struct page *page;
+
+	if (!ptep)
+		return -EINVAL;
+
+	page = alloc_pages_node(nid, gfp | __GFP_ZERO | __GFP_NOWARN, 0);
+	if (!page)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&pisa_meta_pte_lock, flags);
+	if (pte_none(ptep_get(ptep))) {
+		set_pte_at(&init_mm, addr, ptep, pfn_pte(page_to_pfn(page), PAGE_KERNEL));
+		flush_cache_vmap(addr, addr + PAGE_SIZE);
+		page = NULL;
+		/* Pair with test_bit_acquire() in readers. */
+		smp_mb__before_atomic();
+		set_bit(idx, pisa_chunk_bitmap);
+	}
+	spin_unlock_irqrestore(&pisa_meta_pte_lock, flags);
+
+	if (page)
+		__free_page(page);
+	return 0;
+}
+
+/* Allocate the page tables for the entries of [@start_pfn, @end_pfn). */
+static int pisa_meta_prealloc(struct pisa_meta *array, unsigned long nframes,
+			      unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long start, end;
+
+	end_pfn = min(end_pfn, nframes << PISA_ORDER);
+	if (start_pfn >= end_pfn)
+		return 0;
+
+	start = round_down((unsigned long)&array[start_pfn >> PISA_ORDER], PAGE_SIZE);
+	end = round_up((unsigned long)&array[((end_pfn - 1) >> PISA_ORDER) + 1], PAGE_SIZE);
+	return apply_to_page_range(&init_mm, start, end - start, NULL, NULL);
+}
+
+struct pisa_meta_range {
+	struct pisa_meta *array;
+	unsigned long nframes;
+};
+
+static int pisa_meta_prealloc_ram(unsigned long start_pfn, unsigned long nr_pages, void *arg)
+{
+	struct pisa_meta_range *r = arg;
+
+	return pisa_meta_prealloc(r->array, r->nframes, start_pfn, start_pfn + nr_pages);
+}
+
+/* Page tables for memory about to go online; failure keeps it out of the allocators. */
+static int pisa_meta_memory_cb(struct notifier_block *nb, unsigned long action, void *arg)
+{
+	struct memory_notify *mn = arg;
+
+	if (action != MEM_GOING_ONLINE)
+		return NOTIFY_OK;
+
+	mutex_lock(&pisa_meta_mutex);
+	if (pisa_meta_array)
+		pisa_meta_prealloc(pisa_meta_array, pisa_meta_nframes, mn->start_pfn,
+				   mn->start_pfn + mn->nr_pages);
+	mutex_unlock(&pisa_meta_mutex);
+	return NOTIFY_OK;
+}
+
+/* Memory hotplug notifier for preallocating metadata page tables. */
+static struct notifier_block pisa_meta_memory_nb = {
+	.notifier_call = pisa_meta_memory_cb,
+};
+
+int pisa_meta_ensure_pfn(unsigned long pfn, bool can_block)
+{
+	unsigned long idx = pfn >> PISA_CHUNK_ORDER;
+
+	if (!static_branch_unlikely(&pisa_key) || (pfn >> PISA_ORDER) >= pisa_meta_nframes)
+		return -ERANGE;
+
+	if (likely(test_bit_acquire(idx, pisa_chunk_bitmap)))
+		return 0;
+
+	/* Memory onlined before the notifier was registered has no page table. */
+	if (can_block && !pisa_meta_pte((unsigned long)pisa_meta_array + (idx << PAGE_SHIFT))) {
+		int err;
+
+		mutex_lock(&pisa_meta_mutex);
+		err = pisa_meta_prealloc(pisa_meta_array, pisa_meta_nframes, pfn, pfn + 1);
+		mutex_unlock(&pisa_meta_mutex);
+		if (err)
+			return err;
+	}
+
+	return pisa_meta_back(pfn, can_block ? GFP_KERNEL : GFP_ATOMIC);
+}
+
+/* Reserve the sparse @pisa_meta_array and preallocate page tables for present RAM. */
+int pisa_meta_init(void)
+{
+	unsigned long top_pfn, nframes, nchunks, size;
+	struct pisa_meta_range range;
+	struct pisa_meta *array;
+	struct vm_struct *vm;
+	int ret = 0;
+
+	if (static_branch_unlikely(&pisa_key))
+		return 0;
+
+	mutex_lock(&pisa_meta_mutex);
+	if (pisa_meta_array)
+		goto out_unlock;
+
+	if (pisa_max_bits)
+		top_pfn = 1UL << (clamp_t(unsigned int, pisa_max_bits, PISA_SHIFT,
+					   MAX_PHYSMEM_BITS) - PAGE_SHIFT);
+	else
+		top_pfn = max_t(unsigned long, max_pfn, max_possible_pfn);
+	nframes = DIV_ROUND_UP(top_pfn, 1UL << PISA_ORDER);
+	size = PAGE_ALIGN(nframes << PISA_META_SHIFT);
+	nchunks = size >> PAGE_SHIFT;
+
+	/* kvalloc() to avoid kmalloc limitations on large layouts */
+	pisa_chunk_bitmap = kvcalloc(BITS_TO_LONGS(nchunks), sizeof(unsigned long), GFP_KERNEL);
+	if (!pisa_chunk_bitmap) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	vm = get_vm_area(size, VM_MAP);
+	if (!vm) {
+		ret = -ENOMEM;
+		goto out_free_bitmap;
+	}
+	array = vm->addr;
+
+	range.array = array;
+	range.nframes = nframes;
+	ret = walk_system_ram_range(0, nframes << PISA_ORDER, &range, pisa_meta_prealloc_ram);
+	if (ret)
+		goto out_free_vm;
+
+	pisa_meta_nframes = nframes;
+	pisa_meta_array = array;
+	static_branch_enable(&pisa_key);
+
+	pr_info("pisa: %lu frames, %lu KB of KVA\n", nframes, size / 1024);
+	mutex_unlock(&pisa_meta_mutex);
+
+	/* Register outside pisa_meta_mutex (taken by the notifier under chain lock). */
+	register_memory_notifier(&pisa_meta_memory_nb);
+	return 0;
+
+out_free_vm:
+	free_vm_area(vm);
+out_free_bitmap:
+	kvfree(pisa_chunk_bitmap);
+	pisa_chunk_bitmap = NULL;
+out_unlock:
+	mutex_unlock(&pisa_meta_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(pisa_meta_init);
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
new file mode 100644
index 0000000000000..c873970f6a670
--- /dev/null
+++ b/drivers/iommu/pisa-priv.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+#ifndef _DRIVERS_IOMMU_PISA_PRIV_H
+#define _DRIVERS_IOMMU_PISA_PRIV_H
+
+#include <linux/pisa.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_PISA
+
+#define PISA_MAX_BLOCKS		512U
+
+#define PISA_BLOCKS(order)	(1U << (PISA_ORDER - (order)))
+
+/**
+ * struct pisa_meta - Metadata for a single PISA page in @pisa_meta_array
+ * @flags:	PISA_ACTIVE while this page is owned by a pisa_alloc
+ */
+struct pisa_meta {
+	u8 flags;
+} __aligned(PISA_META_SIZE);
+
+static_assert(offsetof(struct pisa_meta, flags) == 0);
+static_assert(sizeof(struct pisa_meta) == PISA_META_SIZE);
+
+int pisa_meta_ensure_pfn(unsigned long pfn, bool can_block);
+struct pisa_meta *pisa_meta_of_pfn(unsigned long pfn);
+unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta);
+
+#endif /* CONFIG_PISA */
+#endif /* _DRIVERS_IOMMU_PISA_PRIV_H */
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
new file mode 100644
index 0000000000000..acf92ced245d8
--- /dev/null
+++ b/include/linux/pisa.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* See Documentation/core-api/pisa.rst for the architecture overview. */
+#ifndef _LINUX_PISA_H
+#define _LINUX_PISA_H
+
+#include <linux/bitops.h>
+#include <linux/jump_label.h>
+#include <linux/mm.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_PISA
+
+#define PISA_SHIFT		21U
+#define PISA_SIZE		(1UL << PISA_SHIFT)
+#define PISA_MASK		(~(PISA_SIZE - 1))
+#define PISA_ORDER		(PISA_SHIFT - PAGE_SHIFT)
+
+/*
+ * Each struct pisa_meta entry in pisa_meta_array has size PISA_META_SIZE
+ * (256 B) and starts with a u8 flags byte.
+ */
+#define PISA_META_SHIFT		8
+#define PISA_META_SIZE		(1U << PISA_META_SHIFT)
+#define PISA_CHUNK_ORDER	(PISA_ORDER + PAGE_SHIFT - PISA_META_SHIFT)
+
+enum {
+	PISA_ACTIVE		= BIT(0), /* page is owned by a pisa_alloc */
+};
+
+/* Enabled on first pisa_meta_init() to activate fast-path hooks. */
+DECLARE_STATIC_KEY_FALSE(pisa_key);
+
+struct pisa_meta;
+extern struct pisa_meta *pisa_meta_array;
+extern unsigned long pisa_meta_nframes;
+extern unsigned long *pisa_chunk_bitmap;
+
+int pisa_meta_init(void);
+
+/* fast membership check for pisa pfn/pages */
+static inline bool is_pisa_pfn(unsigned long pfn)
+{
+	unsigned long frame = pfn >> PISA_ORDER;
+	const u8 *flags;
+
+	if (!static_branch_unlikely(&pisa_key))
+		return false;
+	if (unlikely(frame >= pisa_meta_nframes ||
+		     !test_bit_acquire(pfn >> PISA_CHUNK_ORDER, pisa_chunk_bitmap)))
+		return false;
+
+	flags = (const u8 *)pisa_meta_array + (frame << PISA_META_SHIFT);
+	return READ_ONCE(*flags) & PISA_ACTIVE;
+}
+
+#else /* !CONFIG_PISA */
+
+static inline int pisa_meta_init(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool is_pisa_pfn(unsigned long pfn)
+{
+	return false;
+}
+
+#endif /* CONFIG_PISA */
+
+static inline bool is_pisa_phys(phys_addr_t phys)
+{
+	return is_pisa_pfn(phys >> PAGE_SHIFT);
+}
+
+static inline bool is_pisa_page(const struct page *page)
+{
+	return is_pisa_pfn(page_to_pfn(page));
+}
+#endif /* _LINUX_PISA_H */
-- 
2.56.0.542.g3ef89b7020-goog

