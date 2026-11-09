Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248741;
	b=jYpLZCxXeg9cZoJSbsWUYIQP0dD5G6w66CHp4WU6WdqoVb+pjfFM662Z27rYg58dTrPW
	 fG1g92yYu/e13YjlCYUl22VaosWqajE1pohAZEvKuBrS4tDoxHlheq4S7MVQXS+oVP19g
	 /oRtaI+lgHnd+gh5ttHsy3sVVLPpzkntzufT5MT/6yGIeKQ8aEoR9Ase7G9DVNb2j/gNS
	 IGYIkLFZWmxmsDQA2WUtIDHnRRS5L8m9Gun2L/5hYSUwoiWpeLyJZmb7q9yDFQSFk/TrL
	 yFTmWUxdAPjLFioskbXKyPGJ9utLcOs6fUu77z1eORFBqZNox4MPAGdbRaMn0kwjqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dAobmXP0nouUn7lr60WGpj4sMNpNnxPm0xVJLciGc0w=;
	b=khzUdBsPsf4JTkf2UwqY1NLQdcoWXDCkjO/nbfC2O1GMMQWxP1P5HalT1izo7jX1OUT9
	 iGDAQkBWAiS74ZyseqmKtrux5Tn0coc1yjBPfkqkfbbxjV+IrPtlsL9g0yUGtd1+HpV33
	 M1k45H5olOtu6ot0kDCOwh924tOLkecYFodtfbhnYXF2fRWBuDMTwMgDgUJCSJZ3lHmDp
	 ON9VAjMhMZ+Vdv0bns3UClQP9EUdHe+x0Hr9Mkrja82/BmX2NzfMDKrePXJy7WuM0987o
	 FjtTs8fODjWIcrs4oyVdWgwr/qRLi6BzyUJ1aIIo8ibc/AlwYGDAhNsSIYK5slHF6oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GyQZpla4;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62760A2614
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C62760A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GyQZpla4
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c42f98f354fso102286966b.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248740; x=1794853540; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAobmXP0nouUn7lr60WGpj4sMNpNnxPm0xVJLciGc0w=;
        b=GyQZpla4ZOaGR6WXiqSPbIlOZ0VOyTxCcTrjHnM75GI3p9vvCahHwB+Gwgy0ULtILc
         bKxdpp9qqdACTWlRhiyODu9VPBiwrjPEQ9riy9fVWViTyscmWy5PPe2/HODv87/dX2WI
         WmFhzu9mf8fLMviC7+YPXBEHmHfwVnYWbxEhkVCbopNPEuRBtS0D4lW6NofTCcRXIysC
         B80U+lmQBQV6HwQMWSXsG4hFio4bnBP0+jhNF0rM7usR4ggnlfhWK0btwlR167dnBwYw
         2aBByuCJihPSNxEXHe0NTxaELjhs3Fr/K+zHNJHBCAR5hL4yXFYB3WhOq6iMJSF3ncIi
         FWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248740; x=1794853540;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAobmXP0nouUn7lr60WGpj4sMNpNnxPm0xVJLciGc0w=;
        b=qUSd1ZZVG2RdVkPnN9KTrCOXufzijYOqh8uvl5xSxVqu0TZqYtJxctg6oagE1ozYPy
         xzzwmp4eWLQhXvfUNkE16yd30cAJkP8h0f8LDr2hUXeSRNsq4DY9ffKE/TEEFItiSUr8
         rqfMsYGRzqaEDQ7ntybQFopPpaQ00iNnjL6WtgkQ24qxccwyON0xd07sd2mwjscWCB/+
         8wkSdGAOe6WzargiAjFU0CsPtwy+PjlG8Dr4Hb3hygxK2g4Fpkt7Pmdsg/E+6W0B4aB9
         2pmtwI15BDmGH1tUNmEO20hN41uT5iEsSeSWkt4i4sZIknC4tioXNWpnX5FakIdSh8w8
         jrDg==
