Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF489572693;
	Wed,  9 Sep 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966273; cv=none; b=My+MFDU1ANv0urvdMfPO49SzaV1XfURSEAszeBD5t3agcwvSUZ+8kuNlM8cfVzSCVRkTAQwNLfrTxE/xC9rBYPyh1Wv3SowzKMW1Nngi3DajXaJU1QeM7lPB1YFaFO0CsCIyKF8ApdXnUAdpyd9kGvWQe2xjjsd6xHVcBUnBZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966273; c=relaxed/simple;
	bh=eyqrTym7YH33qhz2IUTjQgGLMwSrBBrEuGTGcohxOs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxOi9XiRn3fy9pU5xGP2Ak2+0yU/d7KoMvnLSgEXA8ob4+aZCB7XVoUhr73rmxG4KjtAmarBEO7WHHVYxoHbf9TtAQucT/D6apcun0InjsDqKunxrVu3kQuD8wEq0eWyrCI8mcaoUtWh8C0WMJE/KijrOkJlOoH2beF2IpdzmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAcK3OrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAcK3OrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BC11F00A3D;
	Wed,  9 Sep 2026 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966271;
	bh=aeXzLXfVC8e+tzbtM1PdBxXt6XZbDS/FpvLHCNUlfWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SAcK3OrWdGIvBXHFshnW4N1kmYi8uwxh70A6GyDCuxzs3FrmYJeKrYDCHVjEu2pmw
	 UIZKF5N1faibN8kfZYJSfF5CU0Dibdmu/VfarSip3jGeg3La2SN17ZRb6kR4YVvsot
	 nQBn/sJrXnnzCKvNgRfFOdliI3BHkx1Ijv5u+yF5K2mxhLL29fk6n2Ubh6H215S+2u
	 ztCV5CLMnDkfxc7sSS0yPfugcoX62t41N/Mi36hA5mdjlUYs/CSFuPjQV3hsoJOekf
	 blBoiFCh2VK5IXhrzqYxtDOLjqBw5HErG+DVT55hQ7Yik6LSawqEn0JIz4cOub2UYd
	 c+QYLaq1P1OqQ==
Message-ID: <af864862-90f9-4b16-a06e-1c189c4c4d6b@kernel.org>
Date: Wed, 9 Sep 2026 17:04:21 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/26] mm/fbatch: lru_add_del_folio()+folio_add_lru()
 after clear_lru()
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
 <b2e312f3-6909-5496-195f-ab71b45970ac@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <b2e312f3-6909-5496-195f-ab71b45970ac@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 11:51, Hugh Dickins wrote:
> Most callers of folio_test_clear_lru() then proceed to remove the folio
> from its lru, and add it back at the end when they're done (if still in
> use). But isolate_migratepages_block() and check_move_unevictable_pages()
> sometimes decide against, and release immediately with a folio_set_lru().
> 
> Which usually works fine: but there's now a small chance that while they
> held the folio with lru bit cleared, an lru_add fbatch drain came along,
> and had to skip that folio because its lru bit was transiently cleared
> (previously, the lru_add fbatch drain relied on finding lru bit never yet
> set). This risks leaving that folio off lru, unreclaimable until freed.

So this makes the previous patch a somewhat bisection hazard? I guess it's
acceptable given it's not fatal.

> Fix such cases by trying lru_add_del_folio() (which only takes action and
> returns true if the folio was on an lru_add fbatch), then folio_add_lru()

Oh ok, that's one detail I didn't realize on the previous patch, and
explains the name of the function. But it's still IMHO confusing.

> if it succeeded: invalidating the old fbatch slot, appending in a new one.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

In general, LGTM.
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Nit below:

> ---
>  mm/compaction.c | 13 +++++++++++--
>  mm/vmscan.c     | 16 +++++++++-------
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index a049415512c6..9e045a90ba21 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1204,7 +1204,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  				     !cc->alloc_contig)) {
>  				low_pfn += folio_nr_pages(folio) - 1;
>  				nr_scanned += folio_nr_pages(folio) - 1;
> -				folio_set_lru(folio);
> +				if (lru_add_del_folio(folio)) {
> +					lruvec_unlock_irqrestore(locked, flags);
> +					folio_add_lru(folio);
> +					locked = NULL;
> +				} else {
> +					folio_set_lru(folio);
> +				}
>  				goto isolate_fail_put;
>  			}
>  		}
> @@ -1293,7 +1299,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  	if (locked)
>  		lruvec_unlock_irqrestore(locked, flags);
>  	if (folio) {
> -		folio_set_lru(folio);
> +		if (lru_add_del_folio(folio))
> +			folio_add_lru(folio);
> +		else
> +			folio_set_lru(folio);
>  		folio_put(folio);
>  	}
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f11491ee9ed5..4e8d5cc34f07 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -8093,17 +8093,19 @@ void check_move_unevictable_folios(struct folio_batch *fbatch)
>  			folio_clear_unevictable(folio);
>  			lruvec_add_folio(lruvec, folio);
>  			pgrescued += nr_pages;
> +		} else if (lru_add_del_folio(folio)) {
> +			lruvec_unlock_irq(lruvec);
> +			folio_add_lru(folio);
> +			lruvec = NULL;
>  		}
> -		folio_set_lru(folio);
> +		if (lruvec)
> +			folio_set_lru(folio);
>  	}
>  
> -	if (lruvec) {
> -		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
> -		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
> +	if (lruvec)
>  		lruvec_unlock_irq(lruvec);
> -	} else if (pgscanned) {
> -		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
> -	}
> +	count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
> +	count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);

AFAIU this is done because we can no longer rule out that !lruvec means
pgrescued is 0.
But we can still distinguish the cheaper __count_vm_events vs
count_vm_events? Probably all the same on x86, but I hear on arm64 this_cpu*
ops have a cost worth proposing rather elaborate schemes to deal with...

>  }
>  EXPORT_SYMBOL_GPL(check_move_unevictable_folios);
>  

