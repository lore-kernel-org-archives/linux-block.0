Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6B438021
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580400; cv=none; b=RKf87zIzfw01ZQzirjV4yW/MzzcmMFitseRMvFT4RKlK26NJpvgRM4NEYf4QFkd7tOfqWbRKzF17p3Trni//Yu6AEq9DH2Mkj3UGpPeWIgICO5tPUE+YNDd4DOLkDbdCx2YackZdgYzAbIoUBNL5ej4Hxesg0JqznMPOzBF1uN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580400; c=relaxed/simple;
	bh=DLxNbafGeyCEB6Cj0RzgQIU/rPeLdjUktAZ9VhvQqDY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X8cssVlCyGFuc44Gh71q+calCeph243IXeGKcv7tVG6yGueWfs/GgYmxMrkkGGfoXaBhvTyKTIlTrHIFx7lkz3Z12/xfcJTPnvi+O1FpkB1KDYTq3+0SXZ4NUKqGAoND7i3UXfZx4Pwle2geh+x6F05+5BwYALVHubcSFSqaGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwVlQZ/Y; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwVlQZ/Y"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81f3b227a4aso54519567b3.1
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787580395; x=1788185195; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9t24td1SIXy4MUg0Hzwh5Pqt3oG+R8+H8KjX8Zm4YEA=;
        b=rwVlQZ/Y3WoQgBowJD0tTNwiBqu2dt4ZKs5sqjrHuEGHqWq/Smwlmx18nzap4cG0T5
         /EXh18q+u0o77xqnrfOE+5iV2/plBqkvEcpadBR5GAAn+L/IjI6DdKkk13z+M+RhN7ox
         6TBoBIHMmkBbaFDgrgv0v2lGY0zq7hejzCGg40x/PIDm2aNykOhrNmw6XwdtpLmO0yhe
         8nNVP/LTVl5fnjY2C+xF54H8AMSN+HDZD/WQe68k09jRF+18pF65ixcpGboDxrZgxTqE
         LA4E4nebhCl4Tn5u5p45XXzieSq5M2+GARodli0D5hDOyMpgVKjMBC/XuIuEMmnz3dEl
         XfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580395; x=1788185195;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9t24td1SIXy4MUg0Hzwh5Pqt3oG+R8+H8KjX8Zm4YEA=;
        b=YUGAbqd/aHcE5qLb48gk2ZyLK0LAUuDp6foQNnmVqq7HhypmM5hbnIszD9JbMk+Q1v
         RZ8UUeMqFADOoHj1u9BG9DWreGkJVJUOwJXM31EeH9Jxte6CR/Tn6VrTpZjcs1tQqT6y
         YSk3AMDc3jEgLL1efOJfFffH2r/s+EThTi36lfNjHixa1ezUrqF9qBEWRbeTT6uuRqQL
         MuZszH3J64BdqZdxTsMER2q3vzHXWIAdpj3oEqRTKSeJCWd1UDQHWx+NmNzXPIkoQ0St
         U3gMWjVFGqZOEtF9gp0MPzsUuyuFDN7i/ZxseOEiXI91vdwRz9RMST0bhmNp9hC8FKQq
         bwuA==
X-Forwarded-Encrypted: i=1; AHgh+RquKB8c75+rfutCJLDCNeruTh3dxpwI+RjRMLV0svTpAq3vD3JFZH8/k7vOi379XRLP8CtAC0nJW/VtYQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kPsp6ve1HYRmtKJgUNSGpI9jfZiWQQNKPWycqz1F7TEbRlFBFS
	jLpu/4Eixe6MVEVEYLhlNpLSO+wQVPRxxHHKoDCPjEyxsCQI09ep9cM4T2B7arF/Tw==
