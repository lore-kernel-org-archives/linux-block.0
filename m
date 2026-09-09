Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614F37FF41
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947971; cv=none; b=M12zNEgBHtwEkrVE4YsqLntv5uxw33Dc1iuTm901OvDgRcOe8lrTBcCdIgCs7yNc6g7aSFMDJwdgp0TGxDCWBDlelyp9KXEEZMWV2y2EU/LkE6scLWOjccAZYSBNG2O/gsc4FWfeXV4aPnYiVlQTut75kIJJGbHdclYg5AlXRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947971; c=relaxed/simple;
	bh=IHzeNW4hzepc7IxdL36p9gKzWS2I1X5tar9DJ0IM6+Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ogvh0PsrrDXYfMTsCt1UkZ0ZV5PD0pqgfUc6A+aTejuMjL54xaeBiT3WRRCSJ1e5aGVGX3H2DYs1RyGrJbnyd7nVxxWm8Yke5b9xCTCfikhOx4oY+8ioe8B0GWLgpt2wy0txq5Qv+cD1/WnpzTjMOEwJQJnQlB7bk9YcP5Er98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muDnN76x; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muDnN76x"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201f9so657d50.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788947968; x=1789552768; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lcHKAya+E91RVS5tU8FF9W2nmuTVga+iF8pC6HMIeNs=;
        b=muDnN76xWRqveKhXb6pdgab8dzilAKxPgXsLv5ubkAmcOYKm8vNv7U8pR5/8YykYhi
         aSAzBF6FpyMEgq7OF+wtoc88QjekB33PT5nvElUpRgpCnZcjTKtOxqK94Y2bphCgFSdW
         4CTtVOei3ir/EajkPxEZci8w1eHkRJwcn2/V1wUHKbhEn333GupLOi/vodZNNHQ5vVh3
         Flh1wDoIlAo20UNXDLfbYy9F/BCkf3CLWnbun9NZEZAj+UnAgOoF36GkV4MEsXkb8Qvn
         ciS6hljlOtzr+xyRLMDRRO1DH3zstEb1E4lLuWenaKA/pl25Lh38fOQoOmJSrECUzgxN
         MefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947968; x=1789552768;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lcHKAya+E91RVS5tU8FF9W2nmuTVga+iF8pC6HMIeNs=;
        b=euYsi5h7VXe7ABquGqDvcWK7P3+b9TxIA0ngAFlPqkwSiAhCKQ2dWGU8bxbivt0XJg
         Umc5TfxDuT9xhgDQBQ+Dh+r7IvFWzea6JIMWyohnwQOQFjyhX7CJxaWDh4za60wEIsYw
         J6nnsY3PgeArVJfXYLp914s/cP73IWvHut/ycGylquYZ9RI6cvx/zgbPqKdlli2RRbDR
         XkwolekaY+ZQ9DtvqG35pMmqyBSpiPZEOGGsihP+tEhb4K0kViBsE2Q4vfdJZ30Y6wiy
         66chH2O1nd7kZU2Rm5X24tP7AXhJm41fBCPXqc5YJ431WxS7aSSVhtJ17/21hHsBgkz9
         OIlg==
X-Forwarded-Encrypted: i=1; AKwUvBwdHmYfSwDDInENgUAPrJ3dFLjyfcPrs15rRvAXHeMFGxtb2TG/CTzeEhFhlsS9WruDY48L7tq1AxiucA==@vger.kernel.org
X-Gm-Message-State: AFuF++nrJiLQP0ZXx7weNrNGrqE/VymRPnSvFMj9A8NVjCvFnZHUc+VS
	gfnCggxNMjL/ugNOJTWGjVeMhlpSqHhYh4zjUcAJxiMoBhPQhm97yTmTj4pFVSwLDA==
