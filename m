Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898186;
	b=bGLbHiE+fhkytbcMboioVVICpFbcheRplmN93wVUxk6c4fHPeTNFQ6Tw+jhC9p7ziCfk
	 7qobfdK339K87t0RmXlL061fDfJgiyWgPOrWeHuKmGJvGL53t3bQzcfBaWWzUvLGZqGFC
	 x0PMIVPhnwwJR04omt6Ky5EILyrAAhFTKx6FVKZHVK8m0XZnxAJ4maiu9VIhxHsIsrzyE
	 uLqZCbP4S65eGGs2hLQI6nic+2kGcZNgxYsbJ+IjyFao8CkIW3XHHNsM8KhwDLWjnIAfW
	 1+B+zoWfm5vqgpwc0dr9hi7RpDuOSZM/pQXXJqwbRbonzQwbquVRlISZ6/W7vSj6Q2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898186;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+GDK5SHSY6SA93NwCdlZTl+b20QDETC0OdxKh5BTja4=;
	b=4At+Amqkb6CTUDF6wkXu9opH7x06FCTnbzI6wLDQm4BQ67yk0+CR+PulLw88M4NDh9RF
	 JDfCPJ/wC0Uu70F4YpO+YH65Ox4tVxvw5h9QTDKMIUQjGI4ecdL/xrFerKwCkIEfUvqPO
	 PUYllOTQYwiaGgPaIcOUAC4g2eTVqKrdxYEHsg8oJz4f//7efgngmtKoBpfMrBEdrsT/O
	 m73vSx2h2dilLQV9hOAQQ4iWm7SrCbdhglMkBp2fOMX2705zNJkKHCVCxmBeJz68ACXK+
	 w9QbfB+ntEkYkbqEFE8ILXnLM80mywF733F1Eyg6hY8Mv0k5EG9Q65XaoJ81fokOEZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/zzQhn9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762D606A33E;
	Thu,  5 Nov 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/zzQhn9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4329B1F00A15;
	Thu,  5 Nov 2026 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898185;
	bh=+GDK5SHSY6SA93NwCdlZTl+b20QDETC0OdxKh5BTja4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U/zzQhn9F9RkCJilk4OZI/QAAx01gxRgJL5gzdN1eBbPe+uIGkyUIY/eHuti0URuV
	 PC7SUDFqmuz2hgDMK1d01qt6xjAyjtPUFHYy28KJ/ecJVH9fN82lpkhN/4yVV1XlRO
	 J+g/tpgZlN6y1WvV3NayHklvEYOpvWYENJlITQYLg5XptBrIk+g6mtTGVFojNMYH0f
	 k08K2sSlJ0/J3aq6my/f7r4uDwhlW8g15clSQ4VvKR/0ZgfPRWwuC2F48xkjZIw6dX
	 57HFiVyxHavVE/PKepqny3sH4DJ91vEiRpr6mCqisqmj08Gc+2CBOd1Z/MKUn0p7F3
	 5Eai81R5zHBiQ==
Date: Thu, 5 Nov 2026 17:03:03 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/7] zsmalloc: switch handle type to struct zs_handle
Message-ID: <auy19VvYgb25vnFc@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-4-senozhatsky@chromium.org>
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
In-Reply-To: <20261105044752.1997895-4-senozhatsky@chromium.org>

[..]
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index 5b7298a5026b..693c9484b638 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -22,14 +22,15 @@ struct zs_pool_stats {
>  };
>  
>  struct zs_pool;
> +struct zs_handle;
>  struct scatterlist;
>  
>  struct zs_pool *zs_create_pool(const char *name);
>  void zs_destroy_pool(struct zs_pool *pool);
>  
> -unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
> -			const int nid);
> -void zs_free(struct zs_pool *pool, unsigned long obj);
> +struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
> +			    const int nid);
> +void zs_free(struct zs_pool *pool, struct zs_handle *handle);
>  
>  size_t zs_huge_class_size(struct zs_pool *pool);
>  
> @@ -40,10 +41,10 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size);
>  
>  void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
>  
> -void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
> +void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
>  			  struct scatterlist *sg, size_t mem_len);
> -void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
> -void zs_obj_write(struct zs_pool *pool, unsigned long handle,
> +void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle);
> +void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
>  		  void *handle_mem, size_t mem_len);

I would squash patch 7's constification here.

>  
>  extern const struct movable_operations zsmalloc_mops;
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 7ef80e0da626..7d8aab56f5cd 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -264,6 +264,10 @@ struct link_free {
>  	};
>  };
>  
> +struct zs_handle {
> +	unsigned long __private obj;
> +};
> +
>  static struct kmem_cache *handle_cachep;
>  static struct kmem_cache *zspage_cachep;
>  
> @@ -438,16 +442,16 @@ static void init_deferred_free(struct zs_pool *pool) {}
>  static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
>  #endif
>  
> -static unsigned long cache_alloc_handle(gfp_t gfp)
> +static struct zs_handle *cache_alloc_handle(gfp_t gfp)
>  {
>  	gfp = gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE);
>  
> -	return (unsigned long)kmem_cache_alloc(handle_cachep, gfp);
> +	return kmem_cache_alloc(handle_cachep, gfp);
>  }
>  
> -static void cache_free_handle(unsigned long handle)
> +static void cache_free_handle(struct zs_handle *handle)
>  {
> -	kmem_cache_free(handle_cachep, (void *)handle);
> +	kmem_cache_free(handle_cachep, handle);
>  }
>  
>  static struct zspage *cache_alloc_zspage(gfp_t gfp)
> @@ -466,9 +470,9 @@ static void cache_free_zspage(struct zspage *zspage)
>   * Pairs with READ_ONCE() in handle_to_obj(): zs_free() may read the
>   * handle locklessly, so prevent store tearing here.
>   */
> -static void record_obj(unsigned long handle, unsigned long obj)
> +static void record_obj(struct zs_handle *handle, unsigned long obj)
>  {
> -	WRITE_ONCE(*(unsigned long *)handle, obj);
> +	WRITE_ONCE(ACCESS_PRIVATE(handle, obj), obj);
>  }
>  
>  /* Protected by class->lock */
> @@ -817,13 +821,13 @@ static unsigned long location_to_obj(struct zpdesc *zpdesc, unsigned int obj_idx
>  	return obj;
>  }
>  
> -static unsigned long handle_to_obj(unsigned long handle)
> +static unsigned long handle_to_obj(struct zs_handle *handle)
>  {
> -	return READ_ONCE(*(unsigned long *)handle);
> +	return READ_ONCE(ACCESS_PRIVATE(handle, obj));
>  }
>  
>  static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
> -				 unsigned long *phandle)
> +				 struct zs_handle **phandle)
>  {
>  	unsigned long handle;
>  	struct zspage *zspage = get_zspage(zpdesc);
> @@ -839,7 +843,7 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
>  		return false;
>  
>  	/* Clear all tags before returning the handle */
> -	*phandle = handle & ~OBJ_TAG_MASK;
> +	*phandle = (struct zs_handle *)(handle & ~OBJ_TAG_MASK);
>  	return true;
>  }

Would it be cleaerer if obj_allocated() just returned the handle here? I
believe this can be done separately in a prep patch.