X-Gm-Gg: AR+sD11xM7IA9kZpmBbFE67TIaoJ8VV6U13tk3SDZ0L/3TM9wpLzXEb/qphSbVHQhr7
	/7sZY2++ULb50rk12818yZeMFp0wglPs0Muh2/+m+4u3hCrRSi5d5cHlcYN86zcR0qUVR4cx28a
	NVbhBwLngkecXr5GVqXdysKba/T5h0n4/vkWyj+syn+n0uHovNbgw/9P3RyUDHgtd3quTCxUFU/
	TYV722KLXYe2HJk3c0H0IJqKcifdEivLQKR51w6hfo4W25CElF6IKxNlo9+sEYqOg8uzN+se4hz
	rseDEtrc2dXHIirvZPIqQ2K9HtdURjv9kduWMdDHCP30yTtlE0EB8yeQugv4m+LEQnIXBYVBIP2
	q6M7kyhE8rLio23xSbBAjKmJ/vgB9MBW7u0NS44i/nXi+04Dq5rtnFuF3T6x7xl3/FgErltWj3x
	NSkuTuumzPz7CZMMgK91IWg+RRPTsjEcOdyFt6bVYL49M6vh7MRQDvieDHdRdCwZnlMt/rDeJYA
	KAtBgS0/F/uhQF0MmzOQ0sC4nUbFeW0TUbhJcAOj6TTp5iH
X-Received: by 2002:a05:690c:e1c5:20b0:80c:2874:67c6 with SMTP id 00721157ae682-849f5a0fb48mr73986717b3.24.1787580394257;
        Mon, 24 Aug 2026 07:06:34 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caacaf1e9sm34320857b3.23.2026.08.24.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:06:31 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:06:26 -0700 (PDT)
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
Subject: [PATCH 06/25] mm/fbatch: fbatch_drain_lazyfree(onstack fbatch) before
 ptl unlock
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <7155e86c-17f7-77d0-21dd-2d267f384a72@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Re-enable lazyfree batching for MADV_FREE. But it's not safe now to leave
potentially stale (then reused) folios in a per-cpu fbatch for lazyfree.
Instead, madvise_free_pte_range() keep an fbatch on its stack, and drain
it each time before dropping pagetable lock, while the folios are secure.

Ignore folio_may_be_lru_cached() and lru_cache_disabled(): limitations
irrelevant to this fbatch drained under spinlock (even if RT); though
in practice madvise_free_huge_pmd() does have to drain every time.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/huge_mm.h |  6 ++++--
 mm/folio.c              | 34 +++++++++++++++++++++-------------
 mm/huge_memory.c        |  6 ++++--
 mm/internal.h           |  3 ++-
 mm/madvise.c            |  9 +++++++--
 5 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c745f7ad2298..d50906327d1d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -24,9 +24,11 @@ static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 }
 #endif
 
-vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf);
+struct folio_batch;
 bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
-			   pmd_t *pmd, unsigned long addr, unsigned long next);
+			   pmd_t *pmd, unsigned long addr, unsigned long next,
+			   struct folio_batch *fbatch);
+vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf);
 bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma, pmd_t *pmd,
 		  unsigned long addr);
 int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma, pud_t *pud,
diff --git a/mm/folio.c b/mm/folio.c
index 88e3ebd7e652..e76868c95acc 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -50,7 +50,6 @@ struct cpu_fbatches {
 	struct folio_batch lru_activate;
 	struct folio_batch lru_deactivate_file;
 	struct folio_batch lru_deactivate;
-	struct folio_batch lru_lazyfree;
 	/* Protecting the following batches which require disabling interrupts */
 	local_lock_t lock_irq;
 	struct folio_batch lru_move_tail;
@@ -193,8 +192,6 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_lock(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
-			/* XXX Temporarily disable lazyfree batching */
-			fbatch == &cpu_fbatches.lru_lazyfree ||
 			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
@@ -651,10 +648,6 @@ void lru_add_drain_cpu(int cpu)
 	fbatch = &fbatches->lru_deactivate;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_deactivate);
-
-	fbatch = &fbatches->lru_lazyfree;
-	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_lazyfree);
 }
 
 /**
@@ -700,19 +693,35 @@ void folio_deactivate(struct folio *folio)
 
 /**
  * folio_mark_lazyfree - make an anon folio lazyfree
- * @folio: folio to deactivate
+ * @fbatch: batch to which folio will be added
+ * @folio: folio to be lazily freed
  *
- * folio_mark_lazyfree() moves @folio to the inactive file list.
- * This is done to accelerate the reclaim of @folio.
+ * folio_mark_lazyfree() moves @folio to the inactive file list
+ * via @fbatch. This is done to accelerate the reclaim of @folio.
  */
