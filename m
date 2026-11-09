Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248747;
	b=CBjsr3XOPNlFq8L0mv1JOKu4Z9wrLFv3Ycr0KzDihBdyJ2fuu152/SW4tR/zmqW1+bqj
	 GclMQHvQMJZjqtf3UxW0M39yeahCGEmTSzNTbBzaeB7FQShacUlgaRvBSVpflOURt7sZs
	 JPXQMxVTq72CyHPO91ERJUZVP5sXe+/XcOJzAX4XnI63PXEIXYS3gvCegvBXwFRwK174t
	 8GoXlgJe4zTGM1Z8re+Vzfb+6UX8rfYqEzRdNkT3FHwdqqGb5alP7CVrkwOkMfDhiPF3n
	 p6iP3uYPF6xDLs7jKLj1/GxsRI4hBYmip43W5U6shMZnaAVn1XmGwuwSnKgQ6aASjmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=mg8qaLpI3RsEIdTCRIOG9C+aZGDoM534bPWkCcix4/0=;
	b=e4zB+/KPrbObcLrMrXnTfPhlAIQlJBDuRHA5oduQENTqbheO7d2eHhDaYQba6fm+3eR3
	 u8Hrf0txNXhD5gSvIqwv6igJnK75XFuWBuuHFHMOzzaivh901MHtj8BaXuOB5u9K9SLjp
	 kRlzx+QZAtkKkhPUfTj2iuSkFIAxDioBCgbXVt6aijJMv+Rj/KywR+azDplTNcRzSzLJJ
	 paFmmXeZ0aV73/n6AiDWDcWq3M7iutAvy/puH0hptoMisMerdkwA1IcJiMFOe60DA7f2v
	 ePzXNuKwzZ8CRVBKBzSEd4oBlhtlMpRv3F/oqpu9wlZd8OpQsNtxcAVWTtAhabY9OUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ThmX7itu;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A560A5BE3
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 392A560A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ThmX7itu
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c40bbd26f74so106837166b.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248745; x=1794853545; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mg8qaLpI3RsEIdTCRIOG9C+aZGDoM534bPWkCcix4/0=;
        b=ThmX7ituOGKCJ/kIRBVyCRVEXvPFYuBftUNzFd1yxrczKYiEwBUMdhGjS3i0Fv0ADs
         Bm4JZAeRnKYMuCUff3WMf8fEOFQmDkFflIpZ5LxQYul8XRRZSW62hZ/eSlg+FsZInRnh
         eeXjFyBd3nhjjWKR07ClOHrYDw42onaBSkVUtMpPbwiteoyEeRpwFqb3kZAYkkOjplXD
         UBy6l7W3V5oldzpxhEr4zZWTxp78WCcXG9AHboSWhCPBCrCIUAQvpNpeBgnbpJc9oFn9
         x3wVpJtcIuV+dmZxpOiCT6DeKS0Zd/OEdS4GlQHDr/5Fa73hXSkbozMs4pIIKnvLqljM
         kb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248745; x=1794853545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mg8qaLpI3RsEIdTCRIOG9C+aZGDoM534bPWkCcix4/0=;
        b=WT5qnwFEeDyuyy+jO8Xg8u0RkeOF1ZS1sSx/nJk3qD9NVk1kcMHc340mMIuFOjbA0S
         7jX6x+HaXsM97W8bAlKZLEONhtnvbSfMX7yMe8Hhfe4dpti6z/6jMLBdGaN4UOFu7DiS
         9Tuq0qkwKlYu50VXPrxhc5VUoy3CMfgQKBKgtxGZ1MeAxYPatWx5gKa+EpbUwsa+IqsO
         4tL5D9VYNuxm1WQCClPglXN5UBs0UG1kDamfCm5Qm+8zAkB+BuLGiD16lZrAmBnqbwe9
         DsmZzGmO2VFEkuQYih3FGykkfoHezyFABTG88u9MypE+moGVtuGFlbVQpMCmBISV8aRg
         IlAA==
