Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD54279DAF
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643539; cv=none; b=UE0VOR7O8I9S2an6W3PnxUPpemAZW7jdxOwR0xzQUSKmX8HF+CeRMm6dLdMP9QZtntnvyewhzQb5XHFMFmQ7tya5NXDrM6uK/0K2rL/Niq76AkQBaD5nLFnq0SGNSDUOAkO5pp4Mq2Wa2r2liZpkgG+/cRK1vsV1jfA54Q/Bwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643539; c=relaxed/simple;
	bh=VDs9ICoc1Cbx3bRkHfGV2KZNv6Un/bJmhOUx1bAvdrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7gwiDkj96nCCJNyEWxfJFR6xOk+1iIWBwCy2TkRKZB0HLByFAzJxwUC+v+OASMpoB7LGU6OaaUoDhnuYNy6vFACjO/TN60/zBvSKiaDeP6jksCYWSnq4JP5OJN39rGHh845u6od7XHhIVUd+q3uBUpg4FEJviPcwGmmNX5rj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVJAwc3M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVJAwc3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4336DC2BCB1
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772643539;
	bh=VDs9ICoc1Cbx3bRkHfGV2KZNv6Un/bJmhOUx1bAvdrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AVJAwc3MJ2J6D6rWdo8AUGtzeFVTj6VC6Dlt7e8UuclWwDpK6f5GadTsTtUS3wpEd
	 W6KC/FW09T/SeYpzo2CJUcF/yXcG1W56xFHo6VH016pdqLnjNvfBgsT+huDUJAugZm
	 /GrS+1FNCQPiFNKqONU8JYZ3SQykhLiUVlQdhXP1xxlmHhhcv0DvHbetfVBPo7PFXE
	 0CDgFj45doG37yzxOF6JW8Qjz9rzVSA/JjmY8hKutlxzPqKjFJMoZjcD1adrbuhMOf
	 K5xHJGXlYmJi4lQh+gak1zJcZrHdWTDuUC9+5MRlMQqzTWuRgi11IRuUv99M4FEJ3N
	 Sgkuq/4QO3x6w==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9359c0ec47so768139866b.0
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 08:58:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXowPvrTx5JgIkRZLlCLNLnTWfn1K4CJVMCe3FC/Ac6ISDSN+DACrd4iIeT+lkMokA2ORnO/rhXFTvkJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/1D9m4hU6kTV7X2r85+mEukUB0xV9lVRRa+HgxbCKDHP0gRp
	gsPY0WvqRqDPIu5cFE0X555WpvSYQDRONO+hQ/A/Dt/BSDlqT0SEL2gdY/ldbp8va4RUULFw9Jp
	KbNaT7RiHQXjAkYiVXjfIV81mdOgZXWE=
X-Received: by 2002:a17:907:7fa1:b0:b8f:e46f:8079 with SMTP id
 a640c23a62f3a-b93f11a3c47mr151357566b.22.1772643537892; Wed, 04 Mar 2026
 08:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com> <20260226192936.3190275-4-joshua.hahnjy@gmail.com>
In-Reply-To: <20260226192936.3190275-4-joshua.hahnjy@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 4 Mar 2026 08:58:44 -0800
X-Gmail-Original-Message-ID: <CAO9r8zP56KdyaQjMp4PK_yS27x35s0p=aHYzT8Ey0f7bkbvNuA@mail.gmail.com>
X-Gm-Features: AaiRm50T4h9I47c9D1mouoa_fkgZburaikg75Do9PmRofEtRFyBH2qk8gM1wq6M
Message-ID: <CAO9r8zP56KdyaQjMp4PK_yS27x35s0p=aHYzT8Ey0f7bkbvNuA@mail.gmail.com>
Subject: Re: [PATCH 3/8] mm/zsmalloc: Introduce objcgs pointer in struct zpdesc
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jens Axboe <axboe@kernel.dk>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <hoangnhat.pham@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  static struct zspage *find_get_zspage(struct size_class *class)
> @@ -1289,13 +1336,14 @@ static unsigned long obj_malloc(struct zs_pool *p=
ool,
>   * @size: size of block to allocate
>   * @gfp: gfp flags when allocating object
>   * @nid: The preferred node id to allocate new zspage (if needed)
> + * @objcg: Whether the zspage should track per-object memory charging.
>   *
>   * On success, handle to the allocated object is returned,
>   * otherwise an ERR_PTR().
>   * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
>   */
>  unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
> -                       const int nid)
> +                       const int nid, bool objcg)