X-Forwarded-Encrypted: i=1; AL+hErGYdK5F2J/rFFKPjEblsmFujp7ZOngzTrFe3YDQ9yNTLWtb681UXoYgLzBCsLuLds9lZtaqUNw0fQiq4A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9MkHI2PD0pqy4DtsXc/59DIPUdTtZeHoMPVFXvRiZGBdIt/msw
	GJssUk3SIzNY1Uag6kS1EG55mOBisNadVPuCDVcDEJAQ6cq2Nq17PgnNvN+VhUuonadsnNo/Vj9
	qcsRNPQ==
X-Received: from edxi20.prod.google.com ([2002:a05:6402:554:b0:6b3:c946:61f7])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:8a6f:b0:c48:ddac:7eb1
 with SMTP id a640c23a62f3a-c50496e7f98mr9105866b.45.1794248739421; Mon, 09
 Nov 2026 10:25:39 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:10 +0000
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
Message-ID: <20261109182533.3594984-3-lrizzo@google.com>
Subject: [RFC PATCH v2 02/25] iommu/dma: Add PISA allocator lifecycle and page
 recycle hook
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

PISA allocators use 2MB physically contiguous memory pages from which IO
buffers are allocated. Recycling memory to the PISA allocator amortizes the
cost of mapping, unmapping and IOTLB flush. Memory is returned to the buddy
allocator only when all active IOMMU/IOTLB mappings have been flushed,
so sensitive data or code will not ever be accessible to IO devices.

Add the allocator creation (struct pisa_alloc, pisa_create()) and the
page release side, hooking into __free_pages_prepare() so that PISA
pages are returned to the allocator.

Also implement asynchronous PISA page retirement and release to the
buddy allocator via a WQ_MEM_RECLAIM worker. Retirement removes PISA
pages from allocators and destroys the mappings flushing the IOTLB, but
defers the buddy release by an RCU grace period.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/Makefile     |   2 +-
 drivers/iommu/pisa-alloc.c | 369 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c |  10 +-
 drivers/iommu/pisa-priv.h  |  85 +++++++++
 include/linux/pisa.h       |  28 ++-
 mm/page_alloc.c            |  21 +++
 6 files changed, 512 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/pisa-alloc.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index b5d3be1df3eda..bda0b102dd3ba 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
-obj-$(CONFIG_PISA) += pisa-meta.o
+obj-$(CONFIG_PISA) += pisa-meta.o pisa-alloc.o
 obj-$(CONFIG_PISA_META_KUNIT_TEST) += pisa-kunit.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
