Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF521C16E
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425956; cv=none; b=mxP9BEF04Pw2cwRBM4SY44E4CFDe1rdguIEY/Q459fB5KgmKmFH3Xr3NXZO1PeOR5BGti4BK6+zspUc5I/VkW5fAvWpvNeSRsENYWlQgblvKud2TQjwxDyQQBK9t9TmwJP23sDtANcTG0+3Y0vqUMNy+iQY1Xf3bdVxBLF/2au0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425956; c=relaxed/simple;
	bh=iEHaxMKhtrNy9fJssLoEdJPDBLXgYPF3H2YCl3VMhUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw2j8NH1qFNLTDrtPmj24QUHJhJkvtWYtqwZVTUE+CYL7XXgqs0cquYIe1CSEndISiN2h4DsoUPYCml+hLcuuYgSf3njL9/YjfsTyKDGCWyrK9YkK8gJpkArLCxgOKYyyewHbau3NXn/gx/4/kA+wUsrudcBol8E1D3RYNKhdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Dvku1hGw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Dvku1hGw"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313862d48e7so813451a91.1
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754425953; x=1755030753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VffBx2GKF1SngED9z68FIrIwHnf4shifVt8eibmdWU=;
        b=Dvku1hGwesBGG3U0Q9oaaD94BVXdF6bqZEt/ICTg1t0GBmq+9NZ25o6oN77RkkicR4
         MPQ4fEOjFJXkRihzSLHsBY7PbchJozJk+zvqL6Fueg/boU1n0/LkH5RNf+lXqLRGTE+T
         i85Ju3Mua9jTgAQk22IkFvf45IUfCyBbWf4+4lHi6glXMqvpFqa3I0SbvUfT6aVgxVWG
         J+j+zXfPuVQs4K9ZSX1EqCt15sr9R+IRauKxkWVINLE/NQgBaxBxJhTYQ5zC54JlTPXa
         gI8DpOD/mgJDdb6XZSqZaMDHLA4hoXtBRetzqoeHbguUhxoAaAlS/O/SeyNtjyymn2QK
         BskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754425953; x=1755030753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VffBx2GKF1SngED9z68FIrIwHnf4shifVt8eibmdWU=;
        b=I8SnV43KxcQx4pd1rlUnpLWTb51QR/mVsOxncQUnKTSzfRZ1GVNoGt2EJ25IepuAG3
         zxt6726+vz/yaeB4JgNDV3pwOH2WVO4V3vsqU2Fe8FbXKmkTrVmT7BRloAFAvqcjWO64
         sD8RSirU18J4+AVJcMpJu0wXtEVGUb7pfbR93hby8+sf/8CDN2DVs9ppGO62k2qnQs5p
         h4kJ3aKmVVNUcyRIGsyQHaudV4Ib2lj/D859QBP+QkRkCeOsbutG7pa1Fzabk/pwh4LA
         y3kZJtLwDXOyVrr+fBX0WmlzdpKTRa7fUX1LAVAfkOGdRNnaQ89pC3A6Ehd03fQ9aeTp
         jY6g==
X-Gm-Message-State: AOJu0YyXRFzTsvn1NeVU9pEUX7Y6slX1wqD4TY3HRLuM3LscmjnGqiV5
	Am0hwyclR0z+85zx7WLXam3l8itfftmC3mkEDPyAK225kF7zB7EhnW6EuWhoEIl3P739Up1y9Zx
	+PC14jI/fb7KzuvOnrEG0d5rwp89aGJ1v47F+MJuw5A==
X-Gm-Gg: ASbGncuj+gp64R1NnNuUjVLYepRPg5F+Pjd9usJdoBwDM4KrTl7a2kqAoiGndgEodlt
	ryEYrRWzMyYWMoT4+9muJeido+SWGgsa/bzthuol0eIO2RibbUKMogyynNemwKxYoeJzayTcsEL
	S/D/rbbKnmZ1KJFv678UGjvcpqcFoeHuP+hKsMwWGSTOVSUBae0t8NAtdtlIf2Bzi4ICqmg1PR4
	K1FKQ==
X-Google-Smtp-Source: AGHT+IFUfjBX/T8Dqt9RUujabjwW1mlrLBmSZSU4sBXG0iHdFpFow6iDK5JSJDJJIIp3xN4FVALBNFoalYK0jX7+atM=
X-Received: by 2002:a17:90b:4d90:b0:31f:28ae:870f with SMTP id
 98e67ed59e1d1-32166cfe636mr97398a91.8.1754425953238; Tue, 05 Aug 2025
 13:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805195608.2379107-1-kbusch@meta.com>
