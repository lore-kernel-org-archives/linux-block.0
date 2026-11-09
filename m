Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248764;
	b=WaMjpvU5eWtaJ6VADU/9QnPaslvVwWjQ9NKKARdKTX8BKLeXUDfZ1wFEClpgCjnjbIpw
	 hufzdxDzxiQtOMmmtRan4WijWZYSX1OMhFRhT7JhK36itLuYboMPVJtOQOtWZV0t6yaKb
	 xf/3nmWASquCeSG7O5jIppEExfzgv8nILCqaeApvz3ifu7bfXInxON6JyLyheDx54BUC6
	 VYuhb2JU9SxGKE5IC/LOFBtGDNlft9gnDAqX0YsG4L5BO3QBBrxvOF5HcLpoqbAtCbjss
	 qANc1BnV40oO0+Or65SnXaPmuXtZ6Jsa099GFSBWplCpH/vldN6tNMZnrdRvyokXh9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8N6NkVFw+HBxOfX5BZQ4CIO14RofA3PAV68cRFz4hoo=;
	b=ms1G0WJ1rHHlSIx7+SDyCDQhi6RlYmZj3jl8NUYxKDsi57pzkfyboj8PVF9NJZPni9h4
	 P/cHt995g1gijmBlqeKbjoMMBgmSMzQKSEaIksvVdOGLWFoHW0z83LVrvJnsPDgV5LtE+
	 pgR4kA/Jwf+iwLxpyxzHu70joPjkdSIsgnMP3kj1cpwKxWcDMsJAaQYp4kcPOIPNtAdEn
	 ZFFXInNgv7yFd8iqVXeWKiZuLpZgXxsYC7UOtO/etVrlfL3bc1J5uAi+X9Kltii21XUVg
	 DGRgv4hONhX5PrUKvT+8N5Vb2nBBqC2knPggMUkpA8Nz9eOompoPLf90ONLE0ErpJXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lQR3fa+y;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11E60700B1
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C11E60700B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lQR3fa+y
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a125f5b317so1280784a12.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248761; x=1794853561; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8N6NkVFw+HBxOfX5BZQ4CIO14RofA3PAV68cRFz4hoo=;
        b=lQR3fa+yi0S2E7TItH0/tZdkSIyIg2Iubep908UPCKUQ31nQQvXeQUrcwcsgDJFSN2
         fLyqCiRiPa4RBUxkRXzFsHL3M48L6fQrN/F+ctcbKjIFA7aAxjdKIO4ZPEnVWkW2EJPb
         xgZ3F9mUstmN1zNn9EeXeeIUdSoi0nkbN2ENQeDv76rzMFjBBBj5CVHjf13ND5JJXY4R
         RBqRs5czgnxkL9gtZ2zC49k2GNKJYwt6EsWZk6nyKqVyj6LClVRtxupdIMH3rRLbff9k
         zkT+1ag8B7Wv0zQZ3F2fAu1zn0Pm6o8CaGkTEau6LAVkHv6TMdCNScUBrJqJoNaqAYop
         6L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248761; x=1794853561;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8N6NkVFw+HBxOfX5BZQ4CIO14RofA3PAV68cRFz4hoo=;
        b=sj5qU6Lv9G9C0Oho2hKWGiZjF39KLiLAL9nPsaaV8DR9EYprpI5E+CSO7cCiTTgIfx
         169XltQagA/tf/R71uJx3sluRkVyxH2FtYu3rBZGGIIWEPzvOA83xpofIU7zaOJpcvCC
         kRlBLKrK2iqlxk++KAJK7iRB0b0UvwD2Lcps6mG3BaFjK42mubTCHvn53beqnlB1SY/5
         EYNcj0mn9HUQlq0TDcCEyEPdXBHFG2ISSjc1aCRKg8KDZ2JguUmMAEro4NFPdOK/qBmt
         NDVh5BSNTmcmS9wSppRtFb1ZAym6/ubrFFRCmnfaa+4WpNRReA1rNdffYwh8se6k36tg
         U9tg==
X-Forwarded-Encrypted: i=1; AL+hErESGDD+5Wkzfu0lU5zv9r8GN+1LNCjphuEAjHPcMDnHPP0gbydHb5WMKPbGZdlVlbfA9P9zQhg2I7Iu8g==@vger.kernel.org
X-Gm-Message-State: APuU4Z85J81nR98Q7qqfSt3Nv0usA4KUmppGDEcVfwd7A7meeisjqyb+
	qrjy/O2aj3H/+hp9A4RJYTUqLbnSehtHwSyRg9KvgGtIJn4kJ9LSqO9hGFeabsV8fCmbiks2C7J
	o0kK7vQ==
X-Received: from edcns3-n2.prod.google.com ([2002:a05:6402:c6c3:20b0:6b1:d313:c75f])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:378c:b0:6b6:f22a:8de9
 with SMTP id 4fb4d7f45d1cf-6b756b02b97mr325016a12.40.1794248760657; Mon, 09
 Nov 2026 10:26:00 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:31 +0000
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
Message-ID: <20261109182533.3594984-24-lrizzo@google.com>
Subject: [RFC PATCH v2 23/25] block, mm, iommu/dma: Support PISA for disk I/O
 and scrub migration
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

Extend PISA user/page-cache allocators to support O_DIRECT and buffered
disk I/O, gated per block/controller device through pisa_rx_bufs (read)
and pisa_tx_bufs (write):

- Split per-node user_pa into DMA_BIDIRECTIONAL, DMA_TO_DEVICE, and
  DMA_FROM_DEVICE allocators, promoting pages to DMA_BIDIRECTIONAL if
  later accessed in the opposite direction.
- Upgrade pinned O_DIRECT user pages in bio_iov_iter_get_pages(), and
  allocate/promote order-0 page-cache folios for buffered I/O when PISA
  is enabled on the target block device.
- Bypass IOVA allocation in dma_iova_try_alloc() for PISA pages so
  blk-mq uses the pre-mapped 2MB window.
