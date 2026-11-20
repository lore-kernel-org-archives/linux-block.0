Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136834;
	b=5jwcN2k1IuJ8/nU6tO5vaYpc/0ob2WCleyeYZDkUouyo+crLMVIsDBEfxbpxJx8tC5Od
	 hnB8DN8FLTLIsErMo+Qtsz9F9D4FHpwkjZgDHcPGp14vWUGhCnskRYyuqT4RM6Icsb5Ao
	 ry4P3E2JMcgKwiKsXNxSuDA6cPBpahfIaw3k6rHJAmRoXKGXj7IY5Mvz8UYD5YybNrHbz
	 QECjeNx3h+E4HJKuVeeMPWG9z/4BaygibnsisfN9e9NznFyNE+7cYUpTql+oadUZQf4rM
	 LvarSH5OYsNreaOKnpeMUSr7p7HggUXgzikn2g94fkWJCu/5ESnNPVO/28pJVGM59kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WXs7Yj1cGBwyhMjJN8Y/E5M3TpnFTlPTOE1zlFzAJtw=;
	b=B9qRy9TzRxt3NzjNvXBIfrpNuFC6ui7cTXifbofPLCGSrJ+QXfp440PYdDaYPcLydg6u
	 S68CyWPZRQaPP5sBRNzAmXJeSF352lLNJ+x1FyBwoE+kY3zJtHIUFpG9UBdtyXEB3PHVJ
	 O+bQMLw461A8CLqO3jeLVzd1TAPq9UL+Um+xVGoGTSK596R75OMrGmMsQJHvoSxfytRds
	 MI/LDMHbBgBItzF/hT5d/N5o7dAInj9mnwcz7U9xDRWOjvJJwFxsxl8H8sNyhJFluf6rH
	 RsnC45OMwvCUhCfEECMVwsrfrf+a0xYFnlssLc5Gdmeu9NbGw+8gmIt0+4HC2UtFrbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gl+pahZK;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896A606C052
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 01:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2896A606C052
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gl+pahZK
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c50c9af44d6so28669866b.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 17:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136833; x=1795741633; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXs7Yj1cGBwyhMjJN8Y/E5M3TpnFTlPTOE1zlFzAJtw=;
        b=gl+pahZKpHWMSfGs8wGWQSx/BnIj+0H1Sn4muB40XBYmIJBeGGfI6QuRJ7g7kekvy2
         kWYvL0poZbjVhEtDN5JW7PYFGySmoN4mmiMCfPZnhAeMt6A/IiqZZ/dME5SfqPjxXtZl
         ShhSofaXh50dSijWTvoey5ES64SqqOpt3FUXGSY0KHqS89zqpTTIsOOJsiiQE5aBrj/U
         zKgSBs3XboSqn3GuOMM5dcRYVL3gEMciKJhG0/uDE8BU/fJMoX3Cubpe0yaIcjPsudXT
         +f286nZF3WMtAABmvWaaPJo4BvCoNhBt0/QbAcNkcQ6ZRg7thda8wL9yCmgoiqDoGz/i
         E3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136833; x=1795741633;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXs7Yj1cGBwyhMjJN8Y/E5M3TpnFTlPTOE1zlFzAJtw=;
        b=nM+77uCVUuP7V8a5rVohCqfUp9EA0RDTS6nXH2O92HLEljsRjc4ZRuq5ZWVqqVarNR
         6jCsQPkyMngRg8JNYE3u7dKTh9rfR0Idjso80JykrSxInNcEDZlaAdg6liK8jnv2goUQ
         sIODDxsaOH6jL9K7AxWRCFuoB4XNSPg8qWbILACsOHpcq7vQ4ngsLoe3bqC1Kg3xjgYd
         jSkyyfTy1SEEtYBPM1bycxpxftsBLmsnYs0en5JfKXzAOxK5BYH+kXQFCzNa9wtlp3VP
         jxiqnmjbQFnH41CoqbZtyFbg6BKhE8eQd6eq6Pdga8KXJv9uupJY4XKOh6hybOtZfKKM
         r4qw==
