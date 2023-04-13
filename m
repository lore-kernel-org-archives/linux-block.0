Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3AC77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDMGyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMGyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94397ECF
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E36C6393F
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E841C433D2;
        Thu, 13 Apr 2023 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681368873;
        bh=whMRQuc2AFNJEaLVG4chXRPvu1VMARX2IyfpVUhW1BE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jLgI9OvY6tbWBZOPD3898YJQh7Rr0KUxAsF2rWjgHsqpIBoNNvIV+v5CFvRbV/wKl
         wxPI0Ipf0n3Wq6GhUb/yFnpHHs/0J48KDWAT0SWsH4BigLX70D2Y8JHDoGhKutvWBU
         Xw372yIn466fQ/49H564gHGMeU6h9gatRJM0JmWjD/R/JV8xyHLW6imaoKyBPXSkEV
         88TUPPhbcRLxanwO1UCsXIuWWtijQyEFImZuvmCVBHU/FaybYRBxN6CXSwLutzkJ82
         IwOUjbeJoeZIZgoBm1tyjHSRtpewjI2WF5Ey0qz2ck4bHscltrwdJ1ZRX6TtzAWc3W
         fA6XDwpIbe76w==
Message-ID: <1f06dd70-bf06-2983-f9fd-5875a8f5d20d@kernel.org>
Date:   Thu, 13 Apr 2023 15:54:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 16/20] blk-mq: don't kick the requeue_list in
 blk_mq_add_to_requeue_list
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230413064057.707578-1-hch@lst.de>
 <20230413064057.707578-17-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413064057.707578-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 15:40, Christoph Hellwig wrote:
> blk_mq_add_to_requeue_list takes a bool parameter to control how to kick
> the requeue list at the end of the function.  Move the call to
> blk_mq_kick_requeue_list to the callers that want it instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One nit below. Looks good otherwise.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cde7ba9c39bf6b..db806c1a194c7b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1412,12 +1412,17 @@ static void __blk_mq_requeue_request(struct request *rq)
>  
>  void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
>  {
> +	struct request_queue *q = rq->q;

Nit: not really needed given that it is used in one place only.
You could just call "blk_mq_kick_requeue_list(rq->q)" below.

> +
>  	__blk_mq_requeue_request(rq);
>  
>  	/* this request will be re-inserted to io scheduler queue */
>  	blk_mq_sched_requeue_request(rq);
>  
> -	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
> +	blk_mq_add_to_requeue_list(rq, true);
> +
> +	if (kick_requeue_list)
> +		blk_mq_kick_requeue_list(q);
>  }
>  EXPORT_SYMBOL(blk_mq_requeue_request);


