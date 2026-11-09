Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248758;
	b=gR7kvWzooKmphdM0iBzKwowD9HJovy9Ah3qgx598+JWjr07lAMTIF+UWmN99KdvBOeLF
	 zfrLFGpjiFGKThhcocdZZ3N7EFZIAmmAzKdWBQTUkS2n8N42TCf81axcgdUnEQadacjLo
	 DAaNpO739/Se+dwpEeYA0nm6ih5AgI64OSfN0lqKp4RerK7mnFxaqXDMcdct8RM/dz+ZR
	 xGr6nqN+Ap6ZJfsCqKNjhUIKGasolyZ/rnP0h7IAA0BglSUBvU/Tn3unVrlPFaabA3xYN
	 D3FMqv9rPVTl/Md65lPmIiaxTM5fDOxxNcbGrYr3QEBYdjhAwivRzSidfjAut7D80Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FSPctyA/MS0u6st/7vSe681gFMr+b88P2K2apPB5g58=;
	b=gqHiHoi7vcCNH7qeIu/1q1XqyitVO1iX0xjj9eCQNAQ/21h7xsHZNITzrZ4XhvtdjQNP
	 xAAuYwcIsU/AxUJpfbsPMuhoCI+mnOb83YR5SyatmBlcaI4LnrKFXB2tDZHvFkOfl913p
	 443CUGr0Mw/bnyCW4jPT5Hspkg8RRFEauajyHXP4SfIwnrSwmyZs3wW4MtC2Z31bJ1tcG
	 TF1mz43GRJro8wdQ0KZzG5hwa0hhQQqMzecyZeVVgdI8yDgo09RmZDWkdNOyimjWkL5g6
	 AO1pkSfgLplzvQFGWPU+nwvy39jSzL1v9rQ/AJkDNUXC9KubZaVOgTi/Tz8a/KODcrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9nC+XkU;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C70606E107
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C70606E107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9nC+XkU
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c293e604f0eso114722566b.3
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248756; x=1794853556; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSPctyA/MS0u6st/7vSe681gFMr+b88P2K2apPB5g58=;
        b=Y9nC+XkUc5j/2LcXmNorBpXnBaWywEv5W7mW03LTnsNtCNz5snXZDsbiO7eejVo6BF
         WZKNUExQh40wasch3SApW2zLjxaO2WzXnd9/Q9hRUhkm1+qxzt3EtaHcETWg7mr+NbE8
         1ZQpu6x3LL18zaj2BNSMVkSMi3H8wKFCiaMGM3TAoM1UXkUUI3KIemL7f5bZiFVL30vR
         5RjfDuoPFuJZB3lK52iXh/8Z7Pu6Mli44ZjyQ5Jbqhd5/faAZjuCvcX2/0OK1pDuplQ8
         FT8emAbWBe9DBqqQsVgp4zxj+imieZbTKeg2KGX/DRU5z6y0QKx+MB4pM7luYX3hcDOt
         4InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248756; x=1794853556;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FSPctyA/MS0u6st/7vSe681gFMr+b88P2K2apPB5g58=;
        b=VzGVkH/zTT+hAPVzItBPiaufOE6xcnV24u8SfZsgvpNsveveS7/0jcmmJlCr/0hGdG
         Sxr/FOcMkbIrELALHELkuFIwWZ2bhOuwQ1k4zkc2SsFW0VsO6pXvQ5uNlP9NgY4ZWcuK
         N9Cva5ol9e+fxzEY8T9sSozzVCcUwyl+6jdKmPoukfroOOG0EjSqdecKpIwBqzR8adI6
         vR/E4CtfSXfO7IH6k11m1J1zopn7d2CLEe7/DEZLQA0RZmOj6GItO32PkuLp4Mj2s8Fq
         1YHiUJqYC3EBGxRmqiRjarmHr3k9s+5rIN3fl0ZzRkXGc6nNGOLu6iIJYwULzN05ZmWN
         1+fg==
