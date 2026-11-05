Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899158;
	b=W7Me9hRlJhHdvzsRlseFrBRsURb8+hHaxdurvG2FgYfquzCWgdb2nlBfwEjggh86a5bN
	 MexBW/hQv0xXMDuTQlE3UZ4SdSfXE3dNGVvfshHRbhy/DgG710j6tF5ndSJt5gNuSTo84
	 iLmtKQ2SSdygPAXMwa6/agICPRR2LQgvWp64uEkZYIBZskUSTXVn7FAoEm/g/OYTAh8hY
	 bKd5TZhZVCTeEfoxrAnifEq6Dn11TX057J8c6+pj32HiSp21cyrCjLe4FZyXXPyBiVkT2
	 mq5rj7prXFkw/01CWpjX42zMh0h4nkDn4QzMvCUQTtLDpWELa8q11R+KDrJ/6jxiZtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899158;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xjdYfBlTXjkgnPLcfHWBun2lYgDctvXz+QMZ9GMRG4s=;
	b=2f96OlrgCstb7bD4CsyJ84hyfxFMI9QX8B7eAQ/++rTK9A73BopBBhp/2qDwRU0nmNae
	 QdpzxoWbzv+GQh/oVwRFxetVrvZQtNHgOcCeIcrWWEkcUh0p2cdWWYUcWF7YLZ6uxojjk
	 uLCK5MjCfPngSI01zbGo4v7gWc98i3b6eg99gEqELd0+IhZdV9QamYVPxQPchYfJrpFjn
	 ViDev8URcRJbWHNvDAJsro9aA9xReH6LDdmNYKSAj33xc9N4Wujn0zywOAY/AlCmQabUs
	 uQQQWOzuy9nugICW8hoxi+97p7/fjwzzo4gVUvb+eCsy1VNHXHzgUQKyaEzdttjxqlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgLnkLkD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422E606A32E;
	Thu,  5 Nov 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgLnkLkD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE771F000C1;
	Thu,  5 Nov 2026 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899157;
	bh=xjdYfBlTXjkgnPLcfHWBun2lYgDctvXz+QMZ9GMRG4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kgLnkLkDmRSHA3cbbJA+NIFwe4aQxML3/H8S77tTIeQVlFhCRp9lH9IGUi734kAiF
	 rXJJxog1sXaAe03e37SNledfxKYHALb52HkKpN2S3qQsajRR8z668Er0SUgN+g32tj
	 1rmYC/Waw/HSAnEIpO/QaJPhGn+ai8cm7fT3EO7SV4pTzIcmWherRXY5TKfARjdJmy
	 kF+rTPelWKyfD0ZBLEeYFZfT2GKe2FdUGlTT8Z3D1ad37+d2a9rbSyjj8SGMDzy655
	 O6NA2e+913hZuGhyu8SUqhcfKO3k2172u5z4m4t6ABJTo7UhqBwMGNq/ubQjK0MX6D
	 J1//kdAYd7YuQ==
Date: Thu, 5 Nov 2026 17:19:16 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/7] zsmalloc: embed struct zs_handle into zram and zswap
 entries
Message-ID: <auy22TkX0ADxP9WR@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-6-senozhatsky@chromium.org>
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
In-Reply-To: <20261105044752.1997895-6-senozhatsky@chromium.org>

On Thu, Nov 05, 2026 at 01:47:35PM +0900, Sergey Senozhatsky wrote:
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
> Since compaction and migration update the handle in place, it must not
> be on the stack (zs_malloc() warns about that) and must not be copied.
> zram recompression allocates a new object before it frees the old one,
> so it uses zram->recomp_handle, protected by ->dev_lock, and
> zs_rebind_handle() moves the new object to the slot handle. zram
> recompression is the only user of zs_rebind_handle().
> 
> This saves 8 bytes per stored page, e.g. 2MB per 1GB of swapped out
> 4K pages.  Since handle is per-entry the memory savings scale.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  Documentation/admin-guide/mm/slab.rst |   2 +-
>  Documentation/mm/zsmalloc.rst         |   4 +-
>  drivers/block/zram/Kconfig            |   1 +
>  drivers/block/zram/zram_drv.c         |  74 ++++++++---------
>  drivers/block/zram/zram_drv.h         |   6 +-
>  include/linux/zsmalloc.h              |  30 ++++++-
>  mm/Kconfig                            |   3 +
>  mm/zsmalloc.c                         | 110 ++++++++++++++++----------
>  mm/zswap.c                            |  22 +++---
>  9 files changed, 154 insertions(+), 98 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/slab.rst b/Documentation/admin-guide/mm/slab.rst
> index 14429ab90611..57e4a118a391 100644
> --- a/Documentation/admin-guide/mm/slab.rst
> +++ b/Documentation/admin-guide/mm/slab.rst
> @@ -96,7 +96,7 @@ except some that are deemed too performance critical and don't need to be
>  debugged by specifying global debug options followed by a list of slab names
>  with "-" as options::
>  
> -	slab_debug=FZ;-,zs_handle,zspage
> +	slab_debug=FZ;-,zspage
>  
>  The state of each debug option for a slab can be found in the respective files
>  under::
> diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> index d2bbecd78e14..dbb5c1a8dcc3 100644
> --- a/Documentation/mm/zsmalloc.rst
> +++ b/Documentation/mm/zsmalloc.rst
> @@ -23,8 +23,8 @@ uncompressed form). For allocation requests larger than this size, failure
>  is returned (see zs_malloc).
>  
>  Additionally, zs_malloc() does not return a dereferenceable pointer.
> -Instead, it returns an opaque handle (unsigned long) which encodes actual
> -location of the allocated object. The reason for this indirection is that
> +Instead, it stores the encoded location of the allocated object in the
> +provided ``struct zs_handle``. The reason for this indirection is that

