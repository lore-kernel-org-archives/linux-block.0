Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C549159D
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946940; cv=none; b=mYPAlXdA8E5Hm1t8YLQm7Ku+7L7Y7We8tNS8mjdXCkwGN17XkPMLVdjIXG7QzTk2WR8urcwWf01RIf3Dian/ycyuIK0pWkFLVf8FrF9Vq4MRdh/KbuGrrcSRgNtykiwrnvRE8Er4sBgQ1nC6oa4t3gWgjk85JZDesnxFLmOVT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946940; c=relaxed/simple;
	bh=N/QTtPy3Eq36G6jCKFgYYujyz3PwIl5VjjdzH4vnlfY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IjnHeTH/M6QQTREMVYkbwEThSQIQnBZUMg0vdcVdglGuw9A88jPlhmA1xgCtJiVFtS1s3QND2qOt5ojmcjMavHmYRDySwlnaF56LCsV13JthxtZeUd+H6qqG/mJXGwiPsIkBCI8JH6NJ+r012lT3VvgmWMLGcssf48vnK9VHiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcRhWs0M; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcRhWs0M"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66de7e0bc85so4729684d50.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788946936; x=1789551736; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZhIjaKSKu0jnDwRfSlp/FTaG5xLy46pxEQXC6FqYeA=;
        b=HcRhWs0MZClW1Z66abZaVnOFx91ik7apWsDxqQBmAPPsCGETn8eTjhzQ1UpbjEFJHo
         /GvxoAxhjCsF9BMxMoh+veQRo61WlM7guQss/g7xDLj0ujkyhZlr8s/BPOkGZjs/STb7
         A8P51g1RhmJ0UsC0XcO8WfO5Z8bWoHzK72srU1kr6t6W+14Usb6GguWw++CIdljQBi9a
         G9k24gGyLZbwbO1Oj8EmOB4ySbmdzpmNqdc4jrL17lOo9p4Eo7OGD67ETqjJegfIB/fG
         WxniyFu5Z1bXuCg/eGi6KEaZuHehM35z2N8V+KJr1JRYSPs9CBSRF3Mait4j4rH+lpLS
         3bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946936; x=1789551736;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZhIjaKSKu0jnDwRfSlp/FTaG5xLy46pxEQXC6FqYeA=;
        b=mAI+ha/ZjVIpaS6EhFAy+nSHwwQa1trq6xyk7sf6ZUlfpTIHcvLar+DDNJ/UbFar7G
         b0QeeWLL/wtRo8wXSLiv6b6S62UpRpPERsKeMNvF78WNKBZPi4Ez4CvleCL+Iq1GxhYD
         mZGUFjR+4mgl13zXwtmAPam0N5D2SJty7hPHU+vDzJkHy1jAR1RXAz6+SJ1hTKH62cRb
         5J4u51UHgbEQgYZl06v8wn9q7eIa7ct+insTRAm0Xht3gWhwkYgPz4NSQrf+hxz/fuew
         ky8FDKfHuhrRwD5CvMIjKTmaD5of0inPavHpxPdM3XGj78KdvZlYGyNyc4DSfcVDliGq
         wh7g==
X-Forwarded-Encrypted: i=1; AKwUvBxc2tzoElNeUR0QKRKrcCZpgVkQNIdJ/t7iNEMIEbAGkt/sgh/55qUUJQkUCmQGmXS1koYX2fZlnYLdeA==@vger.kernel.org
X-Gm-Message-State: AFuF++kThrk6pOtvxI15iIC/LaAif/zvwj0YYHioGBpFAQC5PF2VK36o
	ftYNI3unmR8U9y8qH6qPUYBC3t4K9tGWrxu4syEvDWjMZSrgVv+gRwojUcu5z49ezg==
X-Gm-Gg: AYBFou3R4es1ytHbHkX4GxqmxD5Jk7hGxmKshbYN0Z40F+2LmlczSqiKknAxOomPO7H
	jsbwiS6Rxa3J12JuHdGX3HNKVlLC41bIUThC87tI+yJeWO+MIhww5DzZDy2dBXmPDv8vhznXEKV
	eFQ4DzefD+xV8wwRF9/6BQx+ppvpvNzji5x+kQWajgFIZ6t9dxiRp+wBXqDdQCR3ZjE+uc/xIO4
	VKcksq7VUaKQyw7NUQfbuAgm3vcoAQTqQCnRLtCZIdEVkksfEkkE5b7uLTLQmtXQaoy28j8jICc
	gTzWoD/4abmJKpoKl2+JZOqYgtVVjTvpGDBG9c7YRHeX5ACYpLfWl2oiq+TUC2Jlq2aabvEW4ut
	8r5kczMxiqIxS1i6o0Y6PXpb1WN/94qmSAiSXKxhC4BCoPDA/dUjLey09frTYeYZp1MesspG654
	Ob4K/UJVj5cz3VPyx/VeHtZduNaOK+ypCHydZToC6s1pQ0keq2zj8WqtDWXNObplZM4b+9w2Tqe
	gL7R5mXvf62+yGLkbrYHw9jV4lbF3R1dskRdyV5lHHD1tIpZJ4E2z24HXdo
