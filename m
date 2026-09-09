Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011D4B66E7
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948766; cv=none; b=gTxZTmhnoY5/Fl4E7rrKXt6l3q9NeXs3uYafigNviju2wWgnMDjTHLOmnph2tnbROl3d1+sY54if7qob3a5+qSmuigkI+cgtZXeBzeF+eX5otdrOwTTe8zoFg4MFTh/fcGPDT7+jvs3xujseSIXIb0nGfMHFFyFx218H4APC/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948766; c=relaxed/simple;
	bh=veK2eDLRVGTOGqy7tLB4YUJ+s0qY+28Zl0Q1bFSRbiU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hwiLy1s1XVkv6VLQyJhBX25Q9aveBHQ7qfRzx8eS3rvFpK8TBC1NIX0x5SZpkPdgZl0P/PYAf7BxrjFlysuwx3Yz46kE5JopdDBb3V8e7GYcYoHcmVOzA66LmIAVGZ6sHtM0ehLgPJEtwKBdhCk8Ak7iayC5/9zjGeASR/wN7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mO/6uVOR; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mO/6uVOR"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab1ba47so1168950d50.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948763; x=1789553563; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bX03VdslkeGAuZnZEXnLni54ZZj7BtxRxhR+YMJ/+OA=;
        b=mO/6uVOR1LytX7R1AEc6xw8mKUHiLBuvD5LchX2wHlRXdFmIoI4MoQqBIbTy3bwHsG
         e3bYpTA+zqhbhomqadUhQdNsmOwpbaTEq+uYRATB7A1Qr6wARQfIEuPVUv6ViDBN6vnH
         R+2rLRJ1GxMHIGCVzzJ4eC4qT1F7Yz8mL9CpvJWRwI6BrI1iQoYbS7pe4dFCIWjh9mK4
         bvqg8H9QnJYjNhSjxmYLHm7zzbaRmYyW18RyqmYlq2jBDh/04Jnqa8mPYKpC8b6EuzLL
         poiC5S0mXDQQbJ/bhIDYdrY0kd77QsDbdZOR47LIIAwn6pjezMNckQtuUDwwI9ZJi4Aj
         IhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948763; x=1789553563;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bX03VdslkeGAuZnZEXnLni54ZZj7BtxRxhR+YMJ/+OA=;
        b=ez2JsTa43P77TUGFAvJnn5IBS7CWveqsUWYyUGr1NqxkpX9L9dV20a7XAul+HFJYsm
         +cCf4FRNFec55sEE8BeJGPGSG5f3lZEBDepzEFWOZzALCpm4PlONELG2l015gzaazmph
         UwHbqe2qOwrQauZgn7MWr7lEzTGB1Pr71pw6VKAOqFF0dLU4X9c9x617h+OF7PP7kF35
         L2+BevL323QyxU8Jf/vmLpR9e0OmPNBrs9LM6SxZZuoLebR6J9AL54Qjew+qRXBm8Reg
         6BCpBda7wQ8E0KFa8rfRbrSf1WZnh+9PeLyCaV00XF3N8dPPlPZBHR1HVcm8dXDkENrp
         Tepw==
X-Forwarded-Encrypted: i=1; AKwUvByxyEORHSTXf/QrGDH5g1QD6/x7JI0v0FFWm2iOVWc5wX7cjg/w19PPZ1OydUWkyZ1+2Bdng2zv8tiBRg==@vger.kernel.org
X-Gm-Message-State: AFuF++mR4bBENoh9kMV2K6vA0HT6jC8zy7ZU7EHfL+iTLC+nEqmdqdsN
	vtD+WOkOAyynBlzjIPq/QRCOBynzQNAmqx8kJWtosuTtiFP0DZ/kRUQjkalgVPSP/A==
X-Gm-Gg: AYBFou2bAu0uJ9Sx136I1hRHG8SuO1/1nsHPkcEWKfkzxObio3zOi9Sa1p8nRTsvEZm
	fifp+pMAGmt2xNActmM1dCnotbNYv8l4Pzlw0TNkZ6bDExZ5WSAzdzo+T5iwI+RDj4cJkhGX2R3
	Jkp/0T7MzKeAWFLLOiuCmLP0kseshLvnDoeZPLBNQ2eKemM/BPaEswLAzaQWZPCCJVM3v8A6T3b
	QRlqDZQjH/zpM4lFCt96DPkQAP8QMyAvfzGNPGO+6OLLk6A3NI/VHkgWQa0QV13VGeW0YFy8jUN
	IP0p782/ieEbjiHt4xp72JNF6Fq72fmHwwKrW+crvruAqSP5ccHUEQTkf8spHG/VixUF+bNHVPQ
	Sm/fog6i2sutC+9tDr/rNpt55vTYHj5ask/2uq6yOVMAb5pVvxrQm9FBSKV9NgKRZ6BllPpsxuQ
	ceUdiafxPL+2M5p9Wq9QpEtv5RDoT8mmQLYwyAVKct5XCX9dsz/TPR9f9/tNaolhjq1/mrTspoM
	lmGspIKgrSxkTLMxP4h+it44YK6TShxnqDFnkEuSh3tEsbf0aydrt+UGf0=