X-Forwarded-Encrypted: i=1; AL+hErGK/g1CLDyhmULh8D8/yQd76H0yt0KOvONMZrzAB/y9SPqB+fzniWFTnpgRqz7/CY3S2FV97Tl/MoHGaQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9sF+bciV/uOY/A4gVJ8f4DBPbQF7F2Vb3FGoQAhXymA1AVETUI
	U32gJ0sLJkfny8uSo6ak+ghfHiIwFCrbT4qqDgNBb0syUMFJ/AVoQs6X3cNIQm4voVpXMM9m1Pg
	NBXxpFQ==
X-Received: from ejblc10.prod.google.com ([2002:a17:906:f90a:b0:c3f:a421:260c])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3d90:b0:c40:4320:de2c
 with SMTP id a640c23a62f3a-c504951eb58mr16658666b.15.1794248755247; Mon, 09
 Nov 2026 10:25:55 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:26 +0000
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
Message-ID: <20261109182533.3594984-19-lrizzo@google.com>
Subject: [RFC PATCH v2 18/25] iommu/dma: Migrate user pages into PISA for TX zerocopy
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

MSG_ZEROCOPY sends map each user page with a per-buffer IOMMU mapping
and IOTLB flush. Moving user TX buffers into PISA blocks once allows
subsequent zerocopy sends to reuse pre-mapped 2MB IOMMU entries.

Add drivers/iommu/pisa-user.c to migrate private anonymous order-0 user
pages into per-node DMA_TO_DEVICE PISA allocators, controlled by
pisa.user_max_4K_pages (0 = disabled):
- Explicit migration via madvise(MADV_PISA) and MADV_NOPISA (also
  supported via process_madvise()).
- Automatic best-effort migration on MSG_ZEROCOPY sends in
  zerocopy_fill_skb_from_iter() when the egress device has pisa_tx_bufs
  enabled. For TCP, pages that cannot be migrated fall back to the
  regular copy path into PISA TX page_frags.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/Makefile                 |   2 +-
 drivers/iommu/pisa-alloc.c             |   2 +
 drivers/iommu/pisa-priv.h              |   2 +
 drivers/iommu/pisa-user.c              | 278 +++++++++++++++++++++++++
 include/linux/pisa.h                   |  28 +++
 include/linux/swap.h                   |   1 +
 include/uapi/asm-generic/mman-common.h |   2 +
 mm/madvise.c                           |  11 +
 net/core/datagram.c                    |  82 +++++++-
 net/core/skbuff.c                      |   3 +-
 net/ipv4/tcp.c                         |  12 +-
 11 files changed, 416 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iommu/pisa-user.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 125cf7e813cdc..cd14f80a594a7 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
-obj-$(CONFIG_PISA) += pisa-meta.o pisa-alloc.o pisa-node.o
+obj-$(CONFIG_PISA) += pisa-meta.o pisa-alloc.o pisa-node.o pisa-user.o
 ifeq ($(CONFIG_IOMMU_DMA),y)
 obj-$(CONFIG_PISA) += pisa-map.o
 endif
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 7df2ecde32916..1930135880d2b 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -1756,6 +1756,8 @@ static int __init pisa_init(void)
 		}
 	}
 
+	pisa_user_boot_enable();
+
 	/* Dedicated WQ_MEM_RECLAIM workqueue so reclaim never blocks behind system_wq. */
 	pisa_wq = alloc_workqueue("pisa", WQ_MEM_RECLAIM, 0);
 	if (!pisa_wq)
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index ef3abb1db9049..fe1bff0bba322 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -185,6 +185,7 @@ static inline long pisa_alloc_held_pages(const struct pisa_alloc *pa)
 struct pisa_node {
 	unsigned long		next_alloc;	/* atomic alloc backoff jiffies */
 	struct pisa_alloc	*pa[2][PISA_ORDER + 1]; /* [0]=RW, [1]=RO by order */
+	struct pisa_alloc	*user_pa;	/* user page migration pa */
 
 	spinlock_t		lock;		/* protects @pages and @nr_pages */
 	struct list_head	pages;		/* reservoir */
@@ -278,6 +279,7 @@ void pisa_schedule_scrub_all(void);
 struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool decrypt, bool *clean);
 unsigned long pisa_reservoir_count(void);
 unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan);
