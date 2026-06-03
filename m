Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443235A3A4
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479713; cv=none; b=TavD4jIJwrNKGiMROooBd4NoWjFGrSWCDHKzjVUG6XaRZUtpjyJSC1ikSnAtxXK8PISlwtYz1h7f6fDW53dv0yQ4FG7dEeIbGc+MlSemHRityxGSD5MslZ/ONk44PBV3jJ5nsNbNFZdhvtYCfAdmqhqozCba8hsISzFx9ZL4beg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479713; c=relaxed/simple;
	bh=qbFSgsTxyZ4Vhq1Vw/I8x+yr1vThhgzZxwAYyshZuGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4P0vvrBxyXqF3VYQAPlAOoARF+jbCCAyPpY4pxlQ9Cndq8syWGM9aTbteUpNYzJCf49R67FrfBKkXNgdsixUAEEZlZ5su7cyCA3oqTtrF7Csp7wxlvs5N2NArd+o61kf4J5kM/JNAen9sqTl/g+cD1/pCpaT3IRCK9xs2oaxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfNCbFBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfNCbFBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167E11F00893;
	Wed,  3 Jun 2026 09:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479711;
	bh=63211LnYkiUjqO9V3W2tlS45oL0M1lm/njpjy+4Gnfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RfNCbFBEaHmRyGCH6pyRnV+DY8NpzyHBZh7DwdPfYVb0Odn9BRLxYHUutQ29olLZx
	 ZsH29A+/x+8D38wwRUoG9nWCd9lOG7fzCt+oLvlVErrZNuDAUVKWaXmjSOv//EnJkn
	 Ez7Bdwkj6wPHURCDhzHJFUDP2hNml5b3Xc1AAw2XmHeANhkdj3G+z+pRBDkLFWJn8L
	 D8IHRRR+RtqV5KbBC40T4//Q3q3j+FbU7iIgYqo+D8MXM/401AuXKXbmiUlebdVIP0
	 e+QkZLbCWjwA/NJUwMWGVD4qagIZ1Ak+tw3EiYFVFyFTwRbJM0DamhrE83cPiA2mfc
	 g0uoAGmPh7DOA==
Message-ID: <64fff44b-27ae-4943-a199-d8764dc28f80@kernel.org>
Date: Wed, 3 Jun 2026 11:41:48 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: simplify the mempool_alloc_bulk API
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, harry@kernel.org,
 akpm@linux-foundation.org
Cc: hao.li@linux.dev, cl@gentwo.org, rientjes@google.com,
 roman.gushchin@linux.dev, linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20260602160038.3976341-1-hch@lst.de>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260602160038.3976341-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 18:00, Christoph Hellwig wrote:
> The mempool_alloc_bulk was modelled after the alloc_pages_bulk API,
> including some misunderstanding of it.
> 
> Remove checking for NULL slots in the array, as alloc_pages_bulk and
> kmem_cache_alloc_bulk always fill the array from the beginning and thus
> we know the offset of the first failing allocation.  This removes support
> for working well with alloc_pages_bulk used to refill page arrays that
> might have an entry removed from in the middle, but that is only used by
> sunrpc and hopefully on it's way out.

Importantly sunrpc doesn't use mempool_alloc_bulk() so we're not affecting
it here.

> Also remove the allocated parameter as it is redundant because the caller
> can simply specific and offset into the entries array.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Somewhat late, but small and affects only one caller. So applied to
slab/for-7.2/alloc_bulk on top of the kmem_cache_alloc_bulk() change.

