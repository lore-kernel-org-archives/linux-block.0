Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD071917CD
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431427; cv=none; b=mvbJchBwmHprObg2ubYbUo8PGcoqFc1iTgsHr0clKz8d2NdenC34NvNgtaUz2X9fKGokaTinLGLtilXO6zMTGELHPYuZyyxnVCsSo/7ciq4VM8/0kb5Vd1NFmsAuRF6gyd0eZXhSyoG459EUTwW6Ulkb3b+KGtMGn2GLkeKV6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431427; c=relaxed/simple;
	bh=Sr14gWZHPDA1jTz2r9bYACVClKlDvI2zTxQNLqMukv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alejrOGD2JPL1YH+2xD9F4e68ak+6Y2jG48nUBimrdjL8+caWeD4tvZ76B9Za5VBVh6mijNPC8I1wE9t/du/zowdTaOr21u8wevxw0LnD4oj4+scxE76nCQzS40647oFHHmwI3vg61QXH8ocrJTRs3VTFlFn/4wQZyCy3MUBHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO8YTXhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO8YTXhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1391F000E9;
	Thu, 25 Jun 2026 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782431425;
	bh=nPKUZaKOV+T0YJEXJcsPSJeM+eppQ2kUQs5Ru8ktT/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VO8YTXhZvxJBWT9+DE82g3PxL+51L6Ww30E759CA9otYOPqXMzpdghOPFjzZQdRp6
	 xoS/VKzUyYgGHtLLnsY+B3QzC3DrvuKaCpoPQLBYD9sfKu869hg0tSUHpxShvZkNdB
	 CL4b1HQ6bCZ2kds0Xljo6dmvXh3Oi4WgNZYnUVykkl1wgJe7crmfIDaZ6/BJqZYCcu
	 UnlRzImqbm7x4BHF7Q6WfBMyGbNChpP8DbDLLm4Ljq1UbbJAqR547QE1DafRc3x9y0
	 XINwDn5zgzgXjiOrvlXgsnPX/eXpaVVLnmszxoCy9S6ATtIYXPyJdet/NRJOSSbhDZ
	 TbXYaoymzju1w==
Message-ID: <9104ac5d-ed2b-409d-8220-512dd4581966@kernel.org>
Date: Fri, 26 Jun 2026 08:50:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempool: optimize mempool resizing
To: Vitaly Wool <vitaly.wool@konsulko.se>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mm@kvack.org,
 Vitaly Vul <vitaly.vul@partner.samsung.com>