+void pisa_user_boot_enable(void);
 
 #endif /* CONFIG_PISA */
 
diff --git a/drivers/iommu/pisa-user.c b/drivers/iommu/pisa-user.c
new file mode 100644
index 0000000000000..a16909d429aca
--- /dev/null
+++ b/drivers/iommu/pisa-user.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * PISA user and page-cache folios: allocate or migrate order-0 folios into
+ * per-node PISA allocators so zero-copy TX and block I/O use 2MB IOMMU mappings.
+ * Disabled on CoCo guests (user PTEs map pages encrypted).
+ */
+#include <linux/cc_platform.h>
+#include <linux/pisa.h>
+#include <linux/gfp.h>
+#include <linux/migrate.h>
+#include <linux/mm.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/nodemask.h>
+#include <linux/pagewalk.h>
+#include <linux/swap.h>
+
+#include "pisa-priv.h"
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "pisa."
+
+/* Soft cap on 4KB user pages held in PISA blocks (0 = disabled). */
+static unsigned long pisa_user_max_4k_pages __read_mostly;
+DEFINE_STATIC_KEY_FALSE(pisa_user_key);
+
+static bool pisa_user_init(void);
+
+static int pisa_user_max_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned long max_pages;
+	int ret;
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return -EOPNOTSUPP;
+	ret = kstrtoul(val, 0, &max_pages);
+	if (ret)
+		return ret;
+	WRITE_ONCE(pisa_user_max_4k_pages, max_pages);
+	if (max_pages) {
+		if (!pisa_nodes[first_memory_node].pa[0][0])
+			return 0;
+		if (!pisa_user_init())
+			return -ENOMEM;
+		static_branch_enable(&pisa_user_key);
+	} else {
+		static_branch_disable(&pisa_user_key);
+	}
+	return 0;
+}
+
+static const struct kernel_param_ops pisa_user_max_ops = {
+	.set = pisa_user_max_set,
+	.get = param_get_ulong,
+};
+module_param_cb(user_max_4K_pages, &pisa_user_max_ops, &pisa_user_max_4k_pages, 0644);
+
+/* True once per-node user allocators have been allocated, serialized by pisa_user_lock. */
+static bool pisa_user_ready __read_mostly;
+static DEFINE_MUTEX(pisa_user_lock);
+
+/* Lazily create per-node user allocators on first use (process context). */
+static bool pisa_user_init(void)
+{
+	int nid;
+
+	if (!READ_ONCE(pisa_user_max_4k_pages) || cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return false;
+	/* Pairs with smp_store_release() below: the allocators are visible. */
+	if (smp_load_acquire(&pisa_user_ready))
+		return true;
+	if (pisa_meta_init())
+		return false;
+	mutex_lock(&pisa_user_lock);
+	for_each_node_state(nid, N_MEMORY) {
+		if (!pisa_nodes[nid].user_pa)
+			pisa_nodes[nid].user_pa = pisa_create(nid, 0, DMA_TO_DEVICE);
+		if (!pisa_nodes[nid].user_pa)
+			goto out;	/* retried on the next call */
+	}
+	/* Publish pisa_nodes[].user_pa to lockless readers. */
+	smp_store_release(&pisa_user_ready, true);
+out:
+	mutex_unlock(&pisa_user_lock);
+	return pisa_user_ready;
+}
+
+void pisa_user_boot_enable(void)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		WRITE_ONCE(pisa_user_max_4k_pages, 0);
+		return;
+	}
+	if (READ_ONCE(pisa_user_max_4k_pages) && pisa_user_init())
+		static_branch_enable(&pisa_user_key);
+}
+
+/* User pages currently held in PISA blocks. */
+static unsigned long pisa_user_in_use(void)
+{
+	unsigned long used = 0;
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY) {
+		const struct pisa_alloc *pa = pisa_nodes[nid].user_pa;
+
+		used += pa ? READ_ONCE(pa->blocks_in_use) : 0;
+	}
+	return used;
+}
+
+/* Pages that can still be moved in before reaching pisa.user_max_4K_pages. */
+static long pisa_user_budget(void)
+{
+	return (long)(READ_ONCE(pisa_user_max_4k_pages) - pisa_user_in_use());
+}
+
+/* Is @folio worth moving into (@to_pisa) or out of PISA memory? */
+static bool pisa_user_want(struct folio *folio, bool to_pisa)
+{
+	if (!folio_test_anon(folio) || folio_is_zone_device(folio) ||
+	    folio_test_ksm(folio) || folio_test_large(folio) ||
+	    folio_maybe_mapped_shared(folio))
+		return false;
+	return is_pisa_pfn(folio_pfn(folio)) != to_pisa;
+}
+
+/* Return true if @folio has references beyond its mappings, swap cache, and @extra. */
+static bool pisa_user_busy(struct folio *folio, int extra)
+{
+	return folio_ref_count(folio) > folio_expected_ref_count(folio) + extra;
+}
+
+struct pisa_user_mtc {
+	gfp_t	gfp;
+	long	budget;
+};
+
+/* new_folio_t for migration into PISA memory. */
+static struct folio *pisa_user_new_folio(struct folio *src, unsigned long private)
+{
+	struct pisa_user_mtc *mtc = (void *)private;
+	int nid = folio_nid(src);
+	struct page *page;
+
+	if (mtc->budget <= 0)
+		return NULL;
+	page = pisa_alloc(pisa_nodes[nid].user_pa, mtc->gfp);
+	if (!page)
+		return NULL;
+	if (pisa_meta_of_pfn(page_to_pfn(page))->flags & PISA_DECRYPTED) {
+		put_page(page);
+		mtc->budget = 0;
+		return NULL;
+	}
+	mtc->budget--;
+	return page_folio(page);
+}
+
+/* new_folio_t for migration out of PISA memory: allocators never serve these. */
+static struct folio *pisa_user_old_folio(struct folio *src, unsigned long private)
+{
+	return __folio_alloc_node(GFP_HIGHUSER_MOVABLE | __GFP_NOWARN, 0, folio_nid(src));
+}
+
+/* Migrate the isolated folios on @list; failures are put back. */
+static void pisa_user_migrate(struct list_head *list, bool to_pisa, gfp_t gfp)
+{
+	struct pisa_user_mtc mtc = { .gfp = gfp, .budget = LONG_MAX };
+	enum migrate_mode mode = MIGRATE_SYNC;
+
+	if (list_empty(list))
+		return;
+	if (to_pisa) {
+		mtc.budget = pisa_user_budget();
+		if (!gfpflags_allow_blocking(gfp))
+			mode = MIGRATE_ASYNC;
+	}
+	if (migrate_pages(list, to_pisa ? pisa_user_new_folio : pisa_user_old_folio,
+			  NULL, (unsigned long)&mtc, mode, MR_SYSCALL, NULL))
+		putback_movable_pages(list);
+}
+
+/**
+ * pisa_upgrade_user_pages - Try to move user pages about to be sent into PISA
+ * @pages: Pages from iov_iter_get_pages2(), one reference each
+ * @nr: Number of entries in @pages
+ *
+ * Best effort, process context. Pages that cannot be moved (e.g. still
+ * referenced by an in-flight skb, or in a large folio) are skipped; for TCP
+ * with pisa_tx_bufs enabled the caller copies them instead.
+ *
+ * Return: false if nothing was attempted and the references are untouched;
+ * true if all references were dropped and the caller must look the pages up
+ * again.
+ */
+bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr)
+{
+	bool drained = false;
+	LIST_HEAD(list);
+	unsigned int i, want = 0;
+
+	if (!pisa_user_init())
+		return false;
+	/* Common case: all pages already in PISA, no budget check needed. */
+	for (i = 0; i < nr; i++)
+		want += pisa_user_want(page_folio(pages[i]), true);
+	if (!want)
+		return false;
+	if (pisa_user_budget() <= 0)
+		return false;
+	for (i = 0; i < nr; i++) {
+		struct folio *folio = page_folio(pages[i]);
+
+		if (!pisa_user_want(folio, true))
+			continue;
+		/* A freshly faulted page may still sit in a per-CPU LRU batch. */
+		if (!drained && !folio_test_lru(folio)) {
+			lru_add_drain();
+			drained = true;
+		}
+		/* The reference from iov_iter_get_pages2() is expected. */
+		if (pisa_user_busy(folio, 1))
+			continue;
+		isolate_folio_to_list(folio, &list);
+	}
+	if (list_empty(&list))
+		return false;
+	/* Migration fails on pages with references it does not expect. */
+	for (i = 0; i < nr; i++)
+		put_page(pages[i]);
+	pisa_user_migrate(&list, true,
+			  GFP_NOWAIT | __GFP_HARDWALL | __GFP_NOWARN);
+	return true;
+}
+
+#define PISA_USER_BATCH	512
+
+/**
+ * pisa_madvise - MADV_PISA / MADV_NOPISA on [@start, @end) of @vma
+ * @vma: VMA, with the mmap lock held for reading
+ * @start: Start address
+ * @end: End address
+ * @to_pisa: true to move present pages into PISA, false to move them out
+ *
+ * Return: 0, -EINVAL for unsupported mappings, or -EOPNOTSUPP if disabled.
+ */
+int pisa_madvise(struct vm_area_struct *vma, unsigned long start, unsigned long end, bool to_pisa)
+{
+	gfp_t gfp = GFP_USER | __GFP_NOWARN;
+	struct folio_walk fw;
+	unsigned long addr;
+	unsigned int n = 0;
+	LIST_HEAD(list);
+
+	if (vma->vm_flags & (VM_SHARED | VM_IO | VM_PFNMAP | VM_HUGETLB))
+		return -EINVAL;
+	if (to_pisa && !pisa_user_init())
+		return -EOPNOTSUPP;
+	lru_add_drain();
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		struct folio *folio = folio_walk_start(&fw, vma, addr, 0);
+
+		if (folio) {
+			if (pisa_user_want(folio, to_pisa) && !pisa_user_busy(folio, 0) &&
+			    isolate_folio_to_list(folio, &list))
+				n++;
+			folio_walk_end(&fw, vma);
+		}
+		if (n == PISA_USER_BATCH) {
+			pisa_user_migrate(&list, to_pisa, gfp);
+			n = 0;
+		}
+		cond_resched();
+	}
+	pisa_user_migrate(&list, to_pisa, gfp);
+	return 0;
+}
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index 452b8fa20c8d7..d11fd3d663dc1 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -132,6 +132,18 @@ static inline void pisa_task_frag_release(struct task_struct *tsk)
 		put_page(tsk->task_frag_pisa.page);
 }
 
