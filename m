Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99530DD1B
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580583; cv=none; b=fn7gDbRXHPyHqbYSTyRZHxlpxa9HpnH2Iwl8MYchtEIlccrIs+S318w8BBvrAulQHxv6lWNncsentvf4S/m0r0FN052NJ8NBY3UjH/+O7Ff4ST0OVQ5uC/rT7ZPjlDmMB8CbeHpbYHzKw8hYGr37m6yz9V/LeVLL2ut9bB+V/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580583; c=relaxed/simple;
	bh=j2H+JD3zxqAi9f4PV0Xuj1JWeNtTun4i8LwUusPeK7Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J4Gyzq+DV//cyr6TsdU/tXHo4KahsF1qWGrl16g7zhSxW/41cEVBYeY/9iC6ixsPpO8qgo6g0XX1ffaRztO8PrZXISSNBvVNdQwq8PV298ec7/lQQfslM5LpIjM7EUq4A7vd0jv/wCEj+iPPyi8YnLqzW9gQ+4GXcuwR461Vlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKrdMjGK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKrdMjGK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-836c43641baso64823677b3.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787580580; x=1788185380; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lCdAyHrZb4E51CG+1fE1lJJ+Rs+kWhPosCUCdWMIdjI=;
        b=TKrdMjGKpRZxCkZtmh3UsETVJaI5g0z8tshCjEt8pl6+7wrF/QBWAqFqJS/0rz7stY
         IccctcRZH/iZ30/+VSZxsXiGAGgFPAk55OilHDQR8ZBm0lE4z8CQxVINkiIpLMzlrZ1K
         m6q0A+tbUmiWTPmHuM081AFUqw3J50mWeB/lTl0rfrIPrE2JF9jA0hpnckflWEnvVV0r
         0fLqnuOMR3zqjkE404a02v+oagExYp50Ru1+obT2lZO6igGKGwa36qxUFblqJ9X6NYPa
         n4j3J5FcB0p7ZLyog+p4DxRK4khx+Nfc8xGr67dl0+qN7Hb+p+CtSUmKDPO5y4T5M007
         BnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580580; x=1788185380;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCdAyHrZb4E51CG+1fE1lJJ+Rs+kWhPosCUCdWMIdjI=;
        b=r6h9Fq4OpFxbmK5ODJKsaD5ZS41MwZK+/YdjE5LItCblsickyOjBlbKqSbR2Msjvcm
         KY8IgW3BXMVJnL8V/saMbervdF4e3vEvFVtrk9VtHNLmLFtMrI2d7m/A6bkWTYJMY9vL
         ksxzNb3Z2wEmuxWVEskw7q8ze+CR4udY1qleuxhjJKOdzIe8gQKQyB43RTJ5ZlZm0NqY
         3lQQWpidYBrQQt/DZ13QjkBo/Ep9nPPtBRaU940xbayw80DYPlSLH79fbeU/ipBaE1fn
         maBFwQ+5QSk9sEMfklsJNJ5+Oa4EA6T54eL7hQOus0jPWkC5bg7HOHPgZ6qMW7a9sihS
         6FLg==
X-Forwarded-Encrypted: i=1; AHgh+RqMfBksb/4y1Vm6jCMeHVrh3q8oFiDIlaNHCVHXmTHCNCsv4SQTQWw3x6yytM5TKL4ZQ3uheES2fhSQVg==@vger.kernel.org
X-Gm-Message-State: AFuF++mzImdWzwEjxi8sNP+K1paIPfuEat9skhweDdnuLJcBfcry7xtF
	wj4g9Q5dMKrfcP804GrEvgS8UjaQH+8MXZquTfO9z06qzJf9F8v8NNq/xK5Gn7zBCw==