- Add pisa.scrub_migrate to compact or demote lingering folios off old,
  sparse user_pa 2MB pages.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 block/bio.c                |  46 ++++
 drivers/iommu/dma-iommu.c  |   2 +-
 drivers/iommu/pisa-alloc.c |  36 ++--
 drivers/iommu/pisa-node.c  |   3 +-
 drivers/iommu/pisa-priv.h  |  21 +-
 drivers/iommu/pisa-user.c  | 417 ++++++++++++++++++++++++++++++++-----
 include/linux/pisa.h       | 100 ++++++++-
 mm/filemap.c               |  15 +-
 mm/page-writeback.c        |   8 +
 mm/readahead.c             |   5 +-
 net/core/datagram.c        |   3 +-
 11 files changed, 581 insertions(+), 75 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b0fcc69de6535..5b43430b5280c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -6,6 +6,7 @@
 #include <linux/swap.h>
 #include <linux/bio-integrity.h>
 #include <linux/blkdev.h>
+#include <linux/pisa.h>
 #include <linux/uio.h>
 #include <linux/iocontext.h>
 #include <linux/slab.h>
@@ -1316,6 +1317,43 @@ static inline bool bio_iov_bvec_aligned(const struct bio *bio,
 }
 #endif
 
+/*
+ * Migrate pinned order-0 user pages in @bio into PISA memory when enabled on
+ * @bio->bi_bdev; returns true if pages were released and the caller must retry.
+ */
+static bool bio_upgrade_pages_to_pisa(struct bio *bio)
+{
+	enum dma_data_direction dir;
+	struct page *pages[64];
+	unsigned int i, nr = 0;
+
+	if (!IS_ENABLED(CONFIG_PISA) || !bio_flagged(bio, BIO_PAGE_PINNED))
+		return false;
+	dir = op_is_write(bio_op(bio)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	if (!is_bdev_pisa_enabled(bio->bi_bdev, dir))
+		return false;
+
+	for (i = 0; i < bio->bi_vcnt && nr < ARRAY_SIZE(pages); i++) {
+		struct page *page = bio->bi_io_vec[i].bv_page;
+
+		if (bvec_nr_pages(&bio->bi_io_vec[i]) == 1 && !is_pisa_page(page)) {
+			get_page(page);
+			pages[nr++] = page;
+		}
+	}
+	if (!nr)
+		return false;
+
+	bio_release_pages(bio, false);
+	bio->bi_vcnt = 0;
+	bio->bi_iter.bi_size = 0;
+	if (!pisa_upgrade_user_pages(pages, nr, dir, false)) {
+		while (nr)
+			put_page(pages[--nr]);
+	}
+	return true;
+}
+
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1346,6 +1384,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 {
 	iov_iter_extraction_t flags = 0;
 	struct iov_iter saved_iter;
+	bool tried_pisa = false;
 	int ret;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
@@ -1367,6 +1406,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		flags |= ITER_ALLOW_P2PDMA;
 
+retry:
 	saved_iter = *iter;
 	do {
 		ssize_t size;
@@ -1386,6 +1426,12 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		bio->bi_iter.bi_size += size;
 	} while (iov_iter_count(iter) && !bio_full(bio, 0));
 
+	if (!tried_pisa && bio_upgrade_pages_to_pisa(bio)) {
+		tried_pisa = true;
+		*iter = saved_iter;
+		goto retry;
+	}
+
 	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
 		bio->bi_opf |= REQ_NOMERGE;
 	ret = bio_iov_iter_align_down(bio, iter, len_align_mask);
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a0c5ddab7a8b6..acedfe04bde26 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1868,7 +1868,7 @@ bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
 	dma_addr_t addr;
 
 	memset(state, 0, sizeof(*state));
-	if (!use_dma_iommu(dev))
+	if (!use_dma_iommu(dev) || is_pisa_phys(phys))
 		return false;
 
 	domain = iommu_get_dma_domain(dev);
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 5054a96f0f4e9..cedb1a62d20e2 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -75,11 +75,10 @@ static unsigned int pisa_compact __read_mostly;
 module_param_named(compact, pisa_compact, uint, 0644);
 
 /* Stop recycling partial pages older than @pisa_old_ms when wasted blocks > @pisa_wasted_pct%. */
-#define PISA_OLD_MS_MAX		100000U
-static unsigned int pisa_wasted_pct __read_mostly;
+unsigned int pisa_wasted_pct __read_mostly;
 module_param_named(wasted_pct, pisa_wasted_pct, uint, 0644);
 
-static unsigned int pisa_old_ms __read_mostly;
+unsigned int pisa_old_ms __read_mostly;
 module_param_named(old_ms, pisa_old_ms, uint, 0644);
 
 /* Max pages zeroed in each scrubber run (0 = disabled, capped at PISA_SCRUB_MAX_LIMIT). */
@@ -98,8 +97,6 @@ struct pisa_node pisa_nodes[MAX_NUMNODES] = {
 	},
 };
 
-static void pisa_schedule_reclaim(void);
-
 static int pisa_scrub_set(const char *val, const struct kernel_param *kp)
 {
 	int ret = param_set_uint(val, kp);
@@ -229,18 +226,6 @@ void pisa_release_page(struct pisa_meta *meta)
 	call_rcu(&meta->rcu, pisa_release_page_rcu);
 }
 
-/* Value of @meta->on_list. 0 is "not on an allocator list", as for a zeroed @meta. */
-enum pisa_meta_list {
-	PISA_LIST_NONE,
-	PISA_LIST_FULL,
-	PISA_LIST_IDLE_CLEAN,		/* head of @idle */
-	PISA_LIST_IDLE_DIRTY,		/* tail of @idle */
-	PISA_LIST_PARTIAL_CLEAN_DENSE,	/* head of @partial */
-	PISA_LIST_PARTIAL_CLEAN_SPARSE,	/* tail of @partial */
-	PISA_LIST_PARTIAL_DIRTY_DENSE,	/* head of @partial_dirty */
-	PISA_LIST_PARTIAL_DIRTY_SPARSE,	/* tail of @partial_dirty */
-};
-
 static void pisa_reclaim_work_fn(struct work_struct *work);
 
 /* Asynchronous reclaim worker for pisa_free_list and expired idle pages. */
@@ -285,7 +270,7 @@ static void pisa_reclaim_work_fn(struct work_struct *work)
 		queue_delayed_work(pisa_wq ?: system_wq, &pisa_reclaim_work, next_delay);
 }
 
