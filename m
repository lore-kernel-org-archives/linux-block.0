Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B87C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 22:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34686218D4
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 22:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARAUUCiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfCVWkh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:40:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36503 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfCVWkh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 18:40:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so3991125wrd.3;
        Fri, 22 Mar 2019 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FW36JplQkgdg8xhdov6vyQM15ACDMZDXHGGVIlsUEuI=;
        b=ARAUUCiAiJ35/FLaZnTAG5MOkj8rJxKZSdYp1O6uYtbiGeEWXd8rC6w640ekH5hMTx
         EkJrJxcyHelC0ZrAm6vvsrr+bOGyiCW3HmLUU+5ZSvSUhEydkGZhVheasV/zkjxnRSCb
         Qdn7ctTsXGBoaq4NDVurEcpOd1aq7RWsjavv92L8/5H//RoBcuGkiXykqfVJx0d/mrgt
         15x20poXnJZ5hk77pDf+YIWQ1KVNfyLdY5NM1cP7fuz9/QLZAXilVvjPGp5Jymnog367
         DPElX5Ph78rg628HJLFW3RI/XX6PAaAjCkRUFZzkkUCY2VGFyL4Ja5u6SEYN9eNaoXZi
         if4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FW36JplQkgdg8xhdov6vyQM15ACDMZDXHGGVIlsUEuI=;
        b=b6kaVAn8N3w5E6eCNodCLnUqfFJTsNOgrSktnewlLXZp8XXIAkX3MtRK/pk8j2kIrO
         abD1Jf32oGukBcNoKlOnwwWBNtMXgypDP6orlDGNyTxpTFGwOM9YiOKclk7mehgpyMWv
         bYoGCXp+dYp+2tu+OTPFC0lH5dEcKF84dHcTNCCgg3NiSrK4vkTRn4GaSKsK4jJZMwaQ
         n6ockdIxBTn56nu5gB+AtJ6Zlir8U1H4D7CPsmHlycDhgNO781Gol5TKROj/isb5oz+N
         NkiGhQIeZ64D8I/aLS2IOMfjzn+3ESGAfbs5oDJfUj83pCrNFhxR387rJTdY6986WoMq
         akaw==
X-Gm-Message-State: APjAAAW8Z9GHx1KgOH0sFKa/2qWlJAH50Pgf0RnFYbrd/JkWjCyE1FdU
        2udYQmMZ/I1Qknxxn5yqiGfVsaaG+v/R9306OWI=
X-Google-Smtp-Source: APXvYqyk/vzm7l9LgmywM/o96ItFOEY5aejuWPomiAmklec3PLLT/OJ0kwbF5nQCex0jihMhc+6XyPt43jPmqGQ9LD4=
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr7748760wrr.275.1553294434240;
 Fri, 22 Mar 2019 15:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190322131346.20169-1-jthumshirn@suse.de> <20190322131346.20169-2-jthumshirn@suse.de>