+/* User pages in PISA blocks, see drivers/iommu/pisa-user.c */
+DECLARE_STATIC_KEY_FALSE(pisa_user_key);
+bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr);
+int pisa_madvise(struct vm_area_struct *vma, unsigned long start,
+		 unsigned long end, bool to_pisa);
+
+/* Is pisa.user_max_4K_pages non-zero? */
+static inline bool pisa_user_enabled(void)
+{
+	return static_branch_unlikely(&pisa_user_key);
+}
+
 #else /* !CONFIG_PISA */
 
 static inline int pisa_meta_init(void)
@@ -213,6 +225,22 @@ static inline void pisa_task_frag_release(struct task_struct *tsk)
 {
 }
 
+static inline bool pisa_user_enabled(void)
+{
+	return false;
+}
+
+static inline bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr)
+{
+	return false;
+}
+
+static inline int pisa_madvise(struct vm_area_struct *vma, unsigned long start,
+			       unsigned long end, bool to_pisa)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_PISA */
 
 static inline struct page *
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4f686709d71f0..3736786ccc5a3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -314,6 +314,7 @@ extern unsigned long totalreserve_pages;
 /* linux/mm/folio.c */
 void folio_add_lru(struct folio *folio);
 void folio_mark_accessed(struct folio *folio);
