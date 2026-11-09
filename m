Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248758;
	b=B+n3LyST/XnaF030dX0jhlA/GlLdzXAUmOC5qkGgs7pfZzsxQqD+SPha/qCrYMvUcWZ5
	 0A8nxd1vXpHOb27Ff113vf8lRzaDrDP/4Fz7YuOTWEZJjw5vvv+3ojfiJuwy/k9HkNRBS
	 1TKk5BnQSHOgO31JFYlki0kcO3CzKgsbzEk9mbu6ICwlJiwxvs5PvMytiyR3cO5g4ZMhp
	 dBcctwI00jlhAijvCGrfmwiTF6eZyEcANHM+lbul3cTboIriJ7mtKlGPDnvQS3dksJ5C8
	 SKCGs4u6sUJBe1/+JWG/qi10MRmqIwd3j61DMKWvJedaGZ9Guqbbitpzv9XvvUFcf+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=F900AAsyhWSGfvSMjAgbbzmK+pQvO8F59zHwAoO/xyA=;
	b=aR7VNEXFzVDCr/5jOVQXfAsWxrNoKlecLPSsKZ/TU9Z0WuCg96SpvHd3hM0ZpnE3d/Tx
	 A6aAEhByN0zo52tPTbMAgs1Wa28qxngztJoxgYkFNUBNOGyEVwSyrFI2+DpBu5igAMj29
	 AN04dndD7ozoYfqRERADIEDTEfUeiyEMl//Qi8Ca1l22upR+GtNa1EjdOUxbQvNVA5xy3
	 NbrFB3jSpdK8Y7epxiLB99fcqyzMtZ7duFT1IQ5uEp0Qh6Nj67eQkRhojrZiK2B03/Uqk
	 m+F3HyGd9XOSXkd1zKNXmtrM41uYFgfvJ490b5ujtx2bLiquKLlHejJh9fm1laA/HaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fXXUwj45;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E146606E130
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E146606E130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fXXUwj45
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c465c4c8da0so137205466b.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248757; x=1794853557; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F900AAsyhWSGfvSMjAgbbzmK+pQvO8F59zHwAoO/xyA=;
        b=fXXUwj45SaVt3UFn2b4xpOL9pi1OyH8MHBRiZoJ0xgh4iWEZeSbDcxIwUOAqOhdjm+
         KjIyPPtAN1K9HjNbYASxm966Y60ixP0x7gOv2gGGi5zZLFTxf21FnAKsU4IJCfrPpeMu
         rv+q//BqOxK1b0DGN6JL1WZaMjGuBiVksbuyUuGZXiJAYrkQdTi4LhvWP6LOb8WFUwXC
         gpfOIizR7opcQephqJ0OW634OUyeVihfHm/w56Wpq+jUha9oSBXMB9bGGebr56OgIAFk
         iCMWOHyE3HJxH6EDODNBrXgfzd1P1HrjOqoF3h/i96FaA4gUROY8wahgEZS9aaFeFzUc
         0zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248757; x=1794853557;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F900AAsyhWSGfvSMjAgbbzmK+pQvO8F59zHwAoO/xyA=;
        b=BrpUgDZ19+KjqmZTItKg2JhkTfBKcWK2SMI/i8Ht5Hva0Dwso0CtXQNw4Q8ytXqcxf
         0mq7LuNvUnvW0KyjassbikiO+kucqWti7eSASFCC3W3rf9ksJf0/7g5dCFF6ggYOhsTA
         PkgEOEq0lXXHYOb6B/R5/hhvkZQJe5n5OPmib3YnBJe/V2SW7UTuWXe+xltJePU4A0c0
         zsQ7ihoJT8XvQc+NApiGF5uGtp9uvuHHIuLsK820vAYJrG3fD5n634iBoaB5XwEEhXOS
         bHjBhP6XWM0yKVNAEvPA5nKMGu1/ihUoRbuj8kpN9e49+We9PDiCFqF2YwiQOtnNtC3D
         Y+KQ==
X-Forwarded-Encrypted: i=1; AL+hErHQl8qF1nmKFSMw/fMEAfWUDwZrUSOKSJ7155CCUV/wgmEKtj5jsjvMGFx9dkZ88YjSaeJI6jZFsrkyaA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Pab1v0fWJf0P3yQp2alHfPRJeLYVigLYSG8bftjL+i5GRnJCY
	tF9w90+sI842df1AHA5Y8Hnu6a124ztdVxTqtkg/7NlbS9ldZ3X9Un3jdFKaqhkBFQjRZTQUjAS
	PQk4S2Q==
