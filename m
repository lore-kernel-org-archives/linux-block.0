Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329878;
	b=O6CtoDZXMLqMPsv5eVcCfP7WcIaBPuMToLe3L1FgC9oBRnqqUr4iRQAhiy29lEiVZMci
	 tRpIBpYrk4y6oRKlPxeudGOvsKOIMZrZ9EeHpeX4p4eMO5++8zA+oTYeGZ4FeXnTsXqfW
	 suISr+lrcB9yHf/CpAy8fcWMvKT5JDim5QarMJ3RlICy9b8xn6P5jsIVev27uIvfl1WaH
	 1FO4msoU4uYCkrc7N6uBXYXHIkSp7TGiS76OaGpomq5rmEtXYNDi4JxW/8ukfsH0tdNwy
	 kPZO1KAZALzwbN7xrAmTiLIN9wyrdBYpTnay0akipSJ4jomrHYK7Fncin2u7S3lPjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329878;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=he0nLvBGCDN8uqNcjTTM0VHtxOcySMAUdvuWZ5SeqT8=;
	b=UFUqxG+VgCY+pG/FHlIJ7TJvLPmw6c6cIVCC98vf1at7sjPRmODN2V/FH0W/q/jV5jp4
	 +zVNSX4utZhhKWyIz4Fsx9GTdfrVIVs7XiKluJ23ylnXuvjAiK2zEMeUHz7sCz0C2PEge
	 izshu9oE3a27lQJxNfXNfCFnxCmbIset6sbrKDXFtFOV/jElczTq4zBa3A3xCVj6X2NgN
	 lN7QJ6Cm601I5uUkiP6RXdXM9Cu+7aJq6Fu5P68jHtRfr/WdHQX4xSv3kLeOpkhJHzSmc
	 n2hf9ZW1a5XYJYYVM8yFzgNTtS5MDrVw191yOTN7EZxZrpHnziBfk5+MhpwI3ua80jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrJzy7hf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E0606A83E;
	Tue, 10 Nov 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrJzy7hf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE40D1F008A6;
	Tue, 10 Nov 2026 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329878;
	bh=he0nLvBGCDN8uqNcjTTM0VHtxOcySMAUdvuWZ5SeqT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JrJzy7hfvYhnswLWixpqtp3vtRIm615A8irbRopyLbtLZhLpctLfiWiJExN8odzXq
	 Ox6jFSj1mIc9nbGMGB7xtcyqCaCDtOnVHMGj4dsGzou1lJgcNnOcazLMncEKBvHb2j
	 dKQI+UgsjSTlxKTfBh5+1K4D9aEhGc8a5Ha1FQqUSxyZQMb7A9jc1V726myR1T5qqj
	 V4vfUgOb9Qw/WChXpJbLULMTypa6qlIr/ByOspZkkQz+aHng+8tT28XQTzpoRcPzR+
	 qlCmnF8KXwMCBCknw8xFdv+6LfJTQQ00ikIpG4oTbAHMkT2+/ZwioYZCsFENxjLLhb
	 9rxEjA8fkYOTg==
Date: Tue, 10 Nov 2026 16:57:56 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 09/11] zsmalloc: embed struct zs_handle into zram and
 zswap entries
Message-ID: <avNMwoleXeYGz2CT@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-10-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110054836.1515030-10-senozhatsky@chromium.org>

