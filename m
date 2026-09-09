Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B052120E
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950469; cv=none; b=jMsqm9qx+HnpZ/ZzHdf922qOub/fDiwizeEP9D4rYS2XUOFMxJ1WVY8R3BHY3KMnqb3ZDbWoeajKfykaZpYRKTfTDJ+F3SIWNAYzIHJvUOLw3kvHb5jjPYRSg1vrQADv2RhtpN70Z+Vbghwmx3nsCdC+Ml6YXekG7IoObuQ8Vhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950469; c=relaxed/simple;
	bh=wCi3pUhWZvq93WjLW4ifiEYeMwDAkqD4CUEmoBl4gEM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RZi4A6kKDEzngNB4Dobf50rPmtYVK1ZJqqUIUOtGnAIgvthWKS77gMc9srTMMuYVAtD5UrBf8v7BHrgyEAytUxUkApVkS65TPcp8oKPFXpptoDUr5K2EvhJGTYrSZfBU29YmCpN9A2BKuyLJN3EoaSEPB+8yZ+xEmG+3QRDo0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFQXFG0h; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFQXFG0h"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-866e57f63a3so64122037b3.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788950467; x=1789555267; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGN+ybR37+qvtDqf9cFN47582j44el3q/H5/GSGFvrU=;
        b=uFQXFG0hXoimqiWby6dfpdSvwp1ywbxkEFfD0FeBMdu6eVcVqX/qatRdy77+gn1t28
         pr3ZJH6p0J62kW32d+tHDLRyOhkmZTfuuM3+aI5rapDZserz+Tnrlkf+ZySE48FhYCtr
         dNzHT8cG7CB++qH1YjPu0SEFSiDn7z2fU4bqPNI6ym0ohv0YhN3m/4v8A/UVzxCO8iXf
         opoWMkuRstsNVFOQsaGR6flUmhiIQ93WPekU7RlOjR8zRh4AhDkKbI6dkHFA/Ic6uhYI
         /wvnbtUiVr9xbHNaCoFf+PEN+tG44AJHK0+HlLZ+FMG/tCQsQL/0S+MmOIJyyOU5ARYT
         GGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950467; x=1789555267;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGN+ybR37+qvtDqf9cFN47582j44el3q/H5/GSGFvrU=;
        b=YRAyawVqpnXHREwskV34nrnsd0AlbXo/rFOL3ECqwGQxBnugPTEKj1myWE1GZQFEVs
         m3w/QRp+yZ86brEafTzA+1x0MJK9J3+mH86XkeLsp8Mtgf/VjnBM1SHBPQz1yoFDGcmU
         VtXWhWySQ7d0xJ0WN34BG/ACdA64NfW3ucTGUZp07pXpvDT3rH/JEh6W2ZXXjmsB0lUz
         4za9VNJcetMsRwPqwvYalo7TSeDAh33nyr6KiK7tC79ganc/mNLQDzbPUwmbVGLDxGos
         nerC1PdtVB7wWbcQK3hOFXt9amBPoj+nQqPyvRfagkPkzK95+RPn1bME3RWysIt85dl3
         XSmg==
X-Forwarded-Encrypted: i=1; AKwUvByue11IMUtOogwn6TZEdGCFjbtYrsxEasLTNblT4D7hUj0/K/ohPSo7CblrutExWT4voFrd5KN5Uy6BUw==@vger.kernel.org
X-Gm-Message-State: AFuF++kBISa9ziXIoAMAMgkJ5HwpCPWegHguazC73J8ZOhqH6Pbu18l9
	3FmcO7fvNi7EPVsHvoFPqpU+MOmVraNxFZl8fte22owLBcGf7U3qNSH91GCjfdDrng==
X-Gm-Gg: AYBFou12dKkOKNgqTY2gDjakWXmH/DsXR8Wh3P/LYw1VBYGosJlNmeBb9/1gCxc6wvd
	Sz7g8E0wZJ6aVMm5NckbYnm5VKfBpBHwlsN1DmMXaCdHszdF0fD+1Vu9M4soukoSfurA/SUu79k
	b3UJqcoHPnSlcjU56tbsdrALJuIW/upW90Pz77kI7827KDbIqXrMrwW2UwcCg8nlPN5I7luyk6q
	w4P4/6kuKg7WY9ekcg1If+694RcavHDTkZD826rCUJvJSTVcxgrhWrDw1oIqFVThxuPsU4w6pi4
	rhkRb1vSgbdB7AQdZ91jU7LPR6ZnU3lI5srwP9k+lvHzzA6pXKUo489R7PfGl821AvGHA7+3Xza
	Clfmq3O9LauJ1g5KbcAIa/y75c4iW2idQXju/chHZfEFYrhWOgQ4NHu0bsGbldL/wKQb8dAgDUQ
	ujFQ41gN0PjfVlo4PTej9F00phdY5E6Ifv3jnl3bSqXyIM72U14rTHMmul0wzGo6zTpn/yrTlTv
	HOa4sLz30jDLRqARWSe6YfxDAvmCbgniwc66XFXg6wLt44Q4i8x/jw4cqI=