X-Forwarded-Encrypted: i=1; AL+hErHwtMa4pYxKOhlKZ9W1GeTjWYJ/liYkgZC1+/POnE0ouFGv09+9FD83HFmCHPrM/yqopsdhxp5vlCcNKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9itNN85E4a9TsekhifN9SGO8KSCE5s4KkP7cumFpVUsOR7dKnP
	h3SzaZNts9cbBkBmkEdVy1L5MKxKuu3d0iPjTbYTyUkni+r8+h7tyToa1N/jnHqdECHFnN9FvxC
	GdvrwFg==
X-Received: from ejpk6.prod.google.com ([2002:a17:906:66c6:b0:c2e:3341:2b56])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9488:b0:c50:475d:980e
 with SMTP id a640c23a62f3a-c50496a4aedmr13882366b.38.1794248744417; Mon, 09
 Nov 2026 10:25:44 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:15 +0000
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
Message-ID: <20261109182533.3594984-8-lrizzo@google.com>
Subject: [RFC PATCH v2 07/25] iommu/dma: Release PISA domain mappings on
 domain teardown
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

Each PISA page can be mapped by multiple IOMMU domains.

Add pisa_domain_release() (called from iommu_put_dma_cookie()) to drop
a dying domain from the registry, clear its bit across all active PISA
pages, and wait on SRCU before reusing the domain index. If iommu_unmap()
fails on page release, mark the 2MB page PISA_QUARANTINED and leak it
so a device can never access reallocated memory.

When a group's last DMA API user detaches
(iommu_device_unuse_default_domain() with owner_cnt reaching 0), call
pisa_domain_quiesce() to unmap all active PISA pages from the default
domain and flush the IOTLB while keeping the domain's window and index
for future demand mappings.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/dma-iommu.c  |   3 +
 drivers/iommu/iommu.c      |   5 +
 drivers/iommu/pisa-alloc.c |  14 ++-
 drivers/iommu/pisa-kunit.c |  18 ++++
 drivers/iommu/pisa-map.c   | 214 ++++++++++++++++++++++++++++++++++++-
 drivers/iommu/pisa-priv.h  |  56 +++++++++-
 include/linux/pisa.h       |   1 +
 7 files changed, 306 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index fba6084feac81..025bceebb2262 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -430,6 +430,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
+	/* Drop cached PISA mappings before the IOVA domain goes away. */
+	pisa_domain_release(domain);
+
 	if (cookie->iovad.granule) {
 		iommu_dma_free_fq(cookie);
 		put_iova_domain(&cookie->iovad);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..dfba3d5c277c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -37,6 +37,7 @@
 #include <linux/generic_pt/iommu.h>
 
 #include "dma-iommu.h"
+#include "pisa-priv.h"
 #include "iommu-priv.h"
 
 static struct kset *iommu_group_kset;
@@ -3363,6 +3364,10 @@ void iommu_device_unuse_default_domain(struct device *dev)
 	if (!WARN_ON(!group->owner_cnt || !xa_empty(&group->pasid_array)))
 		group->owner_cnt--;
 
+	/* Unmap persistent PISA windows when the last driver detaches. */
+	if (!group->owner_cnt)
+		pisa_domain_quiesce(group->default_domain);
+
 	mutex_unlock(&group->mutex);
 }
 
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index d7b73c3a6c0b6..dd90aad296edf 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -13,6 +13,7 @@
 #include <linux/pisa.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
+#include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/llist.h>
 #include <linux/memcontrol.h>
@@ -30,6 +31,7 @@
 #include <linux/workqueue.h>
 #include <net/sock.h>
 
+#include "dma-iommu.h"
 #include "pisa-priv.h"
 
 /* Parameters are pisa.<name> at boot and in /sys/module/pisa/parameters/. */
@@ -88,6 +90,10 @@ static void pisa_release_page_rcu(struct rcu_head *head)
 
 	WRITE_ONCE(meta->pa, NULL);
 