new file mode 100644
index 0000000000000..68f5d333ae15c
--- /dev/null
+++ b/drivers/iommu/pisa-alloc.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * PISA streaming page allocator, async page reclaim, shrinker, and debugfs.
+ * See Documentation/core-api/pisa.rst for the architecture overview.
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/cache.h>
+#include <linux/dma-mapping.h>
+#include <linux/pisa.h>
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/list.h>
+#include <linux/llist.h>
+#include <linux/mm.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "pisa-priv.h"
+
+/* Parameters are pisa.<name> at boot and in /sys/module/pisa/parameters/. */
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "pisa."
+
+/* Idle PISA pages over the allocator watermark queued locklessly for release. */
+static LLIST_HEAD(pisa_free_list);
+
+/* Dedicated WQ_MEM_RECLAIM workqueue, can run without allocations. */
+static struct workqueue_struct *pisa_wq __ro_after_init;
+
+/* Max completely idle PISA pages kept per allocator before async release. */
+static unsigned int pisa_max_idle __read_mostly = 1;
+module_param_named(max_idle, pisa_max_idle, uint, 0644);
+
+/* Grace period in ms before releasing idle PISA pages above @pisa_max_idle (0 = immediate). */
+static unsigned int pisa_idle_ms __read_mostly = 200;
+module_param_named(idle_ms, pisa_idle_ms, uint, 0644);
+
+/* All live allocators, protected by pisa_allocs_lock. */
+static LIST_HEAD(pisa_allocs);
+static DEFINE_RWLOCK(pisa_allocs_lock);
+
+static void pisa_schedule_reclaim(void);
+
+/*
+ * Idle PISA page release proceeds in three stages:
+ * 1. Detach onto lockless pisa_free_list and schedule pisa_reclaim_work.
+ * 2. In process context (pisa_release_page()), unmap from all IOMMU domains,
+ *    clear PISA_ACTIVE, and queue pisa_release_page_rcu() via call_rcu().
+ * 3. After an RCU grace period, pisa_release_page_rcu() unfreezes all blocks
+ *    and returns them to the buddy allocator.
+ */
+
+/* RCU callback: unfreeze and return a retired PISA page's blocks to the buddy allocator. */
+static void pisa_release_page_rcu(struct rcu_head *head)
+{
+	/* Read @meta before freeing blocks; the frame can be reused immediately. */
+	struct pisa_meta *meta = container_of(head, struct pisa_meta, rcu);
+	struct page *block, *page = pfn_to_page(pisa_meta_to_pfn(meta));
+	unsigned int i, order = meta->pa->order;
+
+	WRITE_ONCE(meta->pa, NULL);
+
+	for (i = 0; i < PISA_BLOCKS(order); i++) {
+		block = page + (i << order);
+		page_ref_unfreeze(block, 1);
+		__free_pages(block, order);
+	}
+}
+
+/* Unmap a retired PISA page, clear PISA_ACTIVE, and queue RCU release. */
+static void pisa_release_page(struct pisa_meta *meta)
+{
+	/* pisa_unmap_all(meta) will be called here once IOMMU mappings are added. */
+
+	/* Clear PISA_ACTIVE before the RCU grace period so new readers stop entering. */
+	WRITE_ONCE(meta->flags, meta->flags & ~PISA_ACTIVE);
+	call_rcu(&meta->rcu, pisa_release_page_rcu);
+}
+
+/* Value of @meta->on_list. 0 is "not on an allocator list", as for a zeroed @meta. */
+enum pisa_meta_list {
+	PISA_LIST_NONE,
+	PISA_LIST_FULL,
+	PISA_LIST_IDLE_CLEAN,		/* head of @idle */
+	PISA_LIST_IDLE_DIRTY,		/* tail of @idle */
+	PISA_LIST_PARTIAL_CLEAN_DENSE,	/* head of @partial */
+	PISA_LIST_PARTIAL_CLEAN_SPARSE,	/* tail of @partial */
+	PISA_LIST_PARTIAL_DIRTY_DENSE,	/* head of @partial_dirty */
+	PISA_LIST_PARTIAL_DIRTY_SPARSE,	/* tail of @partial_dirty */
+};
+
+static void pisa_reclaim_work_fn(struct work_struct *work);
+
+/* Asynchronous reclaim worker for pisa_free_list and expired idle pages. */
+static DECLARE_DELAYED_WORK(pisa_reclaim_work, pisa_reclaim_work_fn);
+
+static void pisa_reclaim_work_fn(struct work_struct *work)
+{
+	unsigned long grace = msecs_to_jiffies(READ_ONCE(pisa_idle_ms));
+	unsigned long next_delay = MAX_JIFFY_OFFSET;
+	struct pisa_meta *meta, *tmp;
+	struct llist_node *node;
+	struct pisa_alloc *pa;
+
+	read_lock(&pisa_allocs_lock);
+	list_for_each_entry(pa, &pisa_allocs, node) {
+		unsigned long expire = READ_ONCE(pa->idle_jiffies) + grace;
+		unsigned long now = jiffies, flags;
+
+		if (READ_ONCE(pa->num_idle_pages) <= pa->max_idle_pages)
+			continue;
+		if (grace && time_before(now, expire)) {
+			next_delay = min(next_delay, expire - now);
+			continue;
+		}
+		spin_lock_irqsave(&pa->lock, flags);
+		while (pa->num_idle_pages > pa->max_idle_pages && !list_empty(&pa->idle)) {
+			meta = list_last_entry(&pa->idle, struct pisa_meta, list);
+			list_del_init(&meta->list);
+			WRITE_ONCE(meta->on_list, PISA_LIST_NONE);
+			llist_add(&meta->llnode, &pisa_free_list);
+			pa->num_idle_pages--;
+		}
+		spin_unlock_irqrestore(&pa->lock, flags);
+	}
+	read_unlock(&pisa_allocs_lock);
+
+	node = llist_del_all(&pisa_free_list);
+	llist_for_each_entry_safe(meta, tmp, node, llnode)
+		pisa_release_page(meta);
+
+	if (next_delay != MAX_JIFFY_OFFSET)
+		queue_delayed_work(pisa_wq ?: system_wq, &pisa_reclaim_work, next_delay);
+}
+
+static void pisa_schedule_reclaim(void)
+{
+	struct workqueue_struct *wq = pisa_wq ?: system_wq;
+	unsigned int idle_ms = READ_ONCE(pisa_idle_ms);
+
+	if (!llist_empty(&pisa_free_list) || !idle_ms)
+		mod_delayed_work(wq, &pisa_reclaim_work, 0);
+	else
+		queue_delayed_work(wq, &pisa_reclaim_work, msecs_to_jiffies(idle_ms));
+}
+/*
+ * Update @meta's position on @pa's lists under @pa->lock. When all blocks
+ * become available (avail == bpp), either queues @meta to @pisa_free_list (and
+ * returns true so the caller schedules reclaim) or moves it to @pa->idle.
+ */
+static bool pisa_place_meta(struct pisa_meta *meta)
+{
+	struct pisa_alloc *pa = meta->pa;
+	unsigned int avail = pisa_meta_avail(meta), bpp = PISA_BLOCKS(pa->order);
+	u8 on_list;
+
+	lockdep_assert_held(&pa->lock);
+
+	if (avail == bpp) {
+		if (pa->num_idle_pages >= pa->max_idle_pages && !READ_ONCE(pisa_idle_ms)) {
+			list_del_init(&meta->list);
+			WRITE_ONCE(meta->on_list, PISA_LIST_NONE);
+			llist_add(&meta->llnode, &pisa_free_list);
+			return true;
+		}
+		if (pa->num_idle_pages >= pa->max_idle_pages)
+			WRITE_ONCE(pa->idle_jiffies, jiffies);
+		pa->num_idle_pages++;
+		on_list = meta->nr_dirty ? PISA_LIST_IDLE_DIRTY : PISA_LIST_IDLE_CLEAN;
+	} else if (!avail) {
+		on_list = PISA_LIST_FULL;
+	} else {
+		bool sparse;
+
+		if (avail >= bpp - (bpp >> 2))
+			sparse = true;
+		else if (avail <= (bpp >> 1))
+			sparse = false;
+		else
+			sparse = meta->on_list == PISA_LIST_PARTIAL_CLEAN_SPARSE ||
+				 meta->on_list == PISA_LIST_PARTIAL_DIRTY_SPARSE;
+
+		if (meta->nr_clean)
+			on_list = sparse ? PISA_LIST_PARTIAL_CLEAN_SPARSE :
+					   PISA_LIST_PARTIAL_CLEAN_DENSE;
+		else
+			on_list = sparse ? PISA_LIST_PARTIAL_DIRTY_SPARSE :
+					   PISA_LIST_PARTIAL_DIRTY_DENSE;
+	}
+
+	if (on_list == meta->on_list)
+		return avail == bpp && pa->num_idle_pages > pa->max_idle_pages;
+	WRITE_ONCE(meta->on_list, on_list);
+
+	switch (on_list) {
+	case PISA_LIST_FULL:
+		list_move(&meta->list, &pa->full);
+		break;
+	case PISA_LIST_IDLE_CLEAN:
+		list_move(&meta->list, &pa->idle);
+		break;
+	case PISA_LIST_IDLE_DIRTY:
+		list_move_tail(&meta->list, &pa->idle);
+		break;
+	case PISA_LIST_PARTIAL_CLEAN_DENSE:
+		list_move(&meta->list, &pa->partial);
+		break;
+	case PISA_LIST_PARTIAL_CLEAN_SPARSE:
+		list_move_tail(&meta->list, &pa->partial);
+		break;
+	case PISA_LIST_PARTIAL_DIRTY_DENSE:
+		list_move(&meta->list, &pa->partial_dirty);
+		break;
+	default:
+		list_move_tail(&meta->list, &pa->partial_dirty);
+	}
+	return avail == bpp && pa->num_idle_pages > pa->max_idle_pages;
+}
+
+/* Check for hwpoisoned block; if poisoned, warn once and leak it to keep @pa intact. */
+static bool pisa_block_poisoned(struct pisa_alloc *pa, struct page *block)
+{
+	unsigned int i, nr = 1U << pa->order;
+
+	for (i = 0; i < nr; i++) {
+		if (unlikely(PageHWPoison(block + i))) {
+			pr_err_once("pisa: poisoned block at pfn %lu, leaking it to keep allocator %p intact\n",
+				    page_to_pfn(block), pa);
+			return true;
+		}
+	}
+	return false;
+}
+
+/**
+ * pisa_create - Create a PISA page allocator
+ * @nid: Home NUMA node for this allocator
+ * @order: Block order to dispense (<= PISA_ORDER)
+ * @dir: Supported DMA direction (DMA_BIDIRECTIONAL, DMA_TO_DEVICE, or
+ *	DMA_FROM_DEVICE); other mappings fall back to per-buffer IOMMU mappings
+ *
+ * Return: Pointer to the created allocator, or NULL on failure.
+ */
+struct pisa_alloc *pisa_create(int nid, unsigned int order, enum dma_data_direction dir)
+{
+	struct pisa_alloc *pa;
+
+	if (order > PISA_ORDER || !valid_dma_direction(dir))
+		return NULL;
+
+	pa = kzalloc(sizeof(*pa), GFP_KERNEL);
+	if (!pa)
+		return NULL;
+
+	spin_lock_init(&pa->lock);
+	pa->order = order;
+	pa->nid = pisa_sanitize_nid(nid);
+	pa->max_idle_pages = READ_ONCE(pisa_max_idle) ? : 1;
+	pisa_set_name(pa, "%ps", (void *)_RET_IP_);
+	INIT_LIST_HEAD(&pa->partial);
+	INIT_LIST_HEAD(&pa->partial_dirty);
+	INIT_LIST_HEAD(&pa->idle);
+	INIT_LIST_HEAD(&pa->full);
+
+	write_lock(&pisa_allocs_lock);
+	list_add_tail(&pa->node, &pisa_allocs);
+	write_unlock(&pisa_allocs_lock);
+
+	return pa;
+}
+
+/**
+ * pisa_set_name - Name a PISA allocator for debugfs
+ * @pa: Allocator to name (may be NULL)
+ * @fmt: printf-style format, truncated to fit @pa->name
+ */
+void pisa_set_name(struct pisa_alloc *pa, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!pa)
+		return;
+	va_start(args, fmt);
+	vsnprintf(pa->name, sizeof(pa->name), fmt, args);
+	va_end(args);
+}
+
+/* Return freed @block (at refcount 0) to @pa's bitmaps under @pa->lock. */
+static void pisa_return_block_locked(struct pisa_alloc *pa, struct page *block, bool *release)
+{
+	unsigned long pfn = page_to_pfn(block);
+	struct pisa_meta *meta = pisa_meta_of_pfn(pfn);
+	unsigned int idx = (pfn & (PISA_BLOCKS(0) - 1)) >> pa->order;
+
+	lockdep_assert_held(&pa->lock);
+
+	if (WARN_ON_ONCE(test_bit(idx, meta->clean_bitmap) || test_bit(idx, meta->dirty_bitmap)))
+		return;
+
+	/* __pisa_free_page() zeroed it if init_on_free is set. */
+	if (want_init_on_free()) {
+		__set_bit(idx, meta->clean_bitmap);
+		meta->nr_clean++;
+	} else {
+		__set_bit(idx, meta->dirty_bitmap);
+		meta->nr_dirty++;
+	}
+	*release |= pisa_place_meta(meta);
+}
+
+/**
+ * __pisa_free_page - Recycle a freed block back into its PISA allocator
+ * @page: Block being freed (called from __free_pages_prepare() under RCU)
+ *
+ * Return: true if the page belonged to a PISA allocator and was recycled.
+ */
+bool __pisa_free_page(struct page *page)
+{
+	bool should_release = false;
+	unsigned long pfn = page_to_pfn(page), flags;
+	struct pisa_meta *meta = pisa_meta_of_pfn(pfn);
+	struct pisa_alloc *pa = meta->pa;
+	unsigned int idx = (pfn & (PISA_BLOCKS(0) - 1)) >> pa->order;
+
+	/* Reject double frees, mismatched orders, or unaligned blocks. */
+	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, 1UL << pa->order) ||
+			 compound_order(page) != pa->order ||
+			 test_bit(idx, meta->clean_bitmap) || test_bit(idx, meta->dirty_bitmap)))
+		return true;
+
+	/* Never reuse or return a hwpoisoned block to the buddy allocator. */
+	if (pisa_block_poisoned(pa, page))
+		return true;
+
+	/* Checks skipped by the early return in __free_pages_prepare(). */
+	if (unlikely(!free_page_prepare_pisa(page, pa->order)))
+		return true;
+
+	/* KASAN/KMSAN/pgalloc_tag_sub run when pisa_release_page_rcu() frees to buddy. */
+	if (want_init_on_free())
+		memset(page_address(page), 0, PAGE_SIZE << pa->order);
+
+	spin_lock_irqsave(&pa->lock, flags);
+	pisa_return_block_locked(pa, page, &should_release);
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (should_release)
+		pisa_schedule_reclaim();
+
+	return true;
+}
+
+static int __init pisa_init(void)
+{
+	/* Dedicated WQ_MEM_RECLAIM workqueue so reclaim never blocks behind system_wq. */
+	pisa_wq = alloc_workqueue("pisa", WQ_MEM_RECLAIM, 0);
+	if (!pisa_wq)
+		pr_warn("pisa: no reclaim workqueue, falling back to system_wq\n");
+
+	return 0;
+}
+subsys_initcall(pisa_init);
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 0633f3238e012..12edc73abc9c6 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -85,10 +85,18 @@ static void test_meta_active_toggle(struct kunit *test)
 	__free_pages(page, PISA_ORDER);
 }
 
