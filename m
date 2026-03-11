Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B02334A785
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260257; cv=pass; b=nXmIcWCr8nLcM2BGs7oktqmRiucU1eKRWKJs/7pVgpnDqY4o7IVjMAinaPHSW9QkJuTR9O5VQLHAiHfzuBgD9ITjkhqo0HafgVb6DnQMC7T7+dvKvwax9HTsmFIMgQbrvojm3PW6p1LYvONKtqIHCqK14OXQnoQN2Q6yZ4Bdl1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260257; c=relaxed/simple;
	bh=3dm8Yp2AGbalK9BXMDsf8hHteEQSxAa1UkIjoIarCE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEBzGleGNGrlQLqve04upvsgPw0e9+9wfYWDFP8WknU+1c3bOIgzrZPFw+7r8is1V1NPr+P1eYgba5K65lW21UeLjAG3C1t4Y5BReX9iYAbVeKJkmp0C9TUqwbHdWnve2+bUgZuAdgWhhqNCNw0/n/BVeVhOfOSJ6x47nwQEe0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/ZMVaxa; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/ZMVaxa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so2023455e9.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773260253; cv=none;
        d=google.com; s=arc-20240605;
        b=gBmZ9YF9f9XKpHr3H6qbszKD9aEUehau+PTlxs3xiLAVymLrWmV/y/ZCh/yK4Gyiaa
         8gJi3imryierOB5IkAZGWiZt9yhtjfmElXQhfGmd2ITq8MT5e2zSfE7aO2pH+gJfZ7Ei
         CbVBvb2aTJ2onVMGnZtdj/5oKoLZSKJEnT8vMzw5kZ5zx7P6pKATCxnOVds3noYq6BFk
         4WwQ3xCDKZYiau21RwmcE3ttGvB8xwmf8b2SQ46C5BkgN1B2V1Zy8sbIoRDnQwFJ9svr
         UicdFM/pbG3oUQXkO+LmklQJYlUo55K4h5kyVKGfA06c6MzjvWphhvyR81rbs+JKGPbW
         BdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lV5czEXSj6GTlGyrBR9CLBL/OkAb3+kqVVdUiTYnGjA=;
        fh=IzOPn4GETsb85UoTKy/qNCQbibrm5GiUGgCHfl0Cb5A=;
        b=QfzwNj6HbIakQw2Wxhu8IV6aLA7ukz9FCrKSeSTOsthPAaBhkGzmfvkOakX1++EO2S
         FZqwoCBJRdRvnCnSauiBo60R+fqxqg9CZOgio4AqGV6l3OHTGuTzQgdLCk6dxoxf3pPK
         20aV+AHlBnwiD+BsD0MIf1HZvx6tJ7TfDcuDMf9jt/+gnlCwUW4mDbeMRatk6udTsUh4
         8Jsn0+2CO0yxG5m097SD1byrnldcjArBLlKoMn641OPzbibkdC+3yq71LcXyA7GkrW9p
         nk4kfu/QcQNVq3I3Q/PXJvFPHhaaGy0tJ714SdKZ+cGmqek+E0oTSSaeU0dWBXJ32qpD
         lobg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260253; x=1773865053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV5czEXSj6GTlGyrBR9CLBL/OkAb3+kqVVdUiTYnGjA=;
        b=j/ZMVaxaxW3tPBdyW1Wjp67yR634kREc2M6SHF9HdYQab+jo0psCMfj1uyZhWJjcrj
         bP5EaYFOIOXvUItL7AJSXd0KKeXBEefg1ApK7vaUsdlm51HfLfd/2c3CX67DW6ruBq2D
         c+g8pithkbnuMXN1w3gSYxiP+97eSByY7NerYLmIX7xtaBfgfaYC9pgO+7n+EBNPkVNY
         hnifsb4PG4W+sRzL6TrYDLvIsFLvz9NKUDTzWawQ15VQqnPAGSxXCZjbXTgKtJp4fxBo
         Y+c4e0lb2MWxquqQZ3eQDiu4dV1OLhyR9JJhrSIKeDHriETrqqt/rCYHIkmWWZmZkupZ
         e1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260253; x=1773865053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lV5czEXSj6GTlGyrBR9CLBL/OkAb3+kqVVdUiTYnGjA=;
        b=UQ42ayV1EOMDldoNTTo9FtGVUbqCio8b5EO1kRQzYcAC+C5tEZ+BwzdRkDPwSsRJTJ
         iClbzGq2THG6SS/ZY+pzti3iytuiyFVHGVNul0by1JI2zp92GhKNLQT69k3pARNtRFSf
         1ycR6U+VJSSg79av5zUoEHwZdcQoF4OhhNJcmtvjcnAy3gBrx0VxajiDOnTlLh+q8Z5m
         sXpZ3pNNHE7EFF0z8eeUCS3Yo+Sda8149q0Gzbm5nouZi7QZDSWzi7ZhzlWUR9Z76h98
         dVJnlD3gFknLZM0L1j1PS+QI1omFnIHGMoPDAR9/IxMLtYXLyI4E4Z7v1Ioht55bzKE4
         DQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUD60SZmrOQaQiv3Ot6Y2xGP9jFMETLQcmqzbGT8s92DhfXmHrKakXE1iBko3YPD25NPPBHZkHA4mW15A==@vger.kernel.org
