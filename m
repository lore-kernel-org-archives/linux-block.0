Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25C42F6F1
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580722; cv=none; b=ulzQp1EyLNrSKdDgs0//1XE2gA9S534HPhzkSh9nm5zr6jIcw2wOmIg+7yw07nTlUBMEVMrPY69PB3VCydEfmrn7Rt9gx/MRfUJ0TXvsfndgwXaXkOCXXQQpt404IQfzLe2LUtr4w/YASe7m0PWtBWS/q+QTdI1NYP+NMENicqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580722; c=relaxed/simple;
	bh=+0fA+IVzLIwd37UWmLHSvuI1Tv12RLXSll+aIlyQ6d4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GZ5Q5OzjCEV22LO+i8du3lTx38cZQyIl738quiAmzXCsCj6DpDx+opmN2sMSrAPOaudJHjR0WoZhn9C/rGrkCAD/IoK+Nq/3wb7hP4r0fxP2ZIUb87wDLlRtEA5toum5/psABMNDlwTp9Y8CQmELS3mxwlqW+D886ObNkdO8CNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0YcQbpG; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0YcQbpG"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8200b55dc47so54375457b3.3
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787580719; x=1788185519; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDepnQKhG/ALdT6VngAfs3Gdhl8mXkl03WI9zXHFkmc=;
        b=A0YcQbpGMz6mq26efc2DqHEyIWOaIbyD7Z/jkLzJQcz/NuEYwkA+ZCFJQtPCP/xID2
         qpVs9A6H5Ytq6Z+lkwAuwVQGxRBhBzNIk1LHyIxt4cTO73U+nuxIvcbxodTZ0qaxE4/k
         2kEK/HI8x4BnrHV8bbcHZmpkMc/55P88Zk+QBIVtg8mvkZO/xhXPA0ryOhZStniQIeUp
         TIAJlt9FhQ7MDkD0srz0QzdhyKCvUflUJtKmK3lyuOHlnate8NK8flWHYM9nzd/l3loH
         eV8dgMF7SQdaB3l9ezeR1a+NZu95gC8Jwpbkn9c+8xWZ8TC3nFEf4/RqAcPJ+5qC7wwJ
         e0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580719; x=1788185519;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDepnQKhG/ALdT6VngAfs3Gdhl8mXkl03WI9zXHFkmc=;
        b=GrLExTICXe8CkydPU80sxX0O4Dqv7mb90JhP4k6qAHKype5gnD5e3PbJ3nDV2j5/Lh
         9ylHURs5ZE/m33wharXyRtypF90/yF9S3tfjTOW6Q1mbqMYIGBgj0beWuABU+aB4ojIg
         O6ii1caPLEOG+F3G5olAzACvV9Zp85MC2KJmDbEr/i7jY87qZ0k5ECJC0jDcWQEUwrL9
         Gd2NSTMtAL6mroqtqKcakL4wutBT0cPwZUbEyrnXgTFwfEuSlfxej9qr09U9F1dad0dI
         0C4Mi81H8UmGE38C1lw/dLGzf6RI9i5oEukdg7YmUVvzczpusuVbyrXvf7Syn/BkhJi4
         tytg==
X-Forwarded-Encrypted: i=1; AHgh+RoNDN26MoiUbrvzhnVE4qVM6cvUTYSST6/MgthXAefAH/Ak0p+1WUaIpQrA9fZb3rTvDSbIjXy6n38PZw==@vger.kernel.org
X-Gm-Message-State: AFuF++mZY41bYBDGH4JNxadop1C0Wa/axvTfHegGvDwHjPB3a+12BXpY
	VoJ7jkynFK4fXyEnxPOG/+Q4HKdyOdudvWZhnLJktySWrxYCKfVC/KhXnFlMLIlWCw==