X-Gm-Gg: AR+sD11H+xGNtangSHqyAX4ZdnLPI5hmttNvbc2QHtWr9tFqGgh4fTu28AYTPPkB4gh
	gyfCTY3hu1r7L6WJWEfkpvuIEUTPiDlYCVx9ifwUjd1pOf+FjwyieVGoBqAmRkY2or8X6XcW203
	ndlWLD8pqGk0V/Yq+fyE5jOH6RS0u/3M++wXvGck7+Veb5ax5dRuQ4dSerkqX0p/bv+hYw/O5zB
	m1HFetibCrYlXgiUvDg2UbC2tVyAZ1JBxQ9Qlm9ZLQR5yO+iFQsNNF+rphKmQnX3tHWVn7e79td
	72lCkQEtgYBLk6a36TbnKOZH06OdPbp5duycsyRmqTHdGcrwx7HIWkso46u8pPDnwNcEZ0Z6zMA
	TOmlVKvWXj192qw/ArZN+wsEkE6pHsy7sxIxafNv1cmcqq8oBLC5lUVbfq+VmcZIbAOxbahdr9H
	jjVnsvynyY9cTYUFK0N8CIXH5/TvxZpsCUDySyviy3ETZHCUpBrjE6QQYigCSeQ1cusT9Sx8ERW
	deOlxqGmpe5EjkAP/uulrS6I6sF+eAKtsqmSsIdw6eTMsl9
X-Received: by 2002:a05:690c:e1c1:20b0:836:ec3d:b5e6 with SMTP id 00721157ae682-849f5dfebc0mr66916777b3.28.1787580579812;
        Mon, 24 Aug 2026 07:09:39 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5d252f0sm33979987b3.13.2026.08.24.07.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:09:38 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:09:34 -0700 (PDT)
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
Subject: [PATCH 07/25] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <16b39f43-d91e-7b23-900e-90cec13837ff@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Implement an equivalent to the old __lru_cache_activate_folio()
optimization, to activate a folio recently put in the lru_add fbatch,
without having to put it through the lru_activate fbatch too. Neither
lruvec lock nor lru bit can guard this safely and efficiently, so resort
to try_cmpxchg() on a further, LRU_NEXT_ACTIVATE bit in folio->lru_next.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm_inline.h |  3 +++
 mm/folio.c                | 23 ++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 1ecaf2ef9f2b..1b54900e87f0 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -346,6 +346,7 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
 enum {
 	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
 	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
+	LRU_NEXT_ACTIVATE,
 	NR_LRU_NEXT_FLAGS
 };
 
@@ -355,6 +356,8 @@ bool lru_add_del_folio(struct folio *folio)
 	/* BUG_ON(folio_test_lru(folio)); */
 	if (!(folio->lru_next & BIT(LRU_NEXT_BATCHED)))
 		return false;
+	if (folio->lru_next & BIT(LRU_NEXT_ACTIVATE))
+		folio_set_active(folio);
 	folio->lru.next = LIST_POISON1;
 	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
 	return true;
diff --git a/mm/folio.c b/mm/folio.c
index e76868c95acc..0d8eb9cf5ad5 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -322,15 +322,32 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 
 void folio_activate(struct folio *folio)
 {
+	unsigned long lru_next;
+
 	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
 	    !folio_test_lru(folio))
 		return;
 
 	/*
-	 * XXX: It is curiously difficult to recreate safely the old
-	 * __lru_cache_activate_folio() optimization (folio_set_active()
-	 * directly if it's on the local lru_add fbatch): revisit later.
+	 * This optimization is intended for the common case of folio
+	 * having been recently added to this CPU's lru_add fbatch.
+	 * But since other CPUs can now take it at any instant (after
+	 * a folio_test_clear_lru()), and we may be migrated to another
+	 * CPU, it is simplest just to extend the optimization to all CPUs.
+	 *
+	 * folio_set_active() would be unsafe without the lruvec lock, and
+	 * a folio_test_clear_lru() here might cause a racing drain of the
+	 * lru_add fbatch to skip its lru_add(): so use try_cmpxchg().
 	 */
+	lru_next = READ_ONCE(folio->lru_next);
+	while (lru_next & BIT(LRU_NEXT_BATCHED)) {
+		if (lru_next & BIT(LRU_NEXT_ACTIVATE))
+			return;
+		if (try_cmpxchg(&folio->lru_next, &lru_next,
+				lru_next | BIT(LRU_NEXT_ACTIVATE)))
+			return;
+	}
+
 	folio_batch_add_and_move(folio, lru_activate);
 }
 
-- 
2.51.0