+static void test_alloc_and_recycle(struct kunit *test)
+{
+	KUNIT_EXPECT_NULL(test, pisa_create(NUMA_NO_NODE, 0, DMA_NONE));
+	KUNIT_EXPECT_NULL(test, pisa_create(NUMA_NO_NODE, PISA_ORDER + 1, DMA_BIDIRECTIONAL));
+	pisa_set_name(NULL, "ignored");
+}
+
 static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_meta_init_and_roundtrip),
 	KUNIT_CASE(test_meta_invalid_phys),
 	KUNIT_CASE(test_meta_active_toggle),
+	KUNIT_CASE(test_alloc_and_recycle),
 	{}
 };
 
@@ -98,5 +106,5 @@ static struct kunit_suite pisa_meta_test_suite = {
 };
 
 kunit_test_suite(pisa_meta_test_suite);
-MODULE_DESCRIPTION("KUnit tests for struct pisa_meta table");
+MODULE_DESCRIPTION("KUnit tests for struct pisa_meta table and PISA allocator");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index c873970f6a670..769b0ef071705 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -2,8 +2,13 @@
 #ifndef _DRIVERS_IOMMU_PISA_PRIV_H
 #define _DRIVERS_IOMMU_PISA_PRIV_H
 
+#include <linux/dma-direction.h>
 #include <linux/pisa.h>
