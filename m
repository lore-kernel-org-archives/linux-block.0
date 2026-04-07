Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF003793BA
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591265; cv=pass; b=h6ZgLv9dLcP10z4GzcIydsm3RczoCoE0B9ResanIRkbBOn80FqpnrZ58svOj8ZWkPSAp374zh0ze/7BecGKkiwMZNUdUzOdC/J9gLwcAS4QrqwoHvXropkxHJs20CnEYKj6bim0Tm/IoNNQFSnRCYGTbASV5eCamRWM0C1BNW48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591265; c=relaxed/simple;
	bh=9QBwCXjAGpfO1gckbw2qkxZulQZll1c8VNbgKvgSTiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOcPRfb6vcORFHfCA1EM9nl8+LH2mu4cxpjY1Kaz1meVDl+s7NUnVgWt9QhYwjWkF3SNw6Jh6Uz/t0djLHv1D5ryLjtE+AHP6rb76+jONGjbEBLmh5Jskp/ny3Bgqy2yp13wibHXOrslx4kyoR4T6TBP0cK2XjQfO8Qz8OMhKzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FHLoKM7Y; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FHLoKM7Y"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbd7a1e989so446655a34.1
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 12:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775591262; cv=none;
        d=google.com; s=arc-20240605;
        b=V4RkXD1bNrMbtos8LuJvNh/+Qb59/7FV1/oHZnCnhKBu8wE94yG8m0/c6jbhkctr3Z
         ukb7abM2I1iufQeo30L6g+xIC1VSGHAgK9Eil9EXpzkcsYkYdReHjUP0LmsGQkGpeX7b
         YhPcua5KHRAK48w02CgeiUlhr569B39EX9JloUXS75W912kU5bwXK5BY6q12Z6whu5lj
         fkE7ldX5F43p1lQh8SmDl9x6y4l1UM4NKzXy1w6oSUOKrsNkBE8ABtR4uAdgqA2Asxg4
         WIfsMPyzBM9YMD5q8MWcFznJJdkXyWMW11gb1ON2S+LG5Wo/ucB9mT0ZcyX391/9CMIm
         9Uog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VtPKgUOpKUvlzrxF2ZmOGOGDSuuHnyaX6XNF4YaN8mE=;
        fh=EcIi4Wr0gtIljg5p6qjNWy0wk8Vk4YivbG9pg25TrC0=;
        b=QWC99lt8kWJsHJk7LHxRfyEAHmgBjNzjuLpEd9aLlSExcARC94uZexZhsD6/VEf+73
         PoA+PnDc8r0MZprTvRavW79MaaFQeppy/DihWMw49/GLSkOBY6a7itxihL6/m52rERFD
         k/gU7fzLO73P9bR8wZDqWOhXQ9wTFFT7eBWaGgIcnO2EQ3XcCWdBknihpgdbmAS8FTcm
         FbbBD2b8axJhbBgpzAoB4lTqlPGAx7Fi0Wor6ajGqphCnsaYxTQA+/NSEUIQ9cxLi+6V
         vfiPykPWu9sKNnf/SKGemVsPW6P4/tHHpJBtfQJCrS9dXeWElGNAIuHaTQBwhTJd38AG
         GRcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775591262; x=1776196062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtPKgUOpKUvlzrxF2ZmOGOGDSuuHnyaX6XNF4YaN8mE=;
        b=FHLoKM7YPepQK1UlqLtITATOW7Anh8jY+xOfGP3Oa2J3pYMgqYGxEtXBjGrowwYEPv
         UaSGYrKFleTocaD4b3AAomHtQ0e73elePX8D8edcZgHYdxC0hCL7GaU4AIrkMW8GkE5x
         wkR7geB9/M/xCISL5TXOtk5m0NnYJrZ9iWNGpoPwvWf8SM0rZPuMRQViQQO16C6qhpRx
         MNdWYi32iwgutaji9B2IOo7BCrvNn55FdCRe+9eT7+a7U4o3yQ26oaCwZLQZmC1YGdq7
         rgI7pyyVjTtrIVUbRUOmg//AjBM0BSQFD6Sltsw6wh4NK01Shh0xpzVVuA16hxyK3yCS
         Vi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775591262; x=1776196062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtPKgUOpKUvlzrxF2ZmOGOGDSuuHnyaX6XNF4YaN8mE=;
        b=dzlc6H2wMgqosWAUwSdTWN6gGlp/nB/m05H3tp77DmDhKaB1DXnk7chTB+jHvkZPNZ
         9t+zbIyYzQhqwqDEDKr0D0NoIYb9x6HRF2yg4w/o7kU7oe+D9k8JURoFYAqstfQ9auzv
         trK3IHSCsMsJsx02CAVB9U7JgAMCJa78G45XrBB6hl1MygjzCBeW6ZLOQS9AKl4NRQr+
         lki2A9BqiJJHVl1uSGqfr/ai3qaY4xJulonBx79slKFanqe7fkjcIxLvZSztRlJBvRfN
         UMegwPJwaX2eDJmm8gWPDalHYWrm8GwHt15nSzUK3716jclj7NfwAlo7g2WT1vQUn1Cm
         jsog==
