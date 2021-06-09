Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D14FC4743D
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 03:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296B561289
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 03:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhFIDIA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 23:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhFIDIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 23:08:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE59C061574
        for <linux-block@vger.kernel.org>; Tue,  8 Jun 2021 20:06:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y15so17285866pfl.4
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 20:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=agr5gvqmCHboIPuQkuk9Qc28o7KWp6GF0hDZwofJCLY=;
        b=R2v0+KukrxDijUOhqYsAUOmSam/SIjRoiuknv4efGZAtb33H/5ZahBFSSeow6snj7h
         JMhatR7zZ1rLEVXmSn4JGTP4Eg5iHT1P05pDCgzsMukH6NjeFShOARRQ42ucmO5k6N0w
         qyc8wCWUW4sR3i/xPCKks6hq4aLOYBB0w0ZFA9hbqojgLtc2hF1m+YGAZwf4w1B6hOog
         BmY8rdAd4pn1l600Vfi9RktBkYN9Oy+BVb9ba+NB6jfwQECOW/Pr+ehM42iFmrpr3vJM
         4nNv21Doy6uTTx6GGhHwpxkQn2DSWmHqu6+gq2SKP29PDHxugvydiwRhWzdlDkfGf1JH
         188Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=agr5gvqmCHboIPuQkuk9Qc28o7KWp6GF0hDZwofJCLY=;
        b=EAQJ/06lfc6W9tyY8E9RfGnbKIhIVRXG84QL4JIcDLR1kMtbFpPm5lZK41HFVbzjMD
         thM4wZC7cQVe5DfgjlhjHopCMx5JtEDr22imP6EDcdTfYnsjo1g8jMrqtVbdZDz0zogb
         zgoj18JbKsGWpffggz7fmp7nEw4NWqj+J+Z/1zbHkvtGTiSqjR3V2sVJ5Q6moUZLYlPJ
         vfQ0db2JyL8pD3IYWe+k6XYS8Pc+gswQ7it0cjhu95KrZr/AgpI1hxFfkhK+2AyCmcsh
         Cr2focFi+6kBiiKC3mg9vo4dNyuuVAAOryLTNGUOPqQ5mgFwVQi3sLSLl9kbsGF0dfL8
         pa4Q==
X-Gm-Message-State: AOAM532xxvjVSOgr3JL3z8Gi6I09MJwqvV3SAXZTk09GngPLV9rBcd2T
        cUdp5Iz5WInivZdd124PvJg=
X-Google-Smtp-Source: ABdhPJwSTnaqdwZsx6g8Sadgozcz1MGB6go7TvgImqERSxctvWeVxc5VP5VAQzRFnGWZxpwQFAijWQ==
X-Received: by 2002:aa7:9384:0:b029:2cc:5e38:933a with SMTP id t4-20020aa793840000b02902cc5e38933amr3130302pfe.81.1623207965991;
        Tue, 08 Jun 2021 20:06:05 -0700 (PDT)
Received: from [10.7.3.1] ([133.130.111.179])
        by smtp.gmail.com with ESMTPSA id y190sm2976411pfc.85.2021.06.08.20.06.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:06:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.6\))
Subject: Re: [PATCH 2/2] block: support bio merge for multi-range discard
From:   Wang Shanker <shankerwangmiao@gmail.com>
In-Reply-To: <20210609004556.46928-3-ming.lei@redhat.com>
Date:   Wed, 9 Jun 2021 11:05:59 +0800
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAAB68D1-3F92-4F88-B192-2A202F7CE53D@gmail.com>
References: <20210609004556.46928-1-ming.lei@redhat.com>
 <20210609004556.46928-3-ming.lei@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.6)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 2021=E5=B9=B406=E6=9C=8809=E6=97=A5 08:45=EF=BC=8CMing Lei =
<ming.lei@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> So far multi-range discard treats each bio as one segment(range) of =
single
> discard request. This way becomes not efficient if lots of small sized
> discard bios are submitted, and one example is raid456.
>=20
> Support bio merge for multi-range discard for improving lots of small
> sized discard bios.
>=20
> Turns out it is easy to support it:
>=20
> 1) always try to merge bio first
>=20
> 2) run into multi-range discard only if bio merge can't be done
>=20
> 3) add rq_for_each_discard_range() for retrieving each range(segment)
> of discard request
>=20
> Reported-by: Wang Shanker <shankerwangmiao@gmail.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> block/blk-merge.c          | 12 ++++-----
> drivers/block/virtio_blk.c |  9 ++++---
> drivers/nvme/host/core.c   |  8 +++---
> include/linux/blkdev.h     | 51 ++++++++++++++++++++++++++++++++++++++
> 4 files changed, 66 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcdff1879c34..65210e9a8efa 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -724,10 +724,10 @@ static inline bool blk_discard_mergable(struct =
request *req)
> static enum elv_merge blk_try_req_merge(struct request *req,
> 					struct request *next)
> {
> -	if (blk_discard_mergable(req))
> -		return ELEVATOR_DISCARD_MERGE;
> -	else if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D =
blk_rq_pos(next))
> +	if (blk_rq_pos(req) + blk_rq_sectors(req) =3D=3D =
blk_rq_pos(next))
> 		return ELEVATOR_BACK_MERGE;
> +	else if (blk_discard_mergable(req))