X-Gm-Gg: AYBFou06l9CKzpWrfI2GSMm6T8/gwlxhIt6X6aRM9wbLEdMh6gOrNa1WWtNk4RjAzCh
	m1OZO/8K0vZcxj7Tqiv9MgLuYiOxZ7J9l//9ZYXp1XStGFFm5xp7/YHkiQBxYDQSFi+P5XgxciI
	FN7f5yvDkTE6mO646JawtEr+cRTJ62crPou+bCrBBPCoDj40bswdE6uZbt1mWXuxyLd0fON0AEE
	rxWnMVql0dFZsZuc4gXfUOUBeO9ctSRMOltfjsC0zcv1VTvDp0WDTYwWOKGwT6kW5dhFkoIC1UV
	r/8m4YpFae2ROluge8dRIOJ11I0WXRSabNj2e11zWAUUngeSRMQa2QyR16cGy3MELU2dlIWHlFT
	tLZEcN2in7fGMhj+8dpLwjCNcNstdcX+jU6JdCZjhhc1kNWa5mwwfdgFS+E75V/7Z4t/Ld/oOSM
	JMDG5UESLVe8JLewTW4XWnF5k/QArfmspZ3ntDj9Bh61mcCXr5QUmpcFLEQc/8H+F+nSOKcKgSM
	iZSbRWg9oO3MCS62dDWoSgtaj9xVc9RSD/IFOT7L4iuiBHMJl8T6h5H7ORDkcL+e72+/g==
X-Received: by 2002:a05:690c:31a:b0:87c:a15f:b667 with SMTP id 00721157ae682-88153e6779amr21037b3.19.1788947966891;
        Wed, 09 Sep 2026 02:59:26 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714c1e1eacsm107507057b3.49.2026.09.09.02.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:59:25 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:59:21 -0700 (PDT)
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
Subject: [PATCH v2 09/26] mm/fbatch: restore mlock+munlock batching, without
 extra ref
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <69ba633c-8fd5-1f4b-2e1e-b9b15b8946be@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Update mlock_folio(), munlock_folio() and their fbatch callouts and
helpers, to do folio_try_get()s at batch processing time, instead of
holding a folio reference all the while in mlock_fbatch: as in folio.c.

But more interesting is the use of mod_mlock_count(), using try_cmpxchg()
to update folio->mlock_count safely when possible (now when on lru_add
fbatch as well as when unevictable). While __mlock_folio() is as hard to
think about as before, __munlock_folio() simpler because munlock_folio()
can adjust mlock_count itself without clear_lru() or lruvec lock, and so
do the folio_test_clear_mlocked() immediately for itself (without which
unevictable_pgs_cleared was likely to appear high, when it should be 0
or low to indicate good mlock health).

__munlock_folio() is safe for use even when the unreferenced folio has
been freed and reused. It appears that __mlock_folio() could affect a
folio which has been freed and reused, but only if it is reused as an
mlocked folio, in which case its mlock_count is spuriously incremented
(but usually a spurious munlock decrement will follow).  How grave is
this? If unevictable_pgs_cleared remains low, not so bad.

I've gone back and forth on whether to move mlock_fbatch and these
functions into mm/folio.c: for now they stay here in mm/mlock.c.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mlock.c | 147 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 61 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 2c690f18031e..1050010bbe0b 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -58,6 +58,20 @@ EXPORT_SYMBOL(can_do_mlock);
  * indicate the unevictable state.
  */
 