In-Reply-To: <20190322131346.20169-2-jthumshirn@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 23 Mar 2019 06:40:21 +0800
Message-ID: <CACVXFVOq1ngjpD62SreSZda5k_WJjxOZRHwpqt6si7bRv=O46Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] block: bio: kill BIO_SEG_VALID flag
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 9:14 PM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> From: Jens Axboe <axboe@kernel.dk>
>
> Kill the BIO_SEG_VALID flag. We should just use ->bi_phys_segments to tell
> if it's valid or not.
>
> This patch uses -1 to signify it's not.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [ jth initialize pc bios with 1 phys segment and WARN if we're submitting
> bios with -1 segments ]
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/bio.c               | 15 +++++++++------
>  block/blk-core.c          |  1 +
>  block/blk-merge.c         | 13 ++++++-------
>  drivers/md/raid5.c        |  2 +-
>  include/linux/blk_types.h |  1 -
>  5 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 71a78d9fb8b7..a79b2bbcffd0 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -280,6 +280,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>               unsigned short max_vecs)
>  {
>         memset(bio, 0, sizeof(*bio));
> +       bio->bi_phys_segments = -1;
>         atomic_set(&bio->__bi_remaining, 1);
>         atomic_set(&bio->__bi_cnt, 1);
>
> @@ -305,6 +306,7 @@ void bio_reset(struct bio *bio)
>         bio_uninit(bio);
>
>         memset(bio, 0, BIO_RESET_BYTES);
> +       bio->bi_phys_segments = -1;
>         bio->bi_flags = flags;
>         atomic_set(&bio->__bi_remaining, 1);
>  }
> @@ -573,7 +575,7 @@ EXPORT_SYMBOL(bio_put);
>
>  int bio_phys_segments(struct request_queue *q, struct bio *bio)
>  {
> -       if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
> +       if (unlikely(bio->bi_phys_segments == -1))
>                 blk_recount_segments(q, bio);
>
>         return bio->bi_phys_segments;
> @@ -712,7 +714,10 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
>         bvec->bv_len = len;
>         bvec->bv_offset = offset;
>         bio->bi_vcnt++;
> -       bio->bi_phys_segments++;
> +       if (bio->bi_phys_segments == -1)
> +               bio->bi_phys_segments = 1;
> +       else
> +               bio->bi_phys_segments++;
>         bio->bi_iter.bi_size += len;
>
>         /*
> @@ -731,7 +736,7 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
>
>         /* If we may be able to merge these biovecs, force a recount */
>         if (bio->bi_vcnt > 1 && biovec_phys_mergeable(q, bvec - 1, bvec))
> -               bio_clear_flag(bio, BIO_SEG_VALID);
> +               bio->bi_phys_segments = -1;
>
>   done:
>         return len;
> @@ -1913,10 +1918,8 @@ void bio_trim(struct bio *bio, int offset, int size)
>         if (offset == 0 && size == bio->bi_iter.bi_size)
>                 return;
>
> -       bio_clear_flag(bio, BIO_SEG_VALID);
> -
> +       bio->bi_phys_segments = -1;
>         bio_advance(bio, offset << 9);
> -
>         bio->bi_iter.bi_size = size;
>
>         if (bio_integrity(bio))
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4673ebe42255..53372a16dd7c 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1514,6 +1514,7 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
>         else if (bio_op(bio) == REQ_OP_DISCARD)
>                 rq->nr_phys_segments = 1;
>
> +       WARN_ON(rq->nr_phys_segments == -1);
>         rq->__data_len = bio->bi_iter.bi_size;
>         rq->bio = rq->biotail = bio;
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 1c9d4f0f96ea..16c2ae69c46b 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -343,7 +343,6 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
>         /* physical segments can be figured out during splitting */
>         res = split ? split : *bio;
>         res->bi_phys_segments = nsegs;
> -       bio_set_flag(res, BIO_SEG_VALID);
>
>         if (split) {
>                 /* there isn't chance to merge the splitted bio */
> @@ -440,8 +439,6 @@ void blk_recount_segments(struct request_queue *q, struct bio *bio)
>         bio->bi_next = NULL;
>         bio->bi_phys_segments = __blk_recalc_rq_segments(q, bio);
>         bio->bi_next = nxt;
> -
> -       bio_set_flag(bio, BIO_SEG_VALID);
>  }
>
>  static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
> @@ -620,6 +617,8 @@ static inline int ll_new_hw_segment(struct request_queue *q,
>  {
>         int nr_phys_segs = bio_phys_segments(q, bio);
>
> +       if (WARN_ON(nr_phys_segs == -1))
> +               nr_phys_segs = 0;
>         if (req->nr_phys_segments + nr_phys_segs > queue_max_segments(q))
>                 goto no_merge;
>
> @@ -651,9 +650,9 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
>                 req_set_nomerge(q, req);
>                 return 0;
>         }
> -       if (!bio_flagged(req->biotail, BIO_SEG_VALID))
> +       if (req->biotail->bi_phys_segments == -1)
>                 blk_recount_segments(q, req->biotail);
> -       if (!bio_flagged(bio, BIO_SEG_VALID))
> +       if (bio->bi_phys_segments == -1)
>                 blk_recount_segments(q, bio);
>
>         return ll_new_hw_segment(q, req, bio);
> @@ -673,9 +672,9 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
>                 req_set_nomerge(q, req);
>                 return 0;
>         }
> -       if (!bio_flagged(bio, BIO_SEG_VALID))
> +       if (bio->bi_phys_segments == -1)
>                 blk_recount_segments(q, bio);
> -       if (!bio_flagged(req->bio, BIO_SEG_VALID))
> +       if (req->bio->bi_phys_segments == -1)
>                 blk_recount_segments(q, req->bio);
>
>         return ll_new_hw_segment(q, req, bio);
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index c033bfcb209e..79eb54dcf0f9 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5247,7 +5247,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
>                 rcu_read_unlock();
>                 raid_bio->bi_next = (void*)rdev;
>                 bio_set_dev(align_bi, rdev->bdev);
> -               bio_clear_flag(align_bi, BIO_SEG_VALID);
> +               align_bi->bi_phys_segments = -1;
>
>                 if (is_badblock(rdev, align_bi->bi_iter.bi_sector,
>                                 bio_sectors(align_bi),
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d66bf5f32610..472059e92071 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -215,7 +215,6 @@ struct bio {
>  /*
>   * bio flags
>   */
> -#define BIO_SEG_VALID  1       /* bi_phys_segments valid */
>  #define BIO_CLONED     2       /* doesn't own data */
>  #define BIO_BOUNCED    3       /* bio is a bounce bio */
>  #define BIO_USER_MAPPED 4      /* contains user pages */

Some drivers set max segments as USHRT_MAX, will this patch break this
kind of driver?

Thanks,
Ming Lei
