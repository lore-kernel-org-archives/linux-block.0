Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C41C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 01:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjEVBP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 21:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEVBPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 21:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6DACD
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 18:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5037B60ED1
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 01:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A42C433D2;
        Mon, 22 May 2023 01:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684718123;
        bh=0dScuib9+QAMtwth7zRy5VweBF/8gCNJ292iny4Rlno=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HVLy1P8GgWfNWeuxY4/jDIPWSQwrXHLr4As2HF3MXr+p408I618qa/r2vGhehP1/a
         0dSIUI3FvHzicwZqNakqCJYNJKeJhW1nN0jxFxMXbuS1xIabdQCQkmT5wOEG7k7WH0
         oogiB+GRQtX+27sJk/8kUmS4Amqu/VhB2knLjTwZCz728MUfo2ikS1ppyP5DXn7DE3
         1YsTgAesdFwR50A5bnZHRZoltR0CooNtJmtjK6oWif+pgzqHAxjhTHZGP7EEf0WXkD
         NuvAh62i2SzCXvQBfRZjJJ7CEsCqu6XIPnzNn2uOZqMMMsZATHeLd3cEF45WZqni1t
         b9Awlo6KVsZdQ==
Message-ID: <694813ca-690d-4852-0066-cee6833ad8c4@kernel.org>
Date:   Mon, 22 May 2023 10:15:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Content-Language: en-US
To:     Tian Lan <tilan7663@gmail.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Tian Lan <tian.lan@twosigma.com>
References: <20230522004328.760024-1-tilan7663@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230522004328.760024-1-tilan7663@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/22/23 09:43, Tian Lan wrote:
> From: Tian Lan <tian.lan@twosigma.com>
> 
> If multiple CPUs are sharing the same hardware queue, it can
> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
> is executed simultaneously.
> 
> Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> ---
>  block/blk-mq-tag.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d6af9d431dc6..07372032238a 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -42,13 +42,15 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>  		struct request_queue *q = hctx->queue;
>  
> -		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {

This is weird. test_and_set_bit() returns the bit old value, so shouldn't this be:

		if (test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
			return;

?

>  			return;
> -		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
> +		}
>  	} else {
> -		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
> +		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
>  			return;
> -		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
> +		}

Same here. And given that this pattern is the same for the if and the else, this
entire hunk can likely be simplified.

>  	}
>  
>  	users = atomic_inc_return(&hctx->tags->active_queues);

-- 
Damien Le Moal
Western Digital Research