X-Forwarded-Encrypted: i=1; AL+hErEoFfXdjmMYk4yXpNb1zvxw+a3FuF/+R46ZNNXxOpCa7MYL+8EbNJ+HMVhJ8VHPjGl55sUA4tZy0/ibYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z91xq7uiBCUUYlKd7vinlpq1jNw81sv1yEzSW4qkTuJaZKEXDwL
	KoER8ax8DLW52owXAvkx79V8FjMJMKASYX+ByAm9zZtVJtlmf14CSBWKJAjxJTITyfBfY/tqGV7
	DC8ixKA==
X-Received: from ejst23.prod.google.com ([2002:a17:906:6bd7:b0:c3f:741d:2c1d])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:370b:b0:c51:34ae:dd7
 with SMTP id a640c23a62f3a-c5134ae12d8mr166359266b.17.1795136832058; Thu, 19
 Nov 2026 17:07:12 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:40 +0000
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
Message-ID: <20261120010655.467825-11-lrizzo@google.com>
Subject: [RFC PATCH v3 10/25] mm: Add background page scrubber for PISA allocators
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
 include/linux/pisa-iommu.h |   1 +
 mm/pisa-alloc.c            | 187 ++++++++++++++++++++++++++++++++++++-
 mm/pisa-kunit.c            |  51 +++++++++-
 mm/pisa-meta.c             |   7 +-
 mm/pisa-node.c             |  33 +++++++
 mm/pisa-priv.h             |  10 +-
 6 files changed, 281 insertions(+), 8 deletions(-)

