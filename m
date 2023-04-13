Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1321C77B78
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDMGZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDMGZC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAB77EF1
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88EAB63B65
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DE6C4339B;
        Thu, 13 Apr 2023 06:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681367096;
        bh=zcGFmsUViHGVY9sKSUfX0aVGbAjt0eMjV2+Jc+bu2CI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IHL4QynFNJzGeg1sp4ZrSDMhoi2c4EmlekzFk9xJExitWuo8Og25n4Qi6wg2dCePZ
         gVXgA6YGc5/JjbzuTNbD3/0saHmKXz1X/aIVdBMlE0HF/n8wYJnTwcBdlExGip559h
         nN21qNieumqsyulpBfiNZVBBSC79foZyoX933wc2e6vVkT/DvbVgLlGr0m1k5obDkN
         q5OPcNNmVm+PW1zuGJMEcrVJMuZNbGMpIhg3KXn4p/5S78E0LxdrPUdrMhZijK3AuB
         FpWGIlbJ743q/SzezjpN6K7oWDrLkIkIfiH8DWCkUMAFuHqDfbkGzqOcR1xLpvieMu
         Dnsps9Rpob8gw==
Message-ID: <891b4103-098b-9250-ac9e-83feb63e828f@kernel.org>
Date:   Thu, 13 Apr 2023 15:24:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/5] blk-mq: remove the blk_mq_hctx_stopped check in
 blk_mq_run_work_fn
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230413060651.694656-1-hch@lst.de>
 <20230413060651.694656-3-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413060651.694656-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 15:06, Christoph Hellwig wrote:
> blk_mq_hctx_stopped is alredy checked in blk_mq_sched_dispatch_requests
> under blk_mq_run_dispatch_ops() protetion, so remove the duplicate check.

s/protetion/protection

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-mq.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 52f8e0099c7f4b..5289a34e68b937 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2430,15 +2430,8 @@ EXPORT_SYMBOL(blk_mq_start_stopped_hw_queues);
>  
>  static void blk_mq_run_work_fn(struct work_struct *work)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -
> -	hctx = container_of(work, struct blk_mq_hw_ctx, run_work.work);
> -
> -	/*
> -	 * If we are stopped, don't run the queue.
> -	 */
> -	if (blk_mq_hctx_stopped(hctx))
> -		return;
> +	struct blk_mq_hw_ctx *hctx =
> +		container_of(work, struct blk_mq_hw_ctx, run_work.work);
>  
>  	__blk_mq_run_hw_queue(hctx);
>  }