+static long mod_mlock_count(struct folio *folio, long incdec)
+{
+	long mlock_count = READ_ONCE(folio->mlock_count);
+
+	while (mlock_count & MLOCK_COUNT_0) {
+		if (mlock_count + incdec < MLOCK_COUNT_0)
+			return MLOCK_COUNT_0;
+		if (try_cmpxchg(&folio->mlock_count, &mlock_count,
+				mlock_count + incdec))
+			return mlock_count + incdec;
+	}
+	return 0;
+}
+
 static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 {
 	/* There is nothing more we can do while it's off LRU */
@@ -65,6 +79,7 @@ static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 		return lruvec;
 
 	lruvec = folio_lruvec_relock_irq(folio, lruvec);
+	lruvec_del_folio(lruvec, folio);
 
 	if (unlikely(folio_evictable(folio))) {
 		/*
@@ -73,92 +88,82 @@ static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 		 * folio be unevictable?  I'm not sure, but move it now if so.
 		 */
 		if (folio_test_unevictable(folio)) {
-			lruvec_del_folio(lruvec, folio);
 			folio_clear_unevictable(folio);
-			lruvec_add_folio(lruvec, folio);
-
 			__count_vm_events(UNEVICTABLE_PGRESCUED,
 					  folio_nr_pages(folio));
 		}
 		goto out;
 	}
 
+	/*
+	 * Something to keep in mind when studying the arithmetic here:
+	 * we only come to __mlock_folio() when mlock_folio() could not
+	 * mod_mlock_count() itself; but by the time this is processed,
+	 * the folio may have already been munlocked, or another mlock
+	 * already marked it as unevictable and so mod_mlock_countable.
+	 * And don't forget that a folio may be unevictable for reasons
+	 * other than mlocked (hence the folio_evictable() check above).
+	 */
+
 	if (folio_test_unevictable(folio)) {
 		if (folio_test_mlocked(folio))
-			folio->mlock_count += MLOCK_COUNT_1;
+			mod_mlock_count(folio, MLOCK_COUNT_1);
 		goto out;
 	}
 
-	lruvec_del_folio(lruvec, folio);
 	folio_clear_active(folio);
 	folio_set_unevictable(folio);
-	folio->mlock_count = MLOCK_COUNT_0;
-	if (folio_test_mlocked(folio))
-		folio->mlock_count += MLOCK_COUNT_1;
-	lruvec_add_folio(lruvec, folio);
 	__count_vm_events(UNEVICTABLE_PGCULLED, folio_nr_pages(folio));
+
+	if (!folio_test_mlocked(folio))
+		folio->mlock_count = MLOCK_COUNT_0;
+	else if (!mod_mlock_count(folio, MLOCK_COUNT_1))
+		folio->mlock_count = MLOCK_COUNT_0 + MLOCK_COUNT_1;
 out:
+	lruvec_add_folio(lruvec, folio);
 	folio_set_lru(folio);
 	return lruvec;
 }
 
 static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
 {
-	int nr_pages = folio_nr_pages(folio);
-	bool isolated = false;
+	long nr_pages = folio_nr_pages(folio);
 
-	if (!folio_test_clear_lru(folio))
-		goto munlock;
-
-	isolated = true;
-	lruvec = folio_lruvec_relock_irq(folio, lruvec);
-
-	if (folio_test_unevictable(folio)) {
-		/* Then mlock_count is maintained, but might undercount */
-		if (folio->mlock_count > MLOCK_COUNT_0)
-			folio->mlock_count -= MLOCK_COUNT_1;
-		if (folio->mlock_count > MLOCK_COUNT_0)
-			goto out;
-	}
-	/* else assume that was the last mlock: reclaim will fix it if not */
-
-munlock:
-	if (folio_test_clear_mlocked(folio)) {
-		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
-		if (isolated || !folio_test_unevictable(folio))
-			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
-		else
+	/* There is nothing more we can do while it's off LRU */
+	if (!folio_test_clear_lru(folio)) {
+		if (folio_test_unevictable(folio) && folio_evictable(folio))
 			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
+		/* But whoever puts it back on LRU should rescue it */
+		return lruvec;
 	}
 
-	/* folio_evictable() has to be checked *after* clearing Mlocked */
-	if (isolated && folio_test_unevictable(folio) && folio_evictable(folio)) {
-		lruvec_del_folio(lruvec, folio);
+	lruvec = folio_lruvec_relock_irq(folio, lruvec);
+	lruvec_del_folio(lruvec, folio);
+
+	if (folio_test_unevictable(folio) && folio_evictable(folio)) {
 		folio_clear_unevictable(folio);
-		lruvec_add_folio(lruvec, folio);
 		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	}
-out:
-	if (isolated)
-		folio_set_lru(folio);
+
+	lruvec_add_folio(lruvec, folio);
+	folio_set_lru(folio);
 	return lruvec;
 }
 
 /*
- * Flags held in the low bits of a struct folio pointer on the mlock_fbatch.
+ * Flag held in the low bits of a struct folio pointer on the mlock_fbatch.
  */
-#define LRU_FOLIO 0x1
-static inline struct folio *mlock_lru(struct folio *folio)
+#define MLOCK_FLAG 0x1
+static inline struct folio *mlock_flagged(struct folio *folio)
 {
-	return (struct folio *)((unsigned long)folio + LRU_FOLIO);
+	return (struct folio *)((unsigned long)folio + MLOCK_FLAG);
 }
 
 /*
  * mlock_folio_batch() is derived from folio_batch_move_lru(): perhaps that can
  * make use of such folio pointer flags in future, but for now just keep it for
- * mlock.  We could use three separate folio batches instead, but one feels
- * better (munlocking a full folio batch does not need to drain mlocking folio
- * batches first).
+ * mlock.  We could use separate folio batches instead, but one feels better
+ * (munlocking a full folio batch does not need to drain mlocking batch first).
  */
 static void mlock_folio_batch(struct folio_batch *fbatch)
 {
@@ -169,10 +174,15 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		folio = fbatch->folios[i];
-		mlock = (unsigned long)folio & LRU_FOLIO;
+		mlock = (unsigned long)folio & MLOCK_FLAG;
 		folio = (struct folio *)((unsigned long)folio - mlock);
 		fbatch->folios[i] = folio;
 
+		if (!folio_try_get(folio)) {
+			fbatch->folios[i] = NULL;
+			continue;
+		}
+
 		if (mlock)
 			lruvec = __mlock_folio(folio, lruvec);
 		else
@@ -218,19 +228,25 @@ void mlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
 
-	local_lock(&mlock_fbatch.lock);
-	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
-
 	if (!folio_test_set_mlocked(folio)) {
-		int nr_pages = folio_nr_pages(folio);
+		long nr_pages = folio_nr_pages(folio);
 
 		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
-		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 	}
 
-	folio_get(folio);
-	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
-	    true || /* XXX Temporarily disable mlock batching */
+	/*
+	 * No more to do if mlock_count is maintained: either the folio
+	 * is on an lru_add fbatch, and will be moved to unevictable in
+	 * due course, or it's already counted as unevictable: no need
+	 * for an mlock_fbatch entry below.
+	 */
+	if (mod_mlock_count(folio, MLOCK_COUNT_1))
+		return;
+
+	local_lock(&mlock_fbatch.lock);
+	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
+	if (!folio_batch_add(fbatch, mlock_flagged(folio)) ||
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
@@ -244,15 +260,24 @@ void munlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
 
+	/*
+	 * No more to do if mlock_count is maintained and still raised.
+	 * But if mlock_count is unmaintained, we might need to queue an
+	 * munlock fbatch entry, just to cancel an undequeued mlock entry?
+	 */
+	if (mod_mlock_count(folio, -MLOCK_COUNT_1) > MLOCK_COUNT_0)
+		return;
+
+	if (folio_test_clear_mlocked(folio)) {
+		long nr_pages = folio_nr_pages(folio);
+
+		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
+		count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
+	}
+
 	local_lock(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
-	/*
-	 * folio_test_clear_mlocked(folio) must be left to __munlock_folio(),
-	 * which will check whether the folio is multiply mlocked.
-	 */
-	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
-	    true || /* XXX Temporarily disable munlock batching */
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
-- 
2.51.0