> ---
>  block/blk-crypto-fallback.c |  9 +++++----
>  include/linux/mempool.h     |  2 +-
>  mm/mempool.c                | 27 ++++++++++-----------------
>  3 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 61f595410832..ab6924fba280 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -199,8 +199,8 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
>  	pages += nr_segs * (PAGE_PTRS_PER_BVEC - 1);
>  
>  	/*
> -	 * Try a bulk allocation first.  This could leave random pages in the
> -	 * array unallocated, but we'll fix that up later in mempool_alloc_bulk.
> +	 * Try a bulk allocation first.  This might not fill all allocated
> +	 * pages, but we'll fix that up later in mempool_alloc_bulk.
>  	 *
>  	 * Note: alloc_pages_bulk needs the array to be zeroed, as it assumes
>  	 * any non-zero slot already contains a valid allocation.
> @@ -208,8 +208,9 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
>  	memset(pages, 0, sizeof(struct page *) * nr_segs);
>  	nr_allocated = alloc_pages_bulk(GFP_KERNEL, nr_segs, pages);
>  	if (nr_allocated < nr_segs)
> -		mempool_alloc_bulk(blk_crypto_bounce_page_pool, (void **)pages,
> -				nr_segs, nr_allocated);
> +		mempool_alloc_bulk(blk_crypto_bounce_page_pool,
> +				(void **)pages + nr_allocated,
> +				nr_segs - nr_allocated);
>  	memalloc_noio_restore(memflags);
>  	*pages_ret = pages;
>  	return bio;
> diff --git a/include/linux/mempool.h b/include/linux/mempool.h
> index e8e440e04a06..a0fa6d43e0dc 100644
> --- a/include/linux/mempool.h
> +++ b/include/linux/mempool.h
> @@ -66,7 +66,7 @@ void *mempool_alloc_noprof(struct mempool *pool, gfp_t gfp_mask) __malloc;
>  #define mempool_alloc(...)						\
>  	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
>  int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
> -		unsigned int count, unsigned int allocated);
> +		unsigned int count);
>  #define mempool_alloc_bulk(...)						\
>  	alloc_hooks(mempool_alloc_bulk_noprof(__VA_ARGS__))
>  
> diff --git a/mm/mempool.c b/mm/mempool.c
> index db23e0eef652..473a029fa31f 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -419,12 +419,8 @@ static unsigned int mempool_alloc_from_pool(struct mempool *pool, void **elems,
>  	spin_lock_irqsave(&pool->lock, flags);
>  	if (unlikely(pool->curr_nr < count - allocated))
>  		goto fail;
> -	for (i = 0; i < count; i++) {
> -		if (!elems[i]) {
> -			elems[i] = remove_element(pool);
> -			allocated++;
> -		}
> -	}
> +	while (allocated < count)
> +		elems[allocated++] = remove_element(pool);
>  	spin_unlock_irqrestore(&pool->lock, flags);
>  
>  	/* Paired with rmb in mempool_free(), read comment there. */
> @@ -479,22 +475,21 @@ static inline gfp_t mempool_adjust_gfp(gfp_t *gfp_mask)
>   * @pool:	pointer to the memory pool
>   * @elems:	partially or fully populated elements array
>   * @count:	number of entries in @elem that need to be allocated
> - * @allocated:	number of entries in @elem already allocated
>   *
> - * Allocate elements for each slot in @elem that is non-%NULL. This is done by
> - * first calling into the alloc_fn supplied at pool initialization time, and
> - * dipping into the reserved pool when alloc_fn fails to allocate an element.
> + * Allocate @count elements into @elems.  This is done by first calling into the
> + * alloc_fn supplied at pool initialization time, and dipping into the reserved
> + * pool when alloc_fn fails to allocate an element.
>   *
>   * On return all @count elements in @elems will be populated.
>   *
>   * Return: Always 0.  If it wasn't for %$#^$ alloc tags, it would return void.
>   */
>  int mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
> -		unsigned int count, unsigned int allocated)
> +		unsigned int count)
>  {
>  	gfp_t gfp_mask = GFP_KERNEL;
>  	gfp_t gfp_temp = mempool_adjust_gfp(&gfp_mask);
> -	unsigned int i = 0;
> +	unsigned int allocated = 0;
>  
>  	VM_WARN_ON_ONCE(count > pool->min_nr);
>  	might_alloc(gfp_mask);
> @@ -514,11 +509,9 @@ int mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
>  	 * Try to allocate the elements using the allocation callback first as
>  	 * that might succeed even when the caller's bulk allocation did not.
>  	 */
> -	for (i = 0; i < count; i++) {
> -		if (elems[i])
> -			continue;
> -		elems[i] = pool->alloc(gfp_temp, pool->pool_data);
> -		if (unlikely(!elems[i]))
> +	while (allocated < count) {
> +		elems[allocated] = pool->alloc(gfp_temp, pool->pool_data);
> +		if (unlikely(!elems[allocated]))
>  			goto use_pool;
>  		allocated++;
>  	}

