Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248754;
	b=F1Bv/OkkXbPiF2d4etCYyaxq32lh3Uv8IyloaOkTcwZU7g+zBjRXhHTwBMK3dVjPg0OB
	 QTAPvX/1uTbIani95azDeDUrdzAwSvd/y4JH5Uy1l7qhe2Dxc79ncVfghVwFx9tYpxjOz
	 zB9Wnhclnvuosfh4piKkxj02hpxI90pw1One707nYAmtdfrppnTv9mOqXVp6Uzr4DiAzi
	 pRrNBop0esMtDfINZIbSwD36uENVGgcaq89NF7G/skeoig4/gnPlk35mZxNnOMHMPa57d
	 thoNP87i2stIuXiYun3oPp9Aps/k4oECV26UYAH8V81sOS8bpf9EdwNzkvI6X2s1XeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QVlpo+SbrLJW+bc3XjTubXFpvW/EVjF1pqrflLQoNyw=;
	b=VIDpBhAJxL9V9u3ihIImBHMwJYFUSq+oTqiPwdu3BhgVe/tXuYhrPtqy/R6GrsJh2Kgq
	 VQTbs5ukqV50ChdpXTako6FmIkVB08zdrGPAmE3wDJSPlZPHcxGlWeFaQzJmMmUPLFlAW
	 I1rmDzzsCZ0Bw428gFzC/32rS8KbAZ6NKeA7zOhCXsbIVUe0H8n6V1Rn4ETUlx8fLJJZB
	 IsBJQzz0QxcGJgck7ZNGQ/Q8XsZ0zCj2WUatJnjPokRlS25isDkcdC6tbs/AdnM9/K1GA
	 WbgtFO/ifekd6pdll69O/t3R8oi3WWHZwuU3sLfLSwQy3GFhSuKG/Ty9XMUZsQnh3aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JpPdMSdv;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FBA606B5A7
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FBA606B5A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JpPdMSdv
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b706aec674so1225032a12.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248752; x=1794853552; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QVlpo+SbrLJW+bc3XjTubXFpvW/EVjF1pqrflLQoNyw=;
        b=JpPdMSdvVSpfQkPenWA1x2V/BdpFV2KxO2OMTIbICw5SDcEUd+j9SCWlfJsvK4EO2h
         oNlv6J+Y3DhMOZsbYxmvbNlj64EDUHkmdRV3jkv/jAKxM5PMwYe18+s0dK0DKi76bPLN
         BZx13zO+5Yyem3jTYukaQPQFcKN1B84NfQFbRJU/Rh7iDM90HNEdiLWGsTTwZ5HrIiZS
         UqQ2flvzxazRC4nSUvOW4skDu38ozdydfl+5cda1u9FeK5v/vTqo4X6jFC3laJMV0qmP
         0Wf0ZzSYEQuGYnzehawBtJEFAE7zMVfCIOB8/NkJpOE+8CZBdEy/nLVkazS9wh8RHeTH
         m3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248752; x=1794853552;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVlpo+SbrLJW+bc3XjTubXFpvW/EVjF1pqrflLQoNyw=;
        b=vfAUXdwDBO5etpnFBKYzHA2IoG1BoqOvb4o5zmcUw97trsITohMWIXWnT1PJMNKbWg
         FqvuXTIuLxtDqw31u1xqL90zIL8skr0EDlocOs/UBqzqhAGYXjnGJqpP4+Z8lh3faOeQ
         jfEKMymybypXpUeKQZ4HnVUfWLRxP5EkoXeTP++TpPxAkj/GBPB6voQyhAQY5RcRqjKE
         Mt0ehTJnPjkyOe4ATKR1B4y921qbptvzQBV1whgLWTsmcSanX9PdxY7wMU6DFlWVQZbs
         0jVfRhj1nxa8dypzphk+f0D+bGGlEW2bAO50DG3D9FUkXGQJGtkUMzmDQb2evp5sDrDO
         ndBQ==
X-Forwarded-Encrypted: i=1; AL+hErGKzfDMMO40isrT4MxTwW2oZrA8zGlbZHd7wIt+Qe0TPnL/g9b/SAZoJHje9QdIOeEsOWi5jYHScPu6FQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+X0f4215u/puwDrJjScds8NNPPCoRhEZ2cKuqwIBgrzakb0BPV
	MYJIShyF6NEQNWWViMURnpa8C/sk2fvphjTNjn7qTSR5xznhq0UNbgP/WcX/yCtt9Gg2BVLAvtg
	8+BT9yQ==
