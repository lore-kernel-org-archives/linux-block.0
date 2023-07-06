Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EDEB64D9
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 23:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGFXnV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 19:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXnU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 19:43:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B21BE8
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 16:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C608614B6
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 23:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A336C433C7;
        Thu,  6 Jul 2023 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688686998;
        bh=ZWd1xLBAcYrd4hpEx1DnxoM6LlS9imE///WFwTjQQAI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fLFHFasWq91ickOQfAPPbdyrCcaHi8dEp56SDfnKXIOszRxVAPpnRvfFAtXKXsJJA
         GGkYkhR1kjXqVOLHJT7BJI9Fix/JvlXoEoPZc9S8mrd3Wwv6y6E7PqAu/p0xyBo6NZ
         N773NbxBfAB/qT98VLu2e4l4zyZ+XxssHnUhKrd3mqFqSmnFiUmK/1NMLZob3NcXJT
         Lxv35LeBDuwxAh4OKP8D32tdkRn0QzeMcyFk595Ad8zSNWH9DXoxhrYdJvoUAnVVL2
         Xu6l1edV9+6D7hO4lAZfVeI58ceU33IuX1+q+4CS3hubBxiUzW8mxNK63Jh1Nascl9
         yOzURYkHBJncw==
Message-ID: <4c6be788-0b13-6c96-fd35-ba18833b2c35@kernel.org>
Date:   Fri, 7 Jul 2023 08:43:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Do not merge if merging is disabled
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20230706201433.3987617-1-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230706201433.3987617-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/23 05:14, Bart Van Assche wrote:
> While testing the performance impact of zoned write pipelining, I
> noticed that merging happens even if merging has been disabled via
> sysfs. Fix this.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-mq-sched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 67c95f31b15b..8883721f419a 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -375,7 +375,8 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
>  bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
>  				   struct list_head *free)
>  {
> -	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq, free);
> +	return !blk_queue_nomerges(q) && rq_mergeable(rq) &&
> +		elv_attempt_insert_merge(q, rq, free);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>  

-- 
Damien Le Moal
Western Digital Research

