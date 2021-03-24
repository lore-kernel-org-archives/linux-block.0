Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B1BC433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C19061A09
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 15:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbhCXPxB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234220AbhCXPww (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 11:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95D6961A0D;
        Wed, 24 Mar 2021 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616601172;
        bh=xGC0hpeL+a/X4HKR8Sv3T6bC7RitCZ5HrnvpCxiiROM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDGX/CVp/6SGPKnj8u55so5ycn/X5eldXqZZt/+MYI9iwVNPjqELcUqpqbQrEX9+3
         A7aThcsLHHj++eqWoDybqvd6c8ba5yvjab5FmJIOeC3rvfP06eR76Zj/wlOa6THqiH
         kN5JjaaGYtKgmiO8fmub6VUuUwl0W8parncnqN4RpUPjYbeybO9nCipf9tyXeVkR2Z
         8pNOpLuHKqcewPRUIVaotWGy/rrafTXsNvtPzyW2E8JXQNL0vJ6FHescmKLv0alJwK
         vJSR8VdJXAoLnEOVWTOmhrtlIZiT1uu7LOwvGuZHq3imT605VwH67JDLtcRzjyC3HE
         AHUZ1TIIeZpkg==
Date:   Thu, 25 Mar 2021 00:52:45 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH V3 03/13] block: add helper of blk_create_io_context
Message-ID: <20210324155245.GA26474@redsun51.ssa.fujisawa.hgst.com>
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324121927.362525-4-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 08:19:17PM +0800, Ming Lei wrote:
> +static inline void blk_create_io_context(struct request_queue *q)
> +{
> +	/*
> +	 * Various block parts want %current->io_context, so allocate it up
> +	 * front rather than dealing with lots of pain to allocate it only
> +	 * where needed. This may fail and the block layer knows how to live
> +	 * with it.
> +	 */

I think this comment would make more sense if it were placed above the
caller rather than within this function. 

> +	if (unlikely(!current->io_context))
> +		create_task_io_context(current, GFP_ATOMIC, q->node);
> +}
> +
>  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  {
>  	struct block_device *bdev = bio->bi_bdev;
> @@ -836,6 +848,8 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  		}
>  	}
>  
> +	blk_create_io_context(q);
> +
>  	if (!blk_queue_poll(q))
>  		bio->bi_opf &= ~REQ_HIPRI;
>  
> @@ -876,15 +890,6 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  		break;
>  	}
>  
> -	/*
> -	 * Various block parts want %current->io_context, so allocate it up
> -	 * front rather than dealing with lots of pain to allocate it only
> -	 * where needed. This may fail and the block layer knows how to live
> -	 * with it.
> -	 */
> -	if (unlikely(!current->io_context))
> -		create_task_io_context(current, GFP_ATOMIC, q->node);
> -
>  	if (blk_throtl_bio(bio)) {
>  		blkcg_bio_issue_init(bio);
>  		return false;
> -- 
> 2.29.2