-static void pisa_schedule_reclaim(void)
+void pisa_schedule_reclaim(void)
 {
 	struct workqueue_struct *wq = pisa_wq ?: system_wq;
 	unsigned int idle_ms = READ_ONCE(pisa_idle_ms);
@@ -301,7 +286,7 @@ static void pisa_schedule_reclaim(void)
  * become available (avail == bpp), either queues @meta to @pisa_free_list (and
  * returns true so the caller schedules reclaim) or moves it to @pa->idle.
  */
-static bool pisa_place_meta(struct pisa_meta *meta)
+bool pisa_place_meta(struct pisa_meta *meta)
 {
 	struct pisa_alloc *pa = meta->pa;
 	unsigned int avail = pisa_meta_avail(meta), bpp = PISA_BLOCKS(pa->order);
@@ -505,6 +490,9 @@ bool pisa_scrub_node(int nid)
 	struct pisa_alloc *pa;
 	bool more = false;
 
+	if (!budget)
+		goto migrate;
+
 	read_lock(&pisa_allocs_lock);
 	list_for_each_entry(pa, &pisa_allocs, node) {
 		if (pa->nid != nid || !READ_ONCE(pa->scrub_demand))
@@ -526,6 +514,16 @@ bool pisa_scrub_node(int nid)
 	}
 	read_unlock(&pisa_allocs_lock);
 
+migrate:
+	if (READ_ONCE(pisa_scrub_migrate)) {
+		unsigned long rem = !budget ? 512 : (budget > done ? budget - done : 0);
+
+		if (rem && local_clock() < deadline)
+			more |= pisa_user_scrub_node(nid, rem, deadline);
+		else
+			more = true;
+	}
+
 	return more;
 }
 
diff --git a/drivers/iommu/pisa-node.c b/drivers/iommu/pisa-node.c
index cd29c146c281e..7469674133620 100644
--- a/drivers/iommu/pisa-node.c
+++ b/drivers/iommu/pisa-node.c
@@ -184,7 +184,8 @@ void pisa_schedule_scrub(int nid)
 {
 	struct pisa_node *node;
 
-	if (!READ_ONCE(pisa_scrub_max) || nid == NUMA_NO_NODE)
+	if ((!READ_ONCE(pisa_scrub_max) && !READ_ONCE(pisa_scrub_migrate)) ||
+	    nid == NUMA_NO_NODE)
 		return;
 
 	node = &pisa_nodes[nid];
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index 4d04bb191ecea..1ecfebbaeb381 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -61,6 +61,18 @@ enum {
  * - pisa_srcu: protects pisa_domains[] readers against pisa_domain_release().
  */
 
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
 /**
  * struct pisa_meta - Metadata for a single PISA page in @pisa_meta_array
  * @flags:	PISA_ACTIVE / PISA_QUARANTINED / PISA_DECRYPTED
@@ -187,7 +199,7 @@ static inline long pisa_alloc_held_pages(const struct pisa_alloc *pa)
 struct pisa_node {
 	unsigned long		next_alloc;	/* atomic alloc backoff jiffies */
 	struct pisa_alloc	*pa[2][PISA_ORDER + 1]; /* [0]=RW, [1]=RO by order */
-	struct pisa_alloc	*user_pa;	/* user page migration pa */
+	struct pisa_alloc	*user_pa[3];	/* user/page-cache allocators by dir */
 
 	spinlock_t		lock;		/* protects @pages and @nr_pages */
 	struct list_head	pages;		/* reservoir */
@@ -243,6 +255,8 @@ static inline void pisa_alloc_backoff(int nid, bool can_block)
 		WRITE_ONCE(pisa_nodes[nid].next_alloc, jiffies + DIV_ROUND_UP(HZ, 100));
 }
 bool pisa_want_decrypt(void);
+bool pisa_place_meta(struct pisa_meta *meta);
+void pisa_schedule_reclaim(void);
 int pisa_page_prepare(struct page *page, struct pisa_meta *meta);
 int pisa_page_unprepare(struct pisa_meta *meta);
 
@@ -266,11 +280,16 @@ static inline struct page *pisa_alloc(struct pisa_alloc *pa, gfp_t gfp)
 	return page;
 }
 
+#define PISA_OLD_MS_MAX		100000U
+extern unsigned int pisa_wasted_pct;
+extern unsigned int pisa_old_ms;
+extern unsigned int pisa_scrub_migrate;
 unsigned long pisa_shrink_list(spinlock_t *lock, struct list_head *list,
 			       unsigned int *nr, struct list_head *release_list,
 			       unsigned long nr_to_scan);
 extern unsigned int pisa_scrub_max;
 bool pisa_scrub_node(int nid);
+bool pisa_user_scrub_node(int nid, unsigned long budget, u64 deadline);
 
 /* pisa-node.c: per-NUMA-node PISA page reservoir and work item */
 extern unsigned int pisa_reservoir_max;
diff --git a/drivers/iommu/pisa-user.c b/drivers/iommu/pisa-user.c
index a16909d429aca..7dca3bf066f0d 100644
--- a/drivers/iommu/pisa-user.c
+++ b/drivers/iommu/pisa-user.c
@@ -4,15 +4,23 @@
  * per-node PISA allocators so zero-copy TX and block I/O use 2MB IOMMU mappings.
  * Disabled on CoCo guests (user PTEs map pages encrypted).
  */
+#include <linux/blkdev.h>
 #include <linux/cc_platform.h>
+#include <linux/device.h>
 #include <linux/pisa.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/migrate.h>
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/nodemask.h>
+#include <linux/pagemap.h>
 #include <linux/pagewalk.h>
+#include <linux/folio_batch.h>
+#include <linux/sched/clock.h>
 #include <linux/swap.h>
 
 #include "pisa-priv.h"
@@ -55,6 +63,27 @@ static const struct kernel_param_ops pisa_user_max_ops = {
 };
 module_param_cb(user_max_4K_pages, &pisa_user_max_ops, &pisa_user_max_4k_pages, 0644);
 
+/*
+ * Scrub-time migration of old sparse user_pa PISA pages when waste exceeds
+ * pisa.wasted_pct (0 = off, 1 = compact in allocator, 2 = demote to the buddy allocator).
+ */
+unsigned int pisa_scrub_migrate __read_mostly;
+
+static int pisa_scrub_migrate_set(const char *val, const struct kernel_param *kp)
+{
+	int ret = param_set_uint(val, kp);
+
+	if (!ret && pisa_scrub_migrate && static_branch_unlikely(&pisa_key))
+		pisa_schedule_scrub_all();
+	return ret;
+}
+
+static const struct kernel_param_ops pisa_scrub_migrate_ops = {
+	.set = pisa_scrub_migrate_set,
+	.get = param_get_uint,
+};
+module_param_cb(scrub_migrate, &pisa_scrub_migrate_ops, &pisa_scrub_migrate, 0644);
+
 /* True once per-node user allocators have been allocated, serialized by pisa_user_lock. */
 static bool pisa_user_ready __read_mostly;
 static DEFINE_MUTEX(pisa_user_lock);
@@ -62,6 +91,7 @@ static DEFINE_MUTEX(pisa_user_lock);
 /* Lazily create per-node user allocators on first use (process context). */
 static bool pisa_user_init(void)
 {
+	static const char * const dir_names[3] = { "bi", "tx", "rx" };
 	int nid;
 
 	if (!READ_ONCE(pisa_user_max_4k_pages) || cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
@@ -73,10 +103,20 @@ static bool pisa_user_init(void)
 		return false;
 	mutex_lock(&pisa_user_lock);
 	for_each_node_state(nid, N_MEMORY) {
-		if (!pisa_nodes[nid].user_pa)
-			pisa_nodes[nid].user_pa = pisa_create(nid, 0, DMA_TO_DEVICE);
-		if (!pisa_nodes[nid].user_pa)
-			goto out;	/* retried on the next call */
+		unsigned int dir;
+
+		for (dir = 0; dir < ARRAY_SIZE(pisa_nodes[nid].user_pa); dir++) {
+			struct pisa_alloc *pa = pisa_nodes[nid].user_pa[dir];
+
+			if (!pa) {
+				pa = pisa_create(nid, 0, dir);
+				if (!pa)
+					goto out;	/* retried on the next call */
+				pisa_set_name(pa, "user_%s_n%d", dir_names[dir], nid);
+				pisa_enable_pcp(pa);
+				pisa_nodes[nid].user_pa[dir] = pa;
+			}
+		}
 	}
 	/* Publish pisa_nodes[].user_pa to lockless readers. */
 	smp_store_release(&pisa_user_ready, true);
@@ -102,9 +142,13 @@ static unsigned long pisa_user_in_use(void)
 	int nid;
 
 	for_each_node_state(nid, N_MEMORY) {
-		const struct pisa_alloc *pa = pisa_nodes[nid].user_pa;
+		unsigned int dir;
 
-		used += pa ? READ_ONCE(pa->blocks_in_use) : 0;
+		for (dir = 0; dir < ARRAY_SIZE(pisa_nodes[nid].user_pa); dir++) {
+			const struct pisa_alloc *pa = pisa_nodes[nid].user_pa[dir];
+
+			used += pa ? READ_ONCE(pa->blocks_in_use) : 0;
+		}
 	}
 	return used;
 }
@@ -115,14 +159,43 @@ static long pisa_user_budget(void)
 	return (long)(READ_ONCE(pisa_user_max_4k_pages) - pisa_user_in_use());
 }
 
-/* Is @folio worth moving into (@to_pisa) or out of PISA memory? */
-static bool pisa_user_want(struct folio *folio, bool to_pisa)
+/*
+ * Return true if @folio should be migrated into (@to_pisa) or out of PISA
+ * memory, promoting existing PISA folios to DMA_BIDIRECTIONAL when needed.
+ */
+static bool pisa_user_want_dir(struct folio *folio, bool to_pisa,
+			       enum dma_data_direction dir, bool allow_file)
 {
-	if (!folio_test_anon(folio) || folio_is_zone_device(folio) ||
-	    folio_test_ksm(folio) || folio_test_large(folio) ||
-	    folio_maybe_mapped_shared(folio))
+	unsigned long pfn = folio_pfn(folio);
+
+	if (is_zero_folio(folio) || folio_is_zone_device(folio) ||
+	    folio_test_ksm(folio) || folio_test_large(folio))
 		return false;
-	return is_pisa_pfn(folio_pfn(folio)) != to_pisa;
+	if (folio_test_anon(folio)) {
+		if (folio_maybe_mapped_shared(folio))
+			return false;
+	} else if (!allow_file || !folio_mapping(folio) ||
+		   folio_test_locked(folio) || folio_test_writeback(folio)) {
+		return false;
+	}
+
+	if (!to_pisa)
+		return is_pisa_pfn(pfn);
+	if (!is_pisa_pfn(pfn))
+		return true;
+
+	if (dir == DMA_TO_DEVICE || dir == DMA_FROM_DEVICE) {
+		int need = (dir == DMA_FROM_DEVICE) ? IOMMU_WRITE : IOMMU_READ;
+		const struct pisa_meta *meta;
+		bool promote;
+
+		rcu_read_lock();
+		meta = is_pisa_pfn(pfn) ? pisa_meta_of_pfn(pfn) : NULL;
+		promote = meta && (meta->prot & need) != need;
+		rcu_read_unlock();
+		return promote;
+	}
+	return false;
 }
 
 /* Return true if @folio has references beyond its mappings, swap cache, and @extra. */
@@ -132,20 +205,26 @@ static bool pisa_user_busy(struct folio *folio, int extra)
 }
 
 struct pisa_user_mtc {
-	gfp_t	gfp;
-	long	budget;
+	gfp_t			gfp;
+	long			budget;
+	enum dma_data_direction	dir;
+	bool			same_alloc;
 };
 
 /* new_folio_t for migration into PISA memory. */
 static struct folio *pisa_user_new_folio(struct folio *src, unsigned long private)
 {
 	struct pisa_user_mtc *mtc = (void *)private;
+	bool already_pisa = is_pisa_pfn(folio_pfn(src));
+	enum dma_data_direction dir = mtc->dir;
 	int nid = folio_nid(src);
 	struct page *page;
 
-	if (mtc->budget <= 0)
+	if (!already_pisa && mtc->budget <= 0)
 		return NULL;
-	page = pisa_alloc(pisa_nodes[nid].user_pa, mtc->gfp);
+	if (already_pisa && !mtc->same_alloc)
+		dir = DMA_BIDIRECTIONAL;
+	page = pisa_alloc(pisa_nodes[nid].user_pa[dir], mtc->gfp);
 	if (!page)
 		return NULL;
 	if (pisa_meta_of_pfn(page_to_pfn(page))->flags & PISA_DECRYPTED) {
@@ -153,7 +232,8 @@ static struct folio *pisa_user_new_folio(struct folio *src, unsigned long privat
 		mtc->budget = 0;
 		return NULL;
 	}
-	mtc->budget--;
+	if (!already_pisa)
+		mtc->budget--;
 	return page_folio(page);
 }
 
@@ -164,78 +244,319 @@ static struct folio *pisa_user_old_folio(struct folio *src, unsigned long privat
 }
 
 /* Migrate the isolated folios on @list; failures are put back. */
-static void pisa_user_migrate(struct list_head *list, bool to_pisa, gfp_t gfp)
+static unsigned int pisa_user_migrate_dir(struct list_head *list, bool to_pisa,
+					  enum dma_data_direction dir,
+					  bool same_alloc, gfp_t gfp)
 {
-	struct pisa_user_mtc mtc = { .gfp = gfp, .budget = LONG_MAX };
+	struct pisa_user_mtc mtc = {
+		.gfp = gfp,
+		.budget = LONG_MAX,
+		.dir = dir,
+		.same_alloc = same_alloc,
+	};
 	enum migrate_mode mode = MIGRATE_SYNC;
+	unsigned int done = 0;
 
 	if (list_empty(list))
-		return;
+		return 0;
 	if (to_pisa) {
 		mtc.budget = pisa_user_budget();
 		if (!gfpflags_allow_blocking(gfp))
 			mode = MIGRATE_ASYNC;
 	}
 	if (migrate_pages(list, to_pisa ? pisa_user_new_folio : pisa_user_old_folio,
-			  NULL, (unsigned long)&mtc, mode, MR_SYSCALL, NULL))
+			  NULL, (unsigned long)&mtc, mode, MR_SYSCALL, &done))
 		putback_movable_pages(list);