X-Forwarded-Encrypted: i=1; AJvYcCUgO/xnfSgf3mOdl0RXZXtzqP9sQ6J1JeQO0zMlqYbVbtbsewJMLsMmipDNU21AgSCyl5Y6PiXe8YHbAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHqvhyI1Iv8G6lhIZ4rc8i7je6go+hitzUG3l78+HXpK+Rnem
	smubjR069aoetJ4sMsBZyrdgxwWB2cNS+oYpbDhaxpkDbwHWlr4hAAImLdJeIclIKVhQKJWryIH
	GTcbrrfdoJZoSEoyWtyulkZ3b26FcrCEkD679nG/y9oYG287Idz1tmB0=
X-Gm-Gg: AeBDieuBNaajwIhDDVA64twtVBGeXAy4niqf0oNUg8cwvCl9ASlR8jKUJ/9iCmUUQ7x
	vTMh7zSwkEfko539+WMbeXCncLylNq3BWxmL5mg6gIJPMt1dBPU//00rMppihPkOCYfa7XgHlbQ
	vR3ZyNd7Tzk2Cb34eDiUMJdv5sL+tvQ/fbiO0Cm4GeTxKOyr3Ij7WD+fTp5FsfwOFVAQzVKAwiI
	CLySLRarbzXVETlq4zJ6T1IgVFCNwkMPdD/ZNt8bbj/ylXcO9iyAa3D4t6VhIDX8VoeuEFOQEwW
	bNWI3AfN
X-Received: by 2002:a05:6830:25d6:b0:7db:e661:bb52 with SMTP id
 46e09a7af769-7dc0479480fmr438392a34.4.1775591261931; Tue, 07 Apr 2026
 12:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153207.3635125-1-ming.lei@redhat.com> <20260331153207.3635125-3-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Apr 2026 12:47:29 -0700
X-Gm-Features: AQROBzBJaIy2Eyt9Bl5kEzfG0qfV6ggOWdfb41lEpsb6Hmjkml0jLUT9U0oQV-w
Message-ID: <CADUfDZq3rTwcnxAekdan3-fi3qdLwFp-T5LsJJ1viqoUv8RqOw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] ublk: add PFN-based buffer matching in I/O path
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:32=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add ublk_try_buf_match() which walks a request's bio_vecs, looks up
> each page's PFN in the per-device maple tree, and verifies all pages
> belong to the same registered buffer at contiguous offsets.
>
> Add ublk_iod_is_shmem_zc() inline helper for checking whether a
> request uses the shmem zero-copy path.
>
> Integrate into the I/O path:
> - ublk_setup_iod(): if pages match a registered buffer, set
>   UBLK_IO_F_SHMEM_ZC and encode buffer index + offset in addr
> - ublk_start_io(): skip ublk_map_io() for zero-copy requests
> - __ublk_complete_rq(): skip ublk_unmap_io() for zero-copy requests
>
> The feature remains disabled (ublk_support_shmem_zc() returns false)
> until the UBLK_F_SHMEM_ZC flag is enabled in the next patch.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 77 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ac6ccc174d44..d53865437600 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -356,6 +356,8 @@ struct ublk_params_header {
>
>  static void ublk_io_release(void *priv);
>  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> +static bool ublk_try_buf_match(struct ublk_device *ub, struct request *r=
q,
> +                                 u32 *buf_idx, u32 *buf_off);

buf_idx could be a u16 * for consistency?

>  static void ublk_buf_cleanup(struct ublk_device *ub);
>  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *=
ubq);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
> @@ -426,6 +428,12 @@ static inline bool ublk_support_shmem_zc(const struc=
t ublk_queue *ubq)
>         return false;
>  }
>
> +static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq,
> +                                       unsigned int tag)
> +{
> +       return ublk_get_iod(ubq, tag)->op_flags & UBLK_IO_F_SHMEM_ZC;
> +}
> +
>  static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *u=
b)
>  {
>         return false;
> @@ -1494,6 +1502,18 @@ static blk_status_t ublk_setup_iod(struct ublk_que=
ue *ubq, struct request *req)
>         iod->nr_sectors =3D blk_rq_sectors(req);
>         iod->start_sector =3D blk_rq_pos(req);
>
> +       /* Try shmem zero-copy match before setting addr */
> +       if (ublk_support_shmem_zc(ubq) && ublk_rq_has_data(req)) {
> +               u32 buf_idx, buf_off;
> +
> +               if (ublk_try_buf_match(ubq->dev, req,
> +                                         &buf_idx, &buf_off)) {
> +                       iod->op_flags |=3D UBLK_IO_F_SHMEM_ZC;
> +                       iod->addr =3D ublk_shmem_zc_addr(buf_idx, buf_off=
);
> +                       return BLK_STS_OK;
> +               }
> +       }
> +
>         iod->addr =3D io->buf.addr;
>
>         return BLK_STS_OK;
> @@ -1539,6 +1559,10 @@ static inline void __ublk_complete_rq(struct reque=
st *req, struct ublk_io *io,
>             req_op(req) !=3D REQ_OP_DRV_IN)
>                 goto exit;
>
> +       /* shmem zero copy: no data to unmap, pages already shared */
> +       if (ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))