+#include <linux/list.h>
+#include <linux/llist.h>
+#include <linux/nodemask.h>
 #include <linux/spinlock.h>
+#include <linux/topology.h>
 #include <linux/types.h>
 
 #ifdef CONFIG_PISA
@@ -12,20 +17,100 @@
 
 #define PISA_BLOCKS(order)	(1U << (PISA_ORDER - (order)))
 
+/*
+ * Lock hierarchy:
+ * - pisa_allocs_lock (rwlock): outermost; protects pisa_allocs list.
+ * - pisa_meta_mutex (mutex): serializes pisa_meta_init() and page-table alloc.
+ * - pa->lock (spinlock, irqsave): per-allocator lists, bitmaps, and stats.
+ */
+
 /**
  * struct pisa_meta - Metadata for a single PISA page in @pisa_meta_array
  * @flags:	PISA_ACTIVE while this page is owned by a pisa_alloc
+ * @nr_clean:	Zeroed available blocks in @clean_bitmap
+ * @nr_dirty:	Dirty available blocks in @dirty_bitmap
+ * @on_list:	Current placement in @pa (enum pisa_meta_list)
+ * @pa:		Owning pisa_alloc (NULL for reservoir pages)
+ * @list:	Node in @pa lists or per-node reservoir (pisa_node.pages)
+ * @llnode:	Node in lockless pisa_free_list for async release to the buddy allocator
+ * @rcu:	RCU head used to defer release to the buddy allocator
+ * @clean_bitmap: Bitmap of zeroed available block indices
+ * @dirty_bitmap: Bitmap of dirty available block indices
  */
 struct pisa_meta {
 	u8 flags;
+	u16 nr_clean;
+	u16 nr_dirty;
+	u8 on_list;
+	struct pisa_alloc *pa;
+	struct list_head list;
+
+	union {
+		struct llist_node llnode;
+		struct rcu_head rcu;
+	};
+
+	DECLARE_BITMAP(clean_bitmap, PISA_MAX_BLOCKS) ____cacheline_aligned;
+	DECLARE_BITMAP(dirty_bitmap, PISA_MAX_BLOCKS) ____cacheline_aligned;
 } __aligned(PISA_META_SIZE);
 
 static_assert(offsetof(struct pisa_meta, flags) == 0);
 static_assert(sizeof(struct pisa_meta) == PISA_META_SIZE);
 