+	return done;
 }
 
 /**
- * pisa_upgrade_user_pages - Try to move user pages about to be sent into PISA
- * @pages: Pages from iov_iter_get_pages2(), one reference each
+ * pisa_upgrade_user_pages - Try to move user pages into PISA for @dir
+ * @pages: Pages from iov_iter_get_pages2() or iov_iter_extract_pages()
  * @nr: Number of entries in @pages
+ * @dir: I/O direction (DMA_TO_DEVICE or DMA_FROM_DEVICE)
+ * @pinned: true if @pages are FOLL_PIN-pinned, false if refcounted (+1)
  *
- * Best effort, process context. Pages that cannot be moved (e.g. still
- * referenced by an in-flight skb, or in a large folio) are skipped; for TCP
- * with pisa_tx_bufs enabled the caller copies them instead.
- *
- * Return: false if nothing was attempted and the references are untouched;
- * true if all references were dropped and the caller must look the pages up
- * again.
+ * Return: true if references/pins were dropped and the caller must re-lookup.
  */
-bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr)
+bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr,
+			     enum dma_data_direction dir, bool pinned)
 {
+	int extra = pinned ? GUP_PIN_COUNTING_BIAS : 1;
 	bool drained = false;
 	LIST_HEAD(list);
-	unsigned int i, want = 0;
+	unsigned int i, want = 0, need_budget = 0;
 
 	if (!pisa_user_init())
 		return false;
-	/* Common case: all pages already in PISA, no budget check needed. */
-	for (i = 0; i < nr; i++)
-		want += pisa_user_want(page_folio(pages[i]), true);
+	/* Common case: all pages already in PISA with matching prot. */
+	for (i = 0; i < nr; i++) {
+		struct folio *folio = page_folio(pages[i]);
+
+		if (pisa_user_want_dir(folio, true, dir, false)) {
+			want++;
+			need_budget += !is_pisa_pfn(folio_pfn(folio));
+		}
+	}
 	if (!want)
 		return false;
-	if (pisa_user_budget() <= 0)
+	if (need_budget && pisa_user_budget() <= 0)
 		return false;
 	for (i = 0; i < nr; i++) {
 		struct folio *folio = page_folio(pages[i]);
 
-		if (!pisa_user_want(folio, true))
+		if (!pisa_user_want_dir(folio, true, dir, false))
 			continue;
 		/* A freshly faulted page may still sit in a per-CPU LRU batch. */
 		if (!drained && !folio_test_lru(folio)) {
 			lru_add_drain();
 			drained = true;
 		}
-		/* The reference from iov_iter_get_pages2() is expected. */
-		if (pisa_user_busy(folio, 1))
+		if (pisa_user_busy(folio, extra))
 			continue;
 		isolate_folio_to_list(folio, &list);
 	}
 	if (list_empty(&list))
 		return false;
-	/* Migration fails on pages with references it does not expect. */
-	for (i = 0; i < nr; i++)
-		put_page(pages[i]);
-	pisa_user_migrate(&list, true,
-			  GFP_NOWAIT | __GFP_HARDWALL | __GFP_NOWARN);
+	/* Migration fails on pages with references or pins it does not expect. */
+	if (pinned) {
+		unpin_user_pages(pages, nr);
+	} else {
+		for (i = 0; i < nr; i++)
+			put_page(pages[i]);
+	}
+	pisa_user_migrate_dir(&list, true, dir, false,
+			      GFP_NOWAIT | __GFP_HARDWALL | __GFP_NOWARN);
+	return true;
+}
+
+/**
+ * __pisa_filemap_alloc - Allocate an order-0 page-cache folio from a PISA user allocator
+ * @mapping: Page-cache address_space
+ * @gfp: GFP flags
+ * @is_write: True when allocating on the buffered write path
+ *
+ * Return: Newly allocated order-0 folio, or NULL on failure.
+ */
+struct folio *__pisa_filemap_alloc(const struct address_space *mapping,
+				   gfp_t gfp, bool is_write)
+{
+	enum dma_data_direction dir = is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	struct page *page;
+	int nid;
+
+	if (!__pisa_mapping_enabled(mapping, dir))
+		return NULL;
+	if (is_write && __pisa_mapping_enabled(mapping, DMA_FROM_DEVICE))
+		dir = DMA_BIDIRECTIONAL;
+	/* Pairs with smp_store_release() in pisa_user_init(). */
+	if (!smp_load_acquire(&pisa_user_ready) &&
+	    ((gfp & GFP_KERNEL) != GFP_KERNEL || !pisa_user_init()))
+		return NULL;
+	if (pisa_user_budget() <= 0)
+		return NULL;
+	nid = pisa_sanitize_nid(numa_node_id());
+	page = pisa_alloc(pisa_nodes[nid].user_pa[dir], gfp);
+	if (!page)
+		return NULL;
+	if (pisa_meta_of_pfn(page_to_pfn(page))->flags & PISA_DECRYPTED) {
+		put_page(page);
+		return NULL;
+	}
+	return page_folio(page);
+}
+
+/**
+ * pisa_folio_upgrade - Migrate an unlocked order-0 folio to a PISA allocator page
+ * @folio: Folio to migrate (caller holds 1 ref, dropped only when returning true)
+ * @dir: Required DMA direction (DMA_TO_DEVICE or DMA_FROM_DEVICE)
+ * @fbatch: Optional folio_batch holding @folio's reference to release before migration
+ *
+ * Return: true if @folio was isolated and caller's reference was dropped
+ *         (caller must re-lookup in mapping); false if @folio is untouched.
+ */
+bool pisa_folio_upgrade(struct folio *folio, enum dma_data_direction dir,
+			struct folio_batch *fbatch)
+{
+	LIST_HEAD(list);
+
+	if (!pisa_user_init() ||
+	    !pisa_user_want_dir(folio, true, dir, true) ||
+	    (!is_pisa_pfn(folio_pfn(folio)) && pisa_user_budget() <= 0))
+		return false;
+	if (!folio_test_lru(folio))
+		lru_add_drain();
+	if (pisa_user_busy(folio, 1) || !isolate_folio_to_list(folio, &list))
+		return false;
+	/* Drop caller's reference so migrate_pages() sees only expected refs. */
+	if (fbatch)
+		folio_batch_release(fbatch);
+	else
+		folio_put(folio);
+	pisa_user_migrate_dir(&list, true, dir, false,
+			      GFP_NOWAIT | __GFP_HARDWALL | __GFP_NOWARN);
 	return true;
 }
 
