Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1E4825A8;
	Thu, 10 Sep 2026 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041674; cv=none; b=dXu0MTJ2WeXflpyHflQj6KzevOIZgYsWfTue1fxCBmlBeRCndFZq1xporWDHWrA0VWPrAMEJBx57m0v8aal1jdAmHnm31BgxFzoR1JEgdKoKzmYtsrJhZzc9FKm0gkz9QnBb1Ux5cgv+VO2bUDisEKiyOhgvji14r+1KCgv1P3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041674; c=relaxed/simple;
	bh=EiLR1oNWBTUfzhayliGRuhK28Eyt3bB++mx+A/XcLOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcIYDLr/DRAS0Tkr2w2joZBTyY7xkfu7XFx37oQCeogx6SlElYC+Mp9expgPEhBavaBt5xGeJv6Q94zEBEGy2ERFbcVgtjQW/7uwcjDK64fztPindAM79CCaB4EhrAnwqBxdH3KLCVcnX/gJ/SsPq33kdBZk5dRFRjQbQ+g7waw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhEat1/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhEat1/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C017C1F000FF;
	Thu, 10 Sep 2026 12:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789041672;
	bh=gGRiP00UZ2QnxQeyHEnzHM+4PwMNnzfPUpjThhppjiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FhEat1/vifu+AabmjF8NmJPEP65qR4NBg4Ky/6jU3lo17Q0Zo2BhNylfwMKgXlIDI
	 UMImBV5640D83WmIILt73l8RjBygDF6Mt7gu1/ntqS0oBR8lidQsw7r3Sj2i5WdR8V
	 INjCSwvtzlHK8kPH7G5nIBuVR3YVGY4ybJh+g5gGSFGtxyX6EYVptvqJMZZwjeQfGi
	 aeG04jNaLuKWedKy71l1HWQfVdwcFptEjzJJ89C6fdNfHpJadbzrMhFXlVUL2CJHgj
	 w8mBMnWhfb9D+zFJggWb28AQFcd5s8vG8Yuhm57TZx5ehR5Gfv4Ij2Aijxv4bMLNbQ
	 hZcM2Ic2G/G5A==
Message-ID: <ddab52d0-48c7-4d2c-b403-45f11e041654@kernel.org>
Date: Thu, 10 Sep 2026 14:01:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/26] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
Content-Language: en-US
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Binbin Wu <binbin.wu@linux.intel.com>, Christian Brauner
 <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Yang Shi <yang@os.amperecomputing.com>,
 Yu Zhao <yuzhao@google.com>, Zach O'Keefe <zokeefe@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
 <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 11:55, Hugh Dickins wrote:
> Implement an equivalent to the old __lru_cache_activate_folio()
> optimization, to activate a folio recently put in the lru_add fbatch,
> without having to put it through the lru_activate fbatch too. Neither
> lruvec lock nor lru bit can guard this safely and efficiently, so resort
> to try_cmpxchg() on a further, LRU_NEXT_ACTIVATE bit in folio->lru_next.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  include/linux/mm_inline.h |  4 ++++
>  mm/folio.c                | 23 ++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 8420b1276535..8f5efadf9c7c 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -346,6 +346,7 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
>  enum {
>  	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
>  	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> +	LRU_NEXT_ACTIVATE,
>  	NR_LRU_NEXT_FLAGS
>  };

This addition, and the comment "/* This mask will do nothing on 64-bit */"
in folio_add_lru()... does it mean that now this is breaking 32-bit? Should
we make this optimization, or perhaps all of the cpu fbatch, 64-bit only?

> @@ -358,6 +359,9 @@ bool lru_add_del_folio(struct folio *folio)
>  	if (!(lru_next & BIT(LRU_NEXT_BATCHED)))
>  		return false;
>  
> +	if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> +		folio_set_active(folio);
> +
>  	WRITE_ONCE(folio->lru.next, LIST_POISON1);
>  	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
>  
> diff --git a/mm/folio.c b/mm/folio.c
> index a18d8ef6afd5..0b75c3b69d5a 100644
> --- a/mm/folio.c
> +++ b/mm/folio.c
> @@ -256,15 +256,32 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
>  
>  void folio_activate(struct folio *folio)
>  {
> +	unsigned long lru_next;
> +
>  	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
>  	    !folio_test_lru(folio))
>  		return;
>  
>  	/*
> -	 * XXX: It is curiously difficult to recreate safely the old
> -	 * __lru_cache_activate_folio() optimization (folio_set_active()
> -	 * directly if it's on the local lru_add fbatch): revisit later.
> +	 * This optimization is intended for the common case of folio
> +	 * having been recently added to this CPU's lru_add fbatch.
> +	 * But since other CPUs can now take it at any instant (after
> +	 * a folio_test_clear_lru()), and we may be migrated to another
> +	 * CPU, it is simplest just to extend the optimization to all CPUs.
> +	 *
> +	 * folio_set_active() would be unsafe without the lruvec lock, and
> +	 * a folio_test_clear_lru() here might cause a racing drain of the
> +	 * lru_add fbatch to skip its lru_add(): so use try_cmpxchg().
>  	 */
> +	lru_next = READ_ONCE(folio->lru_next);
> +	while (lru_next & BIT(LRU_NEXT_BATCHED)) {
> +		if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> +			return;
> +		if (try_cmpxchg(&folio->lru_next, &lru_next,
> +				lru_next | BIT(LRU_NEXT_ACTIVATE)))
> +			return;
> +	}
> +
>  	folio_batch_add_and_move(folio, lru_activate);
>  }
>  

