Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302E4E8DE8
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949100; cv=none; b=dHXEX+XbSaqyPJ/fv/6oSWF9/cARyOMxl7YRe1sL3QWiiCBW6awO0Yt6x4SW+0s+7Ih/WUuM8v+ibQqgRfBsASkUNS3fW7RGCzAVhKTrlAIKJZMB4gFMyOONyYXHit7KC4TPLStgFF9ULTbjCgNN4w+HrSSb8CopG/kOHSI2ioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949100; c=relaxed/simple;
	bh=BAoHBLGej7CKU513wAnhWH+90yYgW8iGSWBxT+OzRiU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u+fcvONKduXftY99uVqoPKK3Q1xW1gkk4L865EFdMSHpwwTzAfIKHiEa5aDutNrpffO/WI6FbIBcdRyho9yt90H/dSN2wWA6c34iMmEv9Cbu76WW9TtoiNvZNNjarNqwIi+wy7aP+S8YkuDolcX8+teKzD7udP0EpFhS3t9eUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/ZR8I0o; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/ZR8I0o"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66fcf87897fso4327783d50.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788949093; x=1789553893; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vqq1bLSj+HyikJMGO2+S/zPhjWI8z39VCLxfhn2Q3b0=;
        b=L/ZR8I0o54sm99u0HJWpQa6I95wZu5qeb6NPYlTf2EcCcBqivBJ1PhksUmu5XREHaB
         hK2CSzQbzRHRUYRQzB3Gcp97Bo2NNPRXj8STiVrOoROM37tnbee3r8n9QVcsnMPdkQqL
         H64tr7/hEt7OTFFBJxWH7KYsBPYM2LyF6ETt1WOCG0WVb4L/Ge3byNnyptRfT/WOlGxI
         RJEkGbKcXzelwuCkI6nGz8aXBY6MmxH2hUWdGnQGMd24VPxq3COAmgGbrpkaNWfSluP9
         zSTZuboa0YXAVhBGA7xdRBq/FbI3GOHX9eI2CmVShgCBmrLvyRwOprmpIDaMh2u1bgHQ
         pXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949093; x=1789553893;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vqq1bLSj+HyikJMGO2+S/zPhjWI8z39VCLxfhn2Q3b0=;
        b=F5mtyTwdCQxgwU0ksjzm/SR1ZnrKdq63dD+gS/DN7aoVDa+5BSz9wI/H5cwxh6qbZe
         PkurxdMHLJmRtjpC7/AL5x4tyiA1wfrU3cIPXfNUnaiYEA8ND9350EZ49y/rPymDCNxx
         y+qXLuzfKJr1YVB4jJamu466qaxZSt/OWRTcSvDBiP1q+8SSvrmLrMUhQJ1sinAc3mWx
         zH78v/lgqAHYF9PGHy4FXsi8cwuGJOxdfEJl+7LXEkfDv3Bz6kd+IQMnvawmo2e8TsJv
         Bzp6LjVtBWv8MlGA0FIzg3i3odIdrKrsRnLdDXBe4vAkJBxdwV0QdEJ+WpKzesqq5oee
         fZ0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzvEdtl0x9K93IdCXn+HC15DQ0/7rVF5O9ST8JP2r167R/jxio08W0wBp+CeeSaQ30rCWOBQvQyjEh+ag==@vger.kernel.org
X-Gm-Message-State: AFuF++ncRiW51+CUEv9SFrZpABvewGTNDu9aT0Gmddy1gnluJn1DlecJ
	gbgOHny0JmtV8U0UTWT8R86lneGnMbFrffeC3e3/3pfumtSH8kWjzt41OGzqJc8sKA==