This is a lot of pointer chasing. Could we track this with a flag on
struct ublk_io instead?

> +               goto exit;
> +
>         /* for READ request, writing data in iod->addr to rq buffers */
>         unmapped_bytes =3D ublk_unmap_io(need_map, req, io);
>
> @@ -1697,8 +1721,13 @@ static void ublk_auto_buf_dispatch(const struct ub=
lk_queue *ubq,
>  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *=
req,
>                           struct ublk_io *io)
>  {
> -       unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
> +       unsigned mapped_bytes;
>
> +       /* shmem zero copy: skip data copy, pages already shared */
> +       if (ublk_iod_is_shmem_zc(ubq, req->tag))
> +               return true;
> +
> +       mapped_bytes =3D ublk_map_io(ubq, req, io);
>
>         /* partially mapped, update io descriptor */
>         if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> @@ -5458,7 +5487,53 @@ static void ublk_buf_cleanup(struct ublk_device *u=
b)
>         mtree_destroy(&ub->buf_tree);
>  }
>
> +/* Check if request pages match a registered shared memory buffer */
> +static bool ublk_try_buf_match(struct ublk_device *ub,
> +                                  struct request *rq,
> +                                  u32 *buf_idx, u32 *buf_off)
> +{
> +       struct req_iterator iter;
> +       struct bio_vec bv;
> +       int index =3D -1;
> +       unsigned long expected_offset =3D 0;
> +       bool first =3D true;

Could check index < 0 in place of first?

> +
> +       rq_for_each_bvec(bv, rq, iter) {
> +               unsigned long pfn =3D page_to_pfn(bv.bv_page);
> +               struct ublk_buf_range *range;
> +               unsigned long off;
>
> +               range =3D mtree_load(&ub->buf_tree, pfn);
> +               if (!range)
> +                       return false;
> +
> +               off =3D range->base_offset +
> +                       (pfn - range->base_pfn) * PAGE_SIZE + bv.bv_offse=
t;

Doesn't this need to check that the end of the bvec is less than the
end of the range? Otherwise, the bvec could extend into physically
contiguous pages that aren't part of the registered range.

Also, the range could precompute base_pfn - base_offset / PAGE_SIZE
instead of base_offset to make this a bit cheaper.

> +
> +               if (first) {
> +                       /* Read-only buffer can't serve READ (kernel writ=
es) */
> +                       if ((range->flags & UBLK_SHMEM_BUF_READ_ONLY) &&
> +                           req_op(rq) !=3D REQ_OP_WRITE)
> +                               return false;
> +                       index =3D range->buf_index;
> +                       expected_offset =3D off;
> +                       *buf_off =3D off;
> +                       first =3D false;
> +               } else {
> +                       if (range->buf_index !=3D index)
> +                               return false;
> +                       if (off !=3D expected_offset)
> +                               return false;
> +               }
> +               expected_offset +=3D bv.bv_len;
> +       }
> +
> +       if (first)
> +               return false;

How is this case possible? That would mean the request has no bvecs,
but ublk_try_buf_match() is only called for requests with data, right?

Best,
Caleb

> +
> +       *buf_idx =3D index;
> +       return true;
> +}
>
>  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>                 u32 cmd_op, struct ublksrv_ctrl_cmd *header)
> --
> 2.53.0
>
