Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899750;
	b=3jorGQEJicE85aVB9fZRcG8DP+mHFCmGOuj1AHO9OKQg7qYY+iJEvlZypt9EPZ0BcMJ0
	 t9Xiu5Y4mqVYKiV4F0SHqXR65C7C7YowwOIidTPWG77c7sfyznxA5LWKii8quCv8IRY0w
	 1UG1fL3zX8VOzEEpqDh86E0U+ve9zt7ebVBFCwQLxj1W0Y+jaQv3uMFIGEL7t31F+mqla
	 mSw5ng+lPIWj4og3TYewL4fdDg2scaLwujcwkUM7DR5XtUiJWLWX2Nembf+nRgDP5zScB
	 lXr0cPCVnjPip2Mnf/eJANRnpmwcDiJ+n8eMaaw4rFgu9k6jHR14F4AIt4owusH/wOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899750;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OI82NC+VtO6XCg1b7sL9Mba+LLUc0Oyq52Xd0koXNtA=;
	b=hHGkSF966AHOdqRq3M4qfxZc9wiXjpJvtIDA9Vfz5I7WZ0XmsMwaixPt5BfR1cSNBO3G
	 S9xmTYjX8Z+gsCmbFi8I7ES5m1x/YDVEVnpDV0nQb1qbmX2vK4jp415Y73q8FYn00U+P5
	 WptCEuEGNpa5kUvHyC4rNm0k/oMvOMluwR5PwBACj5M+/hKxqLua/daXFEgx4mMOmG6UL
	 MFCDOMY8bJBYdvszEP6y27zKSmgrugtHmToSeXwgsy9MWb9BZakX+eTfz6q1YStLPoxEe
	 Wr0gMEb3EySz+P+78X9BfoKk5Lf3pRcTqiN/MtsnvAhUs85PZfvajkZdHIiFvC2yFuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLB8QlI4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E7606A31B;
	Thu,  5 Nov 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLB8QlI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4601F000C1;
	Thu,  5 Nov 2026 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899749;
	bh=OI82NC+VtO6XCg1b7sL9Mba+LLUc0Oyq52Xd0koXNtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MLB8QlI4b9Zj96xuu1gX2RDKKLpHjWgsbP+lWZ/jXYJAgMJaQP0yow/NhM2eVaerw
	 RUl1gWByjCzr+FPSbtEBObL1y9PjsQTmtTwmlt3C1G0K03nDpp9ICWHkhGOPVfaqHB
	 PooUz4IiQUp6OymGCzzlwIav3h+XQsZ9dBMQaLfT0OQ5gleCT87KAcKDSJENdGj+6v
	 YICepRUZDih8ob8KMzawL3S2K4uLzieLoJa5pMxSuWZ4D4TeQBxlIBrBRhPZfZtIr6
	 BamFIJDtq1UNS7fLmn3sr4TxMwc/Bcs8xFc4lHnswt1r7NTA2cohCcWKoJDVZ/iP0e
	 Muxsn+zeGo5Iw==
Date: Thu, 5 Nov 2026 17:29:08 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/7] zsmalloc: fold zs_obj_write() into zs_store()
Message-ID: <auy6wQIz89NxpskT@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-7-senozhatsky@chromium.org>
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
In-Reply-To: <20261105044752.1997895-7-senozhatsky@chromium.org>

On Thu, Nov 05, 2026 at 01:47:36PM +0900, Sergey Senozhatsky wrote:
> zram and zswap always call zs_obj_write() right after zs_malloc(), and
> zs_obj_write() has to take pool->lock and look up object location
> again, which zs_malloc() just did.
> 
> Replace zs_malloc() and zs_obj_write() with one single zs_store()
> call.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  Documentation/core-api/memory-allocation.rst |  2 +-
>  Documentation/mm/zsmalloc.rst                |  4 +-
>  drivers/block/zram/zram_drv.c                | 43 ++++++-----------
>  include/linux/zsmalloc.h                     |  6 +--
>  mm/zsmalloc.c                                | 51 +++++++++-----------
>  mm/zswap.c                                   |  5 +-
>  6 files changed, 46 insertions(+), 65 deletions(-)
> 
> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> index 648222b6c857..5069ac72b857 100644
> --- a/Documentation/core-api/memory-allocation.rst
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -9,7 +9,7 @@ allocate small chunks using `kmalloc` or `kmem_cache_alloc` families,
>  large virtually contiguous areas using `vmalloc` and its derivatives,
>  or you can directly request pages from the page allocator with
>  `alloc_pages`. It is also possible to use more specialized allocators,
> -for instance `cma_alloc` or `zs_malloc`.
> +for instance `cma_alloc` or `zs_store`.
>  
>  Most of the memory allocation APIs use GFP flags to express how that
>  memory should be allocated. The GFP acronym stands for "get free
> diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> index dbb5c1a8dcc3..52eaba8f97e9 100644
> --- a/Documentation/mm/zsmalloc.rst
> +++ b/Documentation/mm/zsmalloc.rst
> @@ -20,9 +20,9 @@ For simplicity, zsmalloc can only allocate objects of size up to PAGE_SIZE
>  since this satisfies the requirements of all its current users (in the
>  worst case, page is incompressible and is thus stored "as-is" i.e. in
>  uncompressed form). For allocation requests larger than this size, failure
> -is returned (see zs_malloc).
> +is returned (see zs_store).
>  
> -Additionally, zs_malloc() does not return a dereferenceable pointer.
> +Additionally, zs_store() does not return a dereferenceable pointer.