X-Received: from edr28.prod.google.com ([2002:a05:6402:44dc:b0:6b5:8cc8:5d75])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:d7d9:0:b0:6b1:e4cb:a23e
 with SMTP id 4fb4d7f45d1cf-6b7564fbf5fmr267962a12.14.1794248751837; Mon, 09
 Nov 2026 10:25:51 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:23 +0000
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
Message-ID: <20261109182533.3594984-16-lrizzo@google.com>
Subject: [RFC PATCH v2 15/25] iommu/dma: Add background page scrubber for PISA allocators
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

Blocks returned to a pisa_alloc are marked dirty and need to be zeroed
before they can serve __GFP_ZERO requests. Zeroing blocks inline at
allocation time adds CPU cost and latency.

Add an optional background scrubber (enabled via pisa.scrub_max) that
runs on the allocator's home NUMA node work item, zeroes dirty blocks
outside pa->lock in batches, and moves them to meta->clean_bitmap[].
Scrubbing is demand-driven by the number of dirty blocks that __GFP_ZERO
allocations had to zero inline.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 188 ++++++++++++++++++++++++++++++++++++-
 drivers/iommu/pisa-kunit.c |  49 +++++++++-
 drivers/iommu/pisa-node.c  |  31 ++++++
 drivers/iommu/pisa-priv.h  |  11 ++-
 4 files changed, 272 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index b4a25c65bf97e..4b61ec84ed6d1 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -29,6 +29,7 @@
 #include <linux/percpu.h>
 #include <linux/pgalloc_tag.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 #include <linux/set_memory.h>
 #include <linux/shrinker.h>
@@ -72,6 +73,10 @@ module_param_named(idle_ms, pisa_idle_ms, uint, 0644);
 static unsigned int pisa_compact __read_mostly;
 module_param_named(compact, pisa_compact, uint, 0644);
 
+/* Max pages zeroed in each scrubber run (0 = disabled, capped at PISA_SCRUB_MAX_LIMIT). */
+unsigned int pisa_scrub_max __read_mostly;
+#define PISA_SCRUB_MAX_LIMIT	65536U
+
 /* All live allocators, protected by pisa_allocs_lock. */
 static LIST_HEAD(pisa_allocs);
 static DEFINE_RWLOCK(pisa_allocs_lock);