X-Received: by 2002:a05:690e:1243:b0:66f:d290:6336 with SMTP id 956f58d0204a3-670f4914bc5mr2669673d50.10.1788948762060;
        Wed, 09 Sep 2026 03:12:42 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-670febedc44sm2574235d50.11.2026.09.09.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:12:41 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:12:36 -0700 (PDT)
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
Subject: [PATCH v2 15/26] mm/fbatch: remove shake_folio() shake_page() from
 memory-failure
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <29067356-073c-2c36-a78b-7d7d4920aae3@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

shake_folio()'s lru_add_drain_all() no longer serves a purpose, now that
the per-cpu fbatch references are gone. Are the retries in get_any_page()
then still useful? Not obvious, so keep them.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hwpoison-inject.c |  1 -
 mm/internal.h        |  1 -
 mm/memory-failure.c  | 38 +-------------------------------------
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index a11222572f97..9eab4b7d25b2 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -118,7 +118,6 @@ static int hwpoison_inject(void *data, u64 val)
 	if (!hwpoison_filter_enable)
 		goto inject;
 
-	shake_folio(folio);
 	/*
 	 * This implies unable to support non-LRU pages except free page.
 	 */
diff --git a/mm/internal.h b/mm/internal.h
index 40bd128a58ae..6700fff13675 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1171,7 +1171,6 @@ static inline bool node_reclaim_enabled(void)
  */
 #ifdef CONFIG_MEMORY_FAILURE
 int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
-void shake_folio(struct folio *folio);
 typedef int hwpoison_filter_func_t(struct page *p);
 void hwpoison_filter_register(hwpoison_filter_func_t *filter);
 void hwpoison_filter_unregister(void);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a8b03e2920ba..d0abbe13447e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -310,30 +310,6 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	return ret;
 }
 
-/*
- * Unknown page type encountered. Try to check whether it can turn PageLRU by
- * lru_add_drain_all.
- */
-void shake_folio(struct folio *folio)
-{
-	if (folio_test_hugetlb(folio))
-		return;
-	/*
-	 * TODO: Could shrink slab caches here if a lightweight range-based
-	 * shrinker will be available.
-	 */
-	if (folio_test_slab(folio))
-		return;
-
-	lru_add_drain_all();
-}
-EXPORT_SYMBOL_GPL(shake_folio);
-
-static void shake_page(struct page *page)
-{
-	shake_folio(page_folio(page));
-}
-
 static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 		unsigned long address)
 {
@@ -1459,10 +1435,8 @@ static int get_any_page(struct page *p, unsigned long flags)
 			 * We raced with (possibly temporary) unhandlable
 			 * page, retry.
 			 */
-			if (pass++ < GET_PAGE_MAX_RETRY_NUM) {
-				shake_page(p);
+			if (pass++ < GET_PAGE_MAX_RETRY_NUM)
 				goto try_again;
-			}
 			ret = -EIO;
 			goto out;
 		}
@@ -1477,7 +1451,6 @@ static int get_any_page(struct page *p, unsigned long flags)
 		 */
 		if (pass++ < GET_PAGE_MAX_RETRY_NUM) {
 			put_page(p);
-			shake_page(p);
 			count_increased = false;
 			goto try_again;
 		}
@@ -1627,7 +1600,6 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	LIST_HEAD(tokill);
 	bool unmap_success;
 	bool forcekill;
-	bool mlocked = folio_test_mlocked(folio);
 
 	/*
 	 * Here we are interested only in user-mapped pages, so skip any
@@ -1658,13 +1630,6 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
 		       pfn, folio_mapcount(folio));
 
-	/*
-	 * try_to_unmap() might put mlocked page in lru cache, so call
-	 * shake_page() again to ensure that it's flushed.
-	 */
-	if (mlocked)
-		shake_folio(folio);
-
 	/*
 	 * Now that the dirty bit has been propagated to the
 	 * struct page and all unmaps done we can decide if
@@ -2554,7 +2519,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 * The check (unnecessarily) ignores LRU pages being isolated and
 	 * walked by the page reclaim code, however that's not a big loss.
 	 */
-	shake_folio(folio);
 
 	folio_lock(folio);
 
-- 
2.51.0