Well, it doesn't return a pointer at all now.

>  Instead, it stores the encoded location of the allocated object in the
>  provided ``struct zs_handle``. The reason for this indirection is that
>  zsmalloc does not keep zspages permanently mapped since that would cause
[..]

> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index 6c76fd10344e..674358f39191 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -48,8 +48,8 @@ struct scatterlist;
>  struct zs_pool *zs_create_pool(const char *name);
>  void zs_destroy_pool(struct zs_pool *pool);
>  
> -int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
> -	      gfp_t flags, const int nid);
> +int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
> +	     size_t size, gfp_t flags, const int nid);
>  void zs_free(struct zs_pool *pool, struct zs_handle *handle);
>  #ifdef CONFIG_ZSMALLOC_REBIND_HANDLE
>  void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
> @@ -68,8 +68,6 @@ void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
>  void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
>  			  struct scatterlist *sg, size_t mem_len);
>  void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle);
> -void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
> -		  void *handle_mem, size_t mem_len);
>  
>  extern const struct movable_operations zsmalloc_mops;
>  
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 71e6dcb1fb3f..ff1cde4c5dc2 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1172,26 +1172,15 @@ void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle)
>  }
>  EXPORT_SYMBOL_GPL(zs_obj_read_sg_end);
>  
> -void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
> -		  void *handle_mem, size_t mem_len)
> +static void obj_write(struct size_class *class, struct zspage *zspage,
> +		      unsigned long obj, const void *handle_mem,
> +		      size_t mem_len)

Should handle_mem and mem_len be renamed now?

Also, there's a comment in zs_page_migrate() referring to zs_obj_read/write().

>  {
> -	struct zspage *zspage;
>  	struct zpdesc *zpdesc;
> -	unsigned long obj, off;
> +	unsigned long off;
>  	unsigned int obj_idx;
> -	struct size_class *class;
>  
> -	/* Guarantee we can get zspage from handle safely */
> -	read_lock(&pool->lock);
> -	obj = handle_to_obj(handle);
>  	obj_to_location(obj, &zpdesc, &obj_idx);
> -	zspage = get_zspage(zpdesc);
> -
> -	/* Make sure migration doesn't move any pages in this zspage */
> -	zspage_read_lock(zspage);
> -	read_unlock(&pool->lock);
> -
> -	class = zspage_class(pool, zspage);
>  	off = offset_in_page(class->size * obj_idx);
>  
>  	if (!ZsHugePage(zspage))
[..]
  
> @@ -1318,12 +1306,16 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
>  	spin_lock(&class->lock);
>  	zspage = find_get_zspage(class);
>  	if (likely(zspage)) {
> -		obj_malloc(pool, zspage, handle);
> +		obj = obj_malloc(pool, zspage, handle);
>  		/* Now move the zspage to another fullness group, if required */
>  		fix_fullness_group(class, zspage);
>  		class_stat_add(class, ZS_OBJS_INUSE, 1);
> +		zspage_read_lock(zspage);

The zspage lock is now acquired under the class lock instead of the pool
lock, this is probably fine but worth calling out explicitly in the
changelog.

> +		spin_unlock(&class->lock);
>  
> -		goto out;
> +		obj_write(class, zspage, obj, src, size);
> +		zspage_read_unlock(zspage);
> +		return 0;
>  	}
>  
>  	spin_unlock(&class->lock);
> @@ -1332,8 +1324,14 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
>  	if (!zspage)
>  		return -ENOMEM;
>  
> +	/*
> +	 * New zspage is not in class->fullness_list or movable yet, so we
> +	 * can allocate the object and copy data before taking class->lock.
> +	 */
> +	obj = obj_malloc(pool, zspage, handle);
> +	obj_write(class, zspage, obj, src, size);
> +
>  	spin_lock(&class->lock);
> -	obj_malloc(pool, zspage, handle);

Should moving obj_malloc() and obj_write() outside class->lock (and
skipping zspage_read_lock()) for new zspages be split into a separate
patch on top? AFAICT, it's a separate change from merging the
interfaces.

>  	newfg = get_fullness_group(class, zspage);
>  	insert_zspage(class, zspage, newfg);
>  	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