diff --git a/include/linux/pisa-iommu.h b/include/linux/pisa-iommu.h
index 568108747f575..7dd91ff47288a 100644
--- a/include/linux/pisa-iommu.h
+++ b/include/linux/pisa-iommu.h
@@ -55,6 +55,7 @@ struct pisa_meta {
 	u8 on_list;		/* current placement in @pa (PISA_LIST_*) */
 	bool drain;		/* sparse old page draining back to @idle */
 	u32 slot;		/* dense index in @pisa_meta_array and IOVA windows */
+	u16 nr_scrub;		/* blocks being zeroed by the scrubber, in neither bitmap */
 
 	DECLARE_BITMAP(domains_mapped, PISA_MAX_DOMAINS);
 
diff --git a/mm/pisa-alloc.c b/mm/pisa-alloc.c
index 896709303f258..ccba2bf01bd59 100644
--- a/mm/pisa-alloc.c
+++ b/mm/pisa-alloc.c
@@ -32,6 +32,7 @@
 #include <linux/page_table_check.h>
 #include <linux/pci.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 #include <linux/shrinker.h>
 #include <linux/skbuff.h>
@@ -80,6 +81,10 @@ static unsigned int pisa_max_idle __read_mostly = 1;
 unsigned int pisa_idle_ms __read_mostly = 200;
 module_param_named(idle_ms, pisa_idle_ms, uint, 0644);
 
+/* Max pages zeroed in each scrubber run (0 = disabled, capped at PISA_SCRUB_MAX_LIMIT). */
+unsigned int pisa_scrub_max __read_mostly;
+#define PISA_SCRUB_MAX_LIMIT	65536U
+
 /* All live allocators, protected by pisa_allocs_lock. */
 static LIST_HEAD(pisa_allocs);
 static DEFINE_RWLOCK(pisa_allocs_lock);
@@ -113,6 +118,25 @@ static const struct kernel_param_ops pisa_max_idle_ops = {
 };
 module_param_cb(max_idle, &pisa_max_idle_ops, &pisa_max_idle, 0644);
 
+static int pisa_scrub_set(const char *val, const struct kernel_param *kp)
+{
+	int ret = param_set_uint(val, kp);
+
+	if (ret)
+		return ret;
+	WRITE_ONCE(pisa_scrub_max, min(pisa_scrub_max, PISA_SCRUB_MAX_LIMIT));
+	/* Serve demand accumulated while the scrubber was off (once initialized). */
+	if (pisa_enabled() && pisa_scrub_max)
+		pisa_schedule_scrub_all();
+	return 0;
+}
+
+static const struct kernel_param_ops pisa_scrub_ops = {
+	.set = pisa_scrub_set,
+	.get = param_get_uint,
+};
+module_param_cb(scrub_max, &pisa_scrub_ops, &pisa_scrub_max, 0644);
+
 static void pisa_reclaim_work_fn(struct work_struct *work);
 
 /* Asynchronous reclaim worker for pisa_free_list and expired idle pages. */
@@ -245,6 +269,140 @@ static bool is_pisa_block_poisoned(struct pisa_alloc *pa, struct page *block)
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
+	/* Idle pages are left alone: scrubbing one would restart its idle clock. */
+	return NULL;
+}
+
+/* Dirty blocks per allocator, inline-zeroed since the last run, that queue a run. */
+#define PISA_SCRUB_TRIGGER	32U
+/* Cap on @pa->scrub_demand, so a long-off scrubber does not owe too much. */
+#define PISA_SCRUB_DEMAND_MAX	4096U
+/* Bytes zeroed per batch: a few microseconds of memset(). */
+#define PISA_SCRUB_BYTES	SZ_128K
+#define PISA_SCRUB_BATCH	(PISA_SCRUB_BYTES >> PAGE_SHIFT)
+static_assert(PISA_SCRUB_BATCH * sizeof(u16) <= 128);
+
+/*
+ * Scrub one batch of dirty blocks in @pa outside @pa->lock.
+ * Returns the number of PAGE_SIZE pages taken off the dirty bitmap.
+ */
+static unsigned long pisa_alloc_scrub_blocks(struct pisa_alloc *pa)
+{
+	unsigned int bpp, order, idx, count = 0, want;
+	unsigned long flags, used = 0;
+	u16 idxs[PISA_SCRUB_BATCH];
+	struct page *page, *block;
+	struct pisa_meta *meta;
+	bool should_release;
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
+	page = pisa_meta_to_page(meta);
+	want = min(max(PISA_SCRUB_BATCH >> order, 1U), pa->scrub_demand);
+
+	for_each_set_bit(idx, meta->dirty_bitmap, bpp) {
+		block = page + (idx << order);
+		__clear_bit(idx, meta->dirty_bitmap);
+		used++;
+		if (!is_pisa_block_poisoned(pa, block))
+			idxs[count++] = idx;
+		if (used == meta->nr_dirty || count == want)
+			break;
+	}
+	meta->nr_dirty -= used;
+	pa->blocks_in_use += used - count;
+	meta->nr_scrub = count;
+	pisa_place_meta(meta);
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (unlikely(!count))
+		return used << order;
+
+	for (idx = 0; idx < count; idx++) {
+		block = page + (idxs[idx] << order);
+		memset(page_address(block), 0, PAGE_SIZE << order);
+	}
+
+	spin_lock_irqsave(&pa->lock, flags);
+	for (idx = 0; idx < count; idx++)
+		__set_bit(idxs[idx], meta->clean_bitmap);
+	meta->nr_clean += count;
+	meta->nr_scrub = 0;
+	pa->scrub_demand -= min(count, pa->scrub_demand);
+	should_release = pisa_place_meta(meta);
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (should_release)
+		pisa_schedule_reclaim();
+
+	return used << order;
+}
+
+/*
+ * Scrub dirty blocks for allocators homed on @nid up to @pisa_scrub_max pages or
+ * PISA_SCRUB_RUN_NS. Returns true if stopped early with demand remaining.
+ */
+bool pisa_scrub_node(int nid)
+{
+	unsigned long budget = READ_ONCE(pisa_scrub_max), n;
+	u64 deadline = local_clock() + PISA_SCRUB_RUN_NS;
+	struct pisa_alloc *pa;
+	bool progress;
+
+	if (!budget)
+		return false;
+
+	do {
+		progress = false;
+		read_lock(&pisa_allocs_lock);
+		list_for_each_entry(pa, &pisa_allocs, node) {
+			if (pa->nid != nid || !READ_ONCE(pa->scrub_demand))
+				continue;
+			read_unlock(&pisa_allocs_lock);
+			n = pisa_alloc_scrub_blocks(pa);
+			if (n >= budget || local_clock() >= deadline)
+				return true;
+			budget -= n;
+			progress |= n != 0;
+			cond_resched();
+			read_lock(&pisa_allocs_lock);
+		}
+		read_unlock(&pisa_allocs_lock);
+	} while (progress);
+
+	return false;
+}
+
 /**
  * pisa_alloc_create - Create a PISA page allocator
  * @nid: Home NUMA node for this allocator
@@ -731,6 +889,7 @@ static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
 		for (unsigned int i = got; i < got + dirty; i++)
 			set_page_private(out[i], 1);
 		got += dirty;
+		pa->scrub_demand = min(pa->scrub_demand + dirty, PISA_SCRUB_DEMAND_MAX);
 	} else {
 		/* First choice are dirty blocks, followed by clean */
 		got += pisa_scan_bitmap(meta, true, want, out, !frozen);
