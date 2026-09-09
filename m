Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411893BE161
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948997; cv=none; b=lS2d4Y4qmJT0W/5qrayHGXP39JKkO7fexKbzwQTrB5F6k52Q1M4quwX1SDHgCu6DyuAAUUJzzAcH7cLazW6Hd2xy/281aapOQl8VWcc2pVUI9UJCw/qd3FdBO6CCphUCZyPzq/6/OF5B2GD3sszUwU+a6JgmsLuvu6DgFhy0HaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948997; c=relaxed/simple;
	bh=KEiTze2su0A1vp1BBKEvxCvYQVjhfCLRRoQ/gxsZ1F8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F7OBY4N27687l6Zdy3cNBoZLTLCn0hEw9t7jma/XPIQccTZFUzVMu34ovALYOtBfOiNNaibRtRgJm9anYGinatvd/2QSsNJM9rtsK2EhrCDLg6Q2lN1o2de0Pq94cfYFaKWeMKjHnHdIEz9HJweeCQD8SFNXbC8h5XpYGRXyXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwyrAzI+; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwyrAzI+"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aae3149so844311d50.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948982; x=1789553782; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ovd1KkFuD5rQg51sP3+p0bllsBxKk8b6qXB17QYO0U0=;
        b=hwyrAzI+wvUIgVjo6Lx52WtUrdUvT5rei03O1Ho/0BoeeXp8scCzjMRS+8dh4HtB/M
         qEcFwK+SzHFY66p/gIZuPAyijePIhadcM49qboerkYuSo+xJVo7vGaulp5qeP9dw8a9g
         ROJX/n97KeyHT7Rz4/TnCtz7kazdE2QSaIHxgjr9PTtBIQ4mB0j5GPM4bRgLFKRPu0Bb
         u8b9Ovnho6DBsEHFWNRDE/4FVSP4JoxayygM9QL3IyV/yP1JNNINe15Yl1FxspCm75bJ
         ++vDAjdbxpjWtLcYFicLrpBC0SVgMpADfE4NAtuJyDRwa/Ax0L/qdSz8dg/a6gzPwAet
         YJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948982; x=1789553782;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ovd1KkFuD5rQg51sP3+p0bllsBxKk8b6qXB17QYO0U0=;
        b=F9IADDFOvObiskE2Bzg0Sl0qeiTjpl3aM4UedvoEgk53DmNi4SBEQ7L3acpbsVHf9e
         kleR2T+IZnG0AHeMMV0EE+dpZNcRzYm+SWEYw6Js0tF585RbI2WlC/gIj9lBhzoFDpnQ
         4RnbVjSn2QMxH4YAHKBN/7mtuZ6jejHNQzu3ndVGTUEl952hXVyRqa+cKX5Aib3lig01
         n7nQVQoUgPWwHz7yKRYBjHP2yaKJ/M6GdaozqFVsNcVaRGuPGBqYhDTWWCWmZh9wsmWc
         7UO/IBTduKswGGQ//nc6QzFJptRk/A7YsIWqIymrdUTdgrs5jdzPESeme5To1zkK0vaw
         1nCw==
X-Forwarded-Encrypted: i=1; AKwUvBzhBVW2+is6VGV+fl3DGAg/iq9Ex+qaBYoCRtvfAVgY+avRqdZVhcOZwC02dV+HDsuuhKfo+fzwkVWDsw==@vger.kernel.org
X-Gm-Message-State: AFuF++lxFbfdlZkiZwxPfWKFplBf0MwZCfaTf7Clkdx93IewS4KjsVzG
	UDq4uZmA5Mcqq141IAKBjUWagnf7EcPx0eRmRO/N8qyCFb8lnvBQh6kDSK5zDdmoZA==
X-Gm-Gg: AYBFou2p3ZdphVF73R1/lc0/ETh9zjEK2OrU8pXPk2e+uKW34qPbr33wiFNzMwBe2h0
	hDsQoRW+1FBPPQRN1+yejqNUlfpIiSKvXmPC/Phx03zgemWItIjw8tUMajCX2vDrK8V1LmfRtl6
	OF4Nye+uXXG3df1zqiAkZWK1Jv6tQCyZRy5HzPY+vlYmeVZ/S/g5xgjEMnOvrNJQh54yl2PBi8F
	siR2aTEv7u2Q/XxFsduGU3EqT/OSE3U/OcSKeLtekI4mn4WejZ3O/qT/C2cIHuPsZaC2ra2RoQo
	uoY568GhfBXNOAg8661lUts1exRcDbRPkRL+WNvZvrCXuo2TKgkRgHC7qRt4F1d5fsrpov5ZTbR
	KpCfeBYPZAbRAVwm8jTuX3ZF/SqSYXER3wEdIhMfa66IlKDZahGDERLD+51VO9kY3gjL43ASpMN
	G54i8/N87pn1xBVRz7VTtPemcB154t3wQiad0Oknow9uQSg+w3BSkm66IZXTuo0PMxO8iYIUQ8z
	FoKGO5/HUGhfJ3s/pqe3Q1R0209ujEXa2VQxxTd8En17oBTuezcMOTcRsg=
X-Received: by 2002:a05:690e:484b:b0:670:f743:6eb5 with SMTP id 956f58d0204a3-671030a9c66mr1404195d50.19.1788948981459;
        Wed, 09 Sep 2026 03:16:21 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb4912962sm11717181d50.12.2026.09.09.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:16:20 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:16:16 -0700 (PDT)
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
Subject: [PATCH v2 17/26] mm/fbatch: no lru_cache_disable() in
 __alloc_contig_migrate_range()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <84ed3bf8-da32-3447-0577-052c5d1a56b2@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove lru_cache_disable() from __alloc_contig_migrate_range(). It does
not now benefit from lru_add_drain_all() first; and gains little benefit
from invalidating buffer head LRUs first, since 5.0 commit 80409c65e2c6
("mm: migrate: make buffer_migrate_page_norefs() actually succeed").

This will be more controversial. lru_cache_disable()+lru_cache_enable()
were brought in for CMA page migration, see 5.13 commit d479960e44f2
("mm: disable LRU pagevec during the migration temporarily") through
8cc621d2f45d ("mm: fs: invalidate BH LRU during page migration") - I
guess the testing there must have been on a 4.19-based Android kernel,
without 5.0's buffer_migrate_page_norefs().

It's possible that invalidating BH LRUs perhaps 0 times, perhaps N
times, will average out worse than invalidating 1 time and stopping
everyone else; or that folio_test_clear_lru() failures manifest more
than before (note how folio migration has retries on raised refcount,
but isolate_migratepages_block() no retry on failed test_clear_lru).
But let's give this a try and look out for regressions.

Don't delete lru_cache_disable() yet: leaving stale folio pointers in
the per-cpu fbatches, with folio_try_get() yet to come on them, would be
bad for memory hotremoval: the lru_cache_disable() in offline_pages()
protects from that.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/page_alloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..3e085a25a776 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7147,8 +7147,6 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		.reason = MR_CONTIG_RANGE,
 	};
 
-	lru_cache_disable();
-
 	while (pfn < end || !list_empty(&cc->migratepages)) {
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -7182,7 +7180,6 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 			break;
 	}
 
-	lru_cache_enable();
 	if (ret < 0) {
 		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
 			alloc_contig_dump_pages(&cc->migratepages);
-- 
2.51.0

