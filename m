Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888E1C84B2
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565550; cv=none; b=WBG6kdnccEAlIZaglXsdhRNU1t7LN5q331eLM2yVpAdQv4JjsqzXspXZWVDWN5YggoD1T9/CF4G3BPmMvqVDGdP07rUmecx019Rbk8elekVSuctZJKYP//UxOcyarYlynieVR/wwRLjh0oUVVEy8LQzNTfaFzIi2ldi026abcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565550; c=relaxed/simple;
	bh=G+bWJYbt0pb7tC4kxurRjUEdzCx0gmQZh7IgvOT2HtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjlyWYcX+w6gzKIpfsKIbUgksgOe+TsWLsck7imS6euhgSR7vRPCYJ8lgXzwBpJg/LmoVmW54IdpFo8O2ekof6spB61kz3jZA3rXSYRoA5SWZ/NjLBVAIOXTukXwxgdJnTmm4nTmAdQmUgDEk4+b13jYnevm+LKb1vahvKnHMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bRY6NFtW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bRY6NFtW"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa8c788c74so522544a91.2
        for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739565547; x=1740170347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9/7q4G+KdM1Gmk0UhA19a/0bUrMlkvE++gkxXDOozc=;
        b=bRY6NFtW65deRVoPmdFYQpl1ZseIAycWisMYXz9vd80jmPGTfg8Ciidw4RSfGfsPck
         mK1/LQlYj3iQnokIzD7TthLcgglZyTmsU2S9lzJpKJ+4UwSsSL6s+bHQd5jG1ItWKJsf
         KaMMseSG9KlN9Afv+sc54VglCZYzOqzhHq0pHL7WszTAW2DjmF6eQirFCobMVhQ0rHAY
         ARsPHbqrJ7ojUP2zesvP0IdbDZkLIx/XB92cF/MmRr2Hiq0sZb+W3L+tZZ+4u2YhDjRW
         /HIdANE/fZGRw6nikAcz2SZxRIouYrOXejxzxsXF44ct4/nxm2RXMMkK6+ZGsNak5t6E
         9W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739565547; x=1740170347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9/7q4G+KdM1Gmk0UhA19a/0bUrMlkvE++gkxXDOozc=;
        b=btPHtQHz5WcFVl6IJ/QmrxK/fQwl7bORf22K3biRLW/rtU5zqM3zhbGSrV9+VK1dUQ
         7HGQh3iGsOv7y4zIx3n8plMWrzLjMf4/H3Gd8xqYonaYO6n/XuLUI+TU4kQfjvAUyEeF
         KLhC6qIuKFKPmuB6Gb411gecuodWlQlI/hDF8jNCQXUbMStaQ50zbMl4MZ/qt29REtx5
         4eH9QSLsgnYJsudXak0+IH5w/aY4Et78QS2amvLDqypLrqrSBmYFqxdtkag92D0eO66h
         rtu4Lc4yeeltOUhsK1HPY3ka/7STRawbj+Dx8uOH/p0vpCGWF7cCZoZTSVq1DbgcIj1p
         WN2w==
X-Forwarded-Encrypted: i=1; AJvYcCXFMN3HhBKBJHaE4FRQneTaJHUMlPDUboVQeN4YKMPKG3leY7xuuRNzxLrK+qlwSX7LLPBjuqGp4maPjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Mnr6J8QJbSyZHTUcdHTGc52rFhVXbA3bkS0dN2bcD36hxbms
	GEASPPjatBBiLKAH+puA6RFejRgVz1lYM4MnikvI9BtUd58JuJNl06/M8qgUdjWXle3HyFOHgNN
	XdWQkabLiKwxkilwH3UGOub+9/p4ymCTeddcUtg==
X-Gm-Gg: ASbGncsHGZroBRtVgTsGtLfaI3hjPLV+60J8XMHhPYI7qIUP5WmRM1ZyxuBj84iHm0k
	LPWsP/hgzD/RuemxzOlEW9/0w9YjrZzJhPt4P53LbszGLER/mSbgUYeTXksEnSgq8+CGvH+M=
X-Google-Smtp-Source: AGHT+IGrM5Z4GZv1SgF+HR9NBnP0H6lvRv/aEjtZZUYmWM1/uTPBt6ObsA6STXOejZxNlbfU0KEGx3Hk5xjXTkYk3hU=
X-Received: by 2002:a17:90b:4b84:b0:2ea:853a:99e0 with SMTP id
 98e67ed59e1d1-2fc4114ba7fmr298495a91.5.1739565547211; Fri, 14 Feb 2025
 12:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214154348.2952692-1-kbusch@meta.com> <20250214154348.2952692-3-kbusch@meta.com>