@@ -754,6 +913,7 @@ static unsigned int take_blocks(struct pisa_meta *meta, unsigned int want,
 static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigned long nr_pages,
 				       struct page **pages, bool zero, bool frozen)
 {
+	bool should_scrub = false;
 	unsigned long n, flags;
 	struct pisa_meta *meta;
 	unsigned int want;
@@ -767,6 +927,7 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 			continue;
 
 		/* Fallback to a new allocation */
+		should_scrub |= pa->scrub_demand >= PISA_SCRUB_TRIGGER;
 		spin_unlock_irqrestore(&pa->lock, flags);
 		/* With @zero, fresh dirty blocks are zeroed below. */
 		meta = pisa_alloc_split_page(pa->order, gfp, pa->nid);
@@ -780,6 +941,8 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 		pisa_meta_set_flags(meta, PISA_ACTIVE);
 		pa->stats.page_alloc++;
 	}
+	/* Queue the scrubber when the inline zeroing crosses the trigger. */
+	should_scrub |= pa->scrub_demand >= PISA_SCRUB_TRIGGER;
 	spin_unlock_irqrestore(&pa->lock, flags);
 
 out:
@@ -794,6 +957,8 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 		else
 			page_ref_unfreeze(pages[i], 1);
 	}
+	if (should_scrub)
+		pisa_schedule_scrub(pa->nid);
 	return n;
 }
 
@@ -882,8 +1047,14 @@ unsigned long pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp,
 		/* Fill the run of @n NULL entries at @i. */
 		for (n = 1; i + n < nr_pages && !page_array[i + n]; n++)
 			;
-		/* Pairs with smp_store_release() in pisa_enable_pcp(). */
-		if (smp_load_acquire(&pa->pcp) && pa->nid == numa_mem_id())
+		/*
+		 * With the scrubber on, zeroed allocations skip the per-CPU
+		 * cache: __pisa_alloc_bulk() prefers clean blocks and records
+		 * the demand that drives the scrubber.
+		 * smp_load_acquire() pairs with smp_store_release() in pisa_enable_pcp().
+		 */
+		if (smp_load_acquire(&pa->pcp) && pa->nid == numa_mem_id() &&
+		    !(want_init_on_alloc(gfp) && READ_ONCE(pisa_scrub_max)))
 			got = pisa_pcp_alloc(pa, gfp, n, page_array + i, frozen);
 		else
 			got = __pisa_alloc_bulk(pa, gfp, n, page_array + i,
@@ -965,6 +1136,7 @@ static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblock
 		page_ref_unfreeze(page + i, 1);
 	}
 	pa->blocks_in_use += nblocks;
+	pa->scrub_demand = min(pa->scrub_demand + dirty, PISA_SCRUB_DEMAND_MAX);
 	*clean = !dirty;
 	pisa_place_meta(meta);
 	return page;