X-Gm-Gg: AR+sD11aBAbJNqT+OTqqJ/nABKQ3LgrL/mCha4Vsc9jGv+8YPViHbcYTd+XowvlxlLo
	kdcCyDnBlfrr/hgOiUutjm+PWmW8oGa1JvGBZqkkg8MzfAgXGxeiiRlB4raxck3oinEE0XGne5Y
	hX7V0NU0VG73umAS5Y/JprInp41nmy4dBw8H8f0ul1lOLcOiLZl7WXDkHa1wC5JtcLB0VOgYGE0
	+9rOo4gtuhSiibT7HjoKwSMJpEpPRCdPcqa00hKznNdfbThzjSdLTNYQl76pBHKgBTrVTGBbUzW
	dIK2Zwq0fvXDJPioj9d0X9zHARWCUaWX10GbOLwWMHs05SFsndytwS3t5hXl3XVeSdjD5iOw69X
	kdRv/SSkgr4YT6A/8uSpMRdUqUkR6C1nmv+fhTYZlfZFrsYWlq793Ac9k8zesy/53E1PcDB49Ev
	G1ZFi4ZTyU2s7yVlO3YMS7oGSbWHWTBKz0Px5ZVH1uZHk++IYmUhQjEFiaeCKNrWwYcGtqFKBcV
	7TAZLj7b73RXxoGqsRXvviXLCF4i5h/XUo2hA57yBlIG4YRJAApnN2oxWSu
X-Received: by 2002:a05:690c:398:b0:815:bc6a:2e48 with SMTP id 00721157ae682-84c97c883fcmr78457887b3.14.1787580717737;
        Mon, 24 Aug 2026 07:11:57 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca62f6ad5sm33965507b3.18.2026.08.24.07.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:11:56 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:11:52 -0700 (PDT)
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
Subject: [PATCH 08/25] mm/fbatch: replace mlock_new_folio() by
 __folio_add_lru(,mlockit)
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <faddc309-6d92-caa5-c9c9-1b2fe5f37f6e@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Replace mlock_new_folio(), working on mm/mlock.c's mlock_fbatch, by
__folio_add_lru(,mlockit), working on mm/folio.c's lru_add fbatch:
folio moved to lruvec by lru_add(), with its mlocking incidental.

Remove old comment about not needing smp_mb__after_atomic() from
lru_add(): but that is a detail which will need to be reconsidered.

Initialize mlock_count earlier, when adding to fbatch rather than when
adding to lruvec. mlock_count count in 2s, with the low bit set to
distinguish it from lru.prev. This helps when an mlocked folio is put
back early by compaction, but will enable further optimization next.

Change mlock_count from unsigned int to long: long to match pointer
without endian concerns, signed for better treatment of those rare
cases when final munlocks precede their still batched mlocks.

This is an intermediate, poorly tested review stage: mlock_new_folio()
code removed from mm/mlock.c, remaining code there updated to respect
the new mlock_count accounting, but not considered beyond that.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 Documentation/mm/unevictable-lru.rst |  2 +-
 include/linux/mm_types.h             |  8 +++-
 include/linux/swap.h                 |  6 ++-
 mm/folio.c                           | 59 ++++++++++++------------
 mm/huge_memory.c                     |  2 +-
 mm/internal.h                        |  4 +-
 mm/mlock.c                           | 67 ++++------------------------
 7 files changed, 52 insertions(+), 96 deletions(-)

diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 8d11fe6a0854..45b453226336 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -314,7 +314,7 @@ For each PTE (or PMD) being faulted into a VMA, the page add rmap function
 calls mlock_vma_folio(), which calls mlock_folio() when the VMA is VM_LOCKED
 (unless it is a PTE mapping of a part of a transparent huge page).  Or when
 it is a newly allocated anonymous page, folio_add_lru_vma() calls
-mlock_new_folio() instead: similar to mlock_folio(), but can make better
+__folio_add_lru(mlockit) instead: similar to mlock_folio(), but can make better
 judgments, since this page is held exclusively and known not to be on LRU yet.
 
 mlock_folio() sets PG_mlocked immediately, then places the page on the CPU's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2b1a1f983a91..049b114aee09 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -359,7 +359,7 @@ typedef unsigned short mm_id_t;
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
  * @lru: Least Recently Used list; tracks how recently this folio was used.
