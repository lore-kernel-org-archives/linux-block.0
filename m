Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E119F12A
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763180085; cv=none; b=NcB0UUtDQ/0tJ+axiMc9IJ2fSzyS/lI60+Z4pcnq8RgLPuoysxjvquP7ORXNaEjtg8zBpOn0L6oNGvAZDBhX53MG9Wqcaktw8ZsqjtxmIkVVsIqPW/RktoHo4T3XDssHoOOhPbTBcIjayXA7ThmOjpwx2iUuO/zCTXTtgPfJKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763180085; c=relaxed/simple;
	bh=R9YlM3Fc8ZoZioSThJHE8Noe5KQqzOxdajN2Vg8qV2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZ6zzonJpUbd4PXPWwa5LPp1yRREw/BnYpuSLg6jDP3rEgzDPBXrcBSvz8sxBG3LM3uYiRuleBZFsyqjvfDTjfJDkNWC9B2hHavzu23Xvqcw5xLQ/rWAks1jr0j4ZZUHG7B9RiYHalNoN6k+059YYF1DS0/lg3rQnOKYHtBkdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XyDhCbVp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XyDhCbVp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340ad724ea4so455905a91.0
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 20:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763180082; x=1763784882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVwmpEB8Bj8tH7qdGyQtHjvQ6YUfnbrSzY7l2lyfjlk=;
        b=XyDhCbVpaW3QTT1d/2KMk7wk+25UwMKrtC9fucMtG7KvgqN7TJJ15PAB4qAmu55j7t
         ZPPL3seNX++u1GzyVv7y7miTewBsXYwwhFwY7+phvncFU9qU8RRJ0mxAvEA2kOZHkS8g
         CFj+NfbCGu2DUcOWrnstuVtFi26r16XuIJ/kMixLNq0M3nPbBfsOHgDuivsfAScBk+UO
         8u1xH4rW8DRfeaeLRXMWx2/EFWr+9de0V+N2hbh3pmf3miZm1voM1W/nU/BjN6G7z3SH
         MEmmtLPu8VjLBl8dmzIwk7x66LiU8Jf4R7U+qVMyOp63dN/aqWck9yqqji9jNSK7OLe+
         D+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763180082; x=1763784882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVwmpEB8Bj8tH7qdGyQtHjvQ6YUfnbrSzY7l2lyfjlk=;
        b=YaAGyX3BIYGqP7SnTi49GhHkKZ0OnGwgFpx/YpHD5HgSXfWAOG8/uPJRX2q13YHqk/
         lkT7NbDS/GxhavxpbyButE36Rzl1uZQtPJLC7C1J35khxsY6AGry0AHn5lUYY+qeUjh+
         krmWkccD20l+0IN4GgE2rIqU8ud/aqJIalgHmgAjSvsW9XOcbg0LJ44NZxKjnjV2xfRq
         8hy386XD5tp/+Qw7vicOqkXi7/vGLgnGOiUOEwitYbVqovI88yjXP7FdG2EyE19A7MQ6
         KhO8tTbiQw04cYgBO8/bgWld8DdVhh/9tSsdODD+fCYzeVf/mIt3uG3d2S4T6glm0LHj
         wjzA==
X-Forwarded-Encrypted: i=1; AJvYcCVfBa02yVrOIgweaZpvpkxG8GVOC3A+uIqBj9vaweDRr1VX8cKMi0iNtUMlCx3RFyEfNKIuRgrKaraQdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJejTjX4SNly0KnMNFEqLBpr9DWBqqVUKUtfUgtatTTXV+ySnk
	yOlDsA5lOVu+gPkj/3Yu7I12g3EZS8c/H3nLQbwwHwZ1sC3EY/wwFmrXNF63uMoLAzPBZFA0+fs
	VMycK49p91QJq0eSU1vnif3HZHGyoX63qwt4DdDaBUg==
X-Gm-Gg: ASbGnctnEkn6YQSUEqTRTUhkPCdwSe1EGSqs9X/ihHZNzQtm3Hu3ijMFC4iUflixE6U
	ZUOVpUOV8ThIo0n5Fn837wYnehYfmTz5ISkXm7c2JEVYsN97H1ge7INM4eFc4UbV0zFgu7LOc2L
	XT2fT7Miq96nNt1mpIoeoqLeWgQB8DKs87muUHfwqeb4jg056HeyWNdpv1sZb6Ij7whRokLPYJo
	e3CRZ0cQF6dDveNE4McvlDSmKOKh+xoKhO0qoL7qLUGLpKC6LOIck/dagg9oQ==
X-Google-Smtp-Source: AGHT+IG06OKOPxs2KL9FiNMv5EavgqO6i+1LnipcMMzNGHdQkomLzw0Ac/ujZ5S0QV4oKIDZPIfDJsM3lSp4XoSli0A=
X-Received: by 2002:a05:7022:224:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-11b41405607mr1754260c88.4.1763180081853; Fri, 14 Nov 2025
 20:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-2-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 14 Nov 2025 20:14:29 -0800