@@ -995,7 +1167,7 @@ __pisa_alloc_map_coherent(struct device *dev, struct iommu_domain *domain,
 			  size_t size, dma_addr_t *dma_handle, gfp_t gfp,
 			  unsigned long attrs)
 {
-	bool should_release = false, clean = false;
+	bool should_scrub = false, should_release = false, clean = false;
 	struct list_head *lists[3];
 	unsigned long align_mask, flags;
 	struct pisa_meta *meta, *tmp;
@@ -1047,10 +1219,14 @@ __pisa_alloc_map_coherent(struct device *dev, struct iommu_domain *domain,
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
@@ -1061,10 +1237,13 @@ __pisa_alloc_map_coherent(struct device *dev, struct iommu_domain *domain,
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
 	if (!domain && unlikely(!dma_coherent_ok(dev, page_to_phys(page), size))) {
diff --git a/mm/pisa-kunit.c b/mm/pisa-kunit.c
index 0f8cc9baf5d28..4effbc8610079 100644
--- a/mm/pisa-kunit.c
+++ b/mm/pisa-kunit.c
@@ -662,8 +662,57 @@ static void test_gfp_pisa(struct kunit *test)
 
 static void test_reservoir_and_scrubber(struct kunit *test)
 {
+	unsigned int old_res = READ_ONCE(pisa_reservoir_max);
+	unsigned int old_scrub = READ_ONCE(pisa_scrub_max);
+	struct shrink_control sc = { .nr_to_scan = ULONG_MAX };
+	struct pisa_meta *meta;
+	struct pisa_alloc *pa;
+	struct page *p;
+	int nid;
+
 	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
-	KUNIT_EXPECT_EQ(test, READ_ONCE(pisa_reservoir_max), 16U);
+	pisa_shrink_scan(NULL, &sc);
+
+	/* Refill reservoir to 1 PISA page per memory node, then consume one. */
+	WRITE_ONCE(pisa_reservoir_max, 1);
+	pisa_schedule_reservoir();
+	for_each_node_state(nid, N_MEMORY)
+		flush_work(&pisa_nodes[nid].work);
+	KUNIT_EXPECT_GE(test, pisa_reservoir_count(), 1UL);
+
+	pa = pisa_node_pa(first_memory_node, SKB_FRAG_PAGE_ORDER, true);
+	KUNIT_ASSERT_NOT_NULL(test, pa);
+	p = pisa_alloc(pa, GFP_KERNEL);
+	if (p) {
+		meta = pisa_meta_of_pfn(page_to_pfn(p));
+		/* Reservoir pages come pre-zeroed (all remaining blocks clean). */
+		KUNIT_EXPECT_EQ(test, meta->nr_dirty, 0U);
+		__free_pages(p, SKB_FRAG_PAGE_ORDER);
+		pisa_pcp_drain(pa);
+		if (!want_init_on_free()) {
+			KUNIT_EXPECT_GE(test, meta->nr_dirty, 1U);
+
+			/* Scrub the freed block and its PCP batch back into clean_bitmap. */
+			pa->scrub_demand = meta->nr_dirty;
+			WRITE_ONCE(pisa_scrub_max, 512);
+			pisa_scrub_node(pa->nid);
+			KUNIT_EXPECT_EQ(test, meta->nr_dirty, 0U);
+		}
+	}
+	pisa_shrink_scan(NULL, &sc);
+
+	/* Trim reservoirs back to 0. */
+	for_each_node_state(nid, N_MEMORY)
+		flush_work(&pisa_nodes[nid].work);
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
diff --git a/mm/pisa-meta.c b/mm/pisa-meta.c
index 30f0f2f6ef628..49fa5271a392f 100644
--- a/mm/pisa-meta.c
+++ b/mm/pisa-meta.c
@@ -213,10 +213,13 @@ bool pisa_place_meta(struct pisa_meta *meta)
 		 * (head of partial list, preferred for allocation). In between,
 		 * keep the current dense/sparse state.
 		 */
+		/* Blocks that the scrubber is zeroing are free: count them here. */
+		unsigned int nfree = avail + meta->nr_scrub;
+
 		to_list = meta->nr_clean ? PISA_LIST_CLEAN : PISA_LIST_DIRTY;
-		if (avail >= bpp - (bpp >> 2))
+		if (nfree >= bpp - (bpp >> 2))
 			to_list |= PISA_LIST_SPARSE;
-		else if (avail > (bpp >> 1))
+		else if (nfree > (bpp >> 1))
 			to_list |= meta->on_list & PISA_LIST_SPARSE;
 	}
 
diff --git a/mm/pisa-node.c b/mm/pisa-node.c
index a39251b952263..c013e384b1c7e 100644
--- a/mm/pisa-node.c
+++ b/mm/pisa-node.c
@@ -5,6 +5,9 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/export.h>
 #include <linux/pisa.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
@@ -37,6 +40,9 @@ struct pisa_node pisa_nodes[MAX_NUMNODES] = {
 	},
 };
 
+/* Bit number in pisa_node.flags: background scrub requested on this node. */
+#define PISA_NODE_SCRUB	0
+
 static int pisa_reservoir_max_set(const char *val, const struct kernel_param *kp)
 {
 	int ret = param_set_uint(val, kp);
@@ -237,6 +243,30 @@ static void pisa_reservoir_trim_node(struct pisa_node *node, unsigned int max)
 	}
 }
 
+/* Schedule node @nid's work item to scrub allocators homed on @nid. */
+void pisa_schedule_scrub(int nid)
+{
+	struct pisa_node *node;
+
+	if (!READ_ONCE(pisa_scrub_max))
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
@@ -246,6 +276,9 @@ static void pisa_node_work_fn(struct work_struct *work)
 	pisa_reservoir_trim_node(node, READ_ONCE(pisa_reservoir_max));
 	if (pisa_enabled() && READ_ONCE(pisa_reservoir_max))
 		pisa_reservoir_refill_node(node, nid);
+
+	if (test_and_clear_bit(PISA_NODE_SCRUB, &node->flags) && pisa_scrub_node(nid))
+		pisa_schedule_scrub(nid);
 }
 
 /* Queue node @nid's work if its reservoir is below or above the target. */
diff --git a/mm/pisa-priv.h b/mm/pisa-priv.h
index 60120a05082a9..9f01173d30f5f 100644
--- a/mm/pisa-priv.h
+++ b/mm/pisa-priv.h
@@ -108,6 +108,7 @@ struct pisa_alloc {
 	struct list_head	full;		/* PISA pages with 0 free blocks */
 	unsigned int		num_idle_pages;
 	unsigned int		max_idle_pages;
+	unsigned int		scrub_demand;	/* dirty blocks zeroed inline */
 	unsigned long		idle_jiffies;	/* last change of @idle at/above @max_idle_pages */
 	unsigned long		blocks_in_use;	/* blocks handed out and not yet freed */
 	/* Cold. */
@@ -136,7 +137,8 @@ struct pisa_node {
 	spinlock_t		lock;		/* protects @pages and @nr_pages */
 	unsigned int		nr_pages;	/* entries in @pages */
 	struct list_head	pages;		/* reservoir */
-	struct work_struct	work;		/* refill/trim, on this node */
+	unsigned long		flags;		/* PISA_NODE_* requests */
+	struct work_struct	work;		/* refill/trim/scrub, on this node */
 } ____cacheline_aligned_in_smp;
 
 /* Per-NUMA-node PISA state (ring/TX/user allocators, reservoir). */
@@ -229,11 +231,17 @@ static inline struct page *pisa_alloc(struct pisa_alloc *pa, gfp_t gfp)
 unsigned long pisa_shrink_list(spinlock_t *lock, struct list_head *list,
 			       unsigned int *nr, struct list_head *release_list,
 			       unsigned long nr_to_scan);
+/* Time after which a scrubber run stops and requeues. */
+#define PISA_SCRUB_RUN_NS	(50 * NSEC_PER_USEC)
+extern unsigned int pisa_scrub_max;
+bool pisa_scrub_node(int nid);
 
 /* pisa-node.c: per-NUMA-node PISA page reservoir and work item */
 extern unsigned int pisa_reservoir_max;
 void pisa_node_init(void);
 void pisa_schedule_reservoir(void);
+void pisa_schedule_scrub(int nid);
+void pisa_schedule_scrub_all(void);
 struct pisa_meta *pisa_reservoir_pop(int nid, gfp_t gfp, bool *clean);
 unsigned long pisa_reservoir_count(void);
 unsigned long pisa_reservoir_shrink(struct list_head *release_list, unsigned long nr_to_scan);
-- 
2.56.1.809.ga0b61035b5-goog