+	/* Possibly still mapped by a device: leak it, still charged. */
+	if (meta->flags & PISA_QUARANTINED)
+		return;
+
 	/* The page has been unmapped from every domain by pisa_release_page() */
 	pisa_slot_free(slot);
 	atomic_long_dec(&pisa_nr_pages);
@@ -107,7 +113,8 @@ void pisa_release_page(struct pisa_meta *meta)
 		return;
 	}
 
-	/* pisa_unmap_all(meta) will be called here once IOMMU mappings are added. */
+	/* Quarantined on unmap failure and leaked in pisa_release_page_rcu(). */
+	pisa_unmap_all(meta);
 
 	/* Clear PISA_ACTIVE before the RCU grace period so new readers stop entering. */
 	WRITE_ONCE(meta->flags, meta->flags & ~PISA_ACTIVE);
@@ -194,7 +201,8 @@ static bool pisa_place_meta(struct pisa_meta *meta)
 	lockdep_assert_held(&pa->lock);
 
 	if (avail == bpp) {
-		if (pa->num_idle_pages >= pa->max_idle_pages && !READ_ONCE(pisa_idle_ms)) {
+		if ((meta->flags & PISA_QUARANTINED) ||
+		    (pa->num_idle_pages >= pa->max_idle_pages && !READ_ONCE(pisa_idle_ms))) {
 			list_del_init(&meta->list);
 			WRITE_ONCE(meta->on_list, PISA_LIST_NONE);
 			llist_add(&meta->llnode, &pisa_free_list);
@@ -204,7 +212,7 @@ static bool pisa_place_meta(struct pisa_meta *meta)
 			WRITE_ONCE(pa->idle_jiffies, jiffies);
 		pa->num_idle_pages++;
 		on_list = meta->nr_dirty ? PISA_LIST_IDLE_DIRTY : PISA_LIST_IDLE_CLEAN;
-	} else if (!avail) {
+	} else if (!avail || unlikely(meta->flags & PISA_QUARANTINED)) {
 		on_list = PISA_LIST_FULL;
 	} else {
 		bool sparse;
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 5a2e806e74654..f0775aa45a058 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -5,6 +5,7 @@
 #include <kunit/test.h>
 #include <linux/gfp.h>
 #include <linux/pisa.h>
+#include <linux/iommu.h>
 #include <linux/mm.h>
 #include <linux/shrinker.h>
 #include <linux/skbuff.h>
@@ -183,6 +184,7 @@ static void test_alloc_and_recycle(struct kunit *test)
 #ifdef CONFIG_IOMMU_DMA
 static void test_window_helpers(struct kunit *test)
 {
+	struct iommu_domain dummy_domain = {};
 	struct pisa_window win = {};
 
 	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
@@ -196,6 +198,22 @@ static void test_window_helpers(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, is_pisa_iova(&win, SZ_4G));
 	KUNIT_EXPECT_TRUE(test, is_pisa_iova(&win, SZ_4G + pisa_window_size - 1));
 	KUNIT_EXPECT_FALSE(test, is_pisa_iova(&win, SZ_4G + pisa_window_size));
+
+	/* Sentinel values in pisa_window_declined(). */
+	win.domain_idx = PISA_IDX_NONE;
+	KUNIT_EXPECT_EQ(test, pisa_window_declined(&win), 0);
+	win.domain_idx = PISA_IDX_NOHUGE;
+	KUNIT_EXPECT_EQ(test, pisa_window_declined(&win), -EOPNOTSUPP);
+	win.domain_idx = PISA_IDX_NOWINDOW;
+	KUNIT_EXPECT_EQ(test, pisa_window_declined(&win), -ENOSPC);
+	win.domain_idx = PISA_IDX_NOIDX;
+	win.idx_gen = READ_ONCE(pisa_idx_gen);
+	KUNIT_EXPECT_EQ(test, pisa_window_declined(&win), -EBUSY);
+	win.idx_gen--;
+	KUNIT_EXPECT_EQ(test, pisa_window_declined(&win), 0);
+
+	/* Releasing an unregistered domain with an active allocator is a safe no-op. */
+	pisa_domain_release(&dummy_domain);
 }
 
 #endif /* CONFIG_IOMMU_DMA */
diff --git a/drivers/iommu/pisa-map.c b/drivers/iommu/pisa-map.c
index 2e8d635dec34c..2ba977bb68734 100644
--- a/drivers/iommu/pisa-map.c
+++ b/drivers/iommu/pisa-map.c
@@ -4,13 +4,19 @@
  * See Documentation/core-api/pisa.rst for the architecture overview.
  */
 
+#include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/cache.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
+#include <linux/pisa.h>
+#include <linux/export.h>
+#include <linux/iommu.h>
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
-#include <linux/pisa.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/srcu.h>
 
 #include "dma-iommu.h"
 #include "pisa-priv.h"
@@ -88,3 +94,209 @@ void __init pisa_slots_init(void)
 	/* Size of every domain's window: one 2MB page per slot. */
 	pisa_window_size = (u64)pisa_nr_slots << PISA_SHIFT;
 }
+
+/*
+ * Registry of PISA IOMMU domains (0 .. PISA_MAX_DOMAINS - 1). Each slot is
+ * FREE (!domain && !base), ACTIVE (domain), or DRAINING (!domain && base) while
+ * pisa_domain_release() clears @meta->domains_mapped bits.
+ */
+static struct {
+	struct iommu_domain *domain;
+	dma_addr_t base;
+} pisa_domains[PISA_MAX_DOMAINS] __read_mostly;
+static DEFINE_SPINLOCK(pisa_domains_lock);
+
+/* Protects pisa_unmap_all() readers against concurrent pisa_domain_release(). */
+DEFINE_STATIC_SRCU(pisa_srcu);
+
+/* Bumped under pisa_domains_lock whenever a domain index is released. */
+unsigned int pisa_idx_gen __read_mostly;
+
+/* Report a short IOMMU unmap and mark @meta quarantined so it is never reused. */
+static void pisa_quarantine_meta(struct pisa_meta *meta, struct iommu_domain *domain,
+				 int idx, dma_addr_t iova, size_t unmapped)
+{
+	pr_err_ratelimited("pisa: unmap of IOVA %pad in domain %p (index %d) returned %zu, quarantining PISA page\n",
+			   &iova, domain, idx, unmapped);
+	WRITE_ONCE(meta->flags, meta->flags | PISA_QUARANTINED);
+}
+
+/*
+ * Unmap @meta's leaf PTE from every active domain holding it. Returns 0 on
+ * success, or -EIO if any unmap failed (@meta is then quarantined).
+ */
+int pisa_unmap_all(struct pisa_meta *meta)
+{
+	dma_addr_t offset = pisa_meta_win_offset(meta);
+	int idx, srcu_idx;
+
+	srcu_idx = srcu_read_lock(&pisa_srcu);
+	for_each_set_bit(idx, meta->domains_mapped, PISA_MAX_DOMAINS) {
+		struct iommu_domain *domain;
+		unsigned long flags;
+		size_t unmapped;
+		dma_addr_t base;
+
+		if (!test_and_clear_bit(idx, meta->domains_mapped))
+			continue;
+
+		spin_lock_irqsave(&pisa_domains_lock, flags);
+		domain = pisa_domains[idx].domain;
+		base = pisa_domains[idx].base;
+		spin_unlock_irqrestore(&pisa_domains_lock, flags);
+
+		/* Free, or draining: pisa_domain_release() handles the bit. */
+		if (!domain)
+			continue;
+
+		unmapped = iommu_unmap(domain, base + offset, PISA_SIZE);
+		if (unlikely(unmapped != PISA_SIZE))
+			pisa_quarantine_meta(meta, domain, idx, base + offset, unmapped);
+	}
+	srcu_read_unlock(&pisa_srcu, srcu_idx);
+
+	return (meta->flags & PISA_QUARANTINED) ? -EIO : 0;
+}
+
+/* Clear domain @idx from all populated slots. */
+static unsigned int pisa_forget_domain(int idx)
+{
+	unsigned int slot, dropped = 0;
+
+	rcu_read_lock();
+	for_each_set_bit(slot, pisa_slot_bitmap, pisa_nr_slots) {
+		struct pisa_meta *meta = READ_ONCE(pisa_slot2meta[slot]);
+
+		if (meta && test_bit(idx, meta->domains_mapped) &&
+		    test_and_clear_bit(idx, meta->domains_mapped))
+			dropped++;
+	}
+	rcu_read_unlock();
+	return dropped;
+}
+
+/*
+ * Release @domain's registry index and clear its bit in all active
+ * PISA pages, waiting out concurrent unmappers on @pisa_srcu before freeing
+ * the slot.
+ */
+void pisa_domain_release(struct iommu_domain *domain)
+{
+	struct pisa_window *win;
+	unsigned int dropped;
+	unsigned long flags;
+	int idx;
+
+	/* Nothing has ever been active, so nothing can reference @domain. */
+	if (!static_branch_unlikely(&pisa_key))
+		return;
+
+	win = pisa_dma_window(domain);
+	/* @domain never active, so no PISA page can be holding a bit for it. */
+	if (!win || !smp_load_acquire(&win->base))
+		return;
+
+	idx = win->domain_idx - PISA_IDX_FIRST;
+	spin_lock_irqsave(&pisa_domains_lock, flags);
+	if (pisa_domains[idx].domain != domain) {
+		spin_unlock_irqrestore(&pisa_domains_lock, flags);
+		return;
+	}
+	/* Leaving @base set moves the slot to DRAINING state */
+	pisa_domains[idx].domain = NULL;
+	spin_unlock_irqrestore(&pisa_domains_lock, flags);
+
+	dropped = pisa_forget_domain(idx);
+
+	/* Wait out in-flight pisa_unmap_all() readers before reusing @idx. */
+	synchronize_srcu(&pisa_srcu);
+
+	/* Mark slot FREE and bump @pisa_idx_gen so NOIDX domains retry. */
+	spin_lock_irqsave(&pisa_domains_lock, flags);
+	pisa_domains[idx].base = 0;
+	WRITE_ONCE(pisa_idx_gen, pisa_idx_gen + 1);
+	spin_unlock_irqrestore(&pisa_domains_lock, flags);
+
+	if (dropped)
+		pr_debug("pisa: released %u PISA page mappings for domain %p (index %d)\n",
+			 dropped, domain, idx);
+}
+
+/*
+ * Remove @meta's leaf PTE from live @domain (registered at @idx with @base),
+ * batching the IOTLB flush into @gather. Returns 1 if unmapped, 0 otherwise.
+ */
+static unsigned int pisa_unmap_domain_locked(struct pisa_meta *meta,
+					     struct iommu_domain *domain,
+					     int idx, dma_addr_t base,
+					     struct iommu_iotlb_gather *gather)
+{
+	dma_addr_t iova = base + pisa_meta_win_offset(meta);
+	size_t unmapped;
+
+	if (!test_and_clear_bit(idx, meta->domains_mapped))
+		return 0;
+
+	unmapped = iommu_unmap_fast(domain, iova, PISA_SIZE, gather);
+	if (unlikely(unmapped != PISA_SIZE))
+		pisa_quarantine_meta(meta, domain, idx, iova, unmapped);
+	return 1;
+}
+
+/*
+ * Unmap all PISA leaf PTEs from a domain whose last DMA API user detached,
+ * keeping its window and domain index so mappings are re-installed on demand.
+ */
+void pisa_domain_quiesce(struct iommu_domain *domain)
+{
+	struct iommu_iotlb_gather gather;
+	struct pisa_window *win;
+	unsigned int slot, done = 0;
+	bool release = false;
+	dma_addr_t base;
+	int idx;
+
+	if (!static_branch_unlikely(&pisa_key))
+		return;
+	win = pisa_dma_window(domain);
+	/* Pairs with smp_store_release() in pisa_window_assign(). */
+	base = win ? smp_load_acquire(&win->base) : 0;
+	if (!base)
+		return;
+	idx = win->domain_idx - PISA_IDX_FIRST;
+
+	iommu_iotlb_gather_init(&gather);
+	/* Keep call_rcu()-freed pages from reaching the buddy allocator before IOTLB sync. */
+	rcu_read_lock();
+	for_each_set_bit(slot, pisa_slot_bitmap, pisa_nr_slots) {
+		struct pisa_meta *meta = READ_ONCE(pisa_slot2meta[slot]);
+		struct pisa_alloc *pa;
+		unsigned long flags;
+
+		if (!meta || !test_bit(idx, meta->domains_mapped))
+			continue;
+		done += pisa_unmap_domain_locked(meta, domain, idx, base, &gather);
+		if (likely(!(meta->flags & PISA_QUARANTINED)))
+			continue;
+		pa = READ_ONCE(meta->pa);
+		if (!pa)
+			continue;
+		spin_lock_irqsave(&pa->lock, flags);
+		if (meta->pa == pa) {
+			if (meta->on_list == PISA_LIST_IDLE_CLEAN ||
+			    meta->on_list == PISA_LIST_IDLE_DIRTY)
+				pa->num_idle_pages--;
+			release |= pisa_place_meta(meta);
+		}
+		spin_unlock_irqrestore(&pa->lock, flags);
+	}
+
+	if (done)
+		iommu_iotlb_sync(domain, &gather);
+	rcu_read_unlock();
+	if (release)
+		pisa_schedule_reclaim();
+	if (done)
+		pr_debug("pisa: unmapped %u PISA pages from idle domain %p (index %d)\n",
+			 done, domain, idx);
+}
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index 3ef6e51402ceb..f97f69a13d1a9 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -13,6 +13,9 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+struct iommu_domain;
+struct iommu_iotlb_gather;
+
 /**
  * struct pisa_window - A domain's IOVA window reserved for PISA pages
  * @base: Window base IOVA (PISA_SIZE aligned), or 0 if unassigned
@@ -33,6 +36,9 @@ struct pisa_window {
 
 #define PISA_BLOCKS(order)	(1U << (PISA_ORDER - (order)))
 
+/* Max simultaneous PISA IOMMU domains (bit index in pisa_meta.domains_mapped). */
+#define PISA_MAX_DOMAINS		128
+
 /* Sentinel values of pisa_window.domain_idx below PISA_IDX_FIRST. */
 enum {
 	PISA_IDX_NONE,	/* not attempted yet */
@@ -47,15 +53,18 @@ enum {
  * - pisa_allocs_lock (rwlock): outermost; protects pisa_allocs list.
  * - pisa_meta_mutex (mutex): serializes pisa_meta_init() and page-table alloc.
  * - pa->lock (spinlock, irqsave): per-allocator lists, bitmaps, and stats.
+ * - pisa_domains_lock (spinlock, irqsave): leaf lock over pisa_domains[]/windows.
+ * - pisa_srcu: protects pisa_domains[] readers against pisa_domain_release().
  */
 
 /**
  * struct pisa_meta - Metadata for a single PISA page in @pisa_meta_array
- * @flags:	PISA_ACTIVE while this page is owned by a pisa_alloc
+ * @flags:	PISA_ACTIVE / PISA_QUARANTINED
  * @nr_clean:	Zeroed available blocks in @clean_bitmap
  * @nr_dirty:	Dirty available blocks in @dirty_bitmap
  * @on_list:	Current placement in @pa (enum pisa_meta_list)
  * @slot:	Dense IOVA slot index in every domain's window
+ * @domains_mapped: Bitmap of domain indices holding this page's leaf PTE
  * @pa:		Owning pisa_alloc (NULL for reservoir pages)
  * @list:	Node in @pa lists or per-node reservoir (pisa_node.pages)
  * @llnode:	Node in lockless pisa_free_list for async release to the buddy allocator
@@ -69,6 +78,9 @@ struct pisa_meta {
 	u16 nr_dirty;
 	u8 on_list;
 	u32 slot;
+
+	DECLARE_BITMAP(domains_mapped, PISA_MAX_DOMAINS);
+
 	struct pisa_alloc *pa;
 	struct list_head list;
 
@@ -136,6 +148,12 @@ struct pisa_node {
 /* Per-NUMA-node PISA state (ring/TX/user allocators, reservoir). */
 extern struct pisa_node pisa_nodes[MAX_NUMNODES];
 
+/* Offset of @meta from the start of a domain's window. */
+static inline dma_addr_t pisa_meta_win_offset(const struct pisa_meta *meta)
+{
+	return (dma_addr_t)meta->slot << PISA_SHIFT;
+}
+
 int pisa_meta_ensure_pfn(unsigned long pfn, bool can_block);
 struct pisa_meta *pisa_meta_of_pfn(unsigned long pfn);
 unsigned long pisa_meta_to_pfn(const struct pisa_meta *meta);
@@ -202,11 +220,30 @@ unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned lon
 
 /* Size in bytes of every domain's PISA IOVA window, fixed at boot. */
 extern u64 pisa_window_size;
+/* Bumped under pisa_domains_lock whenever a domain index is released. */
+extern unsigned int pisa_idx_gen;
 extern unsigned int pisa_nr_slots;
 
 void pisa_slots_init(void);
 int pisa_slot_alloc(struct pisa_meta *meta);
 void pisa_slot_free(unsigned int slot);
+int pisa_unmap_all(struct pisa_meta *meta);
+
+/* Return negative errno if @win's domain was permanently/currently declined, or 0. */
+static inline int pisa_window_declined(const struct pisa_window *win)
+{
+	switch (READ_ONCE(win->domain_idx)) {
+	case PISA_IDX_NOHUGE:
+		return -EOPNOTSUPP;
+	case PISA_IDX_NOWINDOW:
+		return -ENOSPC;
+	case PISA_IDX_NOIDX:
+		return READ_ONCE(win->idx_gen) == READ_ONCE(pisa_idx_gen) ?
+		       -EBUSY : 0;
+	default:
+		return 0;
+	}
+}
 
 /* Return true if @dma falls within @win's reserved PISA IOVA window. */
 static inline bool is_pisa_iova(const struct pisa_window *win, dma_addr_t dma)
@@ -217,17 +254,34 @@ static inline bool is_pisa_iova(const struct pisa_window *win, dma_addr_t dma)
 	return base && dma - base < pisa_window_size;
 }
 
+void pisa_domain_release(struct iommu_domain *domain);
+void pisa_domain_quiesce(struct iommu_domain *domain);
+
 #else /* !CONFIG_PISA || !CONFIG_IOMMU_DMA */
 
 #define pisa_nr_slots 0U
 static inline void pisa_slots_init(void) {}
 static inline int pisa_slot_alloc(struct pisa_meta *meta) { return 0; }
 static inline void pisa_slot_free(unsigned int slot) {}
+static inline int pisa_unmap_all(struct pisa_meta *meta) { return 0; }
+
+static inline int pisa_window_declined(const struct pisa_window *win)
+{
+	return -EOPNOTSUPP;
+}
 
 static inline bool is_pisa_iova(const struct pisa_window *win, dma_addr_t dma)
 {
 	return false;
 }
 
+static inline void pisa_domain_release(struct iommu_domain *domain)
+{
+}
+
+static inline void pisa_domain_quiesce(struct iommu_domain *domain)
+{
+}
+
 #endif /* CONFIG_PISA && CONFIG_IOMMU_DMA */
 #endif /* _DRIVERS_IOMMU_PISA_PRIV_H */
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index 18ba1c83bd6d3..ab1c32e065bbb 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -27,6 +27,7 @@
 
 enum {
 	PISA_ACTIVE		= BIT(0), /* page is owned by a pisa_alloc */
+	PISA_QUARANTINED	= BIT(1), /* IOMMU unmap failed: never reuse */
 };
 
 /* Enabled on first pisa_meta_init() to activate fast-path hooks. */
-- 
2.56.0.542.g3ef89b7020-goog