- * @mlock_count: Number of times this folio has been pinned by mlock().
+ * @mlock_count: Number of times this folio has been pinned by mlock() *2 +1
  * @mapping: The file this page belongs to, or refers to the anon_vma for
  *    anonymous memory.
  * @index: Offset within the file, in units of pages.  For anonymous memory,
@@ -413,7 +413,7 @@ struct folio {
 				struct {
 					unsigned long lru_next;
 	/* public: */
-					unsigned int mlock_count;
+					long mlock_count;
 	/* private: */
 				};
 	/* public: */
@@ -507,6 +507,10 @@ struct folio {
 	};
 };
 
+/* folio's mlock_count is doubled, low bit set to distinguish from lru.prev */
+#define MLOCK_COUNT_0	1	/* Bit not set in any aligned pointer */
+#define MLOCK_COUNT_1	2	/* Increment or decrement mlock_count */
+
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
 FOLIO_MATCH(flags, flags);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 696ed01709c2..f21e1dd6febc 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -294,7 +294,11 @@ extern unsigned long totalreserve_pages;
 #define nr_free_pages() global_zone_page_state(NR_FREE_PAGES)
 
 /* linux/mm/folio.c */
-void folio_add_lru(struct folio *folio);
+void __folio_add_lru(struct folio *folio, bool mlockit);
+static inline void folio_add_lru(struct folio *folio)
+{
+	__folio_add_lru(folio, false);
+}
 void folio_mark_accessed(struct folio *folio);
 void lru_add_drain_all(void);
 