X-Gm-Features: AWmQ_bmXMewXa3hzF3Hz6jOk14_epW6NwwIts6iR0ot-WLfTkPMnKaB28ZSufVg
Message-ID: <CADUfDZrSO5eAwzjzedMf1gHTUv3Bv7JPL-nspqQG4bQE+F=6XA@mail.gmail.com>
Subject: Re: [PATCH V3 01/27] kfifo: add kfifo_alloc_node() helper for NUMA awareness
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:38=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add __kfifo_alloc_node() by refactoring and reusing __kfifo_alloc(),
> and define kfifo_alloc_node() macro to support NUMA-aware memory
> allocation.
>
> The new __kfifo_alloc_node() function accepts a NUMA node parameter
> and uses kmalloc_array_node() instead of kmalloc_array() for
> node-specific allocation. The existing __kfifo_alloc() now calls
> __kfifo_alloc_node() with NUMA_NO_NODE to maintain backward
> compatibility.
>
> This enables users to allocate kfifo buffers on specific NUMA nodes,
> which is important for performance in NUMA systems where the kfifo
> will be primarily accessed by threads running on specific nodes.
>
> Cc: Stefani Seibold <stefani@seibold.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/kfifo.h | 27 +++++++++++++++++++++++++++
>  lib/kfifo.c           | 13 ++++++++++---
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> index fd743d4c4b4b..61d1fe014a6c 100644
> --- a/include/linux/kfifo.h
> +++ b/include/linux/kfifo.h
> @@ -369,6 +369,30 @@ __kfifo_int_must_check_helper( \
>  }) \
>  )
>
> +/**
> + * kfifo_alloc_node - dynamically allocates a new fifo buffer on a NUMA =
node
> + * @fifo: pointer to the fifo
> + * @size: the number of elements in the fifo, this must be a power of 2
> + * @gfp_mask: get_free_pages mask, passed to kmalloc()
> + * @node: NUMA node to allocate memory on
> + *
> + * This macro dynamically allocates a new fifo buffer with NUMA node awa=
reness.
> + *
> + * The number of elements will be rounded-up to a power of 2.
> + * The fifo will be release with kfifo_free().
> + * Return 0 if no error, otherwise an error code.
> + */
> +#define kfifo_alloc_node(fifo, size, gfp_mask, node) \
> +__kfifo_int_must_check_helper( \
> +({ \
> +       typeof((fifo) + 1) __tmp =3D (fifo); \
> +       struct __kfifo *__kfifo =3D &__tmp->kfifo; \
> +       __is_kfifo_ptr(__tmp) ? \
> +       __kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_mask,=
 node) : \
> +       -EINVAL; \
> +}) \
> +)
> +
>  /**
>   * kfifo_free - frees the fifo
>   * @fifo: the fifo to be freed
> @@ -902,6 +926,9 @@ __kfifo_uint_must_check_helper( \
>  extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
>         size_t esize, gfp_t gfp_mask);
>
> +extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> +       size_t esize, gfp_t gfp_mask, int node);
> +
>  extern void __kfifo_free(struct __kfifo *fifo);
>
>  extern int __kfifo_init(struct __kfifo *fifo, void *buffer,
> diff --git a/lib/kfifo.c b/lib/kfifo.c
> index a8b2eed90599..195cf0feecc2 100644
> --- a/lib/kfifo.c
> +++ b/lib/kfifo.c
> @@ -22,8 +22,8 @@ static inline unsigned int kfifo_unused(struct __kfifo =
*fifo)
>         return (fifo->mask + 1) - (fifo->in - fifo->out);
>  }
>
> -int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> -               size_t esize, gfp_t gfp_mask)
> +int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> +               size_t esize, gfp_t gfp_mask, int node)
>  {
>         /*
>          * round up to the next power of 2, since our 'let the indices
> @@ -41,7 +41,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int si=
ze,
>                 return -EINVAL;
>         }
>
> -       fifo->data =3D kmalloc_array(esize, size, gfp_mask);
> +       fifo->data =3D kmalloc_array_node(esize, size, gfp_mask, node);
>
>         if (!fifo->data) {
>                 fifo->mask =3D 0;
> @@ -51,6 +51,13 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int s=
ize,
>
>         return 0;
>  }
> +EXPORT_SYMBOL(__kfifo_alloc_node);
> +
> +int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> +               size_t esize, gfp_t gfp_mask)
> +{
> +       return __kfifo_alloc_node(fifo, size, esize, gfp_mask, NUMA_NO_NO=
DE);
> +}
>  EXPORT_SYMBOL(__kfifo_alloc);

Is it worth keeping __kfifo_alloc() as an extern function? Seems like
it would make the executable smaller to turn __kfifo_alloc() into a
static inline function that just defers to __kfifo_alloc_node().

Best,
Caleb

>
>  void __kfifo_free(struct __kfifo *fifo)
> --
> 2.47.0
>