X-Received: from ejjj18-n1.prod.google.com ([2002:a05:6938:a092:10b0:c33:6983:9d2f])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3fa6:b0:c46:bbde:734b
 with SMTP id a640c23a62f3a-c50495f02d5mr16406166b.32.1794248756683; Mon, 09
 Nov 2026 10:25:56 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:27 +0000
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
Message-ID: <20261109182533.3594984-20-lrizzo@google.com>
Subject: [RFC PATCH v2 19/25] iommu/dma: Stop recycling old PISA pages when
 allocator waste is high
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

When a PISA allocator holds many partially used 2MB pages with low
overall utilization, callers that recycle blocks in place (page_pool,
per-task TX page_frags, and per-CPU block caches) can keep old 2MB pages
pinned indefinitely with only a few blocks in use.

Record @alloc_jiffies in struct pisa_meta when a 2MB page is bound to an
allocator or taken from the allocator's idle list, and add two module
parameters:
- pisa.wasted_pct (1..99%, 0 disables): wasted block percentage
  threshold above which compaction kicks in.
- pisa.old_ms (1..100000 ms, 0 disables): age threshold after which a
  partially used 2MB page is eligible to stop recycling.

When both parameters are set and an allocator's wasted block fraction
exceeds wasted_pct, pisa_page_can_recycle() returns false for partial
2MB pages older than old_ms (except the head page actively being
filled).

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 48 ++++++++++++++++++++++++++++++++------
 drivers/iommu/pisa-priv.h  |  2 ++
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 1930135880d2b..5054a96f0f4e9 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -74,6 +74,14 @@ module_param_named(idle_ms, pisa_idle_ms, uint, 0644);
 static unsigned int pisa_compact __read_mostly;
 module_param_named(compact, pisa_compact, uint, 0644);
 
+/* Stop recycling partial pages older than @pisa_old_ms when wasted blocks > @pisa_wasted_pct%. */
+#define PISA_OLD_MS_MAX		100000U
+static unsigned int pisa_wasted_pct __read_mostly;
+module_param_named(wasted_pct, pisa_wasted_pct, uint, 0644);
+
+static unsigned int pisa_old_ms __read_mostly;
+module_param_named(old_ms, pisa_old_ms, uint, 0644);
+
 /* Max pages zeroed in each scrubber run (0 = disabled, capped at PISA_SCRUB_MAX_LIMIT). */
 unsigned int pisa_scrub_max __read_mostly;
 #define PISA_SCRUB_MAX_LIMIT	65536U
@@ -399,6 +407,7 @@ static struct pisa_meta *pisa_pick_dirty_meta(struct pisa_alloc *pa)
 		meta = list_last_entry(&pa->idle, struct pisa_meta, list);
 		if (meta->nr_dirty) {
 			pa->num_idle_pages--;
+			WRITE_ONCE(meta->alloc_jiffies, jiffies);
 			return meta;
 		}
 	}