In-Reply-To: <20250805195608.2379107-1-kbusch@meta.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 5 Aug 2025 16:32:22 -0400
X-Gm-Features: Ac12FXzf1DQwoYB9Chi96b11LPtXmteJ5ibOfrKYknn_V8wfzwJuVsZTXpnuFsM
Message-ID: <CADUfDZpv0e_wZ-RPn56rqm6Tz7YvZrwiKK+F8iW8jXYO4puMZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, 
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 3:59=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> The blk-mq dma iteration has an optimization for requests that align to
> the device's iommu merge boundary. This boundary may be larger than the
> device's virtual boundary, but the code had been depending on that queue
> limit to know ahead of time if the request aligns to the optimization.
>
> Rather than rely on that queue limit, which many devices may not even
> have, store the virtual boundary gaps of each segment into the bio as a
> mask while checking the segments and merging. We can then quickly check
> per io if the request can use the optimization or not.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-merge.c         | 30 +++++++++++++++++++++++++++---
>  block/blk-mq-dma.c        |  3 +--
>  block/blk-mq.c            |  5 +++++
>  include/linux/blk-mq.h    |  6 ++++++
>  include/linux/blk_types.h |  2 ++
>  5 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 81bdad915699a..d63389c063006 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -278,6 +278,9 @@ static unsigned int bio_split_alignment(struct bio *b=
io,
>         return lim->logical_block_size;
>  }
>
> +#define bv_seg_gap(bv, bvprv) \
> +       bv.bv_offset | ((bvprv.bv_offset + bvprv.bv_len) & (PAGE_SIZE - 1=
));

Extra semicolon and missing parentheses around inputs and output. Is
there a reason not to make this a static inline function rather than a
macro?

Best,
Caleb