+static inline unsigned int pisa_meta_avail(const struct pisa_meta *meta)
+{
+	return meta->nr_clean + meta->nr_dirty;
+}
+
+/**
+ * struct pisa_alloc - Allocator managing 2MB-backed blocks of a fixed order
+ * @lock:	Spinlock protecting lists and block bitmaps
+ * @order:	Block order managed by this allocator (<= PISA_ORDER)
+ * @partial:	Partially used PISA pages with @nr_clean > 0
+ * @partial_dirty: Partially used PISA pages with @nr_clean == 0 and @nr_dirty > 0
+ * @idle:	Completely free PISA pages (reclaimable under pressure)
+ * @full:	List of PISA pages with 0 free blocks
+ * @num_idle_pages: Length of @idle
+ * @max_idle_pages: High watermark of @idle before async release to the buddy allocator
+ * @idle_jiffies: Timestamp (jiffies) when @idle last exceeded @max_idle_pages
+ * @nid:	NUMA node id
+ * @node:	Node in the global pisa_allocs list
+ * @name:	Debug name (defaults to caller of pisa_create())
+ */
+struct pisa_alloc {
+	/* First cacheline: hot fields touched on block alloc and free. */
+	spinlock_t		lock;
+	u8			order;
+	struct list_head	partial;
+	struct list_head	partial_dirty;
+	struct list_head	idle;
+	struct list_head	full;
+	unsigned int		num_idle_pages;
+	unsigned int		max_idle_pages;
+	unsigned long		idle_jiffies;
+
+	/* Cold. */
+	int			nid;
+	struct list_head	node;
+	char			name[48];
+} ____cacheline_aligned;
+
 int pisa_meta_ensure_pfn(unsigned long pfn, bool can_block);
 struct pisa_meta *pisa_meta_of_pfn(unsigned long pfn);
 unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta);
 
