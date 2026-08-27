Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DF3CEBB8;
	Thu, 27 Aug 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852168; cv=none; b=YPxLVE7PRFDD0X254ymPqYZeTewLcsLaJXjWqSjp1dbSQH36UeNEAB9+fAsTtJ3Te3lunFFcXFRs2uyRTjFPtVT3HOcZ6MnvsdLrigitgT3XLVWCwtBnw8cV1HiCotS6eOK4dQ/0lKRwb509/OIFkfYiTN1U29jsUe2z59oSwHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852168; c=relaxed/simple;
	bh=kMQjf/EQdHt7FND8qem72DXwfRXSrGKRwXhdVhAtewM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rrqt9pV7j9ucqf9EelnWrz46zEsdlaRmSgdIvULj3c8WG5WHH9e79yzMdbZHuFy6Dvdo9Pji+30seLL6kFgfEFDC0R5f04noZN69LxksDtseKESFHTTeZelJi4RSpfizY8W0PqIwhqyIk90zPbsyhkYsbujYEwotux9sqhIiE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Z5niTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Z5niTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A81D1F000E9;
	Thu, 27 Aug 2026 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787852167;
	bh=2DDVHpJux4Ptnn/zNnVoJKBlru2hK4rDAvwWQZHsc/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k7Z5niTt7xai93ANTmHBXk/cNl/JwAUqSQsSU/IV53pXiJwa0lPrt+4i0KRd+RRdN
	 g6IL9KhSNTJ8yTLeyZXeQ68jcMAgqeBYiuSNJJjMEHLOGhqs7HCkfUtfRI9oO+qpOK
	 4VJGqm8nL4vVYUxZ9VHwYX8EUczxXB+IKsD4FRlMFmgihyTXFKa46iDz+OuHMjiIMg
	 xIRCgCi2HdHATCpL17lS3hUpZb+D9fl0AcR+8lW7hn9rDC86QCJVUjpIonY1dqc/B0
	 RXwXa+9MA00B0s/07AimaLzJl+FpnUIt9IgSaX/NwYJOW4Ukv7QaqMbhHY4JAum3W/
	 ZIf+y0Xx1qCIA==
Message-ID: <bd83481f-d25b-441e-90bf-18d49ab9322d@kernel.org>
Date: Thu, 27 Aug 2026 19:35:54 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/25] mm/fbatch: allow folios_put_refs() to skip
 xa_is_value() entries
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Binbin Wu <binbin.wu@linux.intel.com>, Christian Brauner
 <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, JP Kobryn <jp.kobryn@linux.dev>,
 Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
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
 <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>,
 Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <44c7773e-5806-d24a-83c9-f39b3a134138@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <44c7773e-5806-d24a-83c9-f39b3a134138@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 15:55, Hugh Dickins wrote:
