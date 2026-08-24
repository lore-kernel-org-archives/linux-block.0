Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F443746C
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580090; cv=none; b=Yj1kOOe2rW9x1Ixlp1YtVlnwQIL1dYw4IA67RQunM8Tc5P/9W6XNugA+Ec4iQAtX0rd/pOZRIkcbctqrbmvIyMw3JVGzHH7k1EOTG/u43t3+BvY9KV68i1+CdMl09AyzH76PByVnXGhQPjUb4gMQPGwVtvDVc3WFGG71Q8K014w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580090; c=relaxed/simple;
	bh=/pbJ1sO8Ra8ej9Se9y+dT8qIv3r62mtB11/3S/mbr/M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gnev88DLSzu/MCHp/TrPrz9ebNQaXacItoyFVvEB9IpEb+qBB02rKtoJyDMENt7HIVy4cqs7kIr0yV/CZTFXuJFF1yl08/B6eOOXrF/sAeLe+43D+22YCpROu3fjHcoE1iHhRPnPMzF8H9MWtCtMPFy6xwO8seYjXebQJYKqAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmogVx29; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmogVx29"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836c4474028so40473887b3.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787580088; x=1788184888; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3uJrLcgO0TGgb78nKF0vmj4EM5IUhGHLplUqQEbOiM=;
        b=JmogVx29GRJQ9hs2oCzeWZemOnXSVdf0TUwx+5aCQ2slV/Q+eIgtiX3cbcC6f4Ndx4
         +hEe87zjz6zEAbqarEoi/nvTtxZG5v8xhSEnSLJ6VCvX2pbd2qzHWETpsLHBDF5hiqeY
         gJYxpbbnaU6NP0nCwYNgZ03DedP1Ach/5Nq4FFYPOI0TWm9sSktED4Zi9ymdVyCfXSkp
         Kyrs0kuH/ANkhTf3OloBFYNNVUQUrTGoYVGSKNqOa9JQlHu9A9VStVvAGrIcp4ZpSGy3
         dZOApLAvDaUjgkNgY69w5Vy0N9IYD9AjnIXW/sgZRR40kr/hwNljomwGoYBnl/W+WCkY
         kwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580088; x=1788184888;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3uJrLcgO0TGgb78nKF0vmj4EM5IUhGHLplUqQEbOiM=;
        b=XgBEerPK5T4Uvvm2v2how4croEYhWG0b9SbgY/ohh0juKrxzjrcB2T/cnmapzRQ59y
         lCvqm0TPtjdowJ+5N0f4/Mg4y6YIOYciGZS0Chd8EPZ3eGSZE2wyscSdqzGMSrZS54Q4
         WukhvM3gFp7avhQbs6yuPOgg4wXTekJoaC2LdKT//iMjnSSNspFUDGfHDbZpTou8KiKj
         DOAMjMEPuIBNnYXTy7Pwq1LrjyoI341Dcq/vE6h/BYlGiniKq//Kt4dq30F89qdVznzs
         e6Pn0wz3susVhqtZr0IHWtFxPaR979JODnNjhzGDp0gBGw8b8JBhO0iUvs2jt7Kt3g5N
         lqTg==
X-Forwarded-Encrypted: i=1; AHgh+RqnTQtBLxoxKcIBRce2Nd0LBvgyjTvGPyPvFQeiO4Gu7df0pnx/mE3w8y9JbGVja/Ot2AXfBs6qiwNcGA==@vger.kernel.org
X-Gm-Message-State: AFuF++kP3YF+6loi6sHZSQ9tJQlO0plZBj8kJN6o2jw/Bit8BHGHIL7V
	TrK3eAsTuF5+71nkzgXKx7m0PCaJ4zgThCNvwHuOFkQyVB6iTfzjCqeyTbTZB7mefA==
X-Gm-Gg: AR+sD12W2wAUawyE37MquHPHjFWBBmoqY1zZBnS4bCnVufQAeeQoR5BiJNluBQLbmco
	SYbxFou/WbJ81ZRr2pbkppo2vppGCclfd+HyW5FUzU7ImFQJYryTsw6XzLh7U0bpWeHD1B3dZsl
	fpc9g0FBfuApCo04saLsen2CpWKDu1J8I5rhDKPxC11BadZGR4W4w6YpDbSC5v8TzJ2njuVE0Ey
	rOdbu5xWc+3FTDHY8wwIR/xm/CsCJFJdD9bxt+nLDtFPY6rcPF1QPE1opuSNJi2/Ns7gMM+V6sc
	3/R/uSyYI3Y92MVWX8J9u9TzIOe8fikY5b/q7WRaZ4SVi1ptSdkWC7LamRDJvEBqIPHjft5wp4I
	hu3PdZvwf7Xf3gBCdfaNONLPEa6rkbLiG5czPYtd4pBw653i33Uo+wH4OQBPyRa56vy6uhgXf30
	0WvR5WMM3eXlytJ7IizNl6Hs1ayMykkUwVq9uJLZsnUmUqCEaBOFH8ksephBNZevZY9ptIkoQcF
	ABFgzoLLwpyFMERxIJ7SE0CDDvV/TZ00S83tGc8WLwvdxGq