In-Reply-To: <20250214154348.2952692-3-kbusch@meta.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 14 Feb 2025 12:38:54 -0800
X-Gm-Features: AWEUYZkIBN4Pb3oQLMNAeSThyVeSDLd5w9jEGsBuO1XBtR4fgH0QwdGn1f2Kw4I
Message-ID: <CADUfDZpbb0mtGSRSqcepXnM9sijP6-3WAZnzUJrDGbC0AuXTrg@mail.gmail.com>
Subject: Re: [PATCHv3 2/5] io_uring: add support for kernel registered bvecs
To: Keith Busch <kbusch@meta.com>
Cc: ming.lei@redhat.com, asml.silence@gmail.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, io-uring@vger.kernel.org, bernd@bsbernd.com, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 7:45=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Provide an interface for the kernel to leverage the existing
> pre-registered buffers that io_uring provides. User space can reference
> these later to achieve zero-copy IO.
>
> User space must register a sparse fixed buffer table with io_uring in
> order for the kernel to make use of it. Kernel users of this interface
> need to register a callback to know when the last reference is released.
> io_uring uses the existence of this callback to differentiate user vs
> kernel register buffers.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/linux/io_uring.h       |   1 +
>  include/linux/io_uring_types.h |   6 ++
>  io_uring/rsrc.c                | 112 ++++++++++++++++++++++++++++++---
>  io_uring/rsrc.h                |   2 +
>  4 files changed, 113 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> index 85fe4e6b275c7..b5637a2aae340 100644
> --- a/include/linux/io_uring.h
> +++ b/include/linux/io_uring.h
> @@ -5,6 +5,7 @@
>  #include <linux/sched.h>
>  #include <linux/xarray.h>
>  #include <uapi/linux/io_uring.h>
> +#include <linux/blk-mq.h>
>
>  #if defined(CONFIG_IO_URING)
>  void __io_uring_cancel(bool cancel_all);
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_type=
s.h
> index d5bf336882aa8..b9feba4df60c9 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -696,4 +696,10 @@ static inline bool io_ctx_cqe32(struct io_ring_ctx *=
ctx)
>         return ctx->flags & IORING_SETUP_CQE32;
>  }
>
> +int io_buffer_register_bvec(struct io_ring_ctx *ctx, struct request *rq,
> +                           void (*release)(void *), unsigned int index,
> +                           unsigned int issue_flags);
> +void io_buffer_unregister_bvec(struct io_ring_ctx *ctx, unsigned int tag=
,
> +                              unsigned int issue_flags);

Change "tag" to "index" to match the definition?

> +
>  #endif
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index af39b69eb4fde..0e323ca1e8e5c 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -103,19 +103,23 @@ static int io_buffer_validate(struct iovec *iov)
>
>  static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_rsrc_node=
 *node)
