Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66508C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 21:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357CF2175B
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 21:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfCSVLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:11:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:41378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfCSVLa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 17:11:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96511B604;
        Tue, 19 Mar 2019 21:11:27 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 1/2] mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)
Date:   Tue, 19 Mar 2019 22:11:07 +0100
Message-Id: <20190319211108.15495-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319211108.15495-1-vbabka@suse.cz>
References: <20190319211108.15495-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In most configurations, kmalloc() happens to return naturally aligned blocks
for power of two sizes. That means some kmalloc() users might implicitly rely
on that alignment, until stuff breaks when the kernel is built with e.g.
CONFIG_SLUB_DEBUG or CONFIG_SLOB, and blocks stop being aligned. Then
developers have to devise workaround such as own kmem caches with specified
alignment, which is not always practical, as recently evidenced in [1].

Ideally we should provide to mm users what they need without difficult
workarounds or own reimplementations, so let's make the kmalloc() alignment
explicit and guaranteed for power-of-two sizes under all configurations.
What this means for the three available allocators?

* SLAB happens to be OK even before the patch. The implicit alignment could be
  compromised with CONFIG_DEBUG_SLAB due to redzoning, however SLAB disables
  red zoning for caches with alignment larger than unsigned long long.
  Practically on at least x86 this includes kmalloc caches as they use cache
  line alignment which is larger than that. Still, this patch ensures alignment
  on all arches and cache sizes.

* SLUB is implicitly OK unless red zoning is enabled through CONFIG_SLUB_DEBUG
  or boot parameter. With this patch, explicit alignment guarantees it with red
  zoning as well. This will result in more memory being wasted, but that should
  be acceptable in a debugging scenario.

* SLOB has no implicit alignment so this patch adds it explicitly for
  kmalloc(). The downside is increased fragmentation, which is hopefully
  acceptable for this relatively rarely used allocator.

[1] https://lore.kernel.org/linux-fsdevel/20190225040904.5557-1-ming.lei@redhat.com/T/#u

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 11 ++++++++++-
 mm/slob.c        | 42 +++++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 03eeb8b7b4b1..e591d5688558 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -968,10 +968,19 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 		unsigned int useroffset, unsigned int usersize)
 {
 	int err;
+	unsigned int align = ARCH_KMALLOC_MINALIGN;
 
 	s->name = name;
 	s->size = s->object_size = size;
-	s->align = calculate_alignment(flags, ARCH_KMALLOC_MINALIGN, size);
+
+	/*
+	 * For power of two sizes, guarantee natural alignment for kmalloc
+	 * caches, regardless of SL*B debugging options.
+	 */
+	if (is_power_of_2(size))
+		align = max(align, size);
+	s->align = calculate_alignment(flags, align, size);
+
 	s->useroffset = useroffset;
 	s->usersize = usersize;
 
diff --git a/mm/slob.c b/mm/slob.c
index 307c2c9feb44..e100fa09493f 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -215,7 +215,8 @@ static void slob_free_pages(void *b, int order)
 /*
  * Allocate a slob block within a given slob_page sp.
  */
-static void *slob_page_alloc(struct page *sp, size_t size, int align)
+static void *slob_page_alloc(struct page *sp, size_t size, int align,
+							int align_offset)
 {
 	slob_t *prev, *cur, *aligned = NULL;
 	int delta = 0, units = SLOB_UNITS(size);
@@ -223,8 +224,17 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align)
 	for (prev = NULL, cur = sp->freelist; ; prev = cur, cur = slob_next(cur)) {
 		slobidx_t avail = slob_units(cur);
 
+		/*
+		 * 'aligned' will hold the address of the slob block so that the
+		 * address 'aligned'+'align_offset' is aligned according to the
+		 * 'align' parameter. This is for kmalloc() which prepends the
+		 * allocated block with its size, so that the block itself is
+		 * aligned when needed.
+		 */
 		if (align) {
-			aligned = (slob_t *)ALIGN((unsigned long)cur, align);
+			aligned = (slob_t *)
+				(ALIGN((unsigned long)cur + align_offset, align)
+				 - align_offset);
 			delta = aligned - cur;
 		}
 		if (avail >= units + delta) { /* room enough? */
@@ -266,7 +276,8 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align)
 /*
  * slob_alloc: entry point into the slob allocator.
  */
-static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
+static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
+							int align_offset)
 {
 	struct page *sp;
 	struct list_head *prev;
@@ -298,7 +309,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 
 		/* Attempt to alloc */
 		prev = sp->lru.prev;
-		b = slob_page_alloc(sp, size, align);
+		b = slob_page_alloc(sp, size, align, align_offset);
 		if (!b)
 			continue;
 
@@ -326,7 +337,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 		INIT_LIST_HEAD(&sp->lru);
 		set_slob(b, SLOB_UNITS(PAGE_SIZE), b + SLOB_UNITS(PAGE_SIZE));
 		set_slob_page_free(sp, slob_list);
-		b = slob_page_alloc(sp, size, align);
+		b = slob_page_alloc(sp, size, align, align_offset);
 		BUG_ON(!b);
 		spin_unlock_irqrestore(&slob_lock, flags);
 	}
@@ -428,7 +439,7 @@ static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 {
 	unsigned int *m;
-	int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 	void *ret;
 
 	gfp &= gfp_allowed_mask;
@@ -436,19 +447,28 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 	fs_reclaim_acquire(gfp);
 	fs_reclaim_release(gfp);
 
-	if (size < PAGE_SIZE - align) {
+	if (size < PAGE_SIZE - minalign) {
+		int align = minalign;
+
+		/*
+		 * For power of two sizes, guarantee natural alignment for
+		 * kmalloc()'d objects.
+		 */
+		if (is_power_of_2(size))
+			align = max(minalign, (int) size);
+
 		if (!size)
 			return ZERO_SIZE_PTR;
 
-		m = slob_alloc(size + align, gfp, align, node);
+		m = slob_alloc(size + minalign, gfp, align, node, minalign);
 
 		if (!m)
 			return NULL;
 		*m = size;
-		ret = (void *)m + align;
+		ret = (void *)m + minalign;
 
 		trace_kmalloc_node(caller, ret,
-				   size, size + align, gfp, node);
+				   size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
 
@@ -544,7 +564,7 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 	fs_reclaim_release(flags);
 
 	if (c->size < PAGE_SIZE) {
-		b = slob_alloc(c->size, flags, c->align, node);
+		b = slob_alloc(c->size, flags, c->align, node, 0);
 		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
 					    SLOB_UNITS(c->size) * SLOB_UNIT,
 					    flags, node);
-- 
2.21.0

