Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248766;
	b=Yo/8NNL9zQyNXyS4gQv83NJFWi34GRh2G9kOwdqi+z/1d1/rjtCsPaHlygjN0GK4W2s+
	 L+V11GsDv1iPaS397UVrvMeXtDBpJNNL2bt1xDweAPaixbJ/Yihoz+qV1YIcxrU30LvyJ
	 Gfkw9vssFQpLjB+f97QqEjAxLWqBa7TPM36nZjMj6SWyqhWTTNTRxwSrXTVE4OqHYQHZR
	 F186WXSWKrgd5apbfvL1MNd0TmlAHzDEmByYrNTN2+Of6GCPlUL0utXKFCxEY2ClZru+T
	 oGRplj/J6DZ5z0Ticw79ygqtibf4/YIIuj9BhbWggWaPxBYFJzd3Zej83sAiy13U3Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YZNOpdXaj/FQi2D9Zgy/cN5LeIdUsfin4get0Fcs8Gc=;
	b=Iey5Y1wK/f74vymgugzNkRCzoXHxyKsIltIJHMFHFX0LQRtWgWl3td1nEKj6UzPo6e6D
	 X8MD6uo3psC2+wE7UVFoQXgY9UCxnPEpIINCFKc/C/OE2P1jBHEEPBRPLftFjD3j/WuS9
	 0GkwqiL7lQUvnHxgP0r88j/6sYYpD31ODH/6NsHByzf4ONl7M119fTimQxyVnsY0FUZtU
	 gJ82+f9LzFx3Fiw9i9uDW0aLdxMi6/n2Ffu1LffA+Yu1BDvIYj3Ao+D1Yp/+LW95T+H2V
	 0nQHk0KrtU73dp6YwhU8OAc2gehCBDFl5O3lKQJwSc2D2J1eDwawWZspypxQE3HJmpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mHnKHDye;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01D6070EE6
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C01D6070EE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mHnKHDye
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b70b9f6e0aso1571250a12.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248763; x=1794853563; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZNOpdXaj/FQi2D9Zgy/cN5LeIdUsfin4get0Fcs8Gc=;
        b=mHnKHDyeeDYDzL9zaDkmmdwX43Gp7NVmOv7XghnJUFsaOCPc3x14i231F1qQ0LLdJ6
         6u582t4bDKvRPUKtI5jM46Q1W7XqHc2nxm3Xc/6ZD88Y1vONxMf50TBixC0WkoaE3Kb+
         2liJCvnl5uzkY0XztuXFiwgzR/E8p5UPKPIegdHBcAAkRzPVwlxAk4N3UCqegi1DqzVX
         WXssUS6ssQElQfnSY/iFsYc9CxgES/JgsWrFZzMGwV2OWk7NHwlgKYVYW1LM08CygP+x
         Wv7XT+ULNrX4IT7jjuSj1uWt8ePyH5zyTFvdONixFwq4zqvqgdVjJgXCllzyD/q1RNMG
         PAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248763; x=1794853563;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZNOpdXaj/FQi2D9Zgy/cN5LeIdUsfin4get0Fcs8Gc=;
        b=ZFA6o6bAD2awJqv/csShMDlqheuMuF44s1MxN0Pzdv7kIuWKGEeE0Ya0Cs7eggWjix
         coIgU1D6p9uDyzxkOa+wBDKzwxRfpbPmqYvooPBICuiL4Uo8ecB7qNk90EqeXGvtuRcW
         BI70zI8hRaXEZbL5D/0wiL+PduWLFxVJy6Cebhv++uZNUMdnTpFH9OeQNLD/08RjutfK
         90EAyNUG9kBYo+avdzCZobDCsH7PTst2notfx/A/XdbE3DUIxf8jnzGT6wjljgyWb8sh
         4S0jW6MfBT3GBkHoLKrRrD03orCDlteAc7IFL65x7fThpIV8+iXURTWLVwMAJlBDeBdD
         RnFw==
X-Forwarded-Encrypted: i=1; AL+hErHmVyIkXGvbc1tXBX8mXYMOfDYDX6BeKiT52d68XIlFwrm43/miw6jI6LN/hUw7VeeFrZN1aBqogFBeig==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZARs09crraPYQEzQfaLZ6EIlWJ4QQ0TrM9OMVycHp4c2pGvbZ
	Blme3KTfbyypRQOz+HHhAMO9sspfpSpwGVlUNeDFwrJ6EHQqvbOvWYOLYACDr1JzyMTDJK1vzAE
	WuRWkUg==
X-Received: from edsb26.prod.google.com ([2002:aa7:c6da:0:b0:6b5:77a4:90bb])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:ca51:0:b0:6b1:c2d3:6a79
 with SMTP id 4fb4d7f45d1cf-6b7568d85a6mr286943a12.12.1794248762514; Mon, 09
 Nov 2026 10:26:02 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:33 +0000
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
Message-ID: <20261109182533.3594984-26-lrizzo@google.com>
Subject: [RFC PATCH v2 25/25] iommu/dma: Add PISA statistics and debugfs
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

PISA allocation and mapping failures silently fall back to standard page
allocation and per-buffer DMA mappings, making performance regressions
hard to diagnose without observability.

Add per-allocator, per-node reservoir, user-page migration, and global
shrinker/reclaim counters, and expose them via
/sys/kernel/debug/pisa/allocs.
Also emit a one-shot dmesg warning on the first 2MB buddy allocation
failure.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 298 +++++++++++++++++++++++++++++++++----
 drivers/iommu/pisa-kunit.c |   7 +-
 drivers/iommu/pisa-map.c   |  79 +++++++++-
 drivers/iommu/pisa-node.c  |  43 +++++-
 drivers/iommu/pisa-priv.h  | 127 +++++++++++++++-
 drivers/iommu/pisa-user.c  |  77 +++++++++-
 include/linux/pisa.h       |   5 +
 net/core/datagram.c        |   2 +
 8 files changed, 589 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index cedb1a62d20e2..91b9f00d21985 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -11,6 +11,7 @@
 #include <linux/cache.h>
 #include <linux/cc_platform.h>
 #include <linux/cpuhotplug.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
@@ -31,6 +32,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
+#include <linux/seq_file.h>
 #include <linux/set_memory.h>
 #include <linux/shrinker.h>
 #include <linux/skbuff.h>
@@ -85,6 +87,13 @@ module_param_named(old_ms, pisa_old_ms, uint, 0644);
 unsigned int pisa_scrub_max __read_mostly;
 #define PISA_SCRUB_MAX_LIMIT	65536U
 
+/* Reclaim statistics, see pisa_allocs_show(). */
+struct pisa_reclaim_stats pisa_reclaim_stats;
+
+char pisa_pages_2m[16] __ro_after_init;
+char pisa_pages_4k[16] __ro_after_init;
+char pisa_no_pages_2m[16] __ro_after_init;
+
 /* All live allocators, protected by pisa_allocs_lock. */
 static LIST_HEAD(pisa_allocs);
 static DEFINE_RWLOCK(pisa_allocs_lock);
@@ -115,6 +124,7 @@ static const struct kernel_param_ops pisa_scrub_ops = {
 	.get = param_get_uint,
 };
 module_param_cb(scrub_max, &pisa_scrub_ops, &pisa_scrub_max, 0644);