Instead of passing in a boolean here, what if we make it a pool
parameter at creation time? I don't foresee I use case where some
objects are charged and some aren't. This avoids needing to always
pass objcg=3Dtrue (for zswap) or objcg=3Dfalse (for zram), and reduces
churn. Also, it allows us to add assertions to zs_obj_write() (and
elsewhere if needed) that an objcg is passed in when the pool should
be charged.

We can even add a zs_obj_write_objcg() variant that takes in an objcg,
and keep the current one as-is. Both would internally call a helper
that takes in an objcg, but that would further minimize churn to zram.
Not sure if that's worth it though. Sergey, WDYT?


On Thu, Feb 26, 2026 at 11:29=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> Introduce an array of struct obj_cgroup pointers to zpdesc to keep track
> of compressed objects' memcg ownership.
>
> The 8 bytes required to add the array in struct zpdesc brings its size
> up from 56 bytes to 64 bytes. However, in the current implementation,
> struct zpdesc lays on top of struct page[1]. This allows the increased
> size to remain invisible to the outside, since 64 bytes are used for
> struct zpdesc anyways.
>
> The newly added obj_cgroup array pointer overlays page->memcg_data,
> which causes problems for functions that try to perform page charging by
> checking the zeroness of page->memcg_data. To make sure that the
> backing zpdesc's obj_cgroup ** is not interpreted as a mem_cgroup *,
> follow SLUB's lead and use the MEMCG_DATA_OBJEXTS bit to tag the pointer.
>
> Consumers of zsmalloc that do not perform memcg accounting (i.e. zram)
> are completely unaffected by this patch, as the array to track the
> obj_cgroup pointers are only allocated in the zswap path.
>
> This patch temporarily increases the memory used by zswap by 8 bytes
> per zswap_entry, since the obj_cgroup pointer is duplicated in the
> zpdesc and in zswap_entry. In the following patches, we will redirect
> memory charging operations to use the zpdesc's obj_cgroup instead, and
> remove the pointer from zswap_entry. This will leave no net memory usage
> increase for both zram and zswap.
>
> In this patch, allocate / free the objcg pointer array for the zswap
> path, and handle partial object migration and full zpdesc migration.
>
> [1] In the (near) future, struct zpdesc may no longer overlay struct
> page as we shift towards using memdescs. When this happens, the size
> increase of struct zpdesc will no longer free. With that said, the
> difference can be kept minimal.
>
> All the changes that are being implemented are currently guarded under
> CONFIG_MEMCG. We can optionally minimize the impact on zram users by
> guarding these changes in CONFIG_MEMCG && CONFIG_ZSWAP as well.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  drivers/block/zram/zram_drv.c | 10 ++---
>  include/linux/zsmalloc.h      |  2 +-
>  mm/zpdesc.h                   | 25 +++++++++++-
>  mm/zsmalloc.c                 | 74 +++++++++++++++++++++++++++++------
>  mm/zswap.c                    |  2 +-
>  5 files changed, 93 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 61d3e2c74901..60ee85679730 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2220,8 +2220,8 @@ static int write_incompressible_page(struct zram *z=
ram, struct page *page,
>          * like we do for compressible pages.
>          */
>         handle =3D zs_malloc(zram->mem_pool, PAGE_SIZE,
> -                          GFP_NOIO | __GFP_NOWARN |
> -                          __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(pag=
e));
> +                          GFP_NOIO | __GFP_NOWARN | __GFP_HIGHMEM |
> +                          __GFP_MOVABLE, page_to_nid(page), false);
>         if (IS_ERR_VALUE(handle))
>                 return PTR_ERR((void *)handle);
>
> @@ -2283,8 +2283,8 @@ static int zram_write_page(struct zram *zram, struc=
t page *page, u32 index)
>         }
>
>         handle =3D zs_malloc(zram->mem_pool, comp_len,
> -                          GFP_NOIO | __GFP_NOWARN |
> -                          __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(pag=
e));
> +                          GFP_NOIO | __GFP_NOWARN | __GFP_HIGHMEM |
> +                          __GFP_MOVABLE, page_to_nid(page), false);
>         if (IS_ERR_VALUE(handle)) {
>                 zcomp_stream_put(zstrm);
>                 return PTR_ERR((void *)handle);
> @@ -2514,7 +2514,7 @@ static int recompress_slot(struct zram *zram, u32 i=
ndex, struct page *page,
>         handle_new =3D zs_malloc(zram->mem_pool, comp_len_new,
>                                GFP_NOIO | __GFP_NOWARN |
>                                __GFP_HIGHMEM | __GFP_MOVABLE,
> -                              page_to_nid(page));
> +                              page_to_nid(page), false);
>         if (IS_ERR_VALUE(handle_new)) {
>                 zcomp_stream_put(zstrm);
>                 return PTR_ERR((void *)handle_new);
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index 478410c880b1..8ef28b964bb0 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -28,7 +28,7 @@ struct zs_pool *zs_create_pool(const char *name);
>  void zs_destroy_pool(struct zs_pool *pool);
>
>  unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
> -                       const int nid);
> +                       const int nid, bool objcg);
>  void zs_free(struct zs_pool *pool, unsigned long obj);
>
>  size_t zs_huge_class_size(struct zs_pool *pool);
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index b8258dc78548..d10a73e4a90e 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -20,10 +20,12 @@
>   * @zspage:            Points to the zspage this zpdesc is a part of.
>   * @first_obj_offset:  First object offset in zsmalloc pool.
>   * @_refcount:         The number of references to this zpdesc.
> + * @objcgs:            Array of objcgs pointers that the stored objs
> + *                     belong to. Overlayed on top of page->memcg_data, =
and
> + *                     will always have first bit set if it is a valid p=
ointer.
>   *
>   * This struct overlays struct page for now. Do not modify without a goo=
d
> - * understanding of the issues. In particular, do not expand into the ov=
erlap
> - * with memcg_data.
> + * understanding of the issues.
>   *
>   * Page flags used:
>   * * PG_private identifies the first component page.
> @@ -47,6 +49,9 @@ struct zpdesc {
>          */
>         unsigned int first_obj_offset;
>         atomic_t _refcount;
> +#ifdef CONFIG_MEMCG
> +       unsigned long objcgs;
> +#endif
>  };
>  #define ZPDESC_MATCH(pg, zp) \
>         static_assert(offsetof(struct page, pg) =3D=3D offsetof(struct zp=
desc, zp))
> @@ -59,6 +64,9 @@ ZPDESC_MATCH(__folio_index, handle);
>  ZPDESC_MATCH(private, zspage);
>  ZPDESC_MATCH(page_type, first_obj_offset);
>  ZPDESC_MATCH(_refcount, _refcount);
> +#ifdef CONFIG_MEMCG
> +ZPDESC_MATCH(memcg_data, objcgs);
> +#endif
>  #undef ZPDESC_MATCH
>  static_assert(sizeof(struct zpdesc) <=3D sizeof(struct page));
>
> @@ -171,4 +179,17 @@ static inline bool zpdesc_is_locked(struct zpdesc *z=
pdesc)
>  {
>         return folio_test_locked(zpdesc_folio(zpdesc));
>  }
> +
> +#ifdef CONFIG_MEMCG
> +static inline struct obj_cgroup **zpdesc_objcgs(struct zpdesc *zpdesc)
> +{
> +       return (struct obj_cgroup **)(zpdesc->objcgs & ~OBJEXTS_FLAGS_MAS=
K);
> +}
> +
> +static inline void zpdesc_set_objcgs(struct zpdesc *zpdesc,
> +                                    struct obj_cgroup **objcgs)
> +{
> +       zpdesc->objcgs =3D (unsigned long)objcgs | MEMCG_DATA_OBJEXTS;
> +}
> +#endif
>  #endif
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 7846f31bcc8b..7d56bb700e11 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -39,6 +39,7 @@
>  #include <linux/zsmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/workqueue.h>
> +#include <linux/memcontrol.h>
>  #include "zpdesc.h"
>
>  #define ZSPAGE_MAGIC   0x58
> @@ -777,6 +778,10 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
>         ClearPagePrivate(page);
>         zpdesc->zspage =3D NULL;
>         zpdesc->next =3D NULL;
> +#ifdef CONFIG_MEMCG
> +       kfree(zpdesc_objcgs(zpdesc));
> +       zpdesc->objcgs =3D 0;
> +#endif
>         /* PageZsmalloc is sticky until the page is freed to the buddy. *=
/
>  }
>
> @@ -893,6 +898,43 @@ static void init_zspage(struct size_class *class, st=
ruct zspage *zspage)
>         set_freeobj(zspage, 0);
>  }
>
> +#ifdef CONFIG_MEMCG
> +static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
> +                               struct zpdesc *zpdescs[])
> +{
> +       /*
> +        * Add 2 to objcgs_per_zpdesc to account for partial objs that ma=
y be
> +        * stored at the beginning or end of the zpdesc.
> +        */
> +       int objcgs_per_zpdesc =3D (PAGE_SIZE / class->size) + 2;
> +       int i;
> +       struct obj_cgroup **objcgs;
> +
> +       for (i =3D 0; i < class->pages_per_zspage; i++) {
> +               objcgs =3D kcalloc(objcgs_per_zpdesc, sizeof(struct obj_c=
group *),
> +                                gfp & ~__GFP_HIGHMEM);
> +               if (!objcgs) {
> +                       while (--i >=3D 0) {
> +                               kfree(zpdesc_objcgs(zpdescs[i]));
> +                               zpdescs[i]->objcgs =3D 0;
> +                       }
> +
> +                       return false;
> +               }
> +
> +               zpdesc_set_objcgs(zpdescs[i], objcgs);
> +       }
> +
> +       return true;
> +}
> +#else
> +static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
> +                               struct zpdesc *zpdescs[])
> +{
> +       return true;
> +}
> +#endif
> +
>  static void create_page_chain(struct size_class *class, struct zspage *z=
spage,
>                                 struct zpdesc *zpdescs[])
>  {
> @@ -931,7 +973,7 @@ static void create_page_chain(struct size_class *clas=
s, struct zspage *zspage,
>   */
>  static struct zspage *alloc_zspage(struct zs_pool *pool,
>                                    struct size_class *class,
> -                                  gfp_t gfp, const int nid)
> +                                  gfp_t gfp, const int nid, bool objcg)
>  {
>         int i;
>         struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
> @@ -952,24 +994,29 @@ static struct zspage *alloc_zspage(struct zs_pool *=
pool,
>                 struct zpdesc *zpdesc;
>
>                 zpdesc =3D alloc_zpdesc(gfp, nid);
> -               if (!zpdesc) {
> -                       while (--i >=3D 0) {
> -                               zpdesc_dec_zone_page_state(zpdescs[i]);
> -                               free_zpdesc(zpdescs[i]);
> -                       }
> -                       cache_free_zspage(zspage);
> -                       return NULL;
> -               }
> +               if (!zpdesc)
> +                       goto err;
>                 __zpdesc_set_zsmalloc(zpdesc);
>
>                 zpdesc_inc_zone_page_state(zpdesc);
>                 zpdescs[i] =3D zpdesc;
>         }
>
> +       if (objcg && !alloc_zspage_objcgs(class, gfp, zpdescs))
> +               goto err;
> +
>         create_page_chain(class, zspage, zpdescs);
>         init_zspage(class, zspage);
>
>         return zspage;
> +
> +err:
> +       while (--i >=3D 0) {
> +               zpdesc_dec_zone_page_state(zpdescs[i]);
> +               free_zpdesc(zpdescs[i]);
> +       }
> +       cache_free_zspage(zspage);
> +       return NULL;
>  }
>
>  static struct zspage *find_get_zspage(struct size_class *class)
> @@ -1289,13 +1336,14 @@ static unsigned long obj_malloc(struct zs_pool *p=
ool,
>   * @size: size of block to allocate
>   * @gfp: gfp flags when allocating object
>   * @nid: The preferred node id to allocate new zspage (if needed)
> + * @objcg: Whether the zspage should track per-object memory charging.
>   *
>   * On success, handle to the allocated object is returned,
>   * otherwise an ERR_PTR().
>   * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
>   */
>  unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
> -                       const int nid)
> +                       const int nid, bool objcg)
>  {
>         unsigned long handle;
>         struct size_class *class;
> @@ -1330,7 +1378,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_=
t size, gfp_t gfp,
>
>         spin_unlock(&class->lock);
>
> -       zspage =3D alloc_zspage(pool, class, gfp, nid);
> +       zspage =3D alloc_zspage(pool, class, gfp, nid, objcg);
>         if (!zspage) {
>                 cache_free_handle(handle);
>                 return (unsigned long)ERR_PTR(-ENOMEM);
> @@ -1672,6 +1720,10 @@ static void replace_sub_page(struct size_class *cl=
ass, struct zspage *zspage,
>         if (unlikely(ZsHugePage(zspage)))
>                 newzpdesc->handle =3D oldzpdesc->handle;
>         __zpdesc_set_movable(newzpdesc);
> +#ifdef CONFIG_MEMCG
> +       zpdesc_set_objcgs(newzpdesc, zpdesc_objcgs(oldzpdesc));
> +       oldzpdesc->objcgs =3D 0;
> +#endif
>  }
>
>  static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
> diff --git a/mm/zswap.c b/mm/zswap.c
> index af3f0fbb0558..dd083110bfa0 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -905,7 +905,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>         }
>
>         gfp =3D GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABL=
E;
> -       handle =3D zs_malloc(pool->zs_pool, dlen, gfp, page_to_nid(page))=
;
> +       handle =3D zs_malloc(pool->zs_pool, dlen, gfp, page_to_nid(page),=
 true);
>         if (IS_ERR_VALUE(handle)) {
>                 alloc_ret =3D PTR_ERR((void *)handle);
>                 goto unlock;
> --
> 2.47.3
>
>