+void lru_add_drain(void);
 void lru_add_drain_all(void);
 
 enum lru_cache_drained {
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index ef1c27fa3c570..c4332db8e56ff 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -81,6 +81,8 @@
 
 #define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
 #define MADV_GUARD_REMOVE 103		/* unguard range */
+#define MADV_PISA		210	/* move pages into PISA memory */
+#define MADV_NOPISA		211	/* move pages out of PISA memory */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/mm/madvise.c b/mm/madvise.c
index 0214efd2a014f..0eccb44594b04 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2002  Christoph Hellwig
  */
 
+#include <linux/pisa.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
@@ -1393,6 +1394,9 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 		return madvise_guard_install(madv_behavior);
 	case MADV_GUARD_REMOVE:
 		return madvise_guard_remove(madv_behavior);
+	case MADV_PISA:
+	case MADV_NOPISA:
+		return pisa_madvise(vma, range->start, range->end, behavior == MADV_PISA);
 
 	/* The below behaviours update VMAs via madvise_update_vma(). */
 
@@ -1582,6 +1586,9 @@ madvise_behavior_valid(int behavior)
 	case MADV_HWPOISON:
 #endif
 		return true;
+	case MADV_PISA:
+	case MADV_NOPISA:
+		return IS_ENABLED(CONFIG_PISA);
 
 	default:
 		return false;
@@ -1596,6 +1603,8 @@ static bool process_madvise_remote_valid(int behavior)
 	case MADV_PAGEOUT:
 	case MADV_WILLNEED:
 	case MADV_COLLAPSE:
+	case MADV_PISA:
+	case MADV_NOPISA:
 		return true;
 	default:
 		return false;
@@ -1782,6 +1791,8 @@ static enum madvise_lock_mode get_lock_mode(struct madvise_behavior *madv_behavi
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 	case MADV_COLLAPSE:
+	case MADV_PISA:
+	case MADV_NOPISA:
 		return MADVISE_MMAP_READ_LOCK;
 	case MADV_GUARD_INSTALL:
 	case MADV_GUARD_REMOVE:
diff --git a/net/core/datagram.c b/net/core/datagram.c
index ecc30a6f83023..40f20d0faa859 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -39,6 +39,7 @@
 #include <linux/kernel.h>
 #include <linux/uaccess.h>
 #include <linux/mm.h>
+#include <linux/pisa.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -632,10 +633,74 @@ int skb_copy_datagram_from_iter_full(struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_datagram_from_iter_full);
 
-int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
-				struct iov_iter *from, size_t length)
+/*
+ * Upgrade user @pages to PISA memory and, for TCP over a pisa_tx_bufs device,
+ * trim non-PISA trailing pages from the batch.
+ *
+ * Return: false to proceed with attaching *@copied bytes from @pages to @skb,
+ * or true to stop and make the caller return *@ret.
+ */
+static bool pisa_zc_iter(int *ret, struct sk_buff *skb, struct iov_iter *from, size_t *length,
+			 const struct sock *sk, struct page **pages, int max_pages,
+			 unsigned int orig_len, size_t *start, ssize_t *copied)
+{
+	unsigned int i, nr;
+	ssize_t keep;
+
+	if (!pisa_user_enabled() || !user_backed_iter(from))
+		return false;
+
+	/* Move user pages into PISA memory, then look them up again. */
+	if (pisa_upgrade_user_pages(pages, DIV_ROUND_UP(*start + *copied, PAGE_SIZE))) {
+		iov_iter_revert(from, *copied);
+		*copied = iov_iter_get_pages2(from, pages, *length, max_pages, start);
+		if (*copied < 0) {
+			*ret = -EFAULT;
+			return true;
+		}
+	}
+
+	/* Only TCP (which sets skb->sk at transmit time) handles short appends/-EXDEV. */
+	if (!sk || skb->sk)
+		return false;
+
+	/* Only plain MSG_ZEROCOPY ubufs (not io_uring/vhost/devmem). */
+	if (skb_zcopy(skb) && skb_zcopy(skb)->ops != &msg_zerocopy_ubuf_ops)
+		return false;
+
+	/* Egress device must have pisa_tx_bufs enabled so the copy uses a PISA page_frag. */
+	if (!dst_tx_pisa_ok(__sk_dst_get(sk)))
+		return false;
+
+	/*
+	 * Trim @from to the leading pages that are in PISA memory: drop the
+	 * references to the others, give their bytes back to @from, and cap
+	 * *@length so that the caller ends after attaching what is left.
+	 */
+	nr = DIV_ROUND_UP(*start + *copied, PAGE_SIZE);
+	for (i = 0; i < nr && is_pisa_page(pages[i]); i++)
+		;
+	if (i == nr)
+		return false;
+
+	keep = i ? i * PAGE_SIZE - *start : 0;
+	while (nr > i)
+		put_page(pages[--nr]);
+	iov_iter_revert(from, *copied - keep);
+	*copied = keep;
+	*length = keep;
+	if (keep)
+		return false;
+
+	*ret = (skb->len != orig_len) ? 0 : -EXDEV;
+	return true;
+}
+
+static int __zerocopy_fill_skb_from_iter(struct sk_buff *skb, struct iov_iter *from,
+					 size_t length, const struct sock *sk)
 {
 	int frag = skb_shinfo(skb)->nr_frags;
+	unsigned int orig_len = skb->len;
 
 	if (!skb_frags_readable(skb))
 		return -EFAULT;
@@ -643,7 +708,7 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 	while (length && iov_iter_count(from)) {
 		struct page *head, *last_head = NULL;
 		struct page *pages[MAX_SKB_FRAGS];
-		int refs, order, n = 0;
+		int refs, order, n = 0, ret;
 		size_t start;
 		ssize_t copied;
 
@@ -654,6 +719,9 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 					    MAX_SKB_FRAGS - frag, &start);
 		if (copied < 0)
 			return -EFAULT;
+		if (pisa_zc_iter(&ret, skb, from, &length, sk, pages,
+				 MAX_SKB_FRAGS - frag, orig_len, &start, &copied))
+			return ret;
 
 		length -= copied;
 
@@ -703,6 +771,12 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 	return 0;
 }
 
+int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
+				struct iov_iter *from, size_t length)
+{
+	return __zerocopy_fill_skb_from_iter(skb, from, length, NULL);
+}
+
 static int
 zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 			      int length,
