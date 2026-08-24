Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879272D8370
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582087; cv=none; b=MweKUqiV7qfRtp0T3jKjrPzDJwrzW8RweM3lMN11hIGATVg/ROw4y29D74DZxs22gzINzXZtCvdjLSOnVfii39pZr0UvGkPtGoDIOKA7wgGgdPFc9kdce2HnWLyC8OXwv7Ru146u7JkrZN6kV/daVjrpxrwKZWNhFi/FyhgzKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582087; c=relaxed/simple;
	bh=H0gw26kMTBjDSKLBQ5g+X+dYx41gnb8peREE6F6XyqQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fZkztZob+XjoYQRcfQvWZYmSWCPIqaPffAbmtJzsKC359EiecpHLUpXfHxtnqbLh0ZBnShVnEBOy7yeHuyY8Y+PbBSXr6oTr/YthBriTmVgmR64ywaf/ganZdp6e6Lx4uTUyjPwRHWM6o43cIaSdLQUrOOauLsveQut5il3cozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rr8iH3ZU; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rr8iH3ZU"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c67a73eb7so6790027d50.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787582084; x=1788186884; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03W8AdXTU8nvNZrlTGS6pFe21yyktV4JnRO2xEfU4uM=;
        b=Rr8iH3ZUq28RosshzS3vyZrlK7Pzq1o/nuoVy0jor82SLJUwkIdMl4YgoriS52hyxi
         vtgKLbYhwQv26xmHwTnHadaSK+gkieS8ME8xipcT96ukKDc5fL1a3QCXgQsVoJiL0FVg
         g/xzYTiMvly/xn3PHRwqnClD2xKQyn7dNFTW9sZRYUlj/8cKFx4Q8ewyld4x6M0PDSRM
         NRy9f6FHFC4kHDFHimmW5lyVhNGziKUN8qNCwnDdrksaMHdfNfdcB6TEk/cAnahdbFsP
         9mi2qGNoM9FU6xwDv3Psw0zZfINlytuNIgYQTf5ll/GbcJMwALkjG6KPfbWfDp+n+QCN
         omqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582084; x=1788186884;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03W8AdXTU8nvNZrlTGS6pFe21yyktV4JnRO2xEfU4uM=;
        b=KRP/OvwRu2ELdg8oYBo/PbsKGnSiBc5afKomFyVGw29yY66TMdhM4ONNDZLi4LmBYu
         xcmsaB/8tHWGRhEBnexTe6P9/jL92ASAnbcrsoIAhQlchvGqQJ0W0AtU2wSGloJn3ypl
         LXOv1ZsuHowd6mlvpjDYdC3JIBi9oQIXmZBE0zl8rk7YhvBf9KcCW2zfd+dhBJ0yFBAs
         pzQ5aGJlcR+eiXoDnlyXpYvmZ8rTcCQaSJSFoMQ9oC3kdAQ9Ye50CNdEyIEdYFY8CQJf
         KQ3lZwgO7iP0KSCl5b8W7oTnWKQcWLreEFm20XAlyr0+9oy82Fkoike7cGNLFI9pdE2y
         BIZg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0Eio9JIDZ7xMg3WDJ2NLJVgdJsh/WydYAVwVtFiOzz4aFtdfkM/pUPslRAd4dhyw7dfMUtlcL9PDUuQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ncuVX9KL7k+J8BH87vtWnpICFap7OS5NcFMeHvIIA9IkfV2iA9
	Cq8CVj1ypAyyuCfcuiMpPjrX0DoIEwPSKXLJPuV9G6Gx2vsOJjQZzLncr8EaY9ldXQ==
X-Gm-Gg: AR+sD13NO4Iq9MLcn1FkvVbyDeDVDWeN56sN6MoRdeLcFDitfkoFDzWCU0nuGY8sIDH
	bFJKiVRKRN7n6ogN6V2QCqijJdKhyS+b9glodCWSuslaMW/jqJWML7Eu47tDIHmQ0da5JGo5+Tc
	CjJdYI8KrVqsYnalo2l7dHqqkjalbCIsAd1MynQBjdRVYhzTHxxswHNdxhLyhDfcVP/NbFPlGZ3
	4P79zdRYHELfv5lzis/5KDOvH9HDqxnnI7V+bnUTPZyYVF04wXdgR8ag25ojbZ4znS8XzRo5qfG
	QvV9cw1hP2toVuPdgabh4iE113L/FK+XYHKz+0IhKDj1vSb6hJXs/0h8ua89gZdEfvkxVyN88BQ
	7/eZc3TTdVKV3qpN4yRBc3FVkPURxPGNGM/IIjdULQw8Z9h1PvpxlrEO6DkeH4nMhmUNm9otTpX
	YPXO2j4RuXS8BNP9cV714MusNUAjvx/0RhtStk513sK3o+MMfqm4Z9uzju4X4sLZKg6i1Zj46wR
	mAhTn+QEPp+EuQXi4+x71fNKuNXblK1DlECcq/a5LRBmtEaJS6szu02V1g=
