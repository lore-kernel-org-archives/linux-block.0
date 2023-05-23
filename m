Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EDFC77B73
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 02:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjEWChk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 22:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjEWChk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 22:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E427CA
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 19:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2971F62209
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45ADC433EF;
        Tue, 23 May 2023 02:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684809458;
        bh=4hCzkxeRjrY9dRdSbcr+1q3uR5Zpw1DEHyG7V7JFJag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TChL3nt6RIOYX7Q6T5hKvqeKJziX3aPuMgs4xC7/ZZQ1PfwdcAPshEBtZhfdd/Agf
         mBqId8bFY3XCQHTDp3eVFJ47K7Bz1NK1k0jVFTynY4Dul6ZkfAWl00SYsfQg1Qc+Bf
         wuv82YF+cVm5w7w/G9gGsEvou7nv3cRI34JKhpVroJdfuNo5zZqVydofWapwGtEZ6s
         m6IAs/PQVBik+GwHxoiKJlJeJjzfwkYu05D0UIyQMyX19/csVe5aLg4BlJ5WR0v7Oi
         5QAUfSOZZ1kMtFve9k1fjtXzJkv+4CL74LSB3hwBcpEpy+BzC936Oyhkp5Uq+bE8c4
         0uTmPjhsO2tCA==
Message-ID: <b0384ec6-4c75-ae2a-caa7-380373e87d80@kernel.org>
Date:   Tue, 23 May 2023 11:37:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Content-Language: en-US
To:     Tian Lan <tilan7663@gmail.com>, john.g.garry@oracle.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, ming.lei@redhat.com,
        tian.lan@twosigma.com
References: <a11faa27-965e-3109-15e2-33f015262426@oracle.com>
 <20230522210555.794134-1-tilan7663@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230522210555.794134-1-tilan7663@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 06:05, Tian Lan wrote:
> From: Tian Lan <tian.lan@twosigma.com>
> 
> If multiple CPUs are sharing the same hardware queue, it can
> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
> is executed simultaneously.
> 
> Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-mq-tag.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d6af9d431dc6..dfd81cab5788 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -39,16 +39,20 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
>  	unsigned int users;
>  
> +	/*
> +	 * calling test_bit() prior to test_and_set_bit() is intentional,
> +	 * it avoids dirtying the cacheline if the queue is already active.
> +	 */
>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>  		struct request_queue *q = hctx->queue;
>  
> -		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
>  			return;
> -		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
>  	} else {
> -		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
> +		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>  			return;
> -		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
>  	}
>  
>  	users = atomic_inc_return(&hctx->tags->active_queues);

-- 
Damien Le Moal
Western Digital Research