@@ -86,6 +91,24 @@ struct pisa_node pisa_nodes[MAX_NUMNODES] = {
 
 static void pisa_schedule_reclaim(void);
 
+static int pisa_scrub_set(const char *val, const struct kernel_param *kp)
+{
+	int ret = param_set_uint(val, kp);
+
+	if (ret)
+		return ret;
+	WRITE_ONCE(pisa_scrub_max, min(pisa_scrub_max, PISA_SCRUB_MAX_LIMIT));
+	/* Serve demand accumulated while the scrubber was off (once initialized). */
+	if (pisa_scrub_max && static_branch_unlikely(&pisa_key))
+		pisa_schedule_scrub_all();
+	return 0;
+}
+
+static const struct kernel_param_ops pisa_scrub_ops = {
+	.set = pisa_scrub_set,
+	.get = param_get_uint,
+};
+module_param_cb(scrub_max, &pisa_scrub_ops, &pisa_scrub_max, 0644);
 /* Return true if a new PISA page should be decrypted. */
 bool pisa_want_decrypt(void)
 {
@@ -263,6 +286,7 @@ static void pisa_schedule_reclaim(void)
 	else
 		queue_delayed_work(wq, &pisa_reclaim_work, msecs_to_jiffies(idle_ms));
 }
+
 /*
  * Update @meta's position on @pa's lists under @pa->lock. When all blocks
  * become available (avail == bpp), either queues @meta to @pisa_free_list (and
@@ -353,6 +377,148 @@ static bool pisa_block_poisoned(struct pisa_alloc *pa, struct page *block)
 	return false;
 }
 
+/*
+ * Background page scrubber: pre-zeroes dirty blocks in @pa->nid's work item
+ * to match inline-zeroed demand (@pa->scrub_demand) when scrub_max > 0.
+ */
+static struct pisa_meta *pisa_pick_dirty_meta(struct pisa_alloc *pa)
+{
+	struct pisa_meta *meta;
+
+	meta = list_first_entry_or_null(&pa->partial_dirty, struct pisa_meta, list);
+	if (meta)
+		return meta;
+
+	list_for_each_entry(meta, &pa->partial, list) {
+		if (meta->nr_dirty)
+			return meta;
+	}
+
+	if (!list_empty(&pa->idle)) {
+		meta = list_last_entry(&pa->idle, struct pisa_meta, list);
+		if (meta->nr_dirty) {
+			pa->num_idle_pages--;
+			return meta;
+		}
+	}
+
+	return NULL;
+}
+
+/* Dirty blocks per allocator, inline-zeroed since the last run, that queue a run. */
+#define PISA_SCRUB_TRIGGER	32U
+/* Cap on @pa->scrub_demand, so a long-off scrubber does not owe too much. */
+#define PISA_SCRUB_DEMAND_MAX	4096U
+/* Bytes zeroed per batch: a few microseconds of memset(). */
+/* XXX assumes PAGE_SIZE <= SZ_128K (32 * 4KB pages). */
+#define PISA_SCRUB_BYTES	SZ_128K
+#define PISA_SCRUB_BATCH	(PISA_SCRUB_BYTES >> PAGE_SHIFT)
+/* Time after which a run stops and requeues. */
+#define PISA_SCRUB_RUN_NS	(50 * NSEC_PER_USEC)
+
+/*
+ * Scrub one batch of dirty blocks in @pa outside @pa->lock.
+ * Returns the number of PAGE_SIZE pages taken off the dirty bitmap.
+ */
+static unsigned long pisa_scrub_alloc(struct pisa_alloc *pa)
+{
+	unsigned int bpp, order, idx, count = 0, used = 0, want;
+	u16 idxs[PISA_SCRUB_BATCH];
+	unsigned long base_pfn, flags;
+	bool should_release;
+	struct pisa_meta *meta;
+
+	spin_lock_irqsave(&pa->lock, flags);
+	if (!pa->scrub_demand) {
+		spin_unlock_irqrestore(&pa->lock, flags);
+		return 0;
+	}
+
+	meta = pisa_pick_dirty_meta(pa);
+	if (!meta) {
+		pa->scrub_demand = 0;
+		spin_unlock_irqrestore(&pa->lock, flags);
+		return 0;
+	}
+
+	order = pa->order;
+	bpp = PISA_BLOCKS(order);
+	base_pfn = pisa_meta_to_pfn(meta);
+	want = min(max(PISA_SCRUB_BATCH >> order, 1U), pa->scrub_demand);
+
+	for_each_set_bit(idx, meta->dirty_bitmap, bpp) {
+		struct page *block = pfn_to_page(base_pfn + (idx << order));
+
+		__clear_bit(idx, meta->dirty_bitmap);
+		used++;
+		if (!pisa_block_poisoned(pa, block))
+			idxs[count++] = idx;
+		if (used == meta->nr_dirty || count == want)
+			break;
+	}
+	meta->nr_dirty -= used;
+	pa->blocks_in_use += used - count;
+	pisa_place_meta(meta);
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (unlikely(!count))
+		return (unsigned long)used << order;
+
+	for (idx = 0; idx < count; idx++) {
+		struct page *block = pfn_to_page(base_pfn + (idxs[idx] << order));
+
+		memset(page_address(block), 0, PAGE_SIZE << order);
+	}
+
+	spin_lock_irqsave(&pa->lock, flags);
+	for (idx = 0; idx < count; idx++)
+		__set_bit(idxs[idx], meta->clean_bitmap);
+	meta->nr_clean += count;
+	pa->scrub_demand -= min(count, pa->scrub_demand);
+	should_release = pisa_place_meta(meta);
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (should_release)
+		pisa_schedule_reclaim();
+
+	return (unsigned long)used << order;
+}
+
+/*
+ * Scrub dirty blocks for allocators homed on @nid up to @pisa_scrub_max pages or
+ * PISA_SCRUB_RUN_NS. Returns true if stopped early with demand remaining.
+ */
+bool pisa_scrub_node(int nid)
+{
+	unsigned long budget = READ_ONCE(pisa_scrub_max), done = 0, n;
+	u64 deadline = local_clock() + PISA_SCRUB_RUN_NS;
+	struct pisa_alloc *pa;
+	bool more = false;
+
+	read_lock(&pisa_allocs_lock);
+	list_for_each_entry(pa, &pisa_allocs, node) {
+		if (pa->nid != nid || !READ_ONCE(pa->scrub_demand))
+			continue;
+		read_unlock(&pisa_allocs_lock);
+
+		while ((n = pisa_scrub_alloc(pa))) {
+			done += n;
+			if (done >= budget || local_clock() >= deadline) {
+				more = true;
+				break;
+			}
+			cond_resched();
+		}
+
+		read_lock(&pisa_allocs_lock);
+		if (more)
+			break;
+	}
+	read_unlock(&pisa_allocs_lock);
+
+	return more;
+}
+
 /**
  * pisa_create - Create a PISA page allocator
  * @nid: Home NUMA node for this allocator
@@ -952,6 +1118,7 @@ static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
 		for (i = got; i < got + dirty; i++)
 			set_page_private(out[i], 1);
 		got += dirty;
+		pa->scrub_demand = min(pa->scrub_demand + dirty, PISA_SCRUB_DEMAND_MAX);
 	} else {
 		/* First choice are dirty blocks, followed by clean */
 		got += pisa_scan_bitmap(meta, true, want, out, !frozen);
@@ -973,6 +1140,7 @@ static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
 static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigned long nr_pages,
 				       struct page **pages, bool zero, bool frozen)
 {
+	bool should_scrub = false;
 	unsigned long n, flags, i;
 	struct pisa_meta *meta;
 	unsigned int want;
@@ -986,6 +1154,7 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 			continue;
 
 		/* Fallback to a new allocation */
+		should_scrub |= pa->scrub_demand >= PISA_SCRUB_TRIGGER;
 		spin_unlock_irqrestore(&pa->lock, flags);
 		/* With @zero, fresh dirty blocks are zeroed below. */
 		meta = pisa_alloc_split_page(pa->order, gfp, pa->nid);
@@ -998,6 +1167,8 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
 		pa->stats.page_alloc_cnt++;
 	}
