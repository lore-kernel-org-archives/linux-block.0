Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CB5C77B72
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 06:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDQGg6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDQGg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184981716
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA72361E6C
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FECCC433D2;
        Mon, 17 Apr 2023 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681713416;
        bh=0BG5iEaviFg5BHmh+i4LevqoJRTioaiWE9zJ/M3cAKg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AYUT7mHV59U4Knj5v5PjAGzmL7KxmYnDWFyOQoSoi/OsHEO4Db5HYVd+zdwxWxRCt
         0RyS1KFpYz8LrorPEWTS5+pU9QwR4Qb+24E5/QcN1nQZNExddSt1Y6khcOCLquUkq4
         gDUHA1DaMYgcbvnwqFDVZmDAM6/HeEcLs6s+XvxDfgETdtBn+9YbUNCyZYr0T0YQeN
         h3CA/UrDhEAtsLoCFzleB2mJhsNkYE5sIXHjbqUYszcZLxGKihLLodfsGFktRocTOP
         XuW4FbmYlhEr+g1s7Osy+1FoJVpx4UWwfU6wqiFEdyzBvPO7kVg9sMvZd0XzJtsHls
         vkIp51dKZbcmg==
Message-ID: <4689ec07-8da7-eecd-5980-e89fe255af6a@kernel.org>
Date:   Mon, 17 Apr 2023 15:36:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/7] blk-mq: defer to the normal submission path for
 post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-6-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230416200930.29542-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/23 05:09, Christoph Hellwig wrote:
> Requests with the FUA bit on hardware without FUA support need a post
> flush before returning the caller, but they can still be sent using

s/returning/returning to

> the normal I/O path after initializing the flush-related fields and
> end I/O handler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-flush.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index f62e74d9d56bc8..9eda6d46438dba 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -435,6 +435,17 @@ bool blk_insert_flush(struct request *rq)
>  		 * Queue for normal execution.
>  		 */
>  		return false;
> +	case REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH:
> +		/*
> +		 * Initialize the flush fields and completion handler to trigger
> +		 * the post flush, and then just pass the command on.
> +		 */
> +		blk_rq_init_flush(rq);
> +		rq->flush.seq |= REQ_FSEQ_PREFLUSH;

Shouldn't this be REQ_FSEQ_POSTFLUSH ?

> +		spin_lock_irq(&fq->mq_flush_lock);
> +		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
> +		spin_unlock_irq(&fq->mq_flush_lock);
> +		return false;
>  	default:
>  		/*
>  		 * Mark the request as part of a flush sequence and submit it