>  {
> -       unsigned int i;
> +       struct io_mapped_ubuf *imu =3D node->buf;
>
> -       if (node->buf) {
> -               struct io_mapped_ubuf *imu =3D node->buf;
> +       if (!refcount_dec_and_test(&imu->refs))
> +               return;
> +
> +       if (imu->release) {
> +               imu->release(imu->priv);
> +       } else {
> +               unsigned int i;
>
> -               if (!refcount_dec_and_test(&imu->refs))
> -                       return;
>                 for (i =3D 0; i < imu->nr_bvecs; i++)
>                         unpin_user_page(imu->bvec[i].bv_page);
>                 if (imu->acct_pages)
>                         io_unaccount_mem(ctx, imu->acct_pages);
> -               kvfree(imu);
>         }
> +
> +       kvfree(imu);
>  }
>
>  struct io_rsrc_node *io_rsrc_node_alloc(int type)
> @@ -764,6 +768,8 @@ static struct io_rsrc_node *io_sqe_buffer_register(st=
ruct io_ring_ctx *ctx,
>         imu->len =3D iov->iov_len;
>         imu->nr_bvecs =3D nr_pages;
>         imu->folio_shift =3D PAGE_SHIFT;
> +       imu->release =3D NULL;
> +       imu->priv =3D NULL;
>         if (coalesced)
>                 imu->folio_shift =3D data.folio_shift;
>         refcount_set(&imu->refs, 1);
> @@ -860,6 +866,89 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx,=
 void __user *arg,
>         return ret;
>  }
>
> +int io_buffer_register_bvec(struct io_ring_ctx *ctx, struct request *rq,
> +                           void (*release)(void *), unsigned int index,
> +                           unsigned int issue_flags)
> +{
> +       struct io_rsrc_data *data =3D &ctx->buf_table;
> +       struct req_iterator rq_iter;
> +       struct io_mapped_ubuf *imu;
> +       struct io_rsrc_node *node;
> +       int ret =3D 0, i =3D 0;

Use an unsigned type for i so it doesn't need to be sign-extended when
used as an array index?

> +       struct bio_vec bv;
> +       u16 nr_bvecs;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       if (index >=3D data->nr) {
> +               ret =3D -EINVAL;
> +               goto unlock;
> +       }
> +
> +       node =3D data->nodes[index];
> +       if (node) {

I think Pavel already suggested using array_index_nospec() since this
index is under userspace control.
Also nit, but don't see the need to store data->nodes[index] in an
intermediate variable.

> +               ret =3D -EBUSY;
> +               goto unlock;
> +       }
> +
> +       node =3D io_rsrc_node_alloc(IORING_RSRC_BUFFER);
> +       if (!node) {
> +               ret =3D -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       nr_bvecs =3D blk_rq_nr_phys_segments(rq);

Is this guaranteed to match the number of bvecs in the request?
Wouldn't the number of physical segments depend on how the block
device splits the bvecs? lo_rw_aio() uses rq_for_each_bvec() to count
the number of bvecs, for example.

> +       imu =3D kvmalloc(struct_size(imu, bvec, nr_bvecs), GFP_KERNEL);
> +       if (!imu) {
> +               kfree(node);
> +               ret =3D -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       imu->ubuf =3D 0;
> +       imu->len =3D blk_rq_bytes(rq);
> +       imu->acct_pages =3D 0;
> +       imu->nr_bvecs =3D nr_bvecs;
> +       refcount_set(&imu->refs, 1);
> +       imu->release =3D release;
> +       imu->priv =3D rq;

Consider initializing imu->folio_shift? I don't think it's used for
kbufs, but neither is acct_pages. One more store to the same cache
line shouldn't be expensive.

> +
> +       rq_for_each_bvec(bv, rq, rq_iter)
> +               bvec_set_page(&imu->bvec[i++], bv.bv_page, bv.bv_len,
> +                             bv.bv_offset);

Just imu->bvec[i++] =3D bv; ?

> +
> +       node->buf =3D imu;
> +       data->nodes[index] =3D node;
> +unlock:
> +       io_ring_submit_unlock(ctx, issue_flags);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
> +
> +void io_buffer_unregister_bvec(struct io_ring_ctx *ctx, unsigned int ind=
ex,
> +                              unsigned int issue_flags)
> +{
> +       struct io_rsrc_data *data =3D &ctx->buf_table;
> +       struct io_rsrc_node *node;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       if (!data->nr)
> +               goto unlock;
> +       if (index >=3D data->nr)
> +               goto unlock;

If data->nr is 0, index >=3D data->nr will always be true. So I think
you can get rid of the first if statement.

> +
> +       node =3D data->nodes[index];

I think Pavel suggested using array_index_nospec() here too.

> +       if (!node || !node->buf)
> +               goto unlock;

Pavel asked how node can node->buf could be NULL if node is not. I
agree it doesn't seem possible based on how how
io_buffer_register_bvec() initializes the nodes.

> +       if (!node->buf->release)
> +               goto unlock;

Probably could combine this with the if (!node || !node->buf) above.

> +       io_reset_rsrc_node(ctx, data, index);

io_reset_rsrc_node() reads data->nodes[index] again. How about just
open-coding the call to io_put_rsrc_node(ctx, node); and setting
data->nodes[index] =3D NULL; here?

Best,
Caleb

> +unlock:
> +       io_ring_submit_unlock(ctx, issue_flags);
> +}
> +EXPORT_SYMBOL_GPL(io_buffer_unregister_bvec);
> +
>  int io_import_fixed(int ddir, struct iov_iter *iter,
>                            struct io_mapped_ubuf *imu,
>                            u64 buf_addr, size_t len)
> @@ -886,8 +975,8 @@ int io_import_fixed(int ddir, struct iov_iter *iter,
>                 /*
>                  * Don't use iov_iter_advance() here, as it's really slow=
 for
>                  * using the latter parts of a big fixed buffer - it iter=
ates
> -                * over each segment manually. We can cheat a bit here, b=
ecause
> -                * we know that:
> +                * over each segment manually. We can cheat a bit here fo=
r user
> +                * registered nodes, because we know that:
>                  *
>                  * 1) it's a BVEC iter, we set it up
>                  * 2) all bvecs are the same in size, except potentially =
the
> @@ -901,8 +990,15 @@ int io_import_fixed(int ddir, struct iov_iter *iter,
>                  */
>                 const struct bio_vec *bvec =3D imu->bvec;
>
> +               /*
> +                * Kernel buffer bvecs, on the other hand, don't necessar=
ily
> +                * have the size property of user registered ones, so we =
have
> +                * to use the slow iter advance.
> +                */
>                 if (offset < bvec->bv_len) {
>                         iter->iov_offset =3D offset;
> +               } else if (imu->release) {
> +                       iov_iter_advance(iter, offset);
>                 } else {
>                         unsigned long seg_skip;
>
> diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
> index 190f7ee45de93..2e8d1862caefc 100644
> --- a/io_uring/rsrc.h
> +++ b/io_uring/rsrc.h
> @@ -33,6 +33,8 @@ struct io_mapped_ubuf {
>         unsigned int    folio_shift;
>         refcount_t      refs;
>         unsigned long   acct_pages;
> +       void            (*release)(void *);
> +       void            *priv;
>         struct bio_vec  bvec[] __counted_by(nr_bvecs);
>  };
>
> --
> 2.43.5
>
>