+
 /* Return true if a new PISA page should be decrypted. */
 bool pisa_want_decrypt(void)
 {
@@ -179,7 +189,7 @@ static void pisa_release_page_rcu(struct rcu_head *head)
 	unsigned long flags;
 
 	spin_lock_irqsave(&meta->pa->lock, flags);
-	meta->pa->stats.page_free_cnt++;
+	pisa_stat_inc(meta->pa->stats.page_free_cnt);
 	spin_unlock_irqrestore(&meta->pa->lock, flags);
 	WRITE_ONCE(meta->pa, NULL);
 
@@ -190,6 +200,7 @@ static void pisa_release_page_rcu(struct rcu_head *head)
 	/* Still shared with the host, or possibly still mapped by a device. */
 	if (meta->flags & (PISA_DECRYPTED | PISA_QUARANTINED))
 		return;
+
 	atomic_long_dec(&pisa_nr_pages);
 	for (i = 0; i < PISA_BLOCKS(order); i++) {
 		block = page + (i << order);
@@ -238,6 +249,9 @@ static void pisa_reclaim_work_fn(struct work_struct *work)
 	struct pisa_meta *meta, *tmp;
 	struct llist_node *node;
 	struct pisa_alloc *pa;
+	unsigned int n = 0;
+
+	pisa_stat_inc(pisa_reclaim_stats.reclaim_run);
 
 	read_lock(&pisa_allocs_lock);
 	list_for_each_entry(pa, &pisa_allocs, node) {
@@ -263,8 +277,11 @@ static void pisa_reclaim_work_fn(struct work_struct *work)
 	read_unlock(&pisa_allocs_lock);
 
 	node = llist_del_all(&pisa_free_list);
-	llist_for_each_entry_safe(meta, tmp, node, llnode)
+	llist_for_each_entry_safe(meta, tmp, node, llnode) {
 		pisa_release_page(meta);
+		n++;
+	}
+	pisa_stat_add(pisa_reclaim_stats.reclaim_pages, n);
 
 	if (next_delay != MAX_JIFFY_OFFSET)
 		queue_delayed_work(pisa_wq ?: system_wq, &pisa_reclaim_work, next_delay);
@@ -469,6 +486,7 @@ static unsigned long pisa_scrub_alloc(struct pisa_alloc *pa)
 	for (idx = 0; idx < count; idx++)
 		__set_bit(idxs[idx], meta->clean_bitmap);
 	meta->nr_clean += count;
+	pisa_stat_add(pa->stats.block_scrub_cnt, count);
 	pa->scrub_demand -= min(count, pa->scrub_demand);
 	should_release = pisa_place_meta(meta);
 	spin_unlock_irqrestore(&pa->lock, flags);
@@ -603,6 +621,7 @@ static void pisa_return_block_locked(struct pisa_alloc *pa, struct page *block,
 		meta->nr_dirty++;
 	}
 	pa->blocks_in_use--;
+	pisa_stat_inc(pa->stats.block_free_cnt);
 	*release |= pisa_place_meta(meta);
 }
 
@@ -729,7 +748,8 @@ static const struct kernel_param_ops pisa_pcp_batch_ops = {
 module_param_cb(pcp_batch, &pisa_pcp_batch_ops, &pisa_pcp_batch, 0644);
 
 /* Cache @n blocks at refcount 0 on this CPU, @n <= PISA_PCP_BATCH. */
-static void pisa_pcp_push(struct pisa_alloc *pa, struct page **blocks, unsigned int n)
+static void pisa_pcp_push(struct pisa_alloc *pa, struct page **blocks, unsigned int n,
+			  bool is_free)
 {
 	unsigned int i, batch = READ_ONCE(pisa_pcp_batch);
 	struct pisa_pcp *pcp;
@@ -738,6 +758,8 @@ static void pisa_pcp_push(struct pisa_alloc *pa, struct page **blocks, unsigned
 	local_irq_save(flags);
 	pcp = this_cpu_ptr(pa->pcp);
 	spin_lock(&pcp->lock);
+	if (is_free)
+		pisa_stat_add(pcp->free_cnt, n);
 	for (i = 0; i < n; i++) {
 		if (pcp->count == PISA_PCP_HIGH) {
 			/* Keep the most recently freed, likely still in cache. */
@@ -799,18 +821,37 @@ void pisa_pcp_drain(struct pisa_alloc *pa)
 	}
 }
 
-/* Blocks in @pa's caches, for shrinker and debugfs. */
-static unsigned long pisa_pcp_count(struct pisa_alloc *pa)
+/* Aggregate statistics across @pa's per-CPU caches, for shrinker and debugfs. */
+static unsigned long pisa_pcp_stats(struct pisa_alloc *pa, u64 *alloc, u64 *miss,
+				    u64 *free, u64 *ks, u64 *as)
 {
+	u64 a = 0, m = 0, f = 0, s_k = 0, s_a = 0;
 	unsigned long n = 0;
 	int cpu;
 
-	if (!pa->pcp)
-		return 0;
-	for_each_possible_cpu(cpu) {
-		/* A racy sum is good enough for reclaim and statistics. */
-		n += data_race(per_cpu_ptr(pa->pcp, cpu)->count);
+	if (pa->pcp) {
+		for_each_possible_cpu(cpu) {
+			const struct pisa_pcp *pcp = per_cpu_ptr(pa->pcp, cpu);
+
+			/* A racy sum is good enough for reclaim and statistics. */
+			n += READ_ONCE(pcp->count);
+			a += READ_ONCE(pcp->alloc_cnt);
+			m += READ_ONCE(pcp->miss_cnt);
+			f += READ_ONCE(pcp->free_cnt);
+			s_k += READ_ONCE(pcp->alloc_ks);
+			s_a += READ_ONCE(pcp->alloc_as);
+		}
 	}
+	if (alloc)
+		*alloc = a;
+	if (miss)
+		*miss = m;
+	if (free)
+		*free = f;
+	if (ks)
+		*ks = s_k;
+	if (as)
+		*as = s_a;
 	return n;
 }
 
@@ -1206,6 +1247,7 @@ static unsigned int pisa_scan_bitmap(struct pisa_meta *meta, bool dirty,
 	}
 	*countp -= used;
 	pa->blocks_in_use += used;
+	pisa_stat_add(pa->stats.block_alloc_cnt, used);
 	return got;
 }
 
@@ -1254,9 +1296,11 @@ static struct pisa_meta *pisa_pick_meta(struct pisa_alloc *pa, bool zero)
 
 /* Extract up to @want blocks from @meta under @pa->lock. */
 static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
-				struct page **out, bool zero, bool frozen)
+				struct page **out, bool can_block, bool zero,
+				bool frozen)
 {
 	unsigned int avail_before = pisa_meta_avail(meta), got = 0, used;
+	unsigned long base_pfn = pisa_meta_to_pfn(meta);
 	struct pisa_alloc *pa = meta->pa;
 
 	lockdep_assert_held(&pa->lock);
@@ -1269,12 +1313,23 @@ static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
 		dirty = pisa_scan_bitmap(meta, true, want - got, out + got, false);
 		for (i = got; i < got + dirty; i++)
 			set_page_private(out[i], 1);
+		if (can_block) {
+			pisa_stat_add(pa->stats.alloc_kc, got);
+			pisa_stat_add(pa->stats.alloc_ks, dirty);
+		} else {
+			pisa_stat_add(pa->stats.alloc_ac, got);
+			pisa_stat_add(pa->stats.alloc_as, dirty);
+		}
 		got += dirty;
 		pa->scrub_demand = min(pa->scrub_demand + dirty, PISA_SCRUB_DEMAND_MAX);
 	} else {
 		/* First choice are dirty blocks, followed by clean */
 		got += pisa_scan_bitmap(meta, true, want, out, !frozen);
 		got += pisa_scan_bitmap(meta, false, want - got, out + got, !frozen);
+		if (can_block)
+			pisa_stat_add(pa->stats.alloc_kd, got);
+		else
+			pisa_stat_add(pa->stats.alloc_ad, got);
 	}
 
 	used = avail_before - pisa_meta_avail(meta);
@@ -1284,6 +1339,8 @@ static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
 		meta->nr_dirty = 0;
 	}
 	pisa_place_meta(meta);
+	if (page_to_nid(pfn_to_page(base_pfn)) != pa->nid)
+		pisa_stat_add(pa->stats.numa_mismatch_cnt, used);
 
 	return got;
 }
@@ -1292,6 +1349,7 @@ static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
 static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigned long nr_pages,
 				       struct page **pages, bool zero, bool frozen)
 {
+	bool can_block = gfpflags_allow_blocking(gfp);
 	bool should_scrub = false;
 	unsigned long n, flags, i;
 	struct pisa_meta *meta;
@@ -1299,7 +1357,8 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 
 	/* Held across bitmap scans; dropped around slow-path pisa_alloc_split_page(). */
 	spin_lock_irqsave(&pa->lock, flags);
-	for (n = 0; n < nr_pages; n += take_blocks(meta, want, &pages[n], zero, frozen)) {
+	for (n = 0; n < nr_pages;
+	     n += take_blocks(meta, want, &pages[n], can_block, zero, frozen)) {
 		want = min_t(unsigned long, nr_pages - n, PISA_BLOCKS(pa->order));
 		meta = pisa_pick_meta(pa, zero);
 		if (meta)
@@ -1310,15 +1369,31 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 		spin_unlock_irqrestore(&pa->lock, flags);
 		/* With @zero, fresh dirty blocks are zeroed below. */
 		meta = pisa_alloc_split_page(pa->order, gfp, pa->nid);
-		if (IS_ERR(meta))
+		if (IS_ERR(meta)) {
+			long err = PTR_ERR(meta);
+
+			if (err == -EAGAIN) {
+				pisa_stat_atomic_inc(pa->stats.fail_backoff);
+			} else if (err == -ENOSPC) {
+				pisa_stat_atomic_inc(pa->stats.fail_budget);
+			} else if (err == -ENOMEM) {
+				pisa_stat_atomic_inc(pa->stats.fail_nomem);
+				pr_warn_once("pisa: order-%u allocation failed for allocator %p; further failures are counted in debugfs only\n",
+					     PISA_ORDER, pa);
+			} else if (err == -EBUSY) {
+				pisa_stat_atomic_inc(pa->stats.fail_split);
+			}
+			if (!n)
+				pisa_stat_atomic_inc(pa->stats.block_alloc_fail);
 			goto out;
+		}
 		spin_lock_irqsave(&pa->lock, flags);
 		meta->pa = pa;
 		meta->prot = pa->prot;
 		WRITE_ONCE(meta->alloc_jiffies, jiffies);
 		/* Set PISA_ACTIVE after @meta is fully set up. */
 		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
-		pa->stats.page_alloc_cnt++;
+		pisa_stat_inc(pa->stats.page_alloc_cnt);
 	}
 	/* Queue the scrubber when the inline zeroing crosses the trigger. */
 	should_scrub |= pa->scrub_demand >= PISA_SCRUB_TRIGGER;
@@ -1346,9 +1421,11 @@ static unsigned long pisa_pcp_alloc(struct pisa_alloc *pa, gfp_t gfp, unsigned l
 				    struct page **page_array, bool frozen)
 {
 	unsigned int pcp_batch = READ_ONCE(pisa_pcp_batch);
-	unsigned long got, n, i, j;
+	bool zero = want_init_on_alloc(gfp);
+	unsigned long got, local, n, i, j;
 
 	got = pisa_pcp_pop(pa, nr_pages, page_array);
+	local = got;
 	if (got < nr_pages) {
 		if (nr_pages - got >= pcp_batch) {
 			got += __pisa_alloc_bulk(pa, gfp, nr_pages - got,
@@ -1360,7 +1437,7 @@ static unsigned long pisa_pcp_alloc(struct pisa_alloc *pa, gfp_t gfp, unsigned l
 			for (i = 0; i < n && got < nr_pages; i++)
 				page_array[got++] = batch[i];
 			if (i < n)
-				pisa_pcp_push(pa, batch + i, n - i);
+				pisa_pcp_push(pa, batch + i, n - i, false);
 		}
 	}
 
@@ -1369,10 +1446,13 @@ static unsigned long pisa_pcp_alloc(struct pisa_alloc *pa, gfp_t gfp, unsigned l
 
 		page_array[i] = NULL;
 		/* Poisoned while cached: leak it, as pisa_scan_bitmap() does. */
-		if (pisa_block_poisoned(pa, block))
+		if (pisa_block_poisoned(pa, block)) {
+			if (i < local)
+				local--;
 			continue;
+		}
 		pisa_block_prep(block);
-		if (want_init_on_alloc(gfp)) {
+		if (zero) {
 			memset(page_address(block), 0, PAGE_SIZE << pa->order);
 			if (frozen) /* Order zeroing before caller publishes the page. */
 				smp_wmb();
@@ -1381,6 +1461,15 @@ static unsigned long pisa_pcp_alloc(struct pisa_alloc *pa, gfp_t gfp, unsigned l
 			page_ref_unfreeze(block, 1);
 		page_array[j++] = block;
 	}
+	this_cpu_add(pa->pcp->alloc_cnt, j);
+	if (zero) {
+		if (gfpflags_allow_blocking(gfp))
+			this_cpu_add(pa->pcp->alloc_ks, j);
+		else
+			this_cpu_add(pa->pcp->alloc_as, j);
+	}
+	if (j > local)
+		this_cpu_inc(pa->pcp->miss_cnt);
 	return j;
 }
 
@@ -1400,10 +1489,14 @@ unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
 {
 	unsigned long i = 0, n, got;
 
-	if (unlikely(!pa ||
-		     (gfp & (__GFP_DMA | __GFP_DMA32 | __GFP_THISNODE | __GFP_ACCOUNT))))
+	if (unlikely(!pa))
 		goto skip;
 
+	if (unlikely(gfp & (__GFP_DMA | __GFP_DMA32 | __GFP_THISNODE | __GFP_ACCOUNT))) {
+		pisa_stat_atomic_inc(pa->stats.fail_gfp);
+		goto skip;
+	}
+
 	while (i < nr_pages) {
 		if (page_array[i]) {
 			i++;
@@ -1500,6 +1593,9 @@ static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblock
 		page_ref_unfreeze(page + i, 1);
 	}
 	pa->blocks_in_use += nblocks;
+	pisa_stat_add(pa->stats.block_alloc_cnt, nblocks);
+	pisa_stat_add(pa->stats.alloc_kc, nblocks - dirty);
+	pisa_stat_add(pa->stats.alloc_ks, dirty);
 	pa->scrub_demand = min(pa->scrub_demand + dirty, PISA_SCRUB_DEMAND_MAX);
 	pisa_place_meta(meta);
 	return page;
@@ -1577,7 +1673,7 @@ void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
 		meta->prot = pa->prot;
 		WRITE_ONCE(meta->alloc_jiffies, jiffies);
 		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
-		pa->stats.page_alloc_cnt++;
+		pisa_stat_inc(pa->stats.page_alloc_cnt);
 		page = pisa_take_contig(meta, nblocks, align_mask);
 		if (unlikely(!page))
 			should_release = pisa_place_meta(meta);
@@ -1591,6 +1687,11 @@ void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
 		pisa_schedule_scrub(pa->nid);
 	if (!page)
 		return NULL;
+	/* Pairs with cmpxchg_release() in pisa_enable_pcp(). */
+	if (smp_load_acquire(&pa->pcp)) {
+		this_cpu_add(pa->pcp->alloc_cnt, nblocks);
+		this_cpu_inc(pa->pcp->miss_cnt);
+	}
 	*pagep = page;
 	return memset(page_address(page), 0, size);
 }
@@ -1631,9 +1732,10 @@ bool __pisa_free_page(struct page *page)
 	if (smp_load_acquire(&pa->pcp) && pa->nid == numa_mem_id() &&
 	    page_to_nid(page) == numa_mem_id()) {
 		if (pisa_page_can_recycle(page)) {
-			pisa_pcp_push(pa, &page, 1);
+			pisa_pcp_push(pa, &page, 1, true);
 			return true;
 		}
+		this_cpu_inc(pa->pcp->free_cnt);
 		if (this_cpu_read(pa->pcp->count))
 			pisa_pcp_drain_cpu(pa, raw_smp_processor_id());
 	}
@@ -1657,7 +1759,7 @@ static unsigned long pisa_shrink_count(struct shrinker *shrink, struct shrink_co
 	read_lock(&pisa_allocs_lock);
 	list_for_each_entry(pa, &pisa_allocs, node) {
 		nr += (unsigned long)READ_ONCE(pa->num_idle_pages) << PISA_ORDER;
-		nr += pisa_pcp_count(pa) << pa->order;
+		nr += pisa_pcp_stats(pa, NULL, NULL, NULL, NULL, NULL) << pa->order;
 	}
 	read_unlock(&pisa_allocs_lock);
 
@@ -1685,11 +1787,14 @@ unsigned long pisa_shrink_list(spinlock_t *lock, struct list_head *list,
 VISIBLE_IF_KUNIT unsigned long pisa_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct pisa_meta *meta, *tmp;
+	unsigned long freed, res_freed;
 	struct pisa_alloc *pa;
-	unsigned long freed;
 	LIST_HEAD(release_list);
 
 	freed = pisa_reservoir_shrink(&release_list, sc->nr_to_scan);
+	res_freed = freed;
+	pisa_stat_atomic_inc(pisa_reclaim_stats.shrink_scan);
+	pisa_stat_atomic_add(pisa_reclaim_stats.pte_pages_res, res_freed);
 
 	if (freed < sc->nr_to_scan) {
 		read_lock(&pisa_allocs_lock);
@@ -1704,6 +1809,7 @@ VISIBLE_IF_KUNIT unsigned long pisa_shrink_scan(struct shrinker *shrink, struct
 				break;
 		}
 		read_unlock(&pisa_allocs_lock);
+		pisa_stat_atomic_add(pisa_reclaim_stats.pte_pages_idle, freed - res_freed);
 	}
 
 	/* Unmap outside locks; defer decrypted pages to workqueue outside fs_reclaim. */
@@ -1723,6 +1829,141 @@ VISIBLE_IF_KUNIT unsigned long pisa_shrink_scan(struct shrinker *shrink, struct
 	return freed ?: SHRINK_STOP;
 }
 
+/* See pisa_seq_kv(). */
+void __pisa_seq_kv(struct seq_file *s, const char *title, const struct pisa_kv *st, unsigned int n)
+{
+	seq_printf(s, "  %-12s", title);
+	for (; n; n--, st++)
+		seq_printf(s, " %-10s%11lld", st->name, st->val);
+	seq_putc(s, '\n');
+}
+
+/* Output global and active per-allocator statistics in /sys/kernel/debug/pisa/allocs. */
+static int pisa_allocs_show(struct seq_file *s, void *unused)
+{
+	struct pisa_reclaim_stats *rs = &pisa_reclaim_stats;
+	struct pisa_alloc *pa;
+
+	seq_puts(s, "global (allocators with no activity are omitted)\n");
+	pisa_seq_kv(s, pisa_pages_2m, { "in_use", atomic_long_read(&pisa_nr_pages) },
+		    { "max", pisa_max_pages },
+		    { "slots", pisa_nr_slots });
+	pisa_domains_show(s);
+	pisa_seq_kv(s, "reservoir", { pisa_pages_2m, pisa_reservoir_count() },
+		    { "max_node", pisa_reservoir_max });
+	pisa_seq_kv(s, "shrinker",
+		    { "scan", pisa_stat_atomic_read(rs->shrink_scan) },
+		    { "from_res", pisa_stat_atomic_read(rs->pte_pages_res) },
+		    { "from_idle", pisa_stat_atomic_read(rs->pte_pages_idle) });
+	pisa_seq_kv(s, "reclaim",
+		    { "runs", pisa_stat_read(rs->reclaim_run) },
+		    { pisa_pages_2m, pisa_stat_read(rs->reclaim_pages) },
+		    { "unmap_fail", pisa_stat_atomic_read(rs->unmap_fail) });
+	pisa_reservoir_show(s);
+	pisa_user_show(s);
+
+	read_lock(&pisa_allocs_lock);
+	list_for_each_entry(pa, &pisa_allocs, node) {
+		u64 alloc_pages, free_pages, block_alloc, block_free, block_scrub;
+		u64 pages_in_use, blocks_in_use, used_pct = 0, pcp_alloc, pcp_miss;
+		u64 block_fail, fail_gfp, numa_mismatch, pcp_free, cached;
+		u64 alloc_kd, alloc_kc, alloc_ks, alloc_ad, alloc_ac, alloc_as;
+		u64 pcp_ks, pcp_as;
+		struct pisa_alloc_stats *st = &pa->stats;
+		unsigned int num_idle, max_idle;
+		unsigned long flags;
+
+		block_fail = pisa_stat_atomic_read(st->block_alloc_fail);
+		fail_gfp = pisa_stat_atomic_read(st->fail_gfp);
+		cached = pisa_pcp_stats(pa, &pcp_alloc, &pcp_miss, &pcp_free, &pcp_ks, &pcp_as);
+
+		spin_lock_irqsave(&pa->lock, flags);
+		alloc_pages = st->page_alloc_cnt;
+		free_pages = st->page_free_cnt;
+		block_alloc = st->block_alloc_cnt;
+		block_free = st->block_free_cnt;
+		block_scrub = st->block_scrub_cnt;
+		numa_mismatch = st->numa_mismatch_cnt;
+		alloc_kd = st->alloc_kd;
+		alloc_kc = st->alloc_kc;
+		alloc_ks = st->alloc_ks;
+		alloc_ad = st->alloc_ad;
+		alloc_ac = st->alloc_ac;
+		alloc_as = st->alloc_as;
+		num_idle = pa->num_idle_pages;
+		max_idle = pa->max_idle_pages;
+		spin_unlock_irqrestore(&pa->lock, flags);
+
+		/* Omit allocators that have never allocated or failed an allocation. */
+		if (!alloc_pages && !block_alloc && !block_fail && !fail_gfp)
+			continue;
+
+		pages_in_use = alloc_pages > free_pages ? alloc_pages - free_pages : 0;
+		blocks_in_use = block_alloc > block_free + cached ?
+				block_alloc - block_free - cached : 0;
+		if (pages_in_use)
+			used_pct = div64_u64((blocks_in_use << pa->order) * 100,
+					     pages_in_use << PISA_ORDER);
+
+		seq_printf(s, "alloc %s order %u nid %d%s\n", pa->name, pa->order,
+			   pa->nid, pa->prot == IOMMU_READ ? " tx-only" :
+			   pa->prot == IOMMU_WRITE ? " rx-only" : "");
+		pisa_seq_kv(s, pisa_pages_2m, { "got", alloc_pages },
+			    { "put", free_pages }, { "in_use", pages_in_use },
+			    { "idle", num_idle }, { "idle_max", max_idle });
+		pisa_seq_kv(s, pisa_no_pages_2m,
+			    { "backoff", pisa_stat_atomic_read(st->fail_backoff) },
+			    { "budget", pisa_stat_atomic_read(st->fail_budget) },
+			    { "nomem", pisa_stat_atomic_read(st->fail_nomem) },
+			    { "split", pisa_stat_atomic_read(st->fail_split) });
+		pisa_seq_kv(s, "blocks", { "alloc", block_alloc },
+			    { "free", block_free }, { "in_use", blocks_in_use },
+			    { "used_pct", used_pct }, { "scrub", block_scrub });
+		pisa_seq_kv(s, "blocks", { "failed", block_fail },
+			    { "gfp", fail_gfp }, { "numa_miss", numa_mismatch });
+		pisa_seq_kv(s, "allocations",
+			    { "KD", alloc_kd }, { "KC", alloc_kc }, { "KS", alloc_ks },
+			    { "AD", alloc_ad }, { "AC", alloc_ac }, { "AS", alloc_as });
+		if (pa->pcp) {
+			int cpu;
+
+			pisa_seq_kv(s, "pcpu", { "alloc", pcp_alloc },
+				    { "miss", pcp_miss },
+				    { "free", pcp_free }, { "cached", cached },
+				    { "KS", pcp_ks }, { "AS", pcp_as });
+			for_each_possible_cpu(cpu) {
+				const struct pisa_pcp *pcp = per_cpu_ptr(pa->pcp, cpu);
+				u64 a = READ_ONCE(pcp->alloc_cnt);
+				u64 m = READ_ONCE(pcp->miss_cnt);
+				u64 f = READ_ONCE(pcp->free_cnt);
+				unsigned int c = READ_ONCE(pcp->count);
+				char title[16];
+
+				if (!a && !f && !c)
+					continue;
+				snprintf(title, sizeof(title), "pcpu_%u", cpu);
+				pisa_seq_kv(s, title, { "alloc", a },
+					    { "miss", m },
+					    { "free", f }, { "cached", c });
+			}
+		}
+#ifdef CONFIG_IOMMU_DMA
+		pisa_seq_kv(s, "domains",
+			    { "mapped", pisa_stat_atomic_read(st->page_map_cnt) });
+		pisa_seq_kv(s, "map_fail",
+			    { "no_window", pisa_stat_atomic_read(st->fallback_nowindow) },
+			    { "no_idx", pisa_stat_atomic_read(st->fallback_noidx) },
+			    { "no_huge", pisa_stat_atomic_read(st->fallback_nohuge) },
+			    { "map_err", pisa_stat_atomic_read(st->fallback_maperr) },
+			    { "prot", pisa_stat_atomic_read(st->fallback_prot) });
+#endif
+	}
+	read_unlock(&pisa_allocs_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pisa_allocs);
+
 /* Return the blocks a dead CPU cached, which nothing else would. */
 static int pisa_cpu_dead(unsigned int cpu)
 {
@@ -1751,6 +1992,10 @@ static int __init pisa_init(void)
 	struct shrinker *shrink;
 	int nid, i;
 
+	snprintf(pisa_pages_2m, sizeof(pisa_pages_2m), "pages_%luM", PISA_SIZE >> 20);
+	snprintf(pisa_pages_4k, sizeof(pisa_pages_4k), "pages_%luK", PAGE_SIZE >> 10);
+	snprintf(pisa_no_pages_2m, sizeof(pisa_no_pages_2m), "no_pages_%luM", PISA_SIZE >> 20);
+
 	pisa_node_init();
 
 	/* Default ceiling is 1/8th of RAM (floor of 16 PISA pages). */
@@ -1787,7 +2032,6 @@ static int __init pisa_init(void)
 			pisa_nodes[nid].pa[ro][order] = pa;
 		}
 	}
-
 	pisa_user_boot_enable();
 
 	/* Dedicated WQ_MEM_RECLAIM workqueue so reclaim never blocks behind system_wq. */
@@ -1799,6 +2043,10 @@ static int __init pisa_init(void)
 				      pisa_cpu_dead) < 0)
 		pr_warn("pisa: no CPU hotplug callback, offline CPUs keep cached blocks\n");
 
+	/* Built-in and never unloaded; debugfs stubs are no-ops when disabled. */
+	debugfs_create_file("allocs", 0444, debugfs_create_dir("pisa", NULL),
+			    NULL, &pisa_allocs_fops);
+
 	shrink = shrinker_alloc(0, "pisa");
 	if (!shrink) {
 		pr_warn("pisa: shrinker registration failed\n");
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 3fc17024bc9d0..22f4966412feb 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -291,9 +291,9 @@ static int fake_domain_setup(struct kunit *test)
 
 static void test_map_and_domain_lifecycle(struct kunit *test)
 {
+	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
 	struct device dev = { .init_name = "pisa_map_kunit", .numa_node = NUMA_NO_NODE,
 			      .coherent_dma_mask = DMA_BIT_MASK(64) };
-	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
 	struct pisa_window *win;
 	struct pisa_meta *meta;
 	struct pisa_alloc *pa;
@@ -574,14 +574,15 @@ static void test_gfp_pisa(struct kunit *test)
 
 static void test_reservoir_and_scrubber(struct kunit *test)
 {
+	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
 	unsigned int old_res = READ_ONCE(pisa_reservoir_max);
 	unsigned int old_scrub = READ_ONCE(pisa_scrub_max);
-	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
 	struct pisa_meta *meta;
 	struct pisa_alloc *pa;
 	struct page *p;
 	int nid;
 
+	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
 	pisa_shrink_scan(NULL, &sc);
 
 	/* Refill reservoir to 1 PISA page per memory node, then consume one. */
@@ -607,9 +608,9 @@ static void test_reservoir_and_scrubber(struct kunit *test)
 			WRITE_ONCE(pisa_scrub_max, 512);
 			pisa_scrub_node(pa->nid);
 			KUNIT_EXPECT_EQ(test, meta->nr_dirty, 0U);
+			KUNIT_EXPECT_GE(test, pa->stats.block_scrub_cnt, 1ULL);
 		}
 	}
-	pisa_shrink_scan(NULL, &sc);
 
 	/* Trim reservoirs back to 0. */
 	WRITE_ONCE(pisa_reservoir_max, 0);
diff --git a/drivers/iommu/pisa-map.c b/drivers/iommu/pisa-map.c
index fc58c639f3288..2f5ea446b7de5 100644
--- a/drivers/iommu/pisa-map.c
+++ b/drivers/iommu/pisa-map.c
@@ -10,12 +10,11 @@
 #include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
 #include <linux/pisa.h>
-#include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/iova.h>
-#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
@@ -106,6 +105,8 @@ static struct {
 	struct iommu_domain *domain;
 	dma_addr_t base;
 	spinlock_t map_lock;	/* serialises iommu_map() in __pisa_map_phys() */
+	atomic_t slots;
+	char name[32];
 } pisa_domains[PISA_MAX_DOMAINS] __read_mostly;
 static DEFINE_SPINLOCK(pisa_domains_lock);
 
@@ -115,12 +116,56 @@ DEFINE_STATIC_SRCU(pisa_srcu);
 /* Bumped under pisa_domains_lock whenever a domain index is released. */
 unsigned int pisa_idx_gen __read_mostly;
 
+void pisa_domains_show(struct seq_file *s)
+{
+	unsigned int active = 0, draining = 0;
+	char bmap[PISA_MAX_DOMAINS];
+	unsigned long flags;
+	int idx;
+
+	spin_lock_irqsave(&pisa_domains_lock, flags);
+	for (idx = 0; idx < PISA_MAX_DOMAINS; idx++) {
+		if (pisa_domains[idx].domain) {
+			active++;
+			bmap[idx] = '1';
+		} else if (pisa_domains[idx].base) {
+			draining++;
+			bmap[idx] = 'd';
+		} else {
+			bmap[idx] = '.';
+		}
+	}
+	spin_unlock_irqrestore(&pisa_domains_lock, flags);
+
+	pisa_seq_kv(s, "domains", { "active", active }, { "draining", draining },
+		    { "max", PISA_MAX_DOMAINS });
+	for (idx = 0; idx < PISA_MAX_DOMAINS; idx++) {
+		if ((idx & 63) == 0)
+			seq_printf(s, "  %-12s", idx ? "" : "domains_map");
+		if ((idx & 7) == 0)
+			seq_putc(s, ' ');
+		seq_putc(s, bmap[idx]);
+		if ((idx & 63) == 63 || idx == PISA_MAX_DOMAINS - 1)
+			seq_putc(s, '\n');
+	}
+
+	spin_lock_irqsave(&pisa_domains_lock, flags);
+	for (idx = 0; idx < PISA_MAX_DOMAINS; idx++) {
+		if (!pisa_domains[idx].domain)
+			continue;
+		seq_printf(s, "  domain_%-5d base %pad size %lluM slots %d name %s\n",
+			   idx, &pisa_domains[idx].base, pisa_window_size >> 20,
+			   atomic_read(&pisa_domains[idx].slots), pisa_domains[idx].name);
+	}
+	spin_unlock_irqrestore(&pisa_domains_lock, flags);
+}
 /* Report a short IOMMU unmap and mark @meta quarantined so it is never reused. */
 static void pisa_quarantine_meta(struct pisa_meta *meta, struct iommu_domain *domain,
 				 int idx, dma_addr_t iova, size_t unmapped)
 {
 	pr_err_ratelimited("pisa: unmap of IOVA %pad in domain %p (index %d) returned %zu, quarantining PISA page\n",
 			   &iova, domain, idx, unmapped);
+	pisa_stat_atomic_inc(pisa_reclaim_stats.unmap_fail);
 	WRITE_ONCE(meta->flags, meta->flags | PISA_QUARANTINED);
 }
 
@@ -142,6 +187,7 @@ int pisa_unmap_all(struct pisa_meta *meta)
 
 		if (!test_and_clear_bit(idx, meta->domains_mapped))
 			continue;
+		atomic_dec(&pisa_domains[idx].slots);
 
 		spin_lock_irqsave(&pisa_domains_lock, flags);
 		domain = pisa_domains[idx].domain;
@@ -217,6 +263,8 @@ void pisa_domain_release(struct iommu_domain *domain)
 	/* Mark slot FREE and bump @pisa_idx_gen so NOIDX domains retry. */
 	spin_lock_irqsave(&pisa_domains_lock, flags);
 	pisa_domains[idx].base = 0;
+	atomic_set(&pisa_domains[idx].slots, 0);
+	pisa_domains[idx].name[0] = '\0';
 	WRITE_ONCE(pisa_idx_gen, pisa_idx_gen + 1);
 	spin_unlock_irqrestore(&pisa_domains_lock, flags);
 
@@ -239,6 +287,7 @@ static unsigned int pisa_unmap_domain_locked(struct pisa_meta *meta,
 
 	if (!test_and_clear_bit(idx, meta->domains_mapped))
 		return 0;
+	atomic_dec(&pisa_domains[idx].slots);
 
 	unmapped = iommu_unmap_fast(domain, iova, PISA_SIZE, gather);
 	if (unlikely(unmapped != PISA_SIZE))
@@ -388,6 +437,9 @@ int pisa_window_assign(struct device *dev, struct iommu_domain *domain, struct p
 			pisa_domains[idx].domain = domain;
 			pisa_domains[idx].base = base;
 			spin_lock_init(&pisa_domains[idx].map_lock);
+			atomic_set(&pisa_domains[idx].slots, 0);
+			strscpy(pisa_domains[idx].name, dev_name(dev),
+				sizeof(pisa_domains[idx].name));
 			WRITE_ONCE(win->domain_idx, idx + PISA_IDX_FIRST);
 			/* Publish .domain_idx before .base (paired with is_pisa_iova()). */
 			smp_store_release(&win->base, base);
@@ -435,8 +487,10 @@ int __pisa_map_phys(dma_addr_t *iova, struct device *dev,
 
 	/* Every leaf PTE of the page carries IOMMU_CACHE | @meta->prot. */
 	block_prot = IOMMU_CACHE | meta->prot;
-	if (unlikely(prot & ~block_prot))
+	if (unlikely(prot & ~block_prot)) {
+		pisa_stat_atomic_inc(meta->pa->stats.fallback_prot);
 		return -EACCES;
+	}
 
 	/* Acquire pairs with the .base release in pisa_window_assign(). */
 	if (unlikely(!smp_load_acquire(&win->base))) {
@@ -445,8 +499,15 @@ int __pisa_map_phys(dma_addr_t *iova, struct device *dev,
 		if (likely(!ret))
 			ret = pisa_window_assign(dev, domain, win);
 
-		if (ret)
+		if (ret) {
+			if (ret == -EOPNOTSUPP)
+				pisa_stat_atomic_inc(meta->pa->stats.fallback_nohuge);
+			else if (ret == -EBUSY)
+				pisa_stat_atomic_inc(meta->pa->stats.fallback_noidx);
+			else
+				pisa_stat_atomic_inc(meta->pa->stats.fallback_nowindow);
 			return ret;
+		}
 	}
 
 	addr = pisa_phys_to_iova(win, meta, phys);
@@ -454,8 +515,10 @@ int __pisa_map_phys(dma_addr_t *iova, struct device *dev,
 	/* Check @dev's own DMA mask and bus limit against the window IOVA. */
 	limit = min_not_zero(dma_get_mask(dev), dev->bus_dma_limit);
 	limit = min_not_zero(limit, dev->coherent_dma_mask);
-	if (unlikely(addr + size - 1 > limit))
+	if (unlikely(addr + size - 1 > limit)) {
+		pisa_stat_atomic_inc(meta->pa->stats.fallback_nowindow);
 		return -ENOSPC;
+	}
 
 	domain_idx = win->domain_idx - PISA_IDX_FIRST;
 	if (likely(test_bit(domain_idx, meta->domains_mapped))) {
@@ -471,10 +534,14 @@ int __pisa_map_phys(dma_addr_t *iova, struct device *dev,
 
 		ret = iommu_map(domain, pisa_phys_to_iova(win, meta, pisa_phys),
 				pisa_pte_phys(meta, pisa_phys), PISA_SIZE, block_prot, GFP_ATOMIC);
-		if (likely(!ret)) {
+		if (unlikely(ret)) {
+			pisa_stat_atomic_inc(meta->pa->stats.fallback_maperr);
+		} else {
 			/* Ensure leaf PTE is visible before setting the domain bit. */
 			smp_mb__before_atomic();
 			set_bit(domain_idx, meta->domains_mapped);
+			atomic_inc(&pisa_domains[domain_idx].slots);
+			pisa_stat_atomic_inc(meta->pa->stats.page_map_cnt);
 		}
 	}
 	spin_unlock_irqrestore(&pisa_domains[domain_idx].map_lock, flags);
diff --git a/drivers/iommu/pisa-node.c b/drivers/iommu/pisa-node.c
index 7469674133620..66280715ba504 100644
--- a/drivers/iommu/pisa-node.c
+++ b/drivers/iommu/pisa-node.c
@@ -15,6 +15,7 @@
 #include <linux/nodemask.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/topology.h>
 #include <linux/workqueue.h>
@@ -139,8 +140,10 @@ static void pisa_reservoir_refill_node(int nid)
 
 		meta = __pisa_page_alloc(GFP_KERNEL | __GFP_THISNODE, nid, true,
 					 pisa_want_decrypt(), &clean);
-		if (IS_ERR(meta))
+		if (IS_ERR(meta)) {
+			pisa_stat_inc(res->stats.refill_err);
 			break;
+		}
 
 		/* Decrypted and init_on_alloc/init_on_free pages are already zeroed. */
 		if (!clean)
@@ -149,6 +152,7 @@ static void pisa_reservoir_refill_node(int nid)
 		spin_lock_irqsave(&res->lock, flags);
 		list_add(&meta->list, &res->pages);
 		res->nr_pages++;
+		pisa_stat_inc(res->stats.refill);
 		spin_unlock_irqrestore(&res->lock, flags);
 
 		cond_resched();
@@ -169,6 +173,7 @@ static void pisa_reservoir_trim_node(int nid, unsigned int max)
 		if (meta) {
 			list_del_init(&meta->list);
 			res->nr_pages--;
+			pisa_stat_inc(res->stats.trim);
 		}
 		spin_unlock_irqrestore(&res->lock, flags);
 		if (!meta)
@@ -184,8 +189,7 @@ void pisa_schedule_scrub(int nid)
 {
 	struct pisa_node *node;
 
-	if ((!READ_ONCE(pisa_scrub_max) && !READ_ONCE(pisa_scrub_migrate)) ||
-	    nid == NUMA_NO_NODE)
+	if (!READ_ONCE(pisa_scrub_max) && !READ_ONCE(pisa_scrub_migrate))
 		return;
 
 	node = &pisa_nodes[nid];
@@ -253,6 +257,7 @@ static struct pisa_meta *pisa_reservoir_pop_node(int nid, unsigned int max, bool
 	if (meta && !!(meta->flags & PISA_DECRYPTED) == decrypt) {
 		list_del_init(&meta->list);
 		res->nr_pages--;
+		pisa_stat_inc(res->stats.hit);
 		refill = res->nr_pages <= max / 2;
 	} else {
 		meta = NULL;
@@ -282,6 +287,7 @@ struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool decrypt, bool *cle
 			*clean = true;
 			return meta;
 		}
+		pisa_stat_atomic_inc(pisa_nodes[nid].stats.miss);
 		/* Empty: pop_node() only schedules after a successful pop. */
 		pisa_schedule_reservoir_node(nid);
 	}
@@ -339,3 +345,34 @@ void __init pisa_node_init(void)
 		INIT_WORK(&pisa_nodes[nid].work, pisa_node_work_fn);
 	}
 }
+
+/* Print the reservoir of each node that has seen any activity. */
+void pisa_reservoir_show(struct seq_file *s)
+{
+	bool header = false;
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct pisa_node *res = &pisa_nodes[nid];
+		unsigned int nr = READ_ONCE(res->nr_pages);
+		s64 refill = pisa_stat_read(res->stats.refill);
+		s64 refill_err = pisa_stat_read(res->stats.refill_err);
+		s64 miss = pisa_stat_atomic_read(res->stats.miss);
+		char title[16];
+
+		/* Pages served or trimmed were refilled first. */
+		if (!nr && !refill && !refill_err && !miss)
+			continue;
+		if (!header) {
+			seq_puts(s, "reservoir\n");
+			header = true;
+		}
+		snprintf(title, sizeof(title), "node_%d", nid);
+		pisa_seq_kv(s, title, { pisa_pages_2m, nr },
+			    { "hit", pisa_stat_read(res->stats.hit) },
+			    { "miss", miss });
+		pisa_seq_kv(s, title, { "refill", refill },
+			    { "refill_err", refill_err },
+			    { "trim", pisa_stat_read(res->stats.trim) });
+	}
+}
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index 1ecfebbaeb381..8eec8996bbca7 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -8,9 +8,7 @@
 #include <linux/list.h>
 #include <linux/llist.h>
 #include <linux/mem_encrypt.h>
-#include <linux/nodemask.h>
 #include <linux/spinlock.h>
-#include <linux/topology.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -136,13 +134,78 @@ static inline unsigned int pisa_meta_avail(const struct pisa_meta *meta)
 struct pisa_pcp {
 	spinlock_t	lock;	/* by this CPU, or by a drain from any CPU */
 	unsigned int	count;
+	u64		alloc_cnt;
+	u64		miss_cnt;
+	u64		free_cnt;
+	u64		alloc_ks;
+	u64		alloc_as;
 	struct page	*blocks[PISA_PCP_HIGH];
 };
 
-/* Per-allocator statistics, see pisa_allocs_show(). */
+#define pisa_stat_add(var, val)		((var) += (val))
+#define pisa_stat_inc(var)		pisa_stat_add(var, 1)
+#define pisa_stat_dec(var)		pisa_stat_add(var, -1)
+#define pisa_stat_read(var)		READ_ONCE(var)
+
+#define pisa_stat_atomic_add(var, val)	atomic64_add(val, &(var))
+#define pisa_stat_atomic_inc(var)	atomic64_inc(&(var))
+#define pisa_stat_atomic_read(var)	atomic64_read(&(var))
+
+/**
+ * struct pisa_alloc_stats - Per-allocator statistics, see pisa_allocs_show()
+ * @page_alloc_cnt:	PISA pages allocated for this allocator
+ * @page_free_cnt:	PISA pages released back to the buddy allocator
+ * @block_alloc_cnt:	Block allocations satisfied
+ * @block_free_cnt:	Block frees recycled into allocator
+ * @block_scrub_cnt:	Dirty blocks zeroed by background scrubber
+ * @numa_mismatch_cnt:	Block allocations satisfied from a non-target NUMA node
+ * @alloc_kd:		Sleepable non-zeroing block allocations
+ * @alloc_kc:		Sleepable zeroing block allocations served from clean_bitmap
+ * @alloc_ks:		Sleepable zeroing block allocations zeroed inline
+ * @alloc_ad:		Atomic non-zeroing block allocations
+ * @alloc_ac:		Atomic zeroing block allocations served from clean_bitmap
+ * @alloc_as:		Atomic zeroing block allocations zeroed inline
+ * @fail_backoff:	PISA page acquisitions skipped due to atomic backoff
+ * @fail_budget:	PISA page acquisitions refused by global pisa_max_pages
+ * @fail_nomem:		PISA page acquisitions that ran out of memory
+ * @fail_split:		split_page_compound() rejections
+ * @block_alloc_fail:	PISA page acquisitions that failed on empty allocator
+ * @fail_gfp:		pisa_alloc() calls declined due to unsupported GFP
+ * @page_map_cnt:	PISA page mappings established across all domains
+ * @fallback_nowindow:	Buffers mapped individually due to no usable IOVA window
+ * @fallback_noidx:	Buffers mapped individually due to exhausted domain indices
+ * @fallback_nohuge:	Buffers mapped individually because domain cannot use PISA
+ * @fallback_maperr:	Buffers mapped individually because PISA mapping failed
+ * @fallback_prot:	Buffers mapped individually due to protection mismatch
+ */
 struct pisa_alloc_stats {
+	/* Updated under @pa->lock. */
 	u64		page_alloc_cnt;
 	u64		page_free_cnt;
+	u64		block_alloc_cnt;
+	u64		block_free_cnt;
+	u64		block_scrub_cnt;
+	u64		numa_mismatch_cnt;
+	u64		alloc_kd;
+	u64		alloc_kc;
+	u64		alloc_ks;
+	u64		alloc_ad;
+	u64		alloc_ac;
+	u64		alloc_as;
+
+	/* Updated without @pa->lock (e.g. pisa_alloc_split_page() and map path). */
+	atomic64_t	fail_backoff;
+	atomic64_t	fail_budget;
+	atomic64_t	fail_nomem;
+	atomic64_t	fail_split;
+	atomic64_t	block_alloc_fail;
+	atomic64_t	fail_gfp;
+	atomic64_t	page_map_cnt;
+	atomic64_t	fallback_nowindow;
+	atomic64_t	fallback_noidx;
+	atomic64_t	fallback_nohuge;
+	atomic64_t	fallback_maperr;
+	atomic64_t	fallback_prot;
 };
 
 /**
@@ -195,6 +258,18 @@ static inline long pisa_alloc_held_pages(const struct pisa_alloc *pa)
 	       READ_ONCE(pa->num_idle_pages);
 }
 
+/* Reservoir statistics, in PISA pages, see pisa_reservoir_show(). */
+struct pisa_reservoir_stats {
+	/* Updated under @res->lock or by the per-node singleton @res->work. */
+	u64		hit;		/* requests for this node it served */
+	u64		refill;		/* PISA pages added by the refill */
+	u64		refill_err;	/* refill allocations that failed */
+	u64		trim;		/* PISA pages released by the trim */
+
+	/* Updated without @res->lock when the reservoir is empty. */
+	atomic64_t	miss;		/* requests for this node found it empty */
+};
+
 /* Per-NUMA-node PISA state. */
 struct pisa_node {
 	unsigned long		next_alloc;	/* atomic alloc backoff jiffies */
@@ -206,8 +281,28 @@ struct pisa_node {
 	unsigned int		nr_pages;
 	unsigned long		flags;		/* PISA_NODE_* requests */
 	struct work_struct	work;		/* refill/trim/scrub, on this node */
+	struct pisa_reservoir_stats stats;
 } ____cacheline_aligned_in_smp;
 
+/* Global reclaim and shrinker statistics, see pisa_allocs_show(). */
+struct pisa_reclaim_stats {
+	/* Updated by singleton pisa_reclaim_work. */
+	u64		reclaim_run;	/* pisa_reclaim_work_fn() runs */
+	u64		reclaim_pages;	/* PISA pages it released */
+
+	/* Updated locklessly. */
+	atomic64_t	shrink_scan;	/* pisa_shrink_scan() calls */
+	atomic64_t	pte_pages_res;	/* 4KB pages taken from the reservoirs */
+	atomic64_t	pte_pages_idle;	/* 4KB pages taken from idle allocators */
+	atomic64_t	unmap_fail;	/* PISA page unmaps that failed */
+};
+
+extern struct pisa_reclaim_stats pisa_reclaim_stats;
+
+extern char pisa_pages_2m[16];
+extern char pisa_pages_4k[16];
+extern char pisa_no_pages_2m[16];
+
 /* Per-NUMA-node PISA state (ring/TX/user allocators, reservoir). */
 extern struct pisa_node pisa_nodes[MAX_NUMNODES];
 
@@ -255,8 +350,6 @@ static inline void pisa_alloc_backoff(int nid, bool can_block)
 		WRITE_ONCE(pisa_nodes[nid].next_alloc, jiffies + DIV_ROUND_UP(HZ, 100));
 }
 bool pisa_want_decrypt(void);
-bool pisa_place_meta(struct pisa_meta *meta);
-void pisa_schedule_reclaim(void);
 int pisa_page_prepare(struct page *page, struct pisa_meta *meta);
 int pisa_page_unprepare(struct pisa_meta *meta);
 
@@ -267,6 +360,8 @@ __printf(2, 3)
 void pisa_set_name(struct pisa_alloc *pa, const char *fmt, ...);
 int pisa_enable_pcp(struct pisa_alloc *pa);
 void pisa_pcp_drain(struct pisa_alloc *pa);
+bool pisa_place_meta(struct pisa_meta *meta);
+void pisa_schedule_reclaim(void);
 void pisa_release_page(struct pisa_meta *meta);
 unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
 			      unsigned long nr_pages, struct page **page_array, bool frozen);
@@ -300,8 +395,28 @@ void pisa_schedule_scrub_all(void);
 struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool decrypt, bool *clean);
 unsigned long pisa_reservoir_count(void);
 unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan);
+
+struct seq_file;
+void pisa_reservoir_show(struct seq_file *s);
+void pisa_user_show(struct seq_file *s);
 void pisa_user_boot_enable(void);
 
+/* One name/value pair of a debugfs statistics line. */
+struct pisa_kv {
+	const char *name;
+	s64 val;
+};
+
+void __pisa_seq_kv(struct seq_file *s, const char *title, const struct pisa_kv *st, unsigned int n);
+
+/* Print @title and fixed-width name/value pairs to debugfs seq_file @s. */
+#define pisa_seq_kv(s, title, ...)				\
+do {									\
+	const struct pisa_kv __st[] = { __VA_ARGS__ };		\
+									\
+	__pisa_seq_kv(s, title, __st, ARRAY_SIZE(__st));		\
+} while (0)
+
 #endif /* CONFIG_PISA */
 
 #if defined(CONFIG_PISA) && defined(CONFIG_IOMMU_DMA)
@@ -316,6 +431,7 @@ void pisa_slots_init(void);
 int pisa_slot_alloc(struct pisa_meta *meta);
 void pisa_slot_free(unsigned int slot);
 int pisa_unmap_all(struct pisa_meta *meta);
+void pisa_domains_show(struct seq_file *s);
 int pisa_window_assign(struct device *dev, struct iommu_domain *domain, struct pisa_window *win);
 int __pisa_map_phys(dma_addr_t *iova, struct device *dev,
 		    struct iommu_domain *domain, phys_addr_t phys,
@@ -364,6 +480,7 @@ static inline void pisa_slots_init(void) {}
 static inline int pisa_slot_alloc(struct pisa_meta *meta) { return 0; }
 static inline void pisa_slot_free(unsigned int slot) {}
 static inline int pisa_unmap_all(struct pisa_meta *meta) { return 0; }
+static inline void pisa_domains_show(struct seq_file *s) {}
 
 static inline int pisa_map_phys(dma_addr_t *iova, struct device *dev,
 				struct iommu_domain *domain, phys_addr_t phys,
diff --git a/drivers/iommu/pisa-user.c b/drivers/iommu/pisa-user.c
index 7dca3bf066f0d..5cf199943f82c 100644
--- a/drivers/iommu/pisa-user.c
+++ b/drivers/iommu/pisa-user.c
@@ -21,6 +21,7 @@
 #include <linux/pagewalk.h>
 #include <linux/folio_batch.h>
 #include <linux/sched/clock.h>
+#include <linux/seq_file.h>
 #include <linux/swap.h>
 
 #include "pisa-priv.h"
@@ -88,6 +89,26 @@ module_param_cb(scrub_migrate, &pisa_scrub_migrate_ops, &pisa_scrub_migrate, 064
 static bool pisa_user_ready __read_mostly;
 static DEFINE_MUTEX(pisa_user_lock);
 
+/* Statistics, see pisa_user_show(). */
+struct pisa_user_stats {
+	atomic64_t	in;		/* pages migrated into PISA blocks */
+	atomic64_t	in_fail;	/* ... isolated but not migrated */
+	atomic64_t	out;		/* pages migrated back to ordinary pages */
+	atomic64_t	out_fail;	/* ... isolated but not migrated */
+	atomic64_t	no_budget;	/* pages not moved in: cap reached */
+	atomic64_t	busy;		/* pages skipped: referenced elsewhere */
+	atomic64_t	large;		/* pages skipped: in a large anon folio */
+	atomic64_t	copy;		/* TCP chunks copied: page not in PISA */
+};
+
+static struct pisa_user_stats pisa_user_stats;
+
+/* Called by zerocopy_fill_skb_from_iter() when it asks TCP to copy. */
+void pisa_stats_inc_user_copy(void)
+{
+	pisa_stat_atomic_inc(pisa_user_stats.copy);
+}
+
 /* Lazily create per-node user allocators on first use (process context). */
 static bool pisa_user_init(void)
 {
@@ -141,6 +162,9 @@ static unsigned long pisa_user_in_use(void)
 	unsigned long used = 0;
 	int nid;
 
+	/* Pairs with smp_store_release() in pisa_user_init(). */
+	if (!smp_load_acquire(&pisa_user_ready))
+		return 0;
 	for_each_node_state(nid, N_MEMORY) {
 		unsigned int dir;
 
@@ -255,7 +279,7 @@ static unsigned int pisa_user_migrate_dir(struct list_head *list, bool to_pisa,
 		.same_alloc = same_alloc,
 	};
 	enum migrate_mode mode = MIGRATE_SYNC;
-	unsigned int done = 0;
+	unsigned int nr, done = 0;
 
 	if (list_empty(list))
 		return 0;
@@ -264,9 +288,17 @@ static unsigned int pisa_user_migrate_dir(struct list_head *list, bool to_pisa,
 		if (!gfpflags_allow_blocking(gfp))
 			mode = MIGRATE_ASYNC;
 	}
+	nr = list_count_nodes(list);	/* all order-0 */
 	if (migrate_pages(list, to_pisa ? pisa_user_new_folio : pisa_user_old_folio,
 			  NULL, (unsigned long)&mtc, mode, MR_SYSCALL, &done))
 		putback_movable_pages(list);
+	if (to_pisa) {
+		pisa_stat_atomic_add(pisa_user_stats.in, done);
+		pisa_stat_atomic_add(pisa_user_stats.in_fail, nr - done);
+	} else {
+		pisa_stat_atomic_add(pisa_user_stats.out, done);
+		pisa_stat_atomic_add(pisa_user_stats.out_fail, nr - done);
+	}
 	return done;
 }
 
@@ -285,7 +317,7 @@ bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr,
 	int extra = pinned ? GUP_PIN_COUNTING_BIAS : 1;
 	bool drained = false;
 	LIST_HEAD(list);
-	unsigned int i, want = 0, need_budget = 0;
+	unsigned int i, want = 0, need_budget = 0, large = 0;
 
 	if (!pisa_user_init())
 		return false;
@@ -293,15 +325,21 @@ bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr,
 	for (i = 0; i < nr; i++) {
 		struct folio *folio = page_folio(pages[i]);
 
+		/* THP/mTHP heap pages are never migrated, see pisa_user_want() */
+		large += folio_test_large(folio) && folio_test_anon(folio);
 		if (pisa_user_want_dir(folio, true, dir, false)) {
 			want++;
 			need_budget += !is_pisa_pfn(folio_pfn(folio));
 		}
 	}
+	if (large)
+		pisa_stat_atomic_add(pisa_user_stats.large, large);
 	if (!want)
 		return false;
-	if (need_budget && pisa_user_budget() <= 0)
+	if (need_budget && pisa_user_budget() <= 0) {
+		pisa_stat_atomic_add(pisa_user_stats.no_budget, need_budget);
 		return false;
+	}
 	for (i = 0; i < nr; i++) {
 		struct folio *folio = page_folio(pages[i]);
 
@@ -312,8 +350,10 @@ bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr,
 			lru_add_drain();
 			drained = true;
 		}
-		if (pisa_user_busy(folio, extra))
+		if (pisa_user_busy(folio, extra)) {
+			pisa_stat_atomic_inc(pisa_user_stats.busy);
 			continue;
+		}
 		isolate_folio_to_list(folio, &list);
 	}
 	if (list_empty(&list))
@@ -583,9 +623,14 @@ int pisa_madvise(struct vm_area_struct *vma, unsigned long start, unsigned long
 		struct folio *folio = folio_walk_start(&fw, vma, addr, 0);
 
 		if (folio) {
-			if (pisa_user_want_dir(folio, to_pisa, DMA_TO_DEVICE, false) &&
-			    !pisa_user_busy(folio, 0) && isolate_folio_to_list(folio, &list))
-				n++;
+			if (to_pisa && folio_test_large(folio) && folio_test_anon(folio)) {
+				pisa_stat_atomic_inc(pisa_user_stats.large);
+			} else if (pisa_user_want_dir(folio, to_pisa, DMA_TO_DEVICE, false)) {
+				if (pisa_user_busy(folio, 0))
+					pisa_stat_atomic_inc(pisa_user_stats.busy);
+				else if (isolate_folio_to_list(folio, &list))
+					n++;
+			}
 			folio_walk_end(&fw, vma);
 		}
 		if (n == PISA_USER_BATCH) {
@@ -597,3 +642,21 @@ int pisa_madvise(struct vm_area_struct *vma, unsigned long start, unsigned long
 	pisa_user_migrate_dir(&list, to_pisa, DMA_TO_DEVICE, false, gfp);
 	return 0;
 }
+
+/* Print user page state and migration statistics to debugfs seq_file @s. */
+void pisa_user_show(struct seq_file *s)
+{
+	seq_puts(s, "user\n");
+	pisa_seq_kv(s, pisa_pages_4k, { "in_use", pisa_user_in_use() },
+		    { "max", pisa_user_max_4k_pages });
+	pisa_seq_kv(s, "migrate",
+		    { "in", pisa_stat_atomic_read(pisa_user_stats.in) },
+		    { "in_fail", pisa_stat_atomic_read(pisa_user_stats.in_fail) },
+		    { "out", pisa_stat_atomic_read(pisa_user_stats.out) },
+		    { "out_fail", pisa_stat_atomic_read(pisa_user_stats.out_fail) });
+	pisa_seq_kv(s, "skipped",
+		    { "no_budget", pisa_stat_atomic_read(pisa_user_stats.no_budget) },
+		    { "busy", pisa_stat_atomic_read(pisa_user_stats.busy) },
+		    { "large", pisa_stat_atomic_read(pisa_user_stats.large) },
+		    { "copy", pisa_stat_atomic_read(pisa_user_stats.copy) });
+}
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index 1d9b07370cc75..667321b18ae47 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -147,6 +147,7 @@ bool pisa_folio_upgrade(struct folio *folio, enum dma_data_direction dir,
 bool __pisa_bdev_enabled(struct block_device *bdev, enum dma_data_direction dir);
 bool __pisa_mapping_enabled(const struct address_space *mapping,
 			    enum dma_data_direction dir);
+void pisa_stats_inc_user_copy(void);
 int pisa_madvise(struct vm_area_struct *vma, unsigned long start,
 		 unsigned long end, bool to_pisa);
 
@@ -331,6 +332,10 @@ pisa_filemap_alloc(const struct address_space *mapping, gfp_t gfp,
 	return NULL;
 }
 
+static inline void pisa_stats_inc_user_copy(void)
+{
+}
+
 static inline int pisa_madvise(struct vm_area_struct *vma, unsigned long start,
 			       unsigned long end, bool to_pisa)
 {
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 8ba9c39cb05ec..360ed445fe779 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -693,6 +693,8 @@ static bool pisa_zc_iter(int *ret, struct sk_buff *skb, struct iov_iter *from, s
 	if (keep)
 		return false;
 
+	if (skb->len == orig_len)
+		pisa_stats_inc_user_copy();
 	*ret = (skb->len != orig_len) ? 0 : -EXDEV;
 	return true;
 }
-- 
2.56.0.542.g3ef89b7020-goog