X-Gm-Gg: AYBFou0pA3reaAFnUPd/YQ6uNAF5LAf+DCDLEG4XGsAUrCyYDpiiWztrI37Svf8uvjy
	8gDFH7C1fVxo5TgdaWAabttnol1lSIfOcvskUjdFqDqzg/c1XpS97aDrS0h95laKQjgW2k18YCR
	KzR633U27mfd4BuRdtS258oyVVInpytEWwSH2fW8cUjGaXLLHsMW/rsMROjFXhkzspJu3kzzrwp
	WdcU7iqTzSB6HZxufm/qcfw/9X3PPyQ0CBGmsBblfN+OKMiL6j5XIf8qX3Y8opImT2/0Xg1/nm1
	Nz7YHfH0jjNkycGt9n07MHv1sAZ7pN1ECkjtcRoTFgn4nkxT/1W63Z/xsXtVfz8L5Lh/3PFjmpW
	eA/nukJWQyFnx/wlOKEsqbhn5tRscMxehM549RuPUwJ2p0/9w2esNX/CFDgWyyMLHg7A2GWhXJh
	VoDlXgA2oRHQZhsvzNNp2jo44DZ3+fE6EyHPvyh5BWx/XsJxgydqWp7HosoZ7A0VCt7R8uw2/HA
	XahDRk94C1nhe2iVe0p1WMcF6lp/1OtBXU2Vt1F2pRkCbctCCJJoPoyH4o=
X-Received: by 2002:a53:ce92:0:b0:66c:c638:8e88 with SMTP id 956f58d0204a3-66fb58dcc41mr7649439d50.2.1788949092561;
        Wed, 09 Sep 2026 03:18:12 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48d6ea5sm12216161d50.7.2026.09.09.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:18:11 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:18:07 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
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
Subject: [PATCH v2 18/26] mm/fbatch: remove lru_add_drain() and _all() calls
 from various
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <3af1563f-1db3-5974-659a-41463ad7a4c9@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
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
index 1290b9170cb2..5944094253b0 100644
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
index 75639298efc2..d09f848d3591 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1236,10 +1236,6 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
 	if (pte)
 		pte_unmap(pte);
 
-	/* Drain LRU cache to remove extra pin on the swapped in pages */
-	if (swapped_in)
-		lru_add_drain();
-
 	result = SCAN_SUCCEED;
 out:
 	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result,
@@ -2320,8 +2316,6 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
-				/* drain lru cache to help folio_isolate_lru() */
-				lru_add_drain();
 			} else if (folio_trylock(folio)) {
 				folio_get(folio);
 				xas_unlock_irq(&xas);
@@ -2335,8 +2329,6 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
 							  end - index);
-				/* drain lru cache to help folio_isolate_lru() */
-				lru_add_drain();
 				folio = filemap_lock_folio(mapping, index);
 				if (IS_ERR(folio)) {
 					result = SCAN_FAIL;
@@ -2975,8 +2967,6 @@ static void khugepaged_do_scan(struct collapse_control *cc)
 	bool wait = true;
 	enum scan_result result = SCAN_SUCCEED;
 
-	lru_add_drain_all();
-
 	cc->progress = 0;
 	while (true) {
 		cond_resched();
@@ -3208,7 +3198,6 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	cc->progress = 0;
 
 	mmgrab(mm);
-	lru_add_drain_all();
 
 	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
 		enum scan_result result = SCAN_FAIL;
diff --git a/mm/ksm.c b/mm/ksm.c
index 49d48d1e0998..890e2c51106d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2625,18 +2625,6 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
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
index 8b0c2c735d3d..e9e2199ba5e9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4313,9 +4313,6 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
 static bool wp_can_reuse_anon_folio(struct folio *folio,
 				    struct vm_area_struct *vma)
 {
-	const bool maybe_in_lru_cache = !folio_test_lru(folio);
-	const bool in_swapcache = folio_test_swapcache(folio);
-
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_large(folio))
 		return __wp_can_reuse_large_anon_folio(folio, vma);
 
@@ -4326,16 +4323,9 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
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
index 009bfa8b212d..7ece4ca0654a 100644
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