+bool __pisa_bdev_enabled(struct block_device *bdev, enum dma_data_direction dir)
+{
+	struct device *dev;
+
+	if (!bdev || !bdev->bd_disk)
+		return false;
+	for (dev = disk_to_dev(bdev->bd_disk); dev; dev = dev->parent) {
+		if (dir == DMA_FROM_DEVICE ?
+		    READ_ONCE(dev->pisa_rx_bufs) :
+		    READ_ONCE(dev->pisa_tx_bufs))
+			return true;
+	}
+	return false;
+}
+
+bool __pisa_mapping_enabled(const struct address_space *mapping, enum dma_data_direction dir)
+{
+	struct super_block *sb;
+
+	if (!mapping || !mapping->host || !mapping->host->i_sb)
+		return false;
+	sb = mapping->host->i_sb;
+	return __pisa_bdev_enabled(sb_is_blkdev_sb(sb) ?
+				   I_BDEV(mapping->host) : sb->s_bdev, dir);
+}
+
 #define PISA_USER_BATCH	512
 
+static unsigned long pisa_user_scrub_alloc(struct pisa_alloc *pa,
+					  enum dma_data_direction dir,
+					  unsigned int mode,
+					  unsigned long budget)
+{
+	unsigned int wasted_pct = READ_ONCE(pisa_wasted_pct);
+	unsigned int old_ms = READ_ONCE(pisa_old_ms);
+	unsigned long bpp = PISA_BLOCKS(0), in_use, free_blocks;
+	unsigned long max_age, base_pfn = 0, flags;
+	DECLARE_BITMAP(inuse_map, PISA_MAX_BLOCKS);
+	struct list_head *lists[] = { &pa->partial_dirty, &pa->partial };
+	struct pisa_meta *meta, *target = NULL;
+	unsigned int i, idx, count = 0;
+	bool should_release = false;
+	unsigned long migrated = 0;
+	LIST_HEAD(list);
+	long held;
+
+	if (!wasted_pct || !old_ms)
+		return 0;
+
+	pisa_pcp_drain(pa);
+
+	held = pisa_alloc_held_pages(pa);
+	in_use = READ_ONCE(pa->blocks_in_use);
+	free_blocks = held > 0 && (unsigned long)held * bpp > in_use ?
+		      (unsigned long)held * bpp - in_use : 0;
+	if (held <= 0 || free_blocks * 100 <= (unsigned long)held * bpp * wasted_pct)
+		return 0;
+
+	max_age = msecs_to_jiffies(min(old_ms, PISA_OLD_MS_MAX));
+
+	spin_lock_irqsave(&pa->lock, flags);
+	for (i = 0; i < ARRAY_SIZE(lists) && !target; i++) {
+		list_for_each_entry_reverse(meta, lists[i], list) {
+			if (mode == 1 && &meta->list == lists[i]->next)
+				break;
+			if (time_after(jiffies, meta->alloc_jiffies + max_age)) {
+				target = meta;
+				break;
+			}
+		}
+	}
+	if (target) {
+		base_pfn = pisa_meta_to_pfn(target);
+		bitmap_or(inuse_map, target->clean_bitmap, target->dirty_bitmap, bpp);
+		bitmap_complement(inuse_map, inuse_map, bpp);
+		WRITE_ONCE(target->on_list, PISA_LIST_FULL);
+		list_move(&target->list, &pa->full);
+	}
+	spin_unlock_irqrestore(&pa->lock, flags);
+
+	if (!target)
+		return 0;
+
+	for_each_set_bit(idx, inuse_map, bpp) {
+		unsigned long pfn = base_pfn + idx;
+		struct folio *folio;
+
+		rcu_read_lock();
+		if (!is_pisa_pfn(pfn)) {
+			rcu_read_unlock();
+			continue;
+		}
+		folio = page_folio(pfn_to_page(pfn));
+		if (!folio_try_get(folio)) {
+			rcu_read_unlock();
+			continue;
+		}
+		if (!is_pisa_pfn(pfn) || folio != page_folio(pfn_to_page(pfn))) {
+			rcu_read_unlock();
+			folio_put(folio);
+			continue;
+		}
+		rcu_read_unlock();
+
+		if (!pisa_user_want_dir(folio, false, dir, true) ||
+		    pisa_user_busy(folio, 1) ||
+		    !isolate_folio_to_list(folio, &list)) {
+			folio_put(folio);
+			continue;
+		}
+		folio_put(folio);
+		if (++count >= min_t(unsigned long, budget, PISA_USER_BATCH))
+			break;
+	}
+
+	if (!list_empty(&list)) {
+		migrated = pisa_user_migrate_dir(&list, mode == 1, dir, true,
+						 GFP_KERNEL | __GFP_NOWARN);
+		pisa_pcp_drain(pa);
+	}
+
+	spin_lock_irqsave(&pa->lock, flags);
+	if (READ_ONCE(target->pa) == pa) {
+		WRITE_ONCE(target->alloc_jiffies, jiffies);
+		should_release = pisa_place_meta(target);
+	}
+	spin_unlock_irqrestore(&pa->lock, flags);
+	if (should_release)
+		pisa_schedule_reclaim();
+
+	return migrated;
+}
+
+bool pisa_user_scrub_node(int nid, unsigned long budget, u64 deadline)
+{
+	unsigned int mode = READ_ONCE(pisa_scrub_migrate);
+	unsigned long done = 0;
+	unsigned int dir;
+
+	/* Pairs with smp_store_release() in pisa_user_init(). */
+	if (!mode || mode > 2 || !smp_load_acquire(&pisa_user_ready))
+		return false;
+
+	for (dir = 0; dir < ARRAY_SIZE(pisa_nodes[nid].user_pa); dir++) {
+		struct pisa_alloc *pa = pisa_nodes[nid].user_pa[dir];
+		unsigned long n;
+
+		if (!pa)
+			continue;
+		while ((n = pisa_user_scrub_alloc(pa, dir, mode, budget - done))) {
+			done += n;
+			if (done >= budget || local_clock() >= deadline)
+				return true;
+			cond_resched();
+		}
+	}
+	return false;
+}
+
 /**
  * pisa_madvise - MADV_PISA / MADV_NOPISA on [@start, @end) of @vma
  * @vma: VMA, with the mmap lock held for reading
@@ -262,17 +583,17 @@ int pisa_madvise(struct vm_area_struct *vma, unsigned long start, unsigned long
 		struct folio *folio = folio_walk_start(&fw, vma, addr, 0);
 
 		if (folio) {
-			if (pisa_user_want(folio, to_pisa) && !pisa_user_busy(folio, 0) &&
-			    isolate_folio_to_list(folio, &list))
+			if (pisa_user_want_dir(folio, to_pisa, DMA_TO_DEVICE, false) &&
+			    !pisa_user_busy(folio, 0) && isolate_folio_to_list(folio, &list))
 				n++;
 			folio_walk_end(&fw, vma);
 		}
 		if (n == PISA_USER_BATCH) {
-			pisa_user_migrate(&list, to_pisa, gfp);
+			pisa_user_migrate_dir(&list, to_pisa, DMA_TO_DEVICE, false, gfp);
 			n = 0;
 		}
 		cond_resched();
 	}
-	pisa_user_migrate(&list, to_pisa, gfp);
+	pisa_user_migrate_dir(&list, to_pisa, DMA_TO_DEVICE, false, gfp);
 	return 0;
 }
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index d11fd3d663dc1..1d9b07370cc75 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -10,9 +10,13 @@
 #include <linux/device.h>
 #include <linux/mm.h>
 #include <linux/numa.h>
+#include <linux/folio_batch.h>
 #include <linux/rcupdate.h>
 
+struct address_space;
+struct block_device;
 struct device;
+struct folio_batch;
 struct iommu_domain;
 
 #ifdef CONFIG_PISA
@@ -134,7 +138,15 @@ static inline void pisa_task_frag_release(struct task_struct *tsk)
 
 /* User pages in PISA blocks, see drivers/iommu/pisa-user.c */
 DECLARE_STATIC_KEY_FALSE(pisa_user_key);
-bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr);
+bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr,
+			     enum dma_data_direction dir, bool pinned);
+struct folio *__pisa_filemap_alloc(const struct address_space *mapping,
+				   gfp_t gfp, bool is_write);
+bool pisa_folio_upgrade(struct folio *folio, enum dma_data_direction dir,
+			struct folio_batch *fbatch);
+bool __pisa_bdev_enabled(struct block_device *bdev, enum dma_data_direction dir);
+bool __pisa_mapping_enabled(const struct address_space *mapping,
+			    enum dma_data_direction dir);
 int pisa_madvise(struct vm_area_struct *vma, unsigned long start,
 		 unsigned long end, bool to_pisa);
 
@@ -144,6 +156,49 @@ static inline bool pisa_user_enabled(void)
 	return static_branch_unlikely(&pisa_user_key);
 }
 
+static inline bool is_bdev_pisa_enabled(struct block_device *bdev,
+					enum dma_data_direction dir)
+{
+	return pisa_user_enabled() && __pisa_bdev_enabled(bdev, dir);
+}
+
+static inline bool pisa_mapping_enabled(const struct address_space *mapping,
+					enum dma_data_direction dir)
+{
+	return pisa_user_enabled() && __pisa_mapping_enabled(mapping, dir);
+}
+
+static inline bool pisa_filemap_upgrade(const struct address_space *mapping,
+					struct folio *folio, bool write_wait)
+{
+	return write_wait && pisa_mapping_enabled(mapping, DMA_TO_DEVICE) &&
+	       pisa_folio_upgrade(folio, DMA_TO_DEVICE, NULL);
+}
+
+static inline bool pisa_writeback_upgrade(const struct address_space *mapping,
+					  struct folio *folio, pgoff_t *index,
+					  struct folio_batch *fbatch)
+{
+	pgoff_t idx;
+
+	if (!pisa_mapping_enabled(mapping, DMA_TO_DEVICE))
+		return false;
+	idx = folio->index;
+	if (!pisa_folio_upgrade(folio, DMA_TO_DEVICE, fbatch))
+		return false;
+	*index = idx;
+	return true;
+}
+
+static inline struct folio *
+pisa_filemap_alloc(const struct address_space *mapping, gfp_t gfp,
+		   unsigned int order, bool is_write)
+{
+	if (order || !pisa_user_enabled())
+		return NULL;
+	return __pisa_filemap_alloc(mapping, gfp, is_write);
+}
+
 #else /* !CONFIG_PISA */
 
 static inline int pisa_meta_init(void)