+	/* Queue the scrubber when the inline zeroing crosses the trigger. */
+	should_scrub |= pa->scrub_demand >= PISA_SCRUB_TRIGGER;
 	spin_unlock_irqrestore(&pa->lock, flags);
 
 out:
@@ -1012,6 +1183,8 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 		else
 			page_ref_unfreeze(pages[i], 1);
 	}
+	if (should_scrub)
+		pisa_schedule_scrub(pa->nid);
 	return n;
 }
 
@@ -1112,7 +1285,7 @@ static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblock
 {
 	DECLARE_BITMAP(busy, PISA_MAX_BLOCKS);
 	struct pisa_alloc *pa = meta->pa;
-	unsigned int bpp = PISA_BLOCKS(0), i;
+	unsigned int bpp = PISA_BLOCKS(0), i, dirty = 0;
 	bool poisoned = false;
 	unsigned long off;
 	struct page *page;
@@ -1166,11 +1339,13 @@ static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblock
 		} else {
 			__clear_bit(off + i, meta->dirty_bitmap);
 			meta->nr_dirty--;
+			dirty++;
 		}
 		pisa_block_prep(page + i);
 		page_ref_unfreeze(page + i, 1);
 	}
 	pa->blocks_in_use += nblocks;
+	pa->scrub_demand = min(pa->scrub_demand + dirty, PISA_SCRUB_DEMAND_MAX);
 	pisa_place_meta(meta);
 	return page;
 }