References: <20260625194915.387663-1-vitaly.wool@konsulko.se>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260625194915.387663-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 4:49 AM, Vitaly Wool wrote:
> From: Vitaly Vul <vitaly.vul@partner.samsung.com>
> 
> Resizing mempool to a bigger size currently requires a new allocation and a
> data copy to a new larger elements array which doesn't go well with the
> idea of having a fast and deadlock free memory allocations during exreme VM
> load.
> 
> This patch introduces a new parameter max_nr for a part of the mempool API,
> which denotes the maximum size of the pool. With it in place we can avoid
> any allocations in mempool_resize() since we can either grant the resizing
> request or reject it basing on thr maximum allowed size of the elements
> array. For those few users of the mempool API that actually use
> mempool_resize() it is a clear upgrade because the maximum number of
> elements is known upfront.
> 
> Derivative APIs (like mempool_init_kmalloc_pool()) are mostly left intact,
> substituted by the new mempool_init_kmalloc_resizable_pool() API where the
> pool is actually meant to be resizable.
> 
> Signed-off-by: Vitaly Vul <vitaly.vul@partner.samsung.com>
> ---
>  block/blk-zoned.c       |  6 ++--
>  drivers/nvme/host/pci.c |  2 +-
>  include/linux/mempool.h | 18 +++++++---
>  mm/mempool.c            | 75 +++++++++++------------------------------
>  4 files changed, 38 insertions(+), 63 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 6a221c180889..5d31597f2fe6 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1918,8 +1918,10 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
>  	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++)
>  		INIT_HLIST_HEAD(&disk->zone_wplugs_hash[i]);
>  
> -	disk->zone_wplugs_pool = mempool_create_kmalloc_pool(pool_size,
> -						sizeof(struct blk_zone_wplug));
> +	disk->zone_wplugs_pool = mempool_create_kmalloc_resizable_pool(
> +					pool_size,
> +					BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE,

Even though that is not encouraged, we can have far more than
BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE zone write plugs for a device, if the user is
writting to more zones that the device advertized max open zone limit.

Furthermore, a device can have a max open zone limit that is far larger than
BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, in which case, we would ve the min_nr
(pool_size argument) greater than the max_nr argument
(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE).

So this does not look correct to me. But more importantly, I am failing to see
what you are after here, and as Andrew asked, I do not see the issue that you
are trying to solve. The mempool resizing to pool_size is always done so that
we can have at least enough zone write plugs in the mempool to satisfy the
device max open zones (or max active zones) limit. Any allocation beyond that
limit is still possible but not relying on having a free element in the mempool.

> +					sizeof(struct blk_zone_wplug));
>  	if (!disk->zone_wplugs_pool)
>  		goto free_hash;
>  
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b5f846200678..eaa4804ab3c3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3349,7 +3349,7 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
>  {
>  	size_t alloc_size = sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
>  
> -	dev->dmavec_mempool = mempool_create_node(1,
> +	dev->dmavec_mempool = mempool_create_node(1, 2,
>  			mempool_kmalloc, mempool_kfree,
>  			(void *)alloc_size, GFP_KERNEL,
>  			dev_to_node(dev->dev));
> diff --git a/include/linux/mempool.h b/include/linux/mempool.h
> index e8e440e04a06..8b950efded18 100644
> --- a/include/linux/mempool.h
> +++ b/include/linux/mempool.h
> @@ -18,6 +18,7 @@ typedef void (mempool_free_t)(void *element, void *pool_data);
>  typedef struct mempool {
>  	spinlock_t lock;
>  	int min_nr;		/* nr of elements at *elements */
> +	int max_nr;		/* max nr of elements at *elements */
>  	int curr_nr;		/* Current nr of elements at *elements */
>  	void **elements;
>  
> @@ -38,7 +39,7 @@ static inline bool mempool_is_saturated(struct mempool *pool)
>  }
>  
>  void mempool_exit(struct mempool *pool);
> -int mempool_init_node(struct mempool *pool, int min_nr,
> +int mempool_init_node(struct mempool *pool, int min_nr, int max_nr,
>  		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
>  		void *pool_data, gfp_t gfp_mask, int node_id);
>  int mempool_init_noprof(struct mempool *pool, int min_nr,
> @@ -49,15 +50,15 @@ int mempool_init_noprof(struct mempool *pool, int min_nr,
>  
>  struct mempool *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
>  		mempool_free_t *free_fn, void *pool_data);
> -struct mempool *mempool_create_node_noprof(int min_nr,
> +struct mempool *mempool_create_node_noprof(int min_nr, int max_nr,
>  		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
>  		void *pool_data, gfp_t gfp_mask, int nid);
>  #define mempool_create_node(...)					\
>  	alloc_hooks(mempool_create_node_noprof(__VA_ARGS__))
>  
> -#define mempool_create(_min_nr, _alloc_fn, _free_fn, _pool_data)	\
> -	mempool_create_node(_min_nr, _alloc_fn, _free_fn, _pool_data,	\
> -			    GFP_KERNEL, NUMA_NO_NODE)
> +#define mempool_create(_min_nr, _alloc_fn, _free_fn, _data)	\
> +	mempool_create_node(_min_nr, (_min_nr)*2, _alloc_fn, _free_fn,	\
> +			    _data, GFP_KERNEL, NUMA_NO_NODE)
>  
>  int mempool_resize(struct mempool *pool, int new_min_nr);
>  void mempool_destroy(struct mempool *pool);
> @@ -102,6 +103,13 @@ void mempool_kfree(void *element, void *pool_data);
>  	mempool_create((_min_nr), mempool_kmalloc, mempool_kfree,	\
>  		       (void *)(unsigned long)(_size))
>  
> +#define mempool_init_kmalloc_resizable_pool(_pool, _min_nr, _max_nr, _size)		\
> +	mempool_init_node(_pool, _min_nr, _max_nr, mempool_kmalloc, mempool_kfree,	\
> +		     (void *)(unsigned long)(_size), GFP_KERNEL, NUMA_NO_NODE)
> +#define mempool_create_kmalloc_resizable_pool(_min_nr, _max_nr, _size)			\
> +	mempool_create_node(_min_nr, _max_nr, mempool_kmalloc, mempool_kfree,		\
> +		       (void *)(unsigned long)(_size), GFP_KERNEL, NUMA_NO_NODE)
> +
>  /*
>   * A mempool_alloc_t and mempool_free_t for a simple page allocator that
>   * allocates pages of the order specified by pool_data
> diff --git a/mm/mempool.c b/mm/mempool.c
> index db23e0eef652..4675405c0bd8 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -207,7 +207,7 @@ void mempool_exit(struct mempool *pool)
>  		void *element = remove_element(pool);
>  		pool->free(element, pool->pool_data);
>  	}
> -	kfree(pool->elements);
> +	kvfree(pool->elements);
>  	pool->elements = NULL;
>  }
>  EXPORT_SYMBOL(mempool_exit);
> @@ -230,22 +230,22 @@ void mempool_destroy(struct mempool *pool)
>  }
>  EXPORT_SYMBOL(mempool_destroy);
>  
> -int mempool_init_node(struct mempool *pool, int min_nr,
> +int mempool_init_node(struct mempool *pool, int min_nr, int max_nr,
>  		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
>  		void *pool_data, gfp_t gfp_mask, int node_id)
>  {
>  	spin_lock_init(&pool->lock);
>  	pool->min_nr	= min_nr;
> +	pool->max_nr	= max_nr;
>  	pool->pool_data = pool_data;
>  	pool->alloc	= alloc_fn;
>  	pool->free	= free_fn;
>  	init_waitqueue_head(&pool->wait);
> -	/*
> -	 * max() used here to ensure storage for at least 1 element to support
> -	 * zero minimum pool
> -	 */
> -	pool->elements = kmalloc_array_node(max(1, min_nr), sizeof(void *),
> -					    gfp_mask, node_id);
> +
> +	if (WARN_ON(max_nr < 1 || min_nr < 0))
> +		return -EINVAL;
> +
> +	pool->elements = kvmalloc_array_node_noprof(max_nr, sizeof(void *), gfp_mask, node_id);
>  	if (!pool->elements)
>  		return -ENOMEM;
>  
> @@ -253,7 +253,7 @@ int mempool_init_node(struct mempool *pool, int min_nr,
>  	 * First pre-allocate the guaranteed number of buffers,
>  	 * also pre-allocate 1 element for zero minimum pool.
>  	 */
> -	while (pool->curr_nr < max(1, pool->min_nr)) {
> +	while (pool->curr_nr < pool->min_nr) {
>  		void *element;
>  
>  		element = pool->alloc(gfp_mask, pool->pool_data);
> @@ -286,7 +286,7 @@ int mempool_init_noprof(struct mempool *pool, int min_nr,
>  		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
>  		void *pool_data)
>  {
> -	return mempool_init_node(pool, min_nr, alloc_fn, free_fn,
> +	return mempool_init_node(pool, min_nr, min_nr * 2, alloc_fn, free_fn,
>  				 pool_data, GFP_KERNEL, NUMA_NO_NODE);
>  
>  }
> @@ -296,6 +296,7 @@ EXPORT_SYMBOL(mempool_init_noprof);
>   * mempool_create_node - create a memory pool
>   * @min_nr:    the minimum number of elements guaranteed to be
>   *             allocated for this pool.
> + * @max_nr:    the maximum capacity of the pool
>   * @alloc_fn:  user-defined element-allocation function.
>   * @free_fn:   user-defined element-freeing function.
>   * @pool_data: optional private data available to the user-defined functions.
> @@ -310,7 +311,7 @@ EXPORT_SYMBOL(mempool_init_noprof);
>   *
>   * Return: pointer to the created memory pool object or %NULL on error.
>   */
> -struct mempool *mempool_create_node_noprof(int min_nr,
> +struct mempool *mempool_create_node_noprof(int min_nr, int max_nr,
>  		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
>  		void *pool_data, gfp_t gfp_mask, int node_id)
>  {
> @@ -320,7 +321,7 @@ struct mempool *mempool_create_node_noprof(int min_nr,
>  	if (!pool)
>  		return NULL;
>  
> -	if (mempool_init_node(pool, min_nr, alloc_fn, free_fn, pool_data,
> +	if (mempool_init_node(pool, min_nr, max_nr, alloc_fn, free_fn, pool_data,
>  			      gfp_mask, node_id)) {
>  		kfree(pool);
>  		return NULL;
> @@ -338,9 +339,8 @@ EXPORT_SYMBOL(mempool_create_node_noprof);
>   *              allocated for this pool.
>   *
>   * This function shrinks/grows the pool. In the case of growing,
> - * it cannot be guaranteed that the pool will be grown to the new
> - * size immediately, but new mempool_free() calls will refill it.
> - * This function may sleep.
> + * the pool will be grown to the new size immediately, but new mempool_free()
> + * calls will refill it.
>   *
>   * Note, the caller must guarantee that no mempool_destroy is called
>   * while this function is running. mempool_alloc() & mempool_free()
> @@ -351,11 +351,13 @@ EXPORT_SYMBOL(mempool_create_node_noprof);
>  int mempool_resize(struct mempool *pool, int new_min_nr)
>  {
>  	void *element;
> -	void **new_elements;
>  	unsigned long flags;
>  
> -	BUG_ON(new_min_nr <= 0);
> -	might_sleep();
> +	if (WARN_ON(new_min_nr < 0))
> +		return -EINVAL;
> +
> +	if (new_min_nr > pool->max_nr)
> +		return -ENOSPC;
>  
>  	spin_lock_irqsave(&pool->lock, flags);
>  	if (new_min_nr <= pool->min_nr) {
> @@ -366,45 +368,8 @@ int mempool_resize(struct mempool *pool, int new_min_nr)
>  			spin_lock_irqsave(&pool->lock, flags);
>  		}
>  		pool->min_nr = new_min_nr;
> -		goto out_unlock;
> -	}
> -	spin_unlock_irqrestore(&pool->lock, flags);
> -
> -	/* Grow the pool */
> -	new_elements = kmalloc_objs(*new_elements, new_min_nr);
> -	if (!new_elements)
> -		return -ENOMEM;
> -
> -	spin_lock_irqsave(&pool->lock, flags);
> -	if (unlikely(new_min_nr <= pool->min_nr)) {
> -		/* Raced, other resize will do our work */
> -		spin_unlock_irqrestore(&pool->lock, flags);
> -		kfree(new_elements);
> -		goto out;
> -	}
> -	memcpy(new_elements, pool->elements,
> -			pool->curr_nr * sizeof(*new_elements));
> -	kfree(pool->elements);
> -	pool->elements = new_elements;
> -	pool->min_nr = new_min_nr;
> -
> -	while (pool->curr_nr < pool->min_nr) {
> -		spin_unlock_irqrestore(&pool->lock, flags);
> -		element = pool->alloc(GFP_KERNEL, pool->pool_data);
> -		if (!element)
> -			goto out;
> -		spin_lock_irqsave(&pool->lock, flags);
> -		if (pool->curr_nr < pool->min_nr) {
> -			add_element(pool, element);
> -		} else {
> -			spin_unlock_irqrestore(&pool->lock, flags);
> -			pool->free(element, pool->pool_data);	/* Raced */
> -			goto out;
> -		}
>  	}
> -out_unlock:
>  	spin_unlock_irqrestore(&pool->lock, flags);
> -out:
>  	return 0;
>  }
>  EXPORT_SYMBOL(mempool_resize);


-- 
Damien Le Moal
Western Digital Research
