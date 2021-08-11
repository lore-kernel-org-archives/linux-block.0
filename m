Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C67EC4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 14:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487B160FC3
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 14:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhHKOzw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232440AbhHKOzv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 10:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B74460FC0;
        Wed, 11 Aug 2021 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628693727;
        bh=wUEr1k+9OTqOwEMyx4ah8qiGrmA/MoBkHPWnCf2IEXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyloWZo6U/tjVyajjJv52aqrsPfNmDPRLedYKHCv4ooeSc493SOSpb6nvEU4Sf6l2
         lzwp0urFjSevg3b3aYc1ZYlQe80kV2ZIqwqF+y5vWnYCBF4HpIy/lACkZmf/YN/rsC
         m/cMjgtTR+yt0D45/reEpvNxJVYWS46BTHpOTBoLbWZyGxt/SR+ZikQiK97rLWJqze
         kRiI/v+Gb+1/tC1uNV6YiIK23Kqt1WE3pxfZWKnRwxojaNjOaE1Qrpj0C8Da0kN8ao
         Dy/grT0biZ1TgX9VHXn6WY4vo1Lp4tIVRWSSksDIhbkg50Oe6G0pfbNAeyQ61CosJs
         FKD4AnZ1wWF0A==
Date:   Wed, 11 Aug 2021 08:55:25 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq: don't grab rq's refcount in
 blk_mq_check_expired()
Message-ID: <20210811145525.GA61802@C02WT3WMHTD6>
References: <20210811143838.622001-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811143838.622001-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 11, 2021 at 10:38:38PM +0800, Ming Lei wrote:
> Inside blk_mq_queue_tag_busy_iter() we already grabbed request's
> refcount before calling ->fn(), so needn't to grab it one more time
> in blk_mq_check_expired().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d2725f94491d..4d3457d2957f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -917,6 +917,10 @@ void blk_mq_put_rq_ref(struct request *rq)
>  		__blk_mq_free_request(rq);
>  }
>  
> +/*
> + * This request won't be re-allocated because its refcount is held when
> + * calling this callback.
> + */
>  static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>  		struct request *rq, void *priv, bool reserved)
>  {
> @@ -930,27 +934,12 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>  		return true;
>  
>  	/*
> -	 * We have reason to believe the request may be expired. Take a
> -	 * reference on the request to lock this request lifetime into its
> -	 * currently allocated context to prevent it from being reallocated in
> -	 * the event the completion by-passes this timeout handler.
> -	 *
> -	 * If the reference was already released, then the driver beat the
> -	 * timeout handler to posting a natural completion.
> -	 */
> -	if (!refcount_inc_not_zero(&rq->ref))
> -		return true;
> -
> -	/*
> -	 * The request is now locked and cannot be reallocated underneath the
> -	 * timeout handler's processing. Re-verify this exact request is truly
> -	 * expired; if it is not expired, then the request was completed and
> -	 * reallocated as a new request.
> +	 * Re-verify this exact request is truly expired; if it is not expired,
> +	 * then the request was completed and reallocated as a new request
> +	 * after returning from blk_mq_check_expired().
>  	 */
>  	if (blk_mq_req_expired(rq, next))
>  		blk_mq_rq_timed_out(rq, reserved);

There's no need to check expired twice if the iterator is already taking a
reference. I had this double check because I didn't want to penalize normal IO
by preventing it from completing while the timeout handler is running, but it
looks like the current timeout iterator is going to do that anyway.

> -
> -	blk_mq_put_rq_ref(rq);
>  	return true;
>  }