diff --git a/mm/folio.c b/mm/folio.c
index 0d8eb9cf5ad5..fa4cf9d7d51b 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -112,31 +112,12 @@ static void lru_add(struct lruvec *lruvec, struct folio *folio)
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
-	/*
-	 * Is an smp_mb__after_atomic() still required here, before
-	 * folio_evictable() tests the mlocked flag, to rule out the possibility
-	 * of stranding an evictable folio on an unevictable LRU?  I think
-	 * not, because __munlock_folio() only clears the mlocked flag
-	 * while the LRU lock is held.
-	 *
-	 * (That is not true of __page_cache_release(), and not necessarily
-	 * true of folios_put(): but those only clear the mlocked flag after
-	 * folio_put_testzero() has excluded any other users of the folio.)
-	 */
 	if (folio_evictable(folio)) {
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
 		folio_clear_active(folio);
 		folio_set_unevictable(folio);
-		/*
-		 * folio->mlock_count = !!folio_test_mlocked(folio)?
-		 * But that leaves __mlock_folio() in doubt whether another
-		 * actor has already counted the mlock or not.  Err on the
-		 * safe side, underestimate, let page reclaim fix it, rather
-		 * than leaving a page on the unevictable LRU indefinitely.
-		 */
-		folio->mlock_count = 0;
 		if (!was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
@@ -449,15 +430,16 @@ void folio_mark_accessed(struct folio *folio)
 EXPORT_SYMBOL(folio_mark_accessed);
 
 /**
- * folio_add_lru - Add a folio to an LRU list.
+ * __folio_add_lru - Add a folio to an LRU list.
  * @folio: The folio to be added to the LRU.
+ * @mlockit: Mark the folio as mlocked.
  *
  * Queue the folio for addition to the LRU. The decision on whether
  * to add the page to the [in]active [file|anon] list is deferred until the
  * folio_batch is drained. This gives a chance for the caller of folio_add_lru()
- * have the folio added to the active list using folio_mark_accessed().
+ * to have the folio added to the active list using folio_mark_accessed().
  */
-void folio_add_lru(struct folio *folio)
+void __folio_add_lru(struct folio *folio, bool mlockit)
 {
 	struct folio_batch *fbatch;
 	unsigned long lru_next;
@@ -492,6 +474,27 @@ void folio_add_lru(struct folio *folio)
 	lru_next |= BIT(LRU_NEXT_BATCHED);
 	folio->lru_next = lru_next;
 
+	if (mlockit) {
+		long nr_pages = folio_nr_pages(folio);
+
+		folio_set_mlocked(folio);
+		folio->mlock_count = MLOCK_COUNT_0 + MLOCK_COUNT_1;
+		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
+		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+	} else if (folio_test_mlocked(folio)) {
+		/*
+		 * A folio is being put back while mlocked. If mlock_count
+		 * has not been overwritten by use of lru.prev, believe it.
+		 * Otherwise, since there may be __mlock_folio()s to come
+		 * through, initialize it to the safer 0 rather than to 1.
+		 */
+		if (!(folio->mlock_count & MLOCK_COUNT_0))
+			folio->mlock_count = MLOCK_COUNT_0;
+	} else {
+		/* Initialize this field, which the page allocator did not */
+		folio->mlock_count = MLOCK_COUNT_0;
+	}
+
 	full = !folio_batch_add(fbatch, folio);
 
 	/* Ensure folio->lru_next visible to folio_test_clear_lru() callers */
@@ -503,24 +506,20 @@ void folio_add_lru(struct folio *folio)
 
 	local_unlock(&cpu_fbatches.lock);
 }
-EXPORT_SYMBOL(folio_add_lru);
+EXPORT_SYMBOL(__folio_add_lru);
 
 /**
  * folio_add_lru_vma() - Add a folio to the appropriate LRU list for this VMA.
  * @folio: The folio to be added to the LRU.
  * @vma: VMA in which the folio is mapped.
  *
- * If the VMA is mlocked, @folio is added to the unevictable list.
+ * If the VMA is mlocked, @folio will be added to the unevictable list.
  * Otherwise, it is treated the same way as folio_add_lru().
  */
 void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
 {
-	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
-
-	if (unlikely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED))
-		mlock_new_folio(folio);
-	else
-		folio_add_lru(folio);
+	__folio_add_lru(folio,
+		(vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED);
 }
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b1f315400111..c7bd99592195 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3621,7 +3621,7 @@ static void lru_add_split_folio(struct folio *folio, struct folio *new_folio,
 		/* head is still on lru (and we have it frozen) */
 		VM_WARN_ON(!folio_test_lru(folio));
 		if (folio_test_unevictable(folio))
-			new_folio->mlock_count = 0;
+			new_folio->mlock_count = MLOCK_COUNT_0;
 		else
 			list_add_tail(&new_folio->lru, &folio->lru);
 		folio_set_lru(new_folio);
diff --git a/mm/internal.h b/mm/internal.h
index ababee1a8872..ff4bd3a14539 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -976,7 +976,7 @@ folio_within_vma(struct folio *folio, struct vm_area_struct *vma)
  *
  * mlock is usually called at the end of folio_add_*_rmap_*(), munlock at
  * the end of folio_remove_rmap_*(); but new anon folios are managed by
- * folio_add_lru_vma() calling mlock_new_folio().
+ * folio_add_lru_vma() calling __folio_add_lru().
  */
 void mlock_folio(struct folio *folio);
 static inline void mlock_vma_folio(struct folio *folio,
@@ -1011,7 +1011,6 @@ static inline void munlock_vma_folio(struct folio *folio,
 		munlock_folio(folio);
 }
 
-void mlock_new_folio(struct folio *folio);
 bool need_mlock_drain(int cpu);
 void mlock_drain_local(void);
 void mlock_drain_remote(int cpu);
@@ -1105,7 +1104,6 @@ static inline bool vma_supports_mlock(const struct vm_area_struct *vma)
 
 #else /* !CONFIG_MMU */
 static inline void unmap_mapping_folio(struct folio *folio) { }
-static inline void mlock_new_folio(struct folio *folio) { }
 static inline bool need_mlock_drain(int cpu) { return false; }
 static inline void mlock_drain_local(void) { }
 static inline void mlock_drain_remote(int cpu) { }
diff --git a/mm/mlock.c b/mm/mlock.c
index 14c02e155d68..53d754e82ba2 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -85,14 +85,16 @@ static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 
 	if (folio_test_unevictable(folio)) {
 		if (folio_test_mlocked(folio))
-			folio->mlock_count++;
+			folio->mlock_count += MLOCK_COUNT_1;
 		goto out;
 	}
 
 	lruvec_del_folio(lruvec, folio);
 	folio_clear_active(folio);
 	folio_set_unevictable(folio);
-	folio->mlock_count = !!folio_test_mlocked(folio);
+	folio->mlock_count = MLOCK_COUNT_0;
+	if (folio_test_mlocked(folio))
+		folio->mlock_count += MLOCK_COUNT_1;
 	lruvec_add_folio(lruvec, folio);
 	__count_vm_events(UNEVICTABLE_PGCULLED, folio_nr_pages(folio));
 out:
@@ -100,25 +102,6 @@ static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 	return lruvec;
 }
 
-static struct lruvec *__mlock_new_folio(struct folio *folio, struct lruvec *lruvec)
-{
-	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
-
-	lruvec = folio_lruvec_relock_irq(folio, lruvec);
-
-	/* As above, this is a little surprising, but possible */
-	if (unlikely(folio_evictable(folio)))
-		goto out;
-
-	folio_set_unevictable(folio);
-	folio->mlock_count = !!folio_test_mlocked(folio);
-	__count_vm_events(UNEVICTABLE_PGCULLED, folio_nr_pages(folio));
-out:
-	lruvec_add_folio(lruvec, folio);
-	folio_set_lru(folio);
-	return lruvec;
-}
-
 static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
 {
 	int nr_pages = folio_nr_pages(folio);
@@ -132,9 +115,9 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
 
 	if (folio_test_unevictable(folio)) {
 		/* Then mlock_count is maintained, but might undercount */
-		if (folio->mlock_count)
-			folio->mlock_count--;
-		if (folio->mlock_count)
+		if (folio->mlock_count > MLOCK_COUNT_0)
+			folio->mlock_count -= MLOCK_COUNT_1;
+		if (folio->mlock_count > MLOCK_COUNT_0)
 			goto out;
 	}
 	/* else assume that was the last mlock: reclaim will fix it if not */
@@ -165,17 +148,11 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
  * Flags held in the low bits of a struct folio pointer on the mlock_fbatch.
  */
 #define LRU_FOLIO 0x1
-#define NEW_FOLIO 0x2
 static inline struct folio *mlock_lru(struct folio *folio)
 {
 	return (struct folio *)((unsigned long)folio + LRU_FOLIO);
 }
 
-static inline struct folio *mlock_new(struct folio *folio)
-{
-	return (struct folio *)((unsigned long)folio + NEW_FOLIO);
-}
-
 /*
  * mlock_folio_batch() is derived from folio_batch_move_lru(): perhaps that can
  * make use of such folio pointer flags in future, but for now just keep it for
@@ -192,14 +169,12 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		folio = fbatch->folios[i];
-		mlock = (unsigned long)folio & (LRU_FOLIO | NEW_FOLIO);
+		mlock = (unsigned long)folio & LRU_FOLIO;
 		folio = (struct folio *)((unsigned long)folio - mlock);
 		fbatch->folios[i] = folio;
 
-		if (mlock & LRU_FOLIO)
+		if (mlock)
 			lruvec = __mlock_folio(folio, lruvec);
-		else if (mlock & NEW_FOLIO)
-			lruvec = __mlock_new_folio(folio, lruvec);
 		else
 			lruvec = __munlock_folio(folio, lruvec);
 	}
@@ -261,30 +236,6 @@ void mlock_folio(struct folio *folio)
 	local_unlock(&mlock_fbatch.lock);
 }
 
-/**
- * mlock_new_folio - mlock a newly allocated folio not yet on LRU
- * @folio: folio to be mlocked, either normal or a THP head.
- */
-void mlock_new_folio(struct folio *folio)
-{
-	struct folio_batch *fbatch;
-	int nr_pages = folio_nr_pages(folio);
-
-	local_lock(&mlock_fbatch.lock);
-	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
-	folio_set_mlocked(folio);
-
-	zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
-	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
-
-	folio_get(folio);
-	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
-	    true || /* XXX Temporarily disable mlock_new batching */
-	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
-		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
-}
-
 /**
  * munlock_folio - munlock a folio
  * @folio: folio to be munlocked, either normal or a THP head.
-- 
2.51.0

