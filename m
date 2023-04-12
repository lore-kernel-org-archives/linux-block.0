Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E4EC7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjDLHYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDLHYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:24:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52ED30CB
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 552F262E42
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1C8C433D2;
        Wed, 12 Apr 2023 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681284271;
        bh=3iT3ajF9lVqQJ4gKrUo2RuMnNZAQGRImp6CH21L+cCg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c1F793sR6iJuhECBtxO/CGPH66bZK55eVju4HAbKPMPa4oIr1+sys6U+ho8xGo1m9
         wcom3t2fyUbbOv8Li0fQTvRjVAKgRqxfsbdIXoWJ5WMIhTGnXSbMza8U9Tj7tZIZMF
         fBKAzR1pTt7VUFsRtyP4t8gvihmJw1DO7LyK55jec2kNLMkaSs9p/S94PHZWzPR2VS
         hcMH5OT8l4Nsjl4R9RIW2JEKLgiV32x1l0cOpWU3e6JujoVif6ucIWi0vrRP0sxgHR
         tLVxWWI6PNG1Lx4bsG4dFYvhp5itlq6p4F1kEX/ZRu2+5eVu2gfMms8iBbqUJ+gTzp
         1K5ka/sbCUpCA==
Message-ID: <9a79c973-6ccb-7e6d-58f8-50a77e03d921@kernel.org>
Date:   Wed, 12 Apr 2023 16:24:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 11/18] blk-mq: refactor the DONTPREP/SOFTBARRIER andling
 in blk_mq_requeue_work
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-12-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Split the RQF_DONTPREP and RQF_SOFTBARRIER in separate branches to make
> the code more readable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c3de03217f4f1a..5dfb927d1b9145 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1427,20 +1427,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
>  	spin_unlock_irq(&q->requeue_lock);
>  
>  	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
> -		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
> -			continue;
> -
> -		rq->rq_flags &= ~RQF_SOFTBARRIER;
> -		list_del_init(&rq->queuelist);
>  		/*
>  		 * If RQF_DONTPREP, rq has contained some driver specific

Nit: while at it, you could fix the bad english here:

rq has contained som... -> rq has some...

Otherwise looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