X-Received: by 2002:a05:690c:568a:20b0:844:9f61:92d9 with SMTP id 00721157ae682-849f67acaa8mr75062557b3.17.1787580086310;
        Mon, 24 Aug 2026 07:01:26 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85426caa5e9sm1557737b3.34.2026.08.24.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:01:25 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:01:20 -0700 (PDT)
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
Subject: [PATCH 04/25] mm/fbatch: lru bit set, no extra ref, while folio on
 per-cpu fbatch
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <e0887417-85a7-453e-e733-561dc11db08f@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Treat folios on a per-cpu fbatch as if they were already on the lruvec:
with PG_lru set, without holding an extra reference. This will enable
the removal of most lru_add_drain() and lru_add_drain_all() calls soon.

Recognize such a folio by 0x02 set in the folio->lru.next pointer by
folio_add_lru(). Then lruvec_del_folio() (aided by "lru_add_del_folio")
can pretend to unlink it, and folio_batch_move_lru()'s lru_add case can
check whether one of the others has already moved it to lruvec.

Let folio->lru.next point to the lru_add fbatch entry, but this is now
just for debugging: it seemed to be important for folio_batch_move_lru()
to distinguish fresh from stale entries, but then it turned out that it
has to processs them identically.

Activate, deactivates and move_tail, holding no reference on the folio,
might come to act on a stale folio when the fbatch is drained: but it's
acquired by try_get and test_clear_lru, so safe even when suboptimal.

Reclaim is not an exact science, and there have been no complaints of
missed actions since 5.11 commit fc574c23558c ("mm/swap.c: serialize
memcg changes in pagevec_lru_move_fn") introduced the TestClearPageLRU
protocol: so don't expect complaints of a few surprisingly taken actions.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm_inline.h |  19 ++++++
 include/linux/mm_types.h  |   4 +-
 mm/folio.c                | 119 +++++++++++++-------------------------
 mm/huge_memory.c          |   6 +-
 4 files changed, 66 insertions(+), 82 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 621c8653d8f7..1ecaf2ef9f2b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -343,6 +343,23 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
 }
 #endif /* CONFIG_LRU_GEN */
 
+enum {
+	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
+	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
+	NR_LRU_NEXT_FLAGS
+};
+
+static __always_inline
+bool lru_add_del_folio(struct folio *folio)
+{
+	/* BUG_ON(folio_test_lru(folio)); */
+	if (!(folio->lru_next & BIT(LRU_NEXT_BATCHED)))
+		return false;
+	folio->lru.next = LIST_POISON1;
+	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
+	return true;
+}
+
 static __always_inline
 void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
@@ -384,6 +401,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 
 	if (lru_gen_del_folio(lruvec, folio, false))
 		return;