On Tue, Nov 10, 2026 at 02:48:14PM +0900, Sergey Senozhatsky wrote:
> zsmalloc allocates an object from handle_cachep for every stored
> object, just to have a stable address which compaction and page
> migration can update when the object moves.  Both zram and zswap
> already have per-entry structures that hold the handle, so we basically
> keep a pointer to a pointer, which costs 8 bytes per stored object,
> slab alloc/free on every store and free, and one more memory load on
> every access.
> 
> Make struct zs_handle public and embed it into zram_table_entry and
> zswap_entry (their sizes don't change), so that zsmalloc writes object
> location directly there, and remove handle_cachep.  zs_malloc() now
> takes a handle pointer and returns an error code, zs_free() resets the
> handle.
> 
> Since compaction and migration update the handle in place, it must be
> naturally aligned, must not be on the stack (zs_malloc() warns about
> both), must not be copied, and must stay allocated until zs_free() or
> zs_rebind_handle().  zram recompression allocates a new object before
> it frees the old one, so it uses zram->recomp_handle, protected by
> ->dev_lock, and zs_rebind_handle() moves the new object to the slot
> handle.  zram recompression is the only user of zs_rebind_handle().
> 
> This saves 8 bytes per stored page, e.g. 2MB per 1GB of swapped out
> 4K pages.  Since handle is per-entry the memory savings scale.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  Documentation/admin-guide/mm/slab.rst |   2 +-
>  Documentation/mm/zsmalloc.rst         |  18 ++--
>  drivers/block/zram/zram_drv.c         |  70 ++++++-------
>  drivers/block/zram/zram_drv.h         |   6 +-
>  include/linux/zsmalloc.h              |  29 +++++-
>  mm/zsmalloc.c                         | 144 ++++++++++++++++----------
>  mm/zswap.c                            |  22 ++--
>  7 files changed, 177 insertions(+), 114 deletions(-)

zsmalloc and zswap bits LGTM with a small nit below:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

[..]
>  
>  /*
> - * Pairs with READ_ONCE() in handle_to_obj(): zs_free() may read the
> - * handle locklessly, so prevent store tearing here.
> + * Pairs with READ_ONCE() in handle_to_obj() and zs_handle_is_allocated():
> + * zs_free(), zs_rebind_handle(), and zs_handle_is_allocated() may read
> + * the handle locklessly, so prevent store tearing here.
>   */
>  static void record_obj(struct zs_handle *handle, unsigned long obj)
>  {
> @@ -1307,31 +1292,37 @@ static unsigned long obj_malloc(struct zs_pool *pool,
>  /**
>   * zs_malloc - Allocate block of given size from pool.
>   * @pool: pool to allocate from
> + * @handle: handle to store allocated object in
>   * @size: size of block to allocate
>   * @gfp: gfp flags when allocating object
>   * @nid: The preferred node id to allocate new zspage (if needed)
>   *
> - * On success, handle to the allocated object is returned,
> - * otherwise an ERR_PTR().
>   * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
> + * zsmalloc keeps a back-pointer to @handle and updates it asynchronously
> + * when the object moves, so @handle must be unsigned-long aligned, must
> + * not be on the stack or modified/copied by the caller, and must remain
> + * allocated until zs_free() or zs_rebind_handle().
> + *
> + * Return: 0 on success, negative error code otherwise.
>   */
> -struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
> -			    const int nid)
> +int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
> +	      gfp_t gfp, const int nid)
>  {
> -	struct zs_handle *handle;
>  	struct size_class *class;
>  	int newfg;
>  	struct zspage *zspage;
>  
> +	if (WARN_ON_ONCE(!IS_ALIGNED((unsigned long)handle,
> +				     __alignof__(unsigned long)) ||
> +			 object_is_on_stack(handle) ||
> +			 zs_handle_is_allocated(handle)))

Nit: Put this in a helper to reuse in zs_rebind_handle().

> +		return -EINVAL;
> +
[..]  
> +/**
> + * zs_rebind_handle() - Rebind an allocated object to a new handle.
> + * @pool: pool the object belongs to
> + * @dst: unallocated destination handle (must not be on the stack)
> + * @src: source handle that currently owns the object
> + *
> + * Rebinds the object from @src to @dst, updating the object header so
> + * compaction and page migration update @dst instead of @src, and resets
> + * @src.
> + */
> +void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
> +		      struct zs_handle *src)
> +{
> +	struct size_class *class;
> +	struct zspage *zspage;
> +	struct zpdesc *zpdesc;
> +	struct link_free *link;
> +	unsigned int obj_idx;
> +	unsigned long obj;
> +	unsigned long off;
> +	void *vaddr;
> +
> +	/* Should never happen; bail out rather than corrupting handles */
> +	if (WARN_ON_ONCE(!IS_ALIGNED((unsigned long)dst,
> +				     __alignof__(unsigned long)) ||
> +			 object_is_on_stack(dst) ||
> +			 zs_handle_is_allocated(dst) ||
> +			 !zs_handle_is_allocated(src)))
> +		return;
[..]