X-Received: by 2002:a05:690c:e3e8:b0:81e:9826:942c with SMTP id 00721157ae682-8711c7488c4mr132269777b3.0.1788950466181;
        Wed, 09 Sep 2026 03:41:06 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714ab77c4dsm108323097b3.34.2026.09.09.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:41:05 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:41:01 -0700 (PDT)
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
Subject: [PATCH v2 27/26] mm/fbatch: paranoid folio vmstats in
 folio_batch_move_lru()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <f86f8e55-3f07-fc87-c64f-f34a3be9a013@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Save mapping and index when adding folio to per-cpu fbatch, check them
when draining the fbatch, show folio counts at the end of /proc/vmstat
when CONFIG_DEBUG_VM=y.

This is a work-in-progress hack, not intended for kernel release:
hence the 27/26 leaving it out of the series; but a useful framework
for study and reassurance on stale fbatch entries.

Could be extended to the mlock_fbatch, but probably nothing new to learn
there. May be more useful if separate stats kept for the lru_add fbatch
and (together) the other four - their characteristics are different.

Needs refinement: the current numbers raise more questions than give
answers. The folio_hoisted, folio_changed, folio_already numbers mostly
record nothing worse than LRU-eligible folio pages getting freed before
drain, and soon recycled for fresh LRU-eligible folios: no harm there;
but these stats do not verify that.

For example, after hours of kernel builds on tmpfs while swapping:

folio_not_got 65750323
folio_off_lru 357827
folio_hoisted 10458363
folio_matched 2888574439
folio_swapped 113626282
folio_changed 11558942
folio_already 12717475
folio_skipped 705

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/vm_event_item.h |  10 ++++
 mm/folio.c                    | 101 +++++++++++++++++++++++++++++++---
 mm/vmstat.c                   |  10 ++++
 3 files changed, 112 insertions(+), 9 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 2628ccda076a..4572463fb65f 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -179,6 +179,16 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NRSWPIN,
 		NRSWPOUT,
 #endif /* CONFIG_SWAP */
+#ifdef CONFIG_DEBUG_VM
+		FOLIO_NOT_GOT,
+		FOLIO_OFF_LRU,
+		FOLIO_HOISTED,
+		FOLIO_MATCHED,
+		FOLIO_SWAPPED,
+		FOLIO_CHANGED,
+		FOLIO_ALREADY,
+		FOLIO_SKIPPED,
+#endif /* CONFIG_DEBUG_VM */
 		NR_VM_EVENT_ITEMS
 };
 
diff --git a/mm/folio.c b/mm/folio.c
index 7c545e4c090d..9f0cb755595a 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -40,19 +40,35 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/pagemap.h>
 
+#ifdef CONFIG_DEBUG_VM
+#define PARANOID_SIZE FOLIO_BATCH_SIZE
+#else
+#define PARANOID_SIZE 0
+#endif
+
+struct mapix {
+	struct address_space *mapping;
+	pgoff_t index;
+};
+
 struct cpu_fbatches {
 	/*
-	 * The following folio batches are grouped together because they are protected
-	 * by disabling preemption (and interrupts remain enabled).
+	 * The following folio batches are grouped together because they are
+	 * protected by disabling preemption (and interrupts remain enabled).
 	 */
 	local_lock_t lock;
 	struct folio_batch lru_add;
+	struct mapix mapix0[PARANOID_SIZE];
 	struct folio_batch lru_activate;
+	struct mapix mapix1[PARANOID_SIZE];
 	struct folio_batch lru_deactivate_file;
+	struct mapix mapix2[PARANOID_SIZE];
 	struct folio_batch lru_deactivate;
+	struct mapix mapix3[PARANOID_SIZE];
 	/* Protecting the following batches which require disabling interrupts */
 	local_lock_t lock_irq;
 	struct folio_batch lru_move_tail;
+	struct mapix mapix4[PARANOID_SIZE];
 };
 
 static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
@@ -60,6 +76,57 @@ static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
 	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
 };
 
