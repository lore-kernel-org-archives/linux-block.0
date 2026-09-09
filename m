Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219973E121A
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947365; cv=none; b=GNEDSYeRqhq8htGEYMCH+85WzGNzKYiVJBXbbvCzgiaRtKvGKhnJLn54j5g5HH031DIx58EZcg8HbFQEm0Ul0Et4yUj6B0GxabmT5Bki86w8GMPWS10Sb4KC5skmxPVUl10Ie0AkjWPvGsgOUHZZBdz1Csbe5D71X4hQw2b8EEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947365; c=relaxed/simple;
	bh=bmiYMnfxqxqXTndNn9OHugj8rDer4W9a5xt6AtmTM94=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fnqDtnXUCglnaPj06vXPasjzrE7VP5ObSp1hE1dXbJHwvdxxULOfVxA2sV7XnS2QqvadGz/9JpKK9C7NSlLxjs3ZX5y+eidE5Xmxhiop0GUwzLKmAxIrT8eSkhykW9ePHn2ADECh1hZwTT/sAUaFdIDUYJNIakNHMLi+Gr55t/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xy1CfrsA; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xy1CfrsA"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcaso7870417b3.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788947362; x=1789552162; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UufK0vMlC6Z+KADxCs5ZoL9LcMsl7R0DiwRuRItb70g=;
        b=Xy1CfrsA3ykgtEBzxr7he0QYrrmY3qjtfiMjhWVfHWvD82Lmk495w9h/A7UoEC7EzO
         eXtlFRoWGRO+0ipdKtnQhjzpxrzCObInhbqjlZX0+cuIUkWzJ+btylZsFb17ElAEFbik
         +ubFA4B6r3+ze2+ybMtgE1NZJdL7C6dlgkpDkXOfSWqSw/p0uJ4OeRFX7fPPlX0PUegI
         G2NVTzmc+E7kIyPHIw4GIAqIIEH524CGYYb0yO8ZP8ggJQKyznkO1d9hFGkUkYyULa3N
         w5CidnpQp/TmCwcvnk50txFpDrhOeYS49TZYOhF2wDUDLiwtFUl7lI1N6ez09IQRfpRu
         7bFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947362; x=1789552162;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UufK0vMlC6Z+KADxCs5ZoL9LcMsl7R0DiwRuRItb70g=;
        b=B4MXsZZLVTPqJ0U1dxf/XR9JeRANULa+D5vVvAquuU/Ur0kj5Ki2Ye+3qh8+HePSge
         2xsg0Iz3gpx6DwXyzXElKFt/FIIBRM/JWZtl1pjcKpITIiNHyvtmOOnBMbBkQMnWkcXt
         9bkEP9WbdKr4wbcYJQBWlOsQCKnPWecgFt34Qsub01dTN1g+UEnkFqaJsjrcuNeVc5JR
         g9WMq6yUkrAYnyVjURDgDSf/PjMFLoyRL08uxEp8bmcUCuo1fK+YikhHAu0NZoUZpZUi
         NykH3hjtbreA+tepEpKIo+H8amjkkkHCUFSkPXGbOaF/IaFiSaNw2QKkLfxV4SNinSGF
         1msg==
X-Forwarded-Encrypted: i=1; AKwUvBz5KMAU0E1FkwQHFeTiVB920ZKuTHk+d+7PawT+oII7Wj4PH+YqgXHYxs3l3/okUqDer7dW3cZ74Ni0mw==@vger.kernel.org
X-Gm-Message-State: AFuF++l4Iy/iguT7vPL8jX8ji5KFan1/sBo5qglR1PBcAr8+hoH7qOmx
	F/B/0Mk4KhM85lZJiQK5InGNSdinR2XmPxjmGBdjZtbsW+NUB4asPNf/TtAexKjBsA==