> Let folios_put_refs() (hence folio_batch_release()) skip xa_is_value()
> entries, and therefore remove unneeded folio_batch_remove_exceptionals().
> 
> It made some sense when introduced in 3.1 for shmem swap entries only,
> but workingset shadows popularized exceptional entries in 3.15, and it's
> silly for so many sites to be squashing exceptionals out of the fbatch,
> merely to suit an inadequacy in folios_put_refs().
> 
> But remove exceptionals on leaving truncate_folio_batch_exceptionals(),
> one of whose callers then passes the fbatch on to others less tolerant.
> 
> No longer essential to this series, since 7.2 commit 9669b87065a6
> ("mm/lruvec: preemptively free dead folios during lru_add drain")
> allowed folios_put_refs() to skip NULLs; but still an improvement.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  include/linux/folio_batch.h |  5 +----
>  mm/folio.c                  | 25 ++++---------------------
>  mm/shmem.c                  |  2 --
>  mm/truncate.c               | 16 ++++++++++------
>  4 files changed, 15 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/folio_batch.h b/include/linux/folio_batch.h
> index b45946adc50b..e1cc8ae023f1 100644
> --- a/include/linux/folio_batch.h
> +++ b/include/linux/folio_batch.h
> @@ -22,8 +22,7 @@ struct folio;
>   * The folio_batch is used to amortise the cost of retrieving and
>   * operating on a set of folios.  The order of folios in the batch may be
>   * significant (eg delete_from_page_cache_batch()).  Some users of the
> - * folio_batch store "exceptional" entries in it which can be removed
> - * by calling folio_batch_remove_exceptionals().
> + * folio_batch store "exceptional" (xa_is_value) entries in it too.
>   */
>  struct folio_batch {
>  	unsigned char nr;
> @@ -100,6 +99,4 @@ static inline void folio_batch_release(struct folio_batch *fbatch)
>  	if (folio_batch_count(fbatch))
>  		__folio_batch_release(fbatch);
>  }
> -
> -void folio_batch_remove_exceptionals(struct folio_batch *fbatch);
>  #endif /* _LINUX_FOLIO_BATCH_H */
> diff --git a/mm/folio.c b/mm/folio.c
> index 62b96c9ce19e..b2bce6b77498 100644
> --- a/mm/folio.c
> +++ b/mm/folio.c
> @@ -983,6 +983,10 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
>  		if (!folio)
>  			continue;
>  
> +		/* Skip any "exceptional" (workingset or shmem swap) entry. */
> +		if (xa_is_value(folio))
> +			continue;
> +
>  		if (is_huge_zero_folio(folio))
>  			continue;
>  
> @@ -1088,27 +1092,6 @@ void __folio_batch_release(struct folio_batch *fbatch)
>  }
>  EXPORT_SYMBOL(__folio_batch_release);
>  
> -/**
> - * folio_batch_remove_exceptionals() - Prune non-folios from a batch.
> - * @fbatch: The batch to prune
> - *
> - * find_get_entries() fills a batch with both folios and shadow/swap/DAX
> - * entries.  This function prunes all the non-folio entries from @fbatch
> - * without leaving holes, so that it can be passed on to folio-only batch
> - * operations.
> - */
> -void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
> -{
> -	unsigned int i, j;
> -
> -	for (i = 0, j = 0; i < folio_batch_count(fbatch); i++) {
> -		struct folio *folio = fbatch->folios[i];
> -		if (!xa_is_value(folio))
> -			fbatch->folios[j++] = folio;
> -	}
> -	fbatch->nr = j;
> -}
> -
>  #ifdef CONFIG_MEMCG
>  static void lruvec_reparent_lru(struct lruvec *child_lruvec,
>  				struct lruvec *parent_lruvec,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 89a1495e55f7..3911721e1e55 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1156,7 +1156,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  				truncate_inode_folio(mapping, folio);
>  			folio_unlock(folio);
>  		}
> -		folio_batch_remove_exceptionals(&fbatch);
>  		folio_batch_release(&fbatch);
>  		cond_resched();
>  	}
> @@ -1276,7 +1275,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  			}
>  			folio_unlock(folio);
>  		}
> -		folio_batch_remove_exceptionals(&fbatch);
>  		folio_batch_release(&fbatch);
>  	}
>  
> diff --git a/mm/truncate.c b/mm/truncate.c
> index b58ba940be47..4151f7a167e3 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -53,7 +53,7 @@ static void clear_shadow_entries(struct address_space *mapping,
>  /*
>   * Unconditionally remove exceptional entries. Usually called from truncate
>   * path. Note that the folio_batch may be altered by this function by removing
> - * exceptional entries similar to what folio_batch_remove_exceptionals() does.
> + * exceptional entries.
>   * Please note that indices[] has entries in ascending order as guaranteed by
>   * either find_get_entries() or find_lock_entries().
>   */
> @@ -95,7 +95,7 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
>  				dax_delete_mapping_entry(mapping, indices[i]);
>  			}
>  		}
> -		goto out;
> +		goto squash;
>  	}
>  
>  	xas_set(&xas, indices[j]);
> @@ -113,8 +113,14 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
>  	if (mapping_shrinkable(mapping))
>  		inode_lru_list_add(mapping->host);
>  	spin_unlock(&mapping->host->i_lock);
> -out:
> -	folio_batch_remove_exceptionals(fbatch);
> +
> +squash:
> +	for (i = j + 1; i < nr; i++) {
> +		folio = fbatch->folios[i];
> +		if (!xa_is_value(folio))
> +			fbatch->folios[j++] = folio;
> +	}
> +	fbatch->nr = j;
>  }

One caller of truncate_folio_batch_exceptionals() just calls
folio_batch_release(). I was wondering whether that one could just stop calling
truncate_folio_batch_exceptionals().

But truncate_folio_batch_exceptionals() does too many other things I don't quite
understand.

I guess one could move the loop into the only remaining caller that does not
call folio_batch_release() afterwards.

But that changes the whole purpose of the function and the name would no longer
match.

Which brings me back to my point that truncate_folio_batch_exceptionals() does a
lot of things besides folio_batch_remove_exceptionals() that I don't understand :)

So I'm sure there is room for future cleanups for somebody that actually
understands what truncate_folio_batch_exceptionals() does besides ... removing
exceptionals.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
