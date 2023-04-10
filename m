Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3914C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 07:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDJHmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 03:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDJHmZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 03:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52F3ABE
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 00:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0D086187C
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 07:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207CCC433EF;
        Mon, 10 Apr 2023 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681112543;
        bh=2GwFYTRJmm+ebz20cHql0YVLwuOTjuOkx44i30O2nGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i9MJCESldWGFAAYiIiX9/AAYe1ifbHt3/YR6zpZ7V8v6g6lqgN3DfHt5O7aopwhE6
         vpEc1sTPpCecJWdkE/YHHwg7RkKfTK6IVO6K7BnBICPM3irhidBKvBBYsoENz/Vo3+
         pfMvC13KSmj1xEJ3ArTDJ6eDRX2YaPfWxyGdZKUuQpVDc8EACM/E/Tzv396p4OJ1TV
         U5ZXlCpBQ83o03mxAgdpkC4gwzC1kxwnirB1gMQABHkWtcCVafci73OeqnrFDKxJ7l
         /zE4VCOlJNyd4mS74fyhZTsIewA9DQdjgk4m+XwAT7PbZy1Kiv+F53EZSmS+WcfkSm
         uUKQVdXnHAEBg==
Message-ID: <a5483be5-7d0e-7a1d-dd74-00b69ba8bf25@kernel.org>
Date:   Mon, 10 Apr 2023 16:42:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 01/12] block: Send zoned writes to the I/O scheduler
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-2-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Send zoned writes inserted by the device mapper to the I/O scheduler.
> This prevents that zoned writes get reordered if a device mapper driver
> has been stacked on top of a driver for a zoned block device.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 16 +++++++++++++---
>  block/blk.h    | 19 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index db93b1a71157..fefc9a728e0e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3008,9 +3008,19 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
>  	blk_account_io_start(rq);
>  
>  	/*
> -	 * Since we have a scheduler attached on the top device,
> -	 * bypass a potential scheduler on the bottom device for
> -	 * insert.
> +	 * Send zoned writes to the I/O scheduler if an I/O scheduler has been
> +	 * attached.
> +	 */
> +	if (q->elevator && blk_rq_is_seq_zoned_write(rq)) {
> +		blk_mq_sched_insert_request(rq, /*at_head=*/false,
> +					    /*run_queue=*/true,
> +					    /*async=*/false);
> +		return BLK_STS_OK;
> +	}

Looks OK to me, but as I understand it, this function is used only for request
based device mapper, none of which currently support zoned block devices if I a
not mistaken. So is this change really necessary ?

> +
> +	/*
> +	 * If no I/O scheduler has been attached or if the request is not a
> +	 * zoned write bypass the I/O scheduler attached to the bottom device.
>  	 */
>  	blk_mq_run_dispatch_ops(q,
>  			ret = blk_mq_request_issue_directly(rq, true));
> diff --git a/block/blk.h b/block/blk.h
> index d65d96994a94..4b6f8d7a6b84 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -118,6 +118,25 @@ static inline bool bvec_gap_to_prev(const struct queue_limits *lim,
>  	return __bvec_gap_to_prev(lim, bprv, offset);
>  }
>  
> +/**
> + * blk_rq_is_seq_zoned_write() - Whether @rq is a write request for a sequential zone.
> + * @rq: Request to examine.
> + *
> + * In this context sequential zone means either a sequential write required or
> + * to a sequential write preferred zone.
> + */
> +static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
> +{
> +	switch (req_op(rq)) {
> +	case REQ_OP_WRITE:
> +	case REQ_OP_WRITE_ZEROES:
> +		return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
> +	case REQ_OP_ZONE_APPEND:
> +	default:
> +		return false;
> +	}
> +}
> +
>  static inline bool rq_mergeable(struct request *rq)
>  {
>  	if (blk_rq_is_passthrough(rq))