X-Gm-Gg: AYBFou0Tay2DbYNNWp7JnEXJpVAmkghq0bcrA5sKvzzpncUqMq5RYx3hkbLMX6GbWli
	PUKG/Jj864MTzqUjc5NWpxnOeXl3V9fFtm+n3Jol4xBx86swo7oDZtAWzO8+DMwFDgJOIIyA35k
	24mZI6LhOgzlE24/s6c9wXtE0b9ipzFpS5C99aIAo25dTXb+s7lc6BaVKHjasRBbCEydotlupJO
	bw2Er0jdiykUAkLxGk0grPTh17XMQsSXM8V8/Km8jDi+czaZuSMqqw3HY+cDzAbnvYCMzwnbMYm
	KHWgFuhzrWbUqie4dX9lehRFtk461GO28EhZjIwKiBjpTG8zGpzmwOQAp2HZZ0UJPu6XsLGXYz2
	VIn0DpQlKv6Ae4ZhxWeAc059OvHyFdh6RZaR26rYMPEjG/a0jrCpo5scIHBZVr7zLlJt4sBwi+w
	EHv8WSTqpX+gZkPfPFz60Y5n2qT9J4Gd+/oampfgIHuIruhGirRb+fhGdsKypAzR0MwwK0b+Efr
	7/WDUYab19usXlzU8xi6bWbvSLibMw47KWGpbmC9YsVPLaO0C6hf7SNDvk=
X-Received: by 2002:a05:690c:e3f2:b0:87c:35a5:4aea with SMTP id 00721157ae682-87f22b7eaf5mr23815837b3.6.1788947361454;
        Wed, 09 Sep 2026 02:49:21 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149600f48sm107580907b3.13.2026.09.09.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:49:20 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:49:15 -0700 (PDT)
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
Subject: [PATCH v2 04/26] mm/fbatch: lru bit set, no extra ref, while folio
 on per-cpu fbatch
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <61e15506-940f-3532-5fc9-4086f7612c10@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
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

(That bit is also used in a transient way by set_page_pfmemalloc(), to
inform interested callers whether page_is_pfmemalloc(): but those callers
are in networking, not putting folios on LRU; and accept that any use of
the page->lru field already erases page_is_pfmemalloc() information.)

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
 include/linux/mm_inline.h |  25 ++++++++
 include/linux/mm_types.h  |   6 +-
 mm/folio.c                | 119 +++++++++++++-------------------------
 mm/huge_memory.c          |   6 +-
 4 files changed, 74 insertions(+), 82 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 621c8653d8f7..8420b1276535 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -343,6 +343,29 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
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
+	unsigned long lru_next = READ_ONCE(folio->lru_next);
+
+	/* BUG_ON(folio_test_lru(folio) && folio_ref_count(folio)); */
+	if (!(lru_next & BIT(LRU_NEXT_BATCHED)))
+		return false;
+
+	WRITE_ONCE(folio->lru.next, LIST_POISON1);
+	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
+
+	/* Ensure folio->lru_next visible when folio_set_lru() called later */
+	smp_mb__before_atomic();
+	return true;
+}
+
 static __always_inline
 void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
@@ -384,6 +407,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 
 	if (lru_gen_del_folio(lruvec, folio, false))
 		return;
+	if (lru_add_del_folio(folio))
+		return;
 
 	if (lru != LRU_UNEVICTABLE)
 		list_del(&folio->lru);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6d815f6440c9..fe6220b97cf3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -85,6 +85,8 @@ struct page {
 	 * WARNING: bit 0 of the first word is used for PageTail(). That
 	 * means the other users of this union MUST NOT use the bit to
 	 * avoid collision and false-positive PageTail().
+	 * Bit 1 of the first word is used by page_is_pfmemalloc().
+	 * Bit 1 of the first word (lru_next) is also used by folio_add_lru().
 	 */
 	union {
 		struct {	/* Page cache and anonymous pages */
@@ -410,10 +412,8 @@ struct folio {
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
index b9dc4f5e10a6..e743cd539b9e 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -152,57 +152,34 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
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
 
@@ -211,8 +188,6 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 {
 	unsigned long flags;
 
-	folio_get(folio);
-
 	if (disable_irq)
 		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
 	else
@@ -273,7 +248,6 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 	if (folio_test_active(folio) || folio_test_unevictable(folio))
 		return;
 
-
 	lruvec_del_folio(lruvec, folio);
 	folio_set_active(folio);
 	lruvec_add_folio(lruvec, folio);
@@ -289,37 +263,12 @@ void folio_activate(struct folio *folio)
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
@@ -410,16 +359,7 @@ void folio_mark_accessed(struct folio *folio)
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
@@ -439,6 +379,10 @@ EXPORT_SYMBOL(folio_mark_accessed);
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
@@ -458,7 +402,26 @@ void folio_add_lru(struct folio *folio)
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
index afbb5974bd22..c7510d875433 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3995,8 +3995,12 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
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