@@ -603,7 +612,7 @@ static void pisa_return_block_locked(struct pisa_alloc *pa, struct page *block,
  * pisa_page_can_recycle - Check if a block can stay cached in a caller pool
  * @page: Block head page
  *
- * Called on the recycle fast path (per-CPU cache, TX page_frag, page_pool).
+ * Called on the recycle fast path (per-CPU cache, TX page_frag).
  * Fast-path cost is a static-key branch plus a READ_ONCE() of module parameters
  * (~1-2 ns when compaction is off); when enabled, it does a lockless RCU +
  * metadata array lookup (~5-10 ns).
@@ -613,10 +622,11 @@ static void pisa_return_block_locked(struct pisa_alloc *pa, struct page *block,
  */
 bool pisa_page_can_recycle(const struct page *page)
 {
-	unsigned long bpp, in_use, free_blocks, pfn;
+	unsigned int compact, wasted_pct, old_ms;
+	unsigned long bpp, in_use, free_blocks;
 	const struct pisa_meta *meta;
 	const struct pisa_alloc *pa;
-	unsigned int compact;
+	unsigned long pfn;
 	bool ret = true;
 	u8 on_list;
 	long held;
@@ -625,7 +635,9 @@ bool pisa_page_can_recycle(const struct page *page)
 		return true;
 
 	compact = READ_ONCE(pisa_compact);
-	if (!compact)
+	wasted_pct = READ_ONCE(pisa_wasted_pct);
+	old_ms = READ_ONCE(pisa_old_ms);
+	if (!compact && (!wasted_pct || !old_ms))
 		return true;
 
 	pfn = page_to_pfn(page);
@@ -638,6 +650,13 @@ bool pisa_page_can_recycle(const struct page *page)
 	if (on_list == PISA_LIST_FULL || on_list == PISA_LIST_NONE)
 		goto out;
 
+	if (!compact) {
+		unsigned long max_age = msecs_to_jiffies(min(old_ms, PISA_OLD_MS_MAX));
+
+		if (!time_after(jiffies, READ_ONCE(meta->alloc_jiffies) + max_age))
+			goto out;
+	}
+
 	pa = meta->pa;
 	if (!pa)
 		goto out;
@@ -657,12 +676,21 @@ bool pisa_page_can_recycle(const struct page *page)
 	free_blocks = held > 0 && (unsigned long)held * bpp > in_use ?
 		      (unsigned long)held * bpp - in_use : 0;
 
-	ret = free_blocks <= (unsigned long)compact * bpp;
+	if (compact && free_blocks > (unsigned long)compact * bpp) {
+		ret = false;
+		goto out;
+	}
+	if (wasted_pct && old_ms && held > 0 &&
+	    free_blocks * 100 > (unsigned long)held * bpp * wasted_pct) {
+		unsigned long max_age = msecs_to_jiffies(min(old_ms, PISA_OLD_MS_MAX));
+
+		ret = !time_after(jiffies, READ_ONCE(meta->alloc_jiffies) + max_age);
+	}
 out:
 	rcu_read_unlock();
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pisa_page_can_recycle);
+EXPORT_SYMBOL(pisa_page_can_recycle);
 
 /* Return @n freed blocks to @pa under a single acquisition of @pa->lock. */
 static void pisa_free_bulk(struct pisa_alloc *pa, struct page **blocks, unsigned int n)
@@ -1195,6 +1223,7 @@ static struct pisa_meta *pisa_pick_meta(struct pisa_alloc *pa, bool zero)
 		meta = list_first_entry_or_null(&pa->idle, struct pisa_meta, list);
 		if (meta && meta->nr_clean) {
 			pa->num_idle_pages--;
+			WRITE_ONCE(meta->alloc_jiffies, jiffies);
 			WRITE_ONCE(pa->idle_jiffies, jiffies);
 			return meta;
 		}
@@ -1218,6 +1247,7 @@ static struct pisa_meta *pisa_pick_meta(struct pisa_alloc *pa, bool zero)
 	if (!list_empty(&pa->idle)) {
 		meta = list_last_entry(&pa->idle, struct pisa_meta, list);
 		pa->num_idle_pages--;
+		WRITE_ONCE(meta->alloc_jiffies, jiffies);
 		WRITE_ONCE(pa->idle_jiffies, jiffies);
 		return meta;
 	}
@@ -1287,6 +1317,7 @@ static unsigned long __pisa_alloc_bulk(struct pisa_alloc *pa, gfp_t gfp, unsigne
 		spin_lock_irqsave(&pa->lock, flags);
 		meta->pa = pa;
 		meta->prot = pa->prot;
+		WRITE_ONCE(meta->alloc_jiffies, jiffies);
 		/* Set PISA_ACTIVE after @meta is fully set up. */
 		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
 		pa->stats.page_alloc_cnt++;
@@ -1454,8 +1485,10 @@ static struct page *pisa_take_contig(struct pisa_meta *meta, unsigned int nblock
 	}
 
 	if (meta->on_list == PISA_LIST_IDLE_CLEAN ||
-	    meta->on_list == PISA_LIST_IDLE_DIRTY)
+	    meta->on_list == PISA_LIST_IDLE_DIRTY) {
 		pa->num_idle_pages--;
+		WRITE_ONCE(meta->alloc_jiffies, jiffies);
+	}
 
 	for (i = 0; i < nblocks; i++) {
 		if (__test_and_clear_bit(off + i, meta->clean_bitmap)) {
@@ -1544,6 +1577,7 @@ void *pisa_alloc_coherent(struct page **pagep, struct device *dev,
 		spin_lock_irqsave(&pa->lock, flags);
 		meta->pa = pa;
 		meta->prot = pa->prot;
+		WRITE_ONCE(meta->alloc_jiffies, jiffies);
 		WRITE_ONCE(meta->flags, meta->flags | PISA_ACTIVE);
 		pa->stats.page_alloc_cnt++;
 		page = pisa_take_contig(meta, nblocks, align_mask);
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index fe1bff0bba322..4d04bb191ecea 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -74,6 +74,7 @@ enum {
  * @list:	Node in @pa lists or per-node reservoir (pisa_node.pages)
  * @llnode:	Node in lockless pisa_free_list for async release to the buddy allocator
  * @rcu:	RCU head used to defer release to the buddy allocator
+ * @alloc_jiffies: Timestamp (jiffies) when the page entered or re-entered use
  * @clean_bitmap: Bitmap of zeroed available block indices
  * @dirty_bitmap: Bitmap of dirty available block indices
  */
@@ -94,6 +95,7 @@ struct pisa_meta {
 		struct llist_node llnode;
 		struct rcu_head rcu;
 	};
+	unsigned long alloc_jiffies;
 
 	DECLARE_BITMAP(clean_bitmap, PISA_MAX_BLOCKS) ____cacheline_aligned;
 	DECLARE_BITMAP(dirty_bitmap, PISA_MAX_BLOCKS) ____cacheline_aligned;
-- 
2.56.0.542.g3ef89b7020-goog