-void folio_mark_lazyfree(struct folio *folio)
+void folio_mark_lazyfree(struct folio_batch *fbatch, struct folio *folio)
 {
 	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
 	    !folio_test_lru(folio) ||
 	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_lazyfree);
+	if (!folio_batch_add(fbatch, folio))
+		folio_batch_move_lru(fbatch, lru_lazyfree);
+}
+
+/**
+ * fbatch_drain_lazyfree - drain the caller's folio batch
+ * @fbatch: batch of folios to be lazily freed
+ *
+ * Must be called before caller drops the page table lock: that is,
+ * before dropping the last certain reference to the folios in @fbatch.
+ * It would be very bad to lazyfree a folio after it was freed and reused.
+ */
+void fbatch_drain_lazyfree(struct folio_batch *fbatch)
+{
+	if (folio_batch_count(fbatch))
+		folio_batch_move_lru(fbatch, lru_lazyfree);
 }
 
 void lru_add_drain(void)
@@ -766,7 +775,6 @@ static bool cpu_needs_drain(unsigned int cpu)
 			 folio_batch_count(&fbatches->lru_move_tail) ||
 			 folio_batch_count(&fbatches->lru_deactivate_file) ||
 			 folio_batch_count(&fbatches->lru_deactivate) ||
-			 folio_batch_count(&fbatches->lru_lazyfree) ||
 			 need_mlock_drain(cpu)) ||
 		has_bh_in_lru(cpu, NULL);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 98b1d0ea50f0..b1f315400111 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2356,7 +2356,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
  * Otherwise, return false.
  */
 bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		pmd_t *pmd, unsigned long addr, unsigned long next)
+		pmd_t *pmd, unsigned long addr, unsigned long next,
+		struct folio_batch *fbatch)
 {
 	spinlock_t *ptl;
 	pmd_t orig_pmd;
@@ -2417,7 +2418,8 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	}
 
-	folio_mark_lazyfree(folio);
+	folio_mark_lazyfree(fbatch, folio);
+	fbatch_drain_lazyfree(fbatch);
 	ret = true;
 out:
 	spin_unlock(ptl);
diff --git a/mm/internal.h b/mm/internal.h
index 68db5abd0a4c..ababee1a8872 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -66,7 +66,8 @@ void lru_add_drain(void);
 void lru_add_drain_cpu(int cpu);
 void lru_add_drain_cpu_zone(struct zone *zone);
 void folio_deactivate(struct folio *folio);
-void folio_mark_lazyfree(struct folio *folio);
+void folio_mark_lazyfree(struct folio_batch *fbatch, struct folio *folio);
+void fbatch_drain_lazyfree(struct folio_batch *fbatch);
 
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
diff --git a/mm/madvise.c b/mm/madvise.c
index 240d9161ee74..6ef1f489123c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -27,6 +27,7 @@
 #include <linux/file.h>
 #include <linux/blk_plug.h>
 #include <linux/backing-dev.h>
+#include <linux/folio_batch.h>
 #include <linux/pagewalk.h>
 #include <linux/swap.h>
 #include <linux/leafops.h>
@@ -657,6 +658,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	struct mmu_gather *tlb = walk->private;
 	struct mm_struct *mm = tlb->mm;
 	struct vm_area_struct *vma = walk->vma;
+	struct folio_batch fbatch;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte, ptent;
 	struct folio *folio;
@@ -664,9 +666,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long next;
 	int nr, max_nr;
 
+	folio_batch_init(&fbatch);
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
-		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
+		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next, &fbatch))
 			return 0;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
@@ -724,6 +727,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 					continue;
 				folio_get(folio);
 				lazy_mmu_mode_disable();
+				fbatch_drain_lazyfree(&fbatch);
 				pte_unmap_unlock(start_pte, ptl);
 				start_pte = NULL;
 				err = split_folio(folio);
@@ -768,13 +772,14 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			clear_young_dirty_ptes(vma, addr, pte, nr, cydp_flags);
 			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
-		folio_mark_lazyfree(folio);
+		folio_mark_lazyfree(&fbatch, folio);
 	}
 
 	if (nr_swap)
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
 	if (start_pte) {
 		lazy_mmu_mode_disable();
+		fbatch_drain_lazyfree(&fbatch);
 		pte_unmap_unlock(start_pte, ptl);
 	}
 	cond_resched();
-- 
2.51.0