X-Received: by 2002:a53:a043:0:b0:66f:c1be:3187 with SMTP id 956f58d0204a3-66fc1be358emr5989382d50.94.1788946935368;
        Wed, 09 Sep 2026 02:42:15 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8b8fsm12141411d50.2.2026.09.09.02.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:42:14 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:42:10 -0700 (PDT)
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
Subject: [PATCH v2 01/26] mm/fbatch: remove !CONFIG_SMP special case of
 folio_activate()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <b482561f-6620-d41d-eea0-a7f2a05cc444@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

3.0 commit eb709b0d062e ("mm: batch activate_page() to reduce lock
contention") brought in an ifdef CONFIG_SMP around activate batching:
https://lore.kernel.org/linux-mm/20100805140755.501af8a7.akpm@linux-foundation.org/
shows a sensitivity to bloat that day, not any incompatibility with UP.

No other batching here has a UP alternative, and it's a bit confusing:
simplify mm/folio.c a little by removing it now.

Certainly we can reduce UP bloat (and/or 32-bit bloat) by, say, lowering
FOLIO_BATCH_SIZE from 31: traditionally 16, 14, 15, then raised to 31 by
6.9 commit 9cecde80aae0 ("mm: increase folio batch size"); or by giving
just the static per-cpu folio batches a type of their own with a smaller
array size on UP (1? or a little batching worthwhile even on UP?). But
not right now, it's orthogonal to this series.

And I suspect that the old ifdef led to lru_activate being placed last,
whereas it's usually the second most popular fbatch: move it there, to
match cpu_needs_drain() comment "Check these in order of likelihood that
they're not zero".

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-By: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/folio.c | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/mm/folio.c b/mm/folio.c
index 50a6dbe55998..c093ca900a3e 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -48,12 +48,10 @@ struct cpu_fbatches {
 	 */
 	local_lock_t lock;
 	struct folio_batch lru_add;
+	struct folio_batch lru_activate;
 	struct folio_batch lru_deactivate_file;
 	struct folio_batch lru_deactivate;
 	struct folio_batch lru_lazyfree;
-#ifdef CONFIG_SMP
-	struct folio_batch lru_activate;
-#endif
 	/* Protecting the following batches which require disabling interrupts */
 	local_lock_t lock_irq;
 	struct folio_batch lru_move_tail;
@@ -283,15 +281,6 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 	count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
 }
 
-#ifdef CONFIG_SMP
-static void folio_activate_drain(int cpu)
-{
-	struct folio_batch *fbatch = &per_cpu(cpu_fbatches.lru_activate, cpu);
-
-	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_activate);
-}
-
 void folio_activate(struct folio *folio)
 {
 	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
@@ -301,25 +290,6 @@ void folio_activate(struct folio *folio)
 	folio_batch_add_and_move(folio, lru_activate);
 }
 
-#else
-static inline void folio_activate_drain(int cpu)
-{
-}
-
-void folio_activate(struct folio *folio)
-{
-	struct lruvec *lruvec;
-
-	if (!folio_test_clear_lru(folio))
-		return;
-
-	lruvec = folio_lruvec_lock_irq(folio);
-	lru_activate(lruvec, folio);
-	lruvec_unlock_irq(lruvec);
-	folio_set_lru(folio);
-}
-#endif
-
 static void __lru_cache_activate_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
@@ -628,6 +598,10 @@ void lru_add_drain_cpu(int cpu)
 		trace_mm_lru_add_drain_tp(cpu, nr_folios);
 	}
 
+	fbatch = &fbatches->lru_activate;
+	if (folio_batch_count(fbatch))
+		folio_batch_move_lru(fbatch, lru_activate);
+
 	fbatch = &fbatches->lru_move_tail;
 	/* Disabling interrupts below acts as a compiler barrier. */
 	if (data_race(folio_batch_count(fbatch))) {
@@ -650,8 +624,6 @@ void lru_add_drain_cpu(int cpu)
 	fbatch = &fbatches->lru_lazyfree;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_lazyfree);
-
-	folio_activate_drain(cpu);
 }
 
 /**
@@ -759,11 +731,11 @@ static bool cpu_needs_drain(unsigned int cpu)
 
 	/* Check these in order of likelihood that they're not zero */
 	return data_race(folio_batch_count(&fbatches->lru_add) ||
+			 folio_batch_count(&fbatches->lru_activate) ||
 			 folio_batch_count(&fbatches->lru_move_tail) ||
 			 folio_batch_count(&fbatches->lru_deactivate_file) ||
 			 folio_batch_count(&fbatches->lru_deactivate) ||
 			 folio_batch_count(&fbatches->lru_lazyfree) ||
-			 folio_batch_count(&fbatches->lru_activate) ||
 			 need_mlock_drain(cpu)) ||
 		has_bh_in_lru(cpu, NULL);
 }
-- 
2.51.0