@@ -1185,7 +1360,7 @@ void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
 			  struct iommu_domain *domain, size_t size,
 			  gfp_t gfp, unsigned long attrs)
 {
-	bool should_release = false;
+	bool should_scrub = false, should_release = false;
 	struct list_head *lists[3];
 	unsigned long align_mask, flags;
 	unsigned int nblocks, i;
@@ -1234,10 +1409,14 @@ void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
 		}
 	}
 	if (!page) {
+		should_scrub |= pa->scrub_demand >= PISA_SCRUB_TRIGGER;
 		spin_unlock_irqrestore(&pa->lock, flags);
 		meta = pisa_alloc_split_page(0, gfp, pa->nid);
-		if (IS_ERR(meta))
+		if (IS_ERR(meta)) {
+			if (should_scrub)
+				pisa_schedule_scrub(pa->nid);
 			return NULL;
+		}
 		spin_lock_irqsave(&pa->lock, flags);
 		meta->pa = pa;
 		meta->prot = pa->prot;
@@ -1247,10 +1426,13 @@ void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
 		if (unlikely(!page))
 			should_release = pisa_place_meta(meta);
 	}
+	should_scrub |= pa->scrub_demand >= PISA_SCRUB_TRIGGER;
 	spin_unlock_irqrestore(&pa->lock, flags);
 
 	if (should_release)
 		pisa_schedule_reclaim();
+	if (should_scrub)
+		pisa_schedule_scrub(pa->nid);
 	if (!page)
 		return NULL;
 	*pagep = page;
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index b63cd6585b673..40bf7801183da 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -572,8 +572,53 @@ static void test_gfp_pisa(struct kunit *test)
 
 static void test_reservoir_and_scrubber(struct kunit *test)
 {
-	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
-	KUNIT_EXPECT_EQ(test, READ_ONCE(pisa_reservoir_max), 16U);
+	unsigned int old_res = READ_ONCE(pisa_reservoir_max);
+	unsigned int old_scrub = READ_ONCE(pisa_scrub_max);
+	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
+	struct pisa_meta *meta;
+	struct pisa_alloc *pa;
+	struct page *p;
+	int nid;
+
+	pisa_shrink_scan(NULL, &sc);
+
+	/* Refill reservoir to 1 PISA page per memory node, then consume one. */
+	WRITE_ONCE(pisa_reservoir_max, 1);
+	pisa_schedule_reservoir();
+	for_each_node_state(nid, N_MEMORY)
+		flush_work(&pisa_nodes[nid].work);
+	KUNIT_EXPECT_GE(test, pisa_reservoir_count(), 1UL);
+
+	pa = pisa_node_pa(first_memory_node, 2, true);
+	KUNIT_ASSERT_NOT_NULL(test, pa);
+	p = pisa_alloc(pa, GFP_KERNEL);
+	if (p) {
+		meta = pisa_meta_of_pfn(page_to_pfn(p));
+		/* Reservoir pages come pre-zeroed (all remaining blocks clean). */
+		KUNIT_EXPECT_EQ(test, meta->nr_dirty, 0U);
+		__free_pages(p, 2);
+		if (!want_init_on_free()) {
+			KUNIT_EXPECT_EQ(test, meta->nr_dirty, 1U);
+
+			/* Scrub dirty block back into clean_bitmap. */
+			pa->scrub_demand = 1;
+			WRITE_ONCE(pisa_scrub_max, 512);
+			pisa_scrub_node(pa->nid);
+			KUNIT_EXPECT_EQ(test, meta->nr_dirty, 0U);
+		}
+	}
+	pisa_shrink_scan(NULL, &sc);
+
+	/* Trim reservoirs back to 0. */
+	WRITE_ONCE(pisa_reservoir_max, 0);
+	pisa_schedule_reservoir();
+	for_each_node_state(nid, N_MEMORY)
+		flush_work(&pisa_nodes[nid].work);
+	KUNIT_EXPECT_EQ(test, pisa_reservoir_count(), 0UL);
+
+	WRITE_ONCE(pisa_reservoir_max, old_res);
+	pisa_schedule_reservoir();
+	WRITE_ONCE(pisa_scrub_max, old_scrub);
 }
 
 static struct kunit_case pisa_meta_test_cases[] = {
diff --git a/drivers/iommu/pisa-node.c b/drivers/iommu/pisa-node.c
index dfde9c021fe05..cd29c146c281e 100644
--- a/drivers/iommu/pisa-node.c
+++ b/drivers/iommu/pisa-node.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/pisa.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
@@ -32,6 +33,9 @@
  */
 unsigned int pisa_reservoir_max __read_mostly = 16;
 
+/* Scrub the allocators whose home node (@pa->nid) is this one. */
+#define PISA_NODE_SCRUB	0
+
 static int pisa_reservoir_max_set(const char *val, const struct kernel_param *kp)
 {
 	int ret = param_set_uint(val, kp);
@@ -175,6 +179,30 @@ static void pisa_reservoir_trim_node(int nid, unsigned int max)
 	}
 }
 