Should we explicitly call out that zsmalloc will keep a back pointer to
the handle and update it asynchronously, so the owner shouldn't modify
it, and should keep it allocated until zs_free() (or rebind)?

Probably somewhere in the code comments too?

>  zsmalloc does not keep zspages permanently mapped since that would cause
>  issues on 32-bit systems where the VA region for kernel space mappings
>  is very small. So, using the allocated memory should be done through the
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index 693c9484b638..6c76fd10344e 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -14,6 +14,7 @@
>  #ifndef _ZS_MALLOC_H_
>  #define _ZS_MALLOC_H_
>  
> +#include <linux/compiler.h>
>  #include <linux/types.h>
>  
>  struct zs_pool_stats {
> @@ -21,16 +22,39 @@ struct zs_pool_stats {
>  	atomic_long_t pages_compacted;
>  };
>  
> +/*
> + * zsmalloc writes object location into the handle and updates it when
> + * the object moves (compaction, page migration), so the handle must not
> + * be on the stack and must not be copied.  Use zs_rebind_handle() to
> + * move an object to another handle.
> + */
> +struct zs_handle {
> +	unsigned long __private obj;
> +} __aligned(sizeof(unsigned long));

Is alignment guaranteed even if this is embedded in a packed struct? I
wonder if we should have an explicit alignment check in
zs_malloc()/zs_store(), and probably rebind too?

> +
> +static inline void zs_handle_init(struct zs_handle *handle)
> +{
> +	ACCESS_PRIVATE(handle, obj) = 0;
> +}
> +
> +static inline bool zs_handle_is_allocated(const struct zs_handle *handle)
> +{
> +	return READ_ONCE(ACCESS_PRIVATE(handle, obj)) != 0;
> +}

Can this ever give a false negative? I believe that's only possible with
pfn=0, I don't know if this can be the case on any architecture. Should
we use something like OBJ_ALLOCATED_TAG?

> +
>  struct zs_pool;
> -struct zs_handle;
>  struct scatterlist;
>  
>  struct zs_pool *zs_create_pool(const char *name);
>  void zs_destroy_pool(struct zs_pool *pool);
>  
> -struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
> -			    const int nid);
> +int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
> +	      gfp_t flags, const int nid);
>  void zs_free(struct zs_pool *pool, struct zs_handle *handle);
> +#ifdef CONFIG_ZSMALLOC_REBIND_HANDLE

FWIW, I don't think this is buying as much. It's one function that is
only called by zram anyway.

> +void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
> +		      struct zs_handle *src);

A few comments in zsmalloc.c mention zs_free() reading the handle
locklessly, do these apply to rebinding as well?

> +#endif
>  
>  size_t zs_huge_class_size(struct zs_pool *pool);

[..]
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 397b06c9f33b..f28a46cae1e1 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -215,7 +215,7 @@ struct zswap_entry {
>  	unsigned int length;
>  	bool referenced;
>  	u8 pool_idx;
> -	struct zs_handle *handle;
> +	struct zs_handle handle;
>  	struct obj_cgroup *objcg;
>  	struct list_head lru;
>  };
> @@ -769,6 +769,7 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
>  	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
>  	if (!entry)
>  		return NULL;
> +	zs_handle_init(&entry->handle);
>  	return entry;
>  }
>  
> @@ -787,7 +788,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  
>  	zswap_lru_del(entry);
>  	if (!WARN_ON_ONCE(!pool)) {

This check is mostly defensive, and if the pool was ever NULL it
prevented a NULL deref, and potentially leaked the underlying zsmalloc
object, which is mostly fine as the pool being NULL points to a larger
problem (e.g. corruption).

However, if that happens now, the handle pointer in zsmalloc would point
at the zswap entry after it's freed by zswap_entry_cache_free() below,
potentially causing a UAF. It's arguably fine as it's just a cascade of
corruptions, but I wonder if we should just bail early and skip all
cleanups below if the pool is NULL.

We'll leak the cgroup charge, stats, and the zswap entry itself -- but
that's arguably the safer option if we already have a corruption
problem.

We can also just delete the NULL check, but it's cheap to keep and I'd
rather have it tbh.

> -		zs_free(pool->zs_pool, entry->handle);
> +		zs_free(pool->zs_pool, &entry->handle);
>  		zswap_pool_put(pool);
>  	}
>  	if (entry->objcg) {