X-Received: by 2002:a53:bd04:0:b0:668:1e79:116e with SMTP id 956f58d0204a3-66ce5bb3350mr6460594d50.27.1787582083708;
        Mon, 24 Aug 2026 07:34:43 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4662219sm3783915d50.7.2026.08.24.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:34:42 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:34:38 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 18/25] mm/fbatch: remove lru_add_drain() and _all() calls
 from various
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <0b9e175f-edf5-630f-afd5-e71fb4e9d376@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Splitting into little patches gets tedious: now that folios on per-cpu
fbatches no longer hold an extra reference (and have the lru flag set),
most calls to lru_add_drain(), and more importantly lru_add_drain_all(),
should be removed.

Remove lru_add_drain() from compact_zone().
Remove lru_add_drain_all() from compact_nodes() and compact_store().
Keep lru_add_drain_cpu_zone() in compact_zone(): it was always a bit of
a hack, a cheap way to get a local_lock() around pcp drain_pages_zone().

Remove lru_add_drain() and lru_add_drain_all() from generic_fadvise(
POSIX_FADV_DONTNEED), but still retry once on failure; remove outdated
comment line from mapping_try_invalidate().

Remove every lru_add_drain() and lru_add_drain_all() from khugepaged.c.

Remove lru_add_drain_all() from KSM's scan_get_next_rmap_item() restart.

Remove lru_add_drain() from wp_can_reuse_anon_folio() and do_swap_page().

Remove lru_add_drain(), lru_add_drain_all() from migrate_device_unmap().

Keep lru_add_drain()s in mm/gup.c populate_vma_page_range() and
faultin_page_range(): good housekeeping after a bulk operation.

Keep lru_add_drain()s in mm/madvise.c: the ones after a bulk op probably
do want to "Push any new pages onto the LRU now", and update the stats;
the ones before a bulk op may be trying to stabilize initial conditions,
or to minimize draining under ptlock.

Keep lru_add_drain_all() in memcg-v1's mem_cgroup_force_empty():
it probably does want to push onto the LRU and update the stats.

Keep lru_add_drain() after bulk op in mlock_vma_pages_range(), partly
for "Unevictable kB" accuracy; but remove the lru_add_drain() before it.

Keep lru_add_drain()s in swap_cluster_readahead(), swap_vma_readahead():
they do want to "Push any new pages onto the LRU now" (akpm 2.5.46).

Keep lru_add_drain()s and lru_add_drain_all() throughout mm/vmscan.c:
it works on LRUs, so it does need folios to be on an actual LRU.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/compaction.c     | 12 +-----------
 mm/fadvise.c        | 17 +----------------
 mm/khugepaged.c     | 11 -----------
 mm/ksm.c            | 12 ------------
 mm/memory.c         | 14 ++------------
 mm/migrate_device.c |  9 ---------
 mm/mlock.c          |  1 -
 mm/truncate.c       |  1 -
 8 files changed, 4 insertions(+), 73 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 9e045a90ba21..8ed375b08f3e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2652,9 +2652,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	trace_mm_compaction_begin(cc, start_pfn, end_pfn, sync);
 
-	/* lru_add_drain_all could be expensive with involving other CPUs */
-	lru_add_drain();
-
 	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
 		int err;
 		unsigned long iteration_start_pfn = cc->migrate_pfn;