Shall we adjust how req->nr_phys_segments is calculated in=20
bio_attempt_discard_merge() so that multiple contiguous bio's can
be seen as one segment?

> +		return ELEVATOR_DISCARD_MERGE;
>=20
> 	return ELEVATOR_NO_MERGE;
> }
> @@ -908,12 +908,12 @@ bool blk_rq_merge_ok(struct request *rq, struct =
bio *bio)
>=20
> enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
> {
> -	if (blk_discard_mergable(rq))
> -		return ELEVATOR_DISCARD_MERGE;
> -	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D =
bio->bi_iter.bi_sector)
> +	if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D =
bio->bi_iter.bi_sector)
> 		return ELEVATOR_BACK_MERGE;
> 	else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D =
bio->bi_iter.bi_sector)
> 		return ELEVATOR_FRONT_MERGE;
> +	else if (blk_discard_mergable(rq))
> +		return ELEVATOR_DISCARD_MERGE;
> 	return ELEVATOR_NO_MERGE;
> }
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..970cb0d8acaa 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -116,7 +116,6 @@ static int =
virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> 	unsigned short segments =3D blk_rq_nr_discard_segments(req);
> 	unsigned short n =3D 0;
> 	struct virtio_blk_discard_write_zeroes *range;
> -	struct bio *bio;
> 	u32 flags =3D 0;
>=20
> 	if (unmap)
> @@ -138,9 +137,11 @@ static int =
virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
> 		range[0].sector =3D cpu_to_le64(blk_rq_pos(req));
> 		n =3D 1;
> 	} else {
> -		__rq_for_each_bio(bio, req) {
> -			u64 sector =3D bio->bi_iter.bi_sector;
> -			u32 num_sectors =3D bio->bi_iter.bi_size >> =
SECTOR_SHIFT;
> +		struct req_discard_range r;
> +
> +		rq_for_each_discard_range(r, req) {
> +			u64 sector =3D r.sector;
> +			u32 num_sectors =3D r.size >> SECTOR_SHIFT;
>=20
> 			range[n].flags =3D cpu_to_le32(flags);
> 			range[n].num_sectors =3D =
cpu_to_le32(num_sectors);
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 24bcae88587a..4b0a39360ce9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -813,7 +813,7 @@ static blk_status_t nvme_setup_discard(struct =
nvme_ns *ns, struct request *req,
> {
> 	unsigned short segments =3D blk_rq_nr_discard_segments(req), n =3D=
 0;
> 	struct nvme_dsm_range *range;
> -	struct bio *bio;
> +	struct req_discard_range r;
>=20
> 	/*
> 	 * Some devices do not consider the DSM 'Number of Ranges' field =
when
> @@ -835,9 +835,9 @@ static blk_status_t nvme_setup_discard(struct =
nvme_ns *ns, struct request *req,
> 		range =3D page_address(ns->ctrl->discard_page);
> 	}
>=20
> -	__rq_for_each_bio(bio, req) {
> -		u64 slba =3D nvme_sect_to_lba(ns, =
bio->bi_iter.bi_sector);
> -		u32 nlb =3D bio->bi_iter.bi_size >> ns->lba_shift;
> +	rq_for_each_discard_range(r, req) {
> +		u64 slba =3D nvme_sect_to_lba(ns, r.sector);
> +		u32 nlb =3D r.size >> ns->lba_shift;
>=20
> 		if (n < segments) {
> 			range[n].cattr =3D cpu_to_le32(0);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d66d0da72529..bd9d22269a7b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1007,6 +1007,57 @@ static inline unsigned int =
blk_rq_stats_sectors(const struct request *rq)
> 	return rq->stats_sectors;
> }
>=20
> +struct req_discard_range {
> +	sector_t	sector;
> +	unsigned int	size;
> +
> +	/*
> +	 * internal field: driver don't use it, and it always points to
> +	 * next bio to be processed
> +	 */
> +	struct bio *__bio;
> +};
> +
> +static inline void req_init_discard_range_iter(const struct request =
*rq,
> +		struct req_discard_range *range)
> +{
> +	range->__bio =3D rq->bio;
> +}
> +
> +/* return true if @range stores one valid discard range */
> +static inline bool req_get_discard_range(struct req_discard_range =
*range)
> +{
> +	struct bio *bio;
> +
> +	if (!range->__bio)
> +		return false;
> +
> +	bio =3D range->__bio;
> +	range->sector =3D bio->bi_iter.bi_sector;
> +	range->size =3D bio->bi_iter.bi_size;
> +	range->__bio =3D bio->bi_next;
> +
> +	while (range->__bio) {
> +		struct bio *bio =3D range->__bio;
> +
> +		if (range->sector + (range->size >> SECTOR_SHIFT) !=3D
> +				bio->bi_iter.bi_sector)
> +			break;
> +
> +		/*
> +		 * ->size won't overflow because req->__data_len is =
defined
> +		 *  as 'unsigned int'
> +		 */
> +		range->size +=3D bio->bi_iter.bi_size;
> +		range->__bio =3D bio->bi_next;
> +	}
> +	return true;
> +}
> +
> +#define rq_for_each_discard_range(range, rq) \
> +	for (req_init_discard_range_iter((rq), &range); \
> +			req_get_discard_range(&range);)
> +
> #ifdef CONFIG_BLK_DEV_ZONED
>=20
> /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
> --=20
> 2.31.1
>=20