+/* Schedule node @nid's work item to scrub allocators homed on @nid. */
+void pisa_schedule_scrub(int nid)
+{
+	struct pisa_node *node;
+
+	if (!READ_ONCE(pisa_scrub_max) || nid == NUMA_NO_NODE)
+		return;
+
+	node = &pisa_nodes[nid];
+	set_bit(PISA_NODE_SCRUB, &node->flags);
+	/* Pairs with the clearing of PENDING before the work runs. */
+	smp_mb__after_atomic();
+	if (!work_pending(&node->work))
+		queue_work_node(nid, system_dfl_wq, &node->work);
+}
+
+void pisa_schedule_scrub_all(void)
+{
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY)
+		pisa_schedule_scrub(nid);
+}
+
 /* Per-node worker: trim/refill the reservoir, then scrub allocators homed on @nid. */
 static void pisa_node_work_fn(struct work_struct *work)
 {
@@ -184,6 +212,9 @@ static void pisa_node_work_fn(struct work_struct *work)
 	pisa_reservoir_trim_node(nid, READ_ONCE(pisa_reservoir_max));
 	if (READ_ONCE(pisa_reservoir_max) && static_branch_unlikely(&pisa_key))
 		pisa_reservoir_refill_node(nid);
+
+	if (test_and_clear_bit(PISA_NODE_SCRUB, &node->flags) && pisa_scrub_node(nid))
+		pisa_schedule_scrub(nid);
 }
 
 /* Queue node @nid's work if its reservoir is below or above the target. */
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index f08388f003fad..ef3abb1db9049 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -144,8 +144,9 @@ struct pisa_alloc_stats {
  * @num_idle_pages: Length of @idle
  * @max_idle_pages: High watermark of @idle before async release to the buddy allocator
  * @idle_jiffies: Timestamp (jiffies) when @idle last exceeded @max_idle_pages
+ * @scrub_demand: Dirty blocks zeroed inline since the scrubber last ran
  * @blocks_in_use: Blocks handed out and not yet freed
- * @nid:	NUMA node id
+ * @nid:	NUMA node whose worker scrubs this allocator
  * @node:	Node in the global pisa_allocs list
  * @name:	Debug name (defaults to caller of pisa_create())
  * @stats:	Per-allocator statistics
@@ -162,6 +163,7 @@ struct pisa_alloc {
 	struct list_head	full;
 	unsigned int		num_idle_pages;
 	unsigned int		max_idle_pages;
+	unsigned int		scrub_demand;
 	unsigned long		idle_jiffies;
 	unsigned long		blocks_in_use;
 	/* Cold. */
@@ -187,7 +189,8 @@ struct pisa_node {
 	spinlock_t		lock;		/* protects @pages and @nr_pages */
 	struct list_head	pages;		/* reservoir */
 	unsigned int		nr_pages;
-	struct work_struct	work;		/* refill/trim, on this node */
+	unsigned long		flags;		/* PISA_NODE_* requests */
+	struct work_struct	work;		/* refill/trim/scrub, on this node */
 } ____cacheline_aligned_in_smp;
 
 /* Per-NUMA-node PISA state (ring/TX/user allocators, reservoir). */
@@ -263,11 +266,15 @@ static inline struct page *pisa_alloc(struct pisa_alloc *pa, gfp_t gfp)
 unsigned long pisa_shrink_list(spinlock_t *lock, struct list_head *list,
 			       unsigned int *nr, struct list_head *release_list,
 			       unsigned long nr_to_scan);
+extern unsigned int pisa_scrub_max;
+bool pisa_scrub_node(int nid);
 
 /* pisa-node.c: per-NUMA-node PISA page reservoir and work item */
 extern unsigned int pisa_reservoir_max;
 void pisa_node_init(void);
 void pisa_schedule_reservoir(void);
+void pisa_schedule_scrub(int nid);
+void pisa_schedule_scrub_all(void);
 struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool decrypt, bool *clean);
 unsigned long pisa_reservoir_count(void);
 unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan);
-- 
2.56.0.542.g3ef89b7020-goog