@@ -760,7 +834,7 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 	else if (binding)
 		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
 	else
-		ret = zerocopy_fill_skb_from_iter(skb, from, length);
+		ret = __zerocopy_fill_skb_from_iter(skb, from, length, sk);
 
 	truesize = skb->truesize - orig_size;
 	if (sk && sk->sk_type == SOCK_STREAM) {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 04ae3bb4bd905..739d09615638c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1935,7 +1935,8 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 
 	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len,
 				      binding);
-	if (err == -EFAULT || (err == -EMSGSIZE && skb->len == orig_len)) {
+	if (err == -EFAULT ||
+	    ((err == -EMSGSIZE || err == -EXDEV) && skb->len == orig_len)) {
 		struct sock *save_sk = skb->sk;
 
 		/* Streams do not free skb on error. Reset to prev state. */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 038063717951c..9214d6213cae5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1128,6 +1128,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	int process_backlog = 0;
 	int sockc_err = 0;
 	int zc = 0;
+	bool must_copy = false;	/* copy the next chunk of a MSG_ZEROCOPY send */
 	long timeo;
 
 	flags = msg->msg_flags;
@@ -1289,7 +1290,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (copy > msg_data_left(msg))
 			copy = msg_data_left(msg);
 
-		if (zc == 0) {
+		if (zc == 0 || unlikely(must_copy)) {
 			const struct dst_entry *dst = __sk_dst_get(sk);
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
@@ -1335,6 +1336,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 				page_ref_inc(pfrag->page);
 			}
 			pfrag->offset += copy;
+			must_copy = false;
 		} else if (zc == MSG_ZEROCOPY)  {
 			/* First append to a fragless skb builds initial
 			 * pure zerocopy skb
@@ -1354,6 +1356,14 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 				tcp_mark_push(tp, skb);
 				goto new_segment;
 			}
+			/*
+			 * The next user page is not in PISA memory: copy this
+			 * chunk, without reporting SO_EE_CODE_ZEROCOPY_COPIED.
+			 */
+			if (unlikely(err == -EXDEV)) {
+				must_copy = true;
+				continue;
+			}
 			if (err < 0)
 				goto do_error;
 			copy = err;
-- 
2.56.0.542.g3ef89b7020-goog