+#if PARANOID_SIZE
+static void paranoid_count(enum vm_event_item folio_counter)
+{
+	count_vm_event(folio_counter);
+}
+
+static void paranoid_save_mapix(struct folio_batch *fbatch)
+{
+	int i = fbatch->nr - 1;	/* folio has just been added */
+	struct mapix *mapix;
+
+	mapix = (struct mapix *)(fbatch->folios + ARRAY_SIZE(fbatch->folios));
+	mapix += i;
+	mapix->mapping = fbatch->folios[i]->mapping;
+	mapix->index = fbatch->folios[i]->index;
+}
+
+static void paranoid_check_mapix(struct folio_batch *fbatch, int i)
+{
+	struct folio *folio = fbatch->folios[i];
+	enum vm_event_item folio_counter;
+	struct mapix *mapix;
+	unsigned long lru_next = READ_ONCE(folio->lru_next);
+
+	if (lru_next & BIT(LRU_NEXT_BATCHED)) {
+		lru_next ^= (unsigned long)&fbatch->folios[i];
+		if (lru_next & ~(BIT(NR_LRU_NEXT_FLAGS) - 1))
+			paranoid_count(FOLIO_HOISTED);
+	}
+
+	mapix = (struct mapix *)(fbatch->folios + ARRAY_SIZE(fbatch->folios));
+	mapix += i;
+	if (folio->mapping == mapix->mapping && folio->index == mapix->index) {
+		folio_counter = FOLIO_MATCHED;
+	} else if (!folio->mapping || !mapix->mapping) {
+		/* Truncated? Swapcache? Needs more cleverness */
+		if (folio->index == mapix->index)
+			folio_counter = FOLIO_MATCHED;
+		else
+			folio_counter = FOLIO_SWAPPED;
+	} else {
+		folio_counter = FOLIO_CHANGED;
+	}
+	paranoid_count(folio_counter);
+}
+#else
+static void paranoid_count(int event) { }
+static void paranoid_save_mapix(struct folio_batch *fbatch) { }
+static void paranoid_check_mapix(struct folio_batch *fbatch, int i) { }
+#endif
+
 static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
 		unsigned long *flagsp)
 {
@@ -135,22 +202,32 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
 
-		if (!folio_try_get(folio))
+		if (!folio_try_get(folio)) {
+			paranoid_count(FOLIO_NOT_GOT);
 			continue;
+		}
 
-		if (!folio_test_clear_lru(folio))
+		if (!folio_test_clear_lru(folio)) {
+			paranoid_count(FOLIO_OFF_LRU);
 			goto restored_lru;
+		}
+
+		paranoid_check_mapix(fbatch, i);
 
 		/* Do not add to LRU if it has already been added */
-		if (move_fn == lru_add && !lru_add_del_folio(folio))
+		if (move_fn == lru_add && !lru_add_del_folio(folio)) {
+			paranoid_count(FOLIO_ALREADY);
 			goto restore_lru;
+		}
 
 		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
 		move_fn(lruvec, folio);
 
 		/* Do add to LRU if not already there (move_fn skipped) */
-		if (lru_add_del_folio(folio))
+		if (lru_add_del_folio(folio)) {
 			lruvec_add_folio(lruvec, folio);
+			paranoid_count(FOLIO_SKIPPED);
+		}
 restore_lru:
 		folio_set_lru(folio);
 		/* See mm/vmscan.c move_folios_to_lru() comment on ordering */
@@ -176,16 +253,21 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		struct folio *folio, move_fn_t move_fn, bool disable_irq)
 {
+	struct folio_batch *cpu_fbatch;
 	unsigned long flags;
+	bool full;
 
 	if (disable_irq)
 		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
 	else
 		local_lock(&cpu_fbatches.lock);
 
-	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
-			!folio_may_be_lru_cached(folio))
-		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
+	cpu_fbatch = this_cpu_ptr(fbatch);
+	full = !folio_batch_add(cpu_fbatch, folio);
+	paranoid_save_mapix(cpu_fbatch);
+
+	if (full || !folio_may_be_lru_cached(folio))
+		folio_batch_move_lru(cpu_fbatch, move_fn);
 
 	if (disable_irq)
 		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
@@ -440,6 +522,7 @@ void __folio_add_lru(struct folio *folio, bool mlockit)
 	}
 
 	full = !folio_batch_add(fbatch, folio);
+	paranoid_save_mapix(fbatch);
 
 	/* Ensure folio->lru_next visible to folio_test_clear_lru() callers */
 	smp_mb__before_atomic();
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d66cb67f55ce..cc61ac10782a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1507,6 +1507,16 @@ const char * const vmstat_text[] = {
 	[I(NRSWPIN)]				= "nrswpin",
 	[I(NRSWPOUT)]				= "nrswpout",
 #endif /* CONFIG_SWAP */
+#ifdef CONFIG_DEBUG_VM
+	[I(FOLIO_NOT_GOT)]			= "folio_not_got",
+	[I(FOLIO_OFF_LRU)]			= "folio_off_lru",
+	[I(FOLIO_HOISTED)]			= "folio_hoisted",
+	[I(FOLIO_MATCHED)]			= "folio_matched",
+	[I(FOLIO_SWAPPED)]			= "folio_swapped",
+	[I(FOLIO_CHANGED)]			= "folio_changed",
+	[I(FOLIO_ALREADY)]			= "folio_already",
+	[I(FOLIO_SKIPPED)]			= "folio_skipped",
+#endif /* CONFIG_DEBUG_VM */
 #undef I
 #endif /* CONFIG_VM_EVENT_COUNTERS */
 };
-- 
2.51.0