+	if (lru_add_del_folio(folio))
+		return;
 
 	if (lru != LRU_UNEVICTABLE)
 		list_del(&folio->lru);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 939b5ea8c9e0..2b1a1f983a91 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -410,10 +410,8 @@ struct folio {
 			union {
 				struct list_head lru;
 	/* private: avoid cluttering the output */
-				/* For the Unevictable "LRU list" slot */
 				struct {
-					/* Avoid compound_info */
-					void *__filler;
+					unsigned long lru_next;
 	/* public: */
 					unsigned int mlock_count;
 	/* private: */
diff --git a/mm/folio.c b/mm/folio.c
index a7010ae3edff..88e3ebd7e652 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -151,57 +151,34 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	int i;
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
-	struct folio_batch free_fbatch;
-	bool is_lru_add = (move_fn == lru_add);
-
-	/*
-	 * If we're adding to the LRU, preemptively filter dead folios. Use
-	 * this dedicated folio batch for temp storage and deferred cleanup.
-	 */
-	if (is_lru_add)
-		folio_batch_init(&free_fbatch);
 
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
 
-		/* block memcg migration while the folio moves between lru */
-		if (!is_lru_add && !folio_test_clear_lru(folio))
-			continue;
-
-		/*
-		 * Filter dead folios by moving them from the add batch to the temp
-		 * batch for freeing after this loop.
-		 *
-		 * We're bypassing normal cleanup. Clear flags that are not
-		 * applicable to dead folios.
-		 *
-		 * Since the folio may be part of a huge page, unqueue from
-		 * deferred split list to avoid a dangling list entry.
-		 */
-		if (is_lru_add && folio_ref_freeze(folio, 1)) {
-			__folio_clear_active(folio);
-			__folio_clear_unevictable(folio);
-			folio_unqueue_deferred_split(folio);
+		if (!folio_try_get(folio)) {
 			fbatch->folios[i] = NULL;
-			folio_batch_add(&free_fbatch, folio);
 			continue;
 		}
 
+		if (!folio_test_clear_lru(folio))
+			continue;
+
+		/* Do not add to LRU if it has already been added */
+		if (move_fn == lru_add && !lru_add_del_folio(folio))
+			goto restore_lru;
+
 		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
 		move_fn(lruvec, folio);
 
+		/* Do add to LRU if not already there (move_fn skipped) */
+		if (lru_add_del_folio(folio))
+			lruvec_add_folio(lruvec, folio);
+restore_lru:
 		folio_set_lru(folio);
 	}
 
 	if (lruvec)
 		lruvec_unlock_irqrestore(lruvec, flags);
-
-	/* Cleanup filtered dead folios. */
-	if (is_lru_add) {
-		mem_cgroup_uncharge_folios(&free_fbatch);
-		free_unref_folios(&free_fbatch);
-	}
-
 	folios_put(fbatch);
 }
 
@@ -210,8 +187,6 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 {
 	unsigned long flags;
 
-	folio_get(folio);
-
 	if (disable_irq)
 		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
 	else
@@ -339,7 +314,6 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 	if (folio_test_active(folio) || folio_test_unevictable(folio))
 		return;
 
-
 	lruvec_del_folio(lruvec, folio);
 	folio_set_active(folio);
 	lruvec_add_folio(lruvec, folio);
@@ -355,37 +329,12 @@ void folio_activate(struct folio *folio)
 	    !folio_test_lru(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_activate);
-}
-
-static void __lru_cache_activate_folio(struct folio *folio)
-{
-	struct folio_batch *fbatch;
-	int i;
-
-	local_lock(&cpu_fbatches.lock);
-	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
-
 	/*
-	 * Search backwards on the optimistic assumption that the folio being
-	 * activated has just been added to this batch. Note that only
-	 * the local batch is examined as a !LRU folio could be in the
-	 * process of being released, reclaimed, migrated or on a remote
-	 * batch that is currently being drained. Furthermore, marking
-	 * a remote batch's folio active potentially hits a race where
-	 * a folio is marked active just after it is added to the inactive
-	 * list causing accounting errors and BUG_ON checks to trigger.
+	 * XXX: It is curiously difficult to recreate safely the old
+	 * __lru_cache_activate_folio() optimization (folio_set_active()
+	 * directly if it's on the local lru_add fbatch): revisit later.
 	 */
-	for (i = folio_batch_count(fbatch) - 1; i >= 0; i--) {
-		struct folio *batch_folio = fbatch->folios[i];
-
-		if (batch_folio == folio) {
-			folio_set_active(folio);
-			break;
-		}
-	}
-
-	local_unlock(&cpu_fbatches.lock);
+	folio_batch_add_and_move(folio, lru_activate);
 }
 
 #ifdef CONFIG_LRU_GEN
@@ -476,16 +425,7 @@ void folio_mark_accessed(struct folio *folio)
 		 * unevictable page accessed has no effect.
 		 */
 	} else if (!folio_test_active(folio)) {
-		/*
-		 * If the folio is on the LRU, queue it for activation via
-		 * cpu_fbatches.lru_activate. Otherwise, assume the folio is in a
-		 * folio_batch, mark it active and it'll be moved to the active
-		 * LRU on the next drain.
-		 */
-		if (folio_test_lru(folio))
-			folio_activate(folio);
-		else
-			__lru_cache_activate_folio(folio);
+		folio_activate(folio);
 		folio_clear_referenced(folio);
 		workingset_activation(folio);
 	}
@@ -505,6 +445,10 @@ EXPORT_SYMBOL(folio_mark_accessed);
  */
 void folio_add_lru(struct folio *folio)
 {
+	struct folio_batch *fbatch;
+	unsigned long lru_next;
+	bool full;
+
 	VM_BUG_ON_FOLIO(folio_test_active(folio) &&
 			folio_test_unevictable(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
@@ -524,7 +468,26 @@ void folio_add_lru(struct folio *folio)
 			folio_mark_accessed(folio);
 	}
 
-	folio_batch_add_and_move(folio, lru_add);
+	local_lock(&cpu_fbatches.lock);
+	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
+
+	/* Storing this address is only for debugging */
+	lru_next = (unsigned long)&fbatch->folios[fbatch->nr];
+	/* This mask will do nothing on 64-bit */
+	lru_next &= ~(BIT(NR_LRU_NEXT_FLAGS) - 1);
+	lru_next |= BIT(LRU_NEXT_BATCHED);
+	folio->lru_next = lru_next;
+
+	full = !folio_batch_add(fbatch, folio);
+
+	/* Ensure folio->lru_next visible to folio_test_clear_lru() callers */
+	smp_mb__before_atomic();
+	folio_set_lru(folio);
+
+	if (full || !folio_may_be_lru_cached(folio) || lru_cache_disabled())
+		folio_batch_move_lru(fbatch, lru_add);
+
+	local_unlock(&cpu_fbatches.lock);
 }
 EXPORT_SYMBOL(folio_add_lru);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 644d6905b49c..98b1d0ea50f0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3993,8 +3993,12 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 		}
 
 		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-		if (do_lru)
+		if (do_lru) {
 			lruvec = folio_lruvec_lock(folio);
+			/* Move from fbatch to lruvec before lru_add_split_folio()s */
+			if (lru_add_del_folio(folio))
+				lruvec_add_folio(lruvec, folio);
+		}
 
 		ret = __split_unmapped_folio(folio, new_order, split_at, xas,
 					     mapping, split_type);
-- 
2.51.0