@@ -230,11 +285,52 @@ static inline bool pisa_user_enabled(void)
 	return false;
 }
 
-static inline bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr)
+static inline bool pisa_upgrade_user_pages(struct page **pages, unsigned int nr,
+					   enum dma_data_direction dir,
+					   bool pinned)
 {
 	return false;
 }
 
+static inline bool pisa_folio_upgrade(struct folio *folio,
+				      enum dma_data_direction dir,
+				      struct folio_batch *fbatch)
+{
+	return false;
+}
+
+static inline bool is_bdev_pisa_enabled(struct block_device *bdev,
+					enum dma_data_direction dir)
+{
+	return false;
+}
+
+static inline bool pisa_mapping_enabled(const struct address_space *mapping,
+					enum dma_data_direction dir)
+{
+	return false;
+}
+
+static inline bool pisa_filemap_upgrade(const struct address_space *mapping,
+					struct folio *folio, bool write_wait)
+{
+	return false;
+}
+
+static inline bool pisa_writeback_upgrade(const struct address_space *mapping,
+					  struct folio *folio, pgoff_t *index,
+					  struct folio_batch *fbatch)
+{
+	return false;
+}
+
+static inline struct folio *
+pisa_filemap_alloc(const struct address_space *mapping, gfp_t gfp,
+		   unsigned int order, bool is_write)
+{
+	return NULL;
+}
+
 static inline int pisa_madvise(struct vm_area_struct *vma, unsigned long start,
 			       unsigned long end, bool to_pisa)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index b04be64a5069f..3860b0c6db4ec 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -15,6 +15,7 @@
 #include <linux/dax.h>
 #include <linux/fs.h>
 #include <linux/sched/signal.h>
