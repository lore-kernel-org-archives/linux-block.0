Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1D1ECAAA1
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 23:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiIBXYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIBXYV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 19:24:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5292B1C106
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 16:14:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q9so3162501pgq.6
        for <linux-block@vger.kernel.org>; Fri, 02 Sep 2022 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UFQxPx2xZ7SXz5if609vWhS7JAKW1EBJUBE4vqHgcYo=;
        b=3rE8sIFgVoYlIoaBXABmjU6tjq4EohsT0ycO+fLTxJFGNlX/oKMrXTP+6WR5tjZy8X
         /MF5F9Ju6ghbTffyPkolxge0v59URbVMmCjeJLIZ7HEbmUAdiDzDFi8wdrD973WJSEG0
         oOoRb9Qlonr8e92FvDSjK9Io2CxV3amzIuafFIyK2KCOfylff6DUDi2DzFmvnLJikMKe
         Oc8hRcmNjKR1LSOyH8Kt0o3TaRx+g50Y2chsi55QS4fBCZvUNCxEtDUw1vX07KDvzRg/
         SpYedok1hrGQmG6d0dBd8H9PvIBOUOPJqQUecofNgxIxD+2uohFyLQUGnEvvVBUVylcw
         FHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UFQxPx2xZ7SXz5if609vWhS7JAKW1EBJUBE4vqHgcYo=;
        b=3rCfHmf+FEbtzoc7Q8GLdbjxJNkIVHh6lW/5w+kTPVIbw5Egwxr+wed87as5egezI5
         X1pp3JP3bvethTMpLSsSAejBn6ZFi7n0NRSPByX7VtFB++BMyojCUT3QI9Kj5/FlbjFI
         tJTCtf5fE//NLHPUlw9S9XPcJKvZvBP4qihadPBCbab0MFWxpL+Z/rdkm1L1AEunehPy
         LR/MfLwh+9ByAOlqsxIQuhEhHAearBMxe55ozZMrKWT9is87AQMiJG8aDNh5QG/byl+9
         Opx/HPvxocLbIlFbhw01S4YqCYOExSZYVGyCQ6xM+Y/Fc310KTaeQBUvnzF8TN3cunw5
         U2ug==
X-Gm-Message-State: ACgBeo0aB2pTUZdro5VpCQw2YPlYa0huhtnUO7D4oRGAchD79VNVvFB2
        lLNPtL6za9/R+KsNjbdVGxg0EQ==
X-Google-Smtp-Source: AA6agR6msLTQtYJkA01Mz762Y9DQHJpPHWp4VEazkW9MBddlGM8sf2+lRipwmx+LQoxu8fKprf1NXQ==
X-Received: by 2002:a63:e845:0:b0:42a:610a:77a9 with SMTP id a5-20020a63e845000000b0042a610a77a9mr33695479pgk.96.1662160482720;
        Fri, 02 Sep 2022 16:14:42 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d33-20020a634f21000000b004215af667cdsm1969982pgb.41.2022.09.02.16.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 16:14:42 -0700 (PDT)
Message-ID: <5dfa132d-de5a-effa-d1bd-a4f948e36cdf@kernel.dk>
Date:   Fri, 2 Sep 2022 17:14:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 3/4] block: add helper to map bvec iterator
 for passthrough
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>
References: <20220902151657.10766-1-joshi.k@samsung.com>
 <CGME20220902152712epcas5p2622e861ac4a5ae9820a9af9442d556b4@epcas5p2.samsung.com>
 <20220902151657.10766-4-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220902151657.10766-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/2/22 9:16 AM, Kanchan Joshi wrote:
> Add blk_rq_map_user_bvec which maps the bvec iterator into a bio and
> places that into the request.
> This helper is to be used in nvme for uring-passthrough with
> fixed-buffer.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/blk-map.c        | 71 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 72 insertions(+)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index f3768876d618..0f7dc568e34b 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -612,6 +612,77 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
>  }
>  EXPORT_SYMBOL(blk_rq_map_user);
>  
> +/* Prepare bio for passthrough IO given an existing bvec iter */
> +int blk_rq_map_user_bvec(struct request *rq, struct iov_iter *iter)
> +{
> +	struct request_queue *q = rq->q;
> +	size_t iter_count, nr_segs;
> +	struct bio *bio;
> +	struct bio_vec *bv, *bvec_arr, *bvprvp = NULL;
> +	struct queue_limits *lim = &q->limits;
> +	unsigned int nsegs = 0, bytes = 0;
> +	int ret, i;
> +
> +	iter_count = iov_iter_count(iter);
> +	nr_segs = iter->nr_segs;
> +
> +	if (!iter_count || (iter_count >> 9) > queue_max_hw_sectors(q))
> +		return -EINVAL;
> +	if (nr_segs > queue_max_segments(q))
> +		return -EINVAL;
> +	if (rq->cmd_flags & REQ_POLLED) {
> +		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
> +
> +		/* no iovecs to alloc, as we already have a BVEC iterator */
> +		bio = bio_alloc_bioset(NULL, 0, opf, GFP_KERNEL,
> +					&fs_bio_set);
> +		if (!bio)
> +			return -ENOMEM;
> +	} else {
> +		bio = bio_kmalloc(0, GFP_KERNEL);
> +		if (!bio)
> +			return -ENOMEM;
> +		bio_init(bio, NULL, bio->bi_inline_vecs, 0, req_op(rq));
> +	}

I think this should be a helper at this point, as it's the same
duplicated code we have in the normal map path.

-- 
Jens Axboe