> +
>  /**
>   * bio_split_rw_at - check if and where to split a read/write bio
>   * @bio:  [in] bio to be split
> @@ -293,9 +296,9 @@ static unsigned int bio_split_alignment(struct bio *b=
io,
>  int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>                 unsigned *segs, unsigned max_bytes)
>  {
> +       unsigned nsegs =3D 0, bytes =3D 0, page_gaps =3D 0;
>         struct bio_vec bv, bvprv, *bvprvp =3D NULL;
>         struct bvec_iter iter;
> -       unsigned nsegs =3D 0, bytes =3D 0;
>
>         bio_for_each_bvec(bv, bio, iter) {
>                 if (bv.bv_offset & lim->dma_alignment)
> @@ -305,8 +308,11 @@ int bio_split_rw_at(struct bio *bio, const struct qu=
eue_limits *lim,
>                  * If the queue doesn't support SG gaps and adding this
>                  * offset would create a gap, disallow it.
>                  */
> -               if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset)=
)
> -                       goto split;
> +               if (bvprvp) {
> +                       if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
> +                               goto split;
> +                       page_gaps |=3D bv_seg_gap(bv, bvprv);
> +               }
>
>                 if (nsegs < lim->max_segments &&
>                     bytes + bv.bv_len <=3D max_bytes &&
> @@ -324,6 +330,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
>         }
>
>         *segs =3D nsegs;
> +       bio->page_gaps =3D page_gaps;
>         return 0;
>  split:
>         if (bio->bi_opf & REQ_ATOMIC)
> @@ -353,6 +360,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
>          * big IO can be trival, disable iopoll when split needed.
>          */
>         bio_clear_polled(bio);
> +       bio->page_gaps =3D page_gaps;
>         return bytes >> SECTOR_SHIFT;
>  }
>  EXPORT_SYMBOL_GPL(bio_split_rw_at);
> @@ -696,6 +704,8 @@ static bool blk_atomic_write_mergeable_rqs(struct req=
uest *rq,
>  static struct request *attempt_merge(struct request_queue *q,
>                                      struct request *req, struct request =
*next)
>  {
> +       struct bio_vec bv, bvprv;
> +
>         if (!rq_mergeable(req) || !rq_mergeable(next))
>                 return NULL;
>
> @@ -753,6 +763,10 @@ static struct request *attempt_merge(struct request_=
queue *q,
>         if (next->start_time_ns < req->start_time_ns)
>                 req->start_time_ns =3D next->start_time_ns;
>
> +       bv =3D next->bio->bi_io_vec[0];
> +       bvprv =3D req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];
> +       req->__page_gaps |=3D blk_rq_page_gaps(next) | bv_seg_gap(bv, bvp=
rv);
> +
>         req->biotail->bi_next =3D next->bio;
>         req->biotail =3D next->biotail;
>
> @@ -861,6 +875,7 @@ enum bio_merge_status bio_attempt_back_merge(struct r=
equest *req,
>                 struct bio *bio, unsigned int nr_segs)
>  {
>         const blk_opf_t ff =3D bio_failfast(bio);
> +       struct bio_vec bv, bvprv;
>
>         if (!ll_back_merge_fn(req, bio, nr_segs))
>                 return BIO_MERGE_FAILED;
> @@ -876,6 +891,10 @@ enum bio_merge_status bio_attempt_back_merge(struct =
request *req,
>         if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
>                 blk_zone_write_plug_bio_merged(bio);
>
> +       bv =3D bio->bi_io_vec[0];
> +       bvprv =3D req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];
> +       req->__page_gaps |=3D bio->page_gaps | bv_seg_gap(bv, bvprv);
> +
>         req->biotail->bi_next =3D bio;
>         req->biotail =3D bio;
>         req->__data_len +=3D bio->bi_iter.bi_size;
> @@ -890,6 +909,7 @@ static enum bio_merge_status bio_attempt_front_merge(=
struct request *req,
>                 struct bio *bio, unsigned int nr_segs)
>  {
>         const blk_opf_t ff =3D bio_failfast(bio);
> +       struct bio_vec bv, bvprv;
>
>         /*
>          * A front merge for writes to sequential zones of a zoned block =
device
> @@ -910,6 +930,10 @@ static enum bio_merge_status bio_attempt_front_merge=
(struct request *req,
>
>         blk_update_mixed_merge(req, bio, true);
>
> +       bv =3D req->bio->bi_io_vec[0];
> +       bvprv =3D bio->bi_io_vec[bio->bi_vcnt - 1];
> +       req->__page_gaps |=3D bio->page_gaps | bv_seg_gap(bv, bvprv);
> +
>         bio->bi_next =3D req->bio;
>         req->bio =3D bio;
>
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index faa36ff6465ee..a03067c4a268f 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -73,8 +73,7 @@ static bool blk_map_iter_next(struct request *req, stru=
ct blk_map_iter *iter)
>  static inline bool blk_can_dma_map_iova(struct request *req,
>                 struct device *dma_dev)
>  {
> -       return !((queue_virt_boundary(req->q) + 1) &
> -               dma_get_merge_boundary(dma_dev));
> +       return !(blk_rq_page_gaps(req) & dma_get_merge_boundary(dma_dev))=
;
>  }
>
>  static bool blk_dma_map_bus(struct blk_dma_iter *iter)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b67d6c02ecebd..09134a66c5666 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -376,6 +376,7 @@ void blk_rq_init(struct request_queue *q, struct requ=
est *rq)
>         INIT_LIST_HEAD(&rq->queuelist);
>         rq->q =3D q;
>         rq->__sector =3D (sector_t) -1;
> +       rq->__page_gaps =3D 0;
>         INIT_HLIST_NODE(&rq->hash);
>         RB_CLEAR_NODE(&rq->rb_node);
>         rq->tag =3D BLK_MQ_NO_TAG;
> @@ -659,6 +660,7 @@ struct request *blk_mq_alloc_request(struct request_q=
ueue *q, blk_opf_t opf,
>                         goto out_queue_exit;
>         }
>         rq->__data_len =3D 0;
> +       rq->__page_gaps =3D 0;
>         rq->__sector =3D (sector_t) -1;
>         rq->bio =3D rq->biotail =3D NULL;
>         return rq;
> @@ -739,6 +741,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
>         rq =3D blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), ta=
g);
>         blk_mq_rq_time_init(rq, alloc_time_ns);
>         rq->__data_len =3D 0;
> +       rq->__page_gaps =3D 0;
>         rq->__sector =3D (sector_t) -1;
>         rq->bio =3D rq->biotail =3D NULL;
>         return rq;
> @@ -2665,6 +2668,7 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
>         rq->bio =3D rq->biotail =3D bio;
>         rq->__sector =3D bio->bi_iter.bi_sector;
>         rq->__data_len =3D bio->bi_iter.bi_size;
> +       rq->__page_gaps =3D bio->page_gaps;
>         rq->nr_phys_segments =3D nr_segs;
>         if (bio_integrity(bio))
>                 rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(r=
q->q,
> @@ -3363,6 +3367,7 @@ int blk_rq_prep_clone(struct request *rq, struct re=
quest *rq_src,
>
>         /* Copy attributes of the original request to the clone request. =
*/
>         rq->__sector =3D blk_rq_pos(rq_src);
> +       rq->__page_gaps =3D blk_rq_page_gaps(rq_src);
>         rq->__data_len =3D blk_rq_bytes(rq_src);
>         if (rq_src->rq_flags & RQF_SPECIAL_PAYLOAD) {
>                 rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2a5a828f19a0b..d8f491867adc0 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -115,6 +115,7 @@ struct request {
>
>         /* the following two fields are internal, NEVER access directly *=
/
>         unsigned int __data_len;        /* total data len */
> +       unsigned int __page_gaps;       /* a mask of all the segment page=
 gaps */
>         sector_t __sector;              /* sector cursor */
>
>         struct bio *bio;
> @@ -1080,6 +1081,11 @@ static inline sector_t blk_rq_pos(const struct req=
uest *rq)
>         return rq->__sector;
>  }
>
> +static inline unsigned int blk_rq_page_gaps(const struct request *rq)
> +{
> +       return rq->__page_gaps;
> +}
> +
>  static inline unsigned int blk_rq_bytes(const struct request *rq)
>  {
>         return rq->__data_len;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0a29b20939d17..d0ed28d40fe02 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -264,6 +264,8 @@ struct bio {
>
>         unsigned short          bi_max_vecs;    /* max bvl_vecs we can ho=
ld */
>
> +       unsigned int            page_gaps;      /* a mask of all the vect=
or gaps */
> +
>         atomic_t                __bi_cnt;       /* pin count */
>
>         struct bio_vec          *bi_io_vec;     /* the actual vec list */
> --
> 2.47.3
>
>