+struct pisa_alloc *pisa_create(int nid, unsigned int order, enum dma_data_direction dir);
+__printf(2, 3)
+void pisa_set_name(struct pisa_alloc *pa, const char *fmt, ...);
+
+static inline int pisa_sanitize_nid(int nid)
+{
+	if ((unsigned int)nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
+		nid = numa_mem_id();
+	if (!node_state(nid, N_MEMORY))
+		nid = first_memory_node;
+	return nid;
+}
+
 #endif /* CONFIG_PISA */
 #endif /* _DRIVERS_IOMMU_PISA_PRIV_H */
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index acf92ced245d8..dddcedb8c93f6 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -3,10 +3,11 @@
 #ifndef _LINUX_PISA_H
 #define _LINUX_PISA_H
 
+#include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/jump_label.h>
 #include <linux/mm.h>
-#include <linux/types.h>
+#include <linux/rcupdate.h>
 
 #ifdef CONFIG_PISA
 
@@ -53,6 +54,24 @@ static inline bool is_pisa_pfn(unsigned long pfn)
 	return READ_ONCE(*flags) & PISA_ACTIVE;
 }
 
+static inline bool is_pisa_page(const struct page *page);
+
+bool __pisa_free_page(struct page *page);
+bool free_page_prepare_pisa(struct page *page, unsigned int order);
+
+static inline bool pisa_free_page(struct page *page)
+{
+	bool ret;
+
+	if (!static_branch_unlikely(&pisa_key))
+		return false;
+	rcu_read_lock();
+	ret = is_pisa_page(page) && __pisa_free_page(page);
+	rcu_read_unlock();
+
+	return ret;
+}
+
 #else /* !CONFIG_PISA */
 
 static inline int pisa_meta_init(void)