+#include <linux/pisa.h>
 #include <linux/uaccess.h>
 #include <linux/capability.h>
 #include <linux/kernel_stat.h>
@@ -1976,6 +1977,7 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 		pgoff_t index, fgf_t fgp_flags, gfp_t gfp, struct mempolicy *policy)
 {
+	bool tried_pisa = false;
 	struct folio *folio;
 
 repeat:
@@ -1985,6 +1987,13 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 	if (!folio)
 		goto no_page;
 
+	if (!tried_pisa) {
+		tried_pisa = true;
+		if (pisa_filemap_upgrade(mapping, folio,
+					 (fgp_flags & (FGP_WRITE | FGP_NOWAIT)) == FGP_WRITE))
+			goto repeat;
+	}
+
 	if (fgp_flags & FGP_LOCK) {
 		if (fgp_flags & FGP_NOWAIT) {
 			if (!folio_trylock(folio)) {
@@ -2044,7 +2053,11 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order, policy);
+			folio = pisa_filemap_alloc(mapping, alloc_gfp, order,
+						   fgp_flags & FGP_WRITE);
+			if (!folio)
+				folio = filemap_alloc_folio(alloc_gfp, order,
+							    policy);
 			if (!folio)
 				continue;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0694ec4098f6d..39cc28f9762c6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -37,6 +37,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/mm_inline.h>
+#include <linux/pisa.h>
 #include <linux/shmem_fs.h>
 #include <trace/events/writeback.h>
 
@@ -2409,6 +2410,7 @@ static pgoff_t wbc_end(struct writeback_control *wbc)
 static struct folio *writeback_get_folio(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	pgoff_t upgraded = ULONG_MAX;
 	struct folio *folio;
 
 retry:
@@ -2423,6 +2425,12 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 			return NULL;
 	}
 
+	if (folio->index != upgraded &&
+	    pisa_writeback_upgrade(mapping, folio, &wbc->index, &wbc->fbatch)) {
+		upgraded = wbc->index;
+		goto retry;
+	}
+
 	folio_lock(folio);
 	if (unlikely(!folio_prepare_writeback(mapping, wbc, folio))) {
 		folio_unlock(folio);
diff --git a/mm/readahead.c b/mm/readahead.c
index 6e5563290287e..f5cfc69dc9909 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -114,6 +114,7 @@
  */
 
 #include <linux/blk_plug.h>
+#include <linux/pisa.h>
 #include <linux/kernel.h>
 #include <linux/dax.h>
 #include <linux/gfp.h>
@@ -197,7 +198,9 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 {
 	struct folio *folio;
 
-	folio = filemap_alloc_folio(gfp_mask, order, NULL);
+	folio = pisa_filemap_alloc(ractl->mapping, gfp_mask, order, false);
+	if (!folio)
+		folio = filemap_alloc_folio(gfp_mask, order, NULL);
 	if (folio && ractl->dropbehind)
 		__folio_set_dropbehind(folio);
 
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 40f20d0faa859..8ba9c39cb05ec 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -651,7 +651,8 @@ static bool pisa_zc_iter(int *ret, struct sk_buff *skb, struct iov_iter *from, s
 		return false;
 
 	/* Move user pages into PISA memory, then look them up again. */
-	if (pisa_upgrade_user_pages(pages, DIV_ROUND_UP(*start + *copied, PAGE_SIZE))) {
+	if (pisa_upgrade_user_pages(pages, DIV_ROUND_UP(*start + *copied, PAGE_SIZE),
+				    DMA_TO_DEVICE, false)) {
 		iov_iter_revert(from, *copied);
 		*copied = iov_iter_get_pages2(from, pages, *length, max_pages, start);
 		if (*copied < 0) {
-- 
2.56.0.542.g3ef89b7020-goog