@@ -2969,9 +2966,6 @@ static int compact_nodes(void)
 {
 	int ret, nid;
 
-	/* Flush pending updates to the LRU lists */
-	lru_add_drain_all();
-
 	for_each_online_node(nid) {
 		ret = compact_node(NODE_DATA(nid), false);
 		if (ret)
@@ -3036,12 +3030,8 @@ static ssize_t compact_store(struct device *dev,
 {
 	int nid = dev->id;
 
-	if (nid >= 0 && nid < nr_node_ids && node_online(nid)) {
-		/* Flush pending updates to the LRU lists */
-		lru_add_drain_all();
-
+	if (nid >= 0 && nid < nr_node_ids && node_online(nid))
 		compact_node(NODE_DATA(nid), false);
-	}
 
 	return count;
 }
diff --git a/mm/fadvise.c b/mm/fadvise.c
index b63fe21416ff..f788a5020384 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -143,27 +143,12 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		if (end_index >= start_index) {
 			unsigned long nr_failed = 0;
 
-			/*
-			 * It's common to FADV_DONTNEED right after
-			 * the read or write that instantiates the
-			 * pages, in which case there will be some
-			 * sitting on the local LRU cache. Try to
-			 * avoid the expensive remote drain and the
-			 * second cache tree walk below by flushing
-			 * them out right away.
-			 */
-			lru_add_drain();
-
 			mapping_try_invalidate(mapping, start_index, end_index,
 					&nr_failed);
-
 			/*
-			 * The failures may be due to the folio being
-			 * in the LRU cache of a remote CPU. Drain all
-			 * caches and try again.
+			 * Retry if any failures, in case they were transient.
 			 */
 			if (nr_failed) {
-				lru_add_drain_all();
 				invalidate_mapping_pages(mapping, start_index,
 						end_index);
 			}
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b237f6e7662a..904a45c11fca 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1225,10 +1225,6 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
 	if (pte)
 		pte_unmap(pte);
 
-	/* Drain LRU cache to remove extra pin on the swapped in pages */
-	if (swapped_in)
-		lru_add_drain();
-
 	result = SCAN_SUCCEED;
 out:
 	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result,
@@ -2325,8 +2321,6 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
-				/* drain lru cache to help folio_isolate_lru() */
-				lru_add_drain();
 			} else if (folio_trylock(folio)) {
 				folio_get(folio);
 				xas_unlock_irq(&xas);
@@ -2340,8 +2334,6 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
 							  end - index);
-				/* drain lru cache to help folio_isolate_lru() */
-				lru_add_drain();
 				folio = filemap_lock_folio(mapping, index);
 				if (IS_ERR(folio)) {
 					result = SCAN_FAIL;
@@ -2981,8 +2973,6 @@ static void khugepaged_do_scan(struct collapse_control *cc)
 	bool wait = true;
 	enum scan_result result = SCAN_SUCCEED;
 
-	lru_add_drain_all();
-
 	cc->progress = 0;
 	while (true) {
 		cond_resched();
@@ -3214,7 +3204,6 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	cc->progress = 0;
 
 	mmgrab(mm);
-	lru_add_drain_all();
 
 	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
 		enum scan_result result = SCAN_FAIL;
diff --git a/mm/ksm.c b/mm/ksm.c
index b4142746777e..5bae928620ad 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2626,18 +2626,6 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		advisor_start_scan();
 		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
 
-		/*
-		 * A number of pages can hang around indefinitely in per-cpu
-		 * LRU cache, raised page count preventing write_protect_page
-		 * from merging them.  Though it doesn't really matter much,
-		 * it is puzzling to see some stuck in pages_volatile until
-		 * other activity jostles them out, and they also prevented
-		 * LTP's KSM test from succeeding deterministically; so drain
-		 * them here (here rather than on entry to ksm_do_scan(),
-		 * so we don't IPI too often when pages_to_scan is set low).
-		 */
-		lru_add_drain_all();
-
 		/*
 		 * Whereas stale stable_nodes on the stable_tree itself
 		 * get pruned in the regular course of stable_tree_search(),
diff --git a/mm/memory.c b/mm/memory.c
index 8da0f945141b..1478bee69e30 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4251,9 +4251,6 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
 static bool wp_can_reuse_anon_folio(struct folio *folio,
 				    struct vm_area_struct *vma)
 {
-	const bool maybe_in_lru_cache = !folio_test_lru(folio);
-	const bool in_swapcache = folio_test_swapcache(folio);
-
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_large(folio))
 		return __wp_can_reuse_large_anon_folio(folio, vma);
 
@@ -4264,16 +4261,9 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
 	 *
 	 * KSM doesn't necessarily raise the folio refcount.
 	 */
-	if (folio_test_ksm(folio) ||
-	    folio_ref_count(folio) > 1 + maybe_in_lru_cache + in_swapcache)
+	if (folio_test_ksm(folio))
 		return false;
-	if (maybe_in_lru_cache)
-		/*
-		 * We cannot easily detect+handle references from
-		 * remote LRU caches or references to LRU folios.
-		 */
-		lru_add_drain();
-	if (folio_ref_count(folio) > 1 + in_swapcache)
+	if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
 		return false;
 	if (!folio_trylock(folio))
 		return false;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 18d097c38853..d3f865904c48 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -575,11 +575,8 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 	struct folio *fault_folio = fault_page ?
 		page_folio(fault_page) : NULL;
 	unsigned long i, restore = 0;
-	bool allow_drain = true;
 	unsigned long unmapped = 0;
 
-	lru_add_drain();
-
 	for (i = 0; i < npages; ) {
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 		struct folio *folio;
@@ -600,12 +597,6 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 
 		/* ZONE_DEVICE folios are not on LRU */
 		if (!folio_is_zone_device(folio)) {
-			if (!folio_test_lru(folio) && allow_drain) {
-				/* Drain CPU's lru cache */
-				lru_add_drain_all();
-				allow_drain = false;
-			}
-
 			if (!folio_isolate_lru(folio)) {
 				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 				restore++;
diff --git a/mm/mlock.c b/mm/mlock.c
index 97134eff6b56..971430e6251e 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -424,7 +424,6 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	vma_start_write(vma);
 	vma_flags_reset_once(vma, new_vma_flags);
 
-	lru_add_drain();
 	walk_page_range_vma(vma, start, end, &mlock_walk_ops, NULL);
 	lru_add_drain();
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 4151f7a167e3..7ea5d513f76a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -571,7 +571,6 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			 */
 			if (!ret) {
 				deactivate_file_folio(folio);
-				/* Likely in the lru cache of a remote CPU */
 				if (nr_failed)
 					(*nr_failed)++;
 			}
-- 
2.51.0