@@ -60,11 +79,18 @@ static inline int pisa_meta_init(void)
 	return -EOPNOTSUPP;
 }
 
+bool free_page_prepare_pisa(struct page *page, unsigned int order);
+
 static inline bool is_pisa_pfn(unsigned long pfn)
 {
 	return false;
 }
 
+static inline bool pisa_free_page(struct page *page)
+{
+	return false;
+}
+
 #endif /* CONFIG_PISA */
 
 static inline bool is_pisa_phys(phys_addr_t phys)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eb4f02617f53c..48df87a19d312 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -17,6 +17,7 @@
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/pisa.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/compiler.h>
@@ -1298,6 +1299,23 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
+/*
+ * pisa_free_page() in __free_pages_prepare() recycles a PISA block into
+ * its allocator before the rest of that function runs. __pisa_free_page() calls
+ * this to apply the buddy allocator's checks.
+ *
+ * Return: false if the block is in a bad state (already reported): leak it.
+ */
+bool free_page_prepare_pisa(struct page *page, unsigned int order)
+{
+	if (!IS_ENABLED(CONFIG_PISA))
+		return true;
+	if (is_check_pages_enabled() && free_page_is_bad(page))
+		return false;
+	page_table_check_free(page, order);
+	return true;
+}
+
 static __always_inline bool __free_pages_prepare(struct page *page,
 		unsigned int order, fpi_t fpi_flags)
 {
@@ -1312,6 +1330,9 @@ static __always_inline bool __free_pages_prepare(struct page *page,
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
+	if (unlikely(pisa_free_page(page)))
+		return false;
+
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
-- 
2.56.0.542.g3ef89b7020-goog

