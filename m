Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F67EC4338F
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C26861058
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 07:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhG2HRh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhG2HRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 03:17:36 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D011C061757
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 00:17:33 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id CE2FCB60DA3;
        Thu, 29 Jul 2021 09:17:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1627543049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbEIlzfX7NpgvHOHEqBMixfYuB7ctzkVAr2o1+JoU3I=;
        b=jRxYyZAfWvV5K8fhIpToo69FrtMjPemySliVDwAPYS/it0tN8LBW5woxZnmblpCQk62KF8
        WAKlV73Zjb9MPfSNR8y3B+1Ed7deOhCGENiBthXyKhVNl6GUE7z6Li3Jw54L1ubzM9tAPI
        sDwOTR3U0ENuvjqVylrahEMScTg+zcM=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: return ELEVATOR_DISCARD_MERGE if possible
Date:   Thu, 29 Jul 2021 09:17:28 +0200
Message-ID: <67816551.sp8fIUDole@natalenko.name>
In-Reply-To: <20210729034226.1591070-1-ming.lei@redhat.com>
References: <20210729034226.1591070-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On =C4=8Dtvrtek 29. =C4=8Dervence 2021 5:42:26 CEST Ming Lei wrote:
> When merging one bio to request, if they are discard IO and the queue
> supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
> because both block core and related drivers(nvme, virtio-blk) doesn't
> handle mixed discard io merge(traditional IO merge together with
> discard merge) well.
>=20
> Fix the issue by returning ELEVATOR_DISCARD_MERGE in this situation,
> so both blk-mq and drivers just need to handle multi-range discard.
>=20
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bfq-iosched.c      |  3 +++
>  block/blk-merge.c        | 16 ----------------
>  block/elevator.c         |  3 +++
>  block/mq-deadline-main.c |  2 ++
>  include/linux/blkdev.h   | 16 ++++++++++++++++
>  5 files changed, 24 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 727955918563..673a634eadd9 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2361,6 +2361,9 @@ static int bfq_request_merge(struct request_queue *=
q,
> struct request **req, __rq =3D bfq_find_rq_fmerge(bfqd, bio, q);
>  	if (__rq && elv_bio_merge_ok(__rq, bio)) {
>  		*req =3D __rq;
> +
> +		if (blk_discard_mergable(__rq))
> +			return ELEVATOR_DISCARD_MERGE;
>  		return ELEVATOR_FRONT_MERGE;
>  	}
>=20
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index a11b3b53717e..f8707ff7e2fc 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -705,22 +705,6 @@ static void blk_account_io_merge_request(struct requ=
est
> *req) }
>  }
>=20
> -/*
> - * Two cases of handling DISCARD merge:
> - * If max_discard_segments > 1, the driver takes every bio
> - * as a range and send them to controller together. The ranges
> - * needn't to be contiguous.
> - * Otherwise, the bios/requests will be handled as same as
> - * others which should be contiguous.
> - */
> -static inline bool blk_discard_mergable(struct request *req)
> -{
> -	if (req_op(req) =3D=3D REQ_OP_DISCARD &&
> -	    queue_max_discard_segments(req->q) > 1)
> -		return true;
> -	return false;
> -}
> -
>  static enum elv_merge blk_try_req_merge(struct request *req,
>  					struct request *next)
>  {
> diff --git a/block/elevator.c b/block/elevator.c
> index 52ada14cfe45..a5fe2615ec0f 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -336,6 +336,9 @@ enum elv_merge elv_merge(struct request_queue *q, str=
uct
> request **req, __rq =3D elv_rqhash_find(q, bio->bi_iter.bi_sector);
>  	if (__rq && elv_bio_merge_ok(__rq, bio)) {
>  		*req =3D __rq;
> +
> +		if (blk_discard_mergable(__rq))
> +			return ELEVATOR_DISCARD_MERGE;
>  		return ELEVATOR_BACK_MERGE;
>  	}
>=20
> diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
> index 6f612e6dc82b..294be0c0db65 100644
> --- a/block/mq-deadline-main.c
> +++ b/block/mq-deadline-main.c
> @@ -677,6 +677,8 @@ static int dd_request_merge(struct request_queue *q,
> struct request **rq,
>=20
>  		if (elv_bio_merge_ok(__rq, bio)) {
>  			*rq =3D __rq;
> +			if (blk_discard_mergable(__rq))
> +				return ELEVATOR_DISCARD_MERGE;
>  			return ELEVATOR_FRONT_MERGE;
>  		}
>  	}
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3177181c4326..87f00292fd7a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1521,6 +1521,22 @@ static inline int
> queue_limit_discard_alignment(struct queue_limits *lim, sector return
> offset << SECTOR_SHIFT;
>  }
>=20
> +/*
> + * Two cases of handling DISCARD merge:
> + * If max_discard_segments > 1, the driver takes every bio
> + * as a range and send them to controller together. The ranges
> + * needn't to be contiguous.
> + * Otherwise, the bios/requests will be handled as same as
> + * others which should be contiguous.
> + */
> +static inline bool blk_discard_mergable(struct request *req)
> +{
> +	if (req_op(req) =3D=3D REQ_OP_DISCARD &&
> +	    queue_max_discard_segments(req->q) > 1)
> +		return true;
> +	return false;
> +}
> +
>  static inline int bdev_discard_alignment(struct block_device *bdev)
>  {
>  	struct request_queue *q =3D bdev_get_queue(bdev);

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Also,

=46ixes: ?

and possibly:

CC: stable@ # v5.x?

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