X-Gm-Message-State: AOJu0YytPU9xk4XxE/dTvygwDZIg6uXk00+FNet0YaUSVLbM8MCLGoxT
	lCHXNy6Tlnh1LkZuVZqHaIRjmKNPDP0RvsFYeUvMSJsidpg9m+XEbHwbZJogLco56wGhDmmBhIa
	cB7gAsIMH6kymzp9w6ysXcmzs9EUOwWM=
X-Gm-Gg: ATEYQzzxZNhy2IHyiNlcyoZpmhJikaXeHs0pwVX+HHTJFp8T7tAcBkbXjGyzMx+5T2J
	+6xI6sY6pt53WTmH+qSXuLmNQSAzcS5Vr/4omEhNAYtr3vkQiy30Aj+ecluqmPzRoR3c/pj0KsV
	AybQWdptlvaBMnRZ1Xl1OoS/kyJhZ+SSUPsonArcScBdYjLeymtqeX17j4EqL0oRezDsmwmITV+
	tCtU75dlYmR9/LdY9JCYCiiH3R8IbOOejW86+9QWlK9qNao+RrXZP5lMctOyK6bJmll8spJlzRy
	OxVX5LBpdLcVsLbEiMdL+jUmV5E6MitCKMukMvQ=
X-Received: by 2002:a05:600c:3511:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-4854b0ae565mr72255395e9.7.1773260253382; Wed, 11 Mar 2026
 13:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com> <20260311195153.4013476-5-joshua.hahnjy@gmail.com>
In-Reply-To: <20260311195153.4013476-5-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 11 Mar 2026 13:17:22 -0700
X-Gm-Features: AaiRm53KOhSCrzsuPj5GmyiSCFvk8oRrWzuZDDh6-67NZPwbQagJ2OtgQg4Zyp4
Message-ID: <CAKEwX=Ns9zGhSSYOfVunb2dR-i-0krFP4SKQfro2FztLkbH6-g@mail.gmail.com>
Subject: Re: [PATCH 04/11] mm/zsmalloc: Introduce objcgs pointer in struct zspage
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <hoangnhat.pham@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:52=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> Introduce an array of struct obj_cgroup pointers to zspage to keep track
> of compressed objects' memcg ownership, if the zs_pool has been made to
> be memcg-aware at creation time.
>
> Move the error path for alloc_zspage to a jump label to simplify the
> growing error handling path for a failed zpdesc allocation.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  mm/zsmalloc.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 3f0f42b78314..dcf99516227c 100644
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
> @@ -273,6 +274,7 @@ struct zspage {
>         struct zpdesc *first_zpdesc;
>         struct list_head list; /* fullness list */
>         struct zs_pool *pool;
> +       struct obj_cgroup **objcgs;
>         struct zspage_lock zsl;
>  };
>
> @@ -825,6 +827,8 @@ static void __free_zspage(struct zs_pool *pool, struc=
t size_class *class,
>                 zpdesc =3D next;
>         } while (zpdesc !=3D NULL);
>
> +       if (pool->memcg_aware)
> +               kfree(zspage->objcgs);
>         cache_free_zspage(zspage);
>
>         class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
> @@ -946,6 +950,16 @@ static struct zspage *alloc_zspage(struct zs_pool *p=
ool,
>         if (!IS_ENABLED(CONFIG_COMPACTION))
>                 gfp &=3D ~__GFP_MOVABLE;
>
> +       if (pool->memcg_aware) {
> +               zspage->objcgs =3D kcalloc(class->objs_per_zspage,
> +                                        sizeof(struct obj_cgroup *),
> +                                        gfp & ~__GFP_HIGHMEM);

I remembered asking this, so my apologies if I missed/forgot your
response - but would vmalloc work here? i.e kvcalloc to fallback to
vmalloc etc.?

> +               if (!zspage->objcgs) {
> +                       cache_free_zspage(zspage);
> +                       return NULL;
> +               }
> +       }
> +
>         zspage->magic =3D ZSPAGE_MAGIC;
>         zspage->pool =3D pool;
>         zspage->class =3D class->index;
> @@ -955,14 +969,8 @@ static struct zspage *alloc_zspage(struct zs_pool *p=
ool,
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
> @@ -973,6 +981,16 @@ static struct zspage *alloc_zspage(struct zs_pool *p=
ool,
>         init_zspage(class, zspage);
>
>         return zspage;
> +
> +err:
> +       while (--i >=3D 0) {
> +               zpdesc_dec_zone_page_state(zpdescs[i]);
> +               free_zpdesc(zpdescs[i]);
> +       }
> +       if (pool->memcg_aware)
> +               kfree(zspage->objcgs);
> +       cache_free_zspage(zspage);
> +       return NULL;
>  }
>
>  static struct zspage *find_get_zspage(struct size_class *class)
> --
> 2.52.0
>
