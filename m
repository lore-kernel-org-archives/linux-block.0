Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB0C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 07:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDJHy5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDJHy4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 03:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09707E9
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 00:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF9F60FF1
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 07:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED56EC433D2;
        Mon, 10 Apr 2023 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681113295;
        bh=SGqdb7d67NdFMf5PGXfQep+0K2zV7FpJt4ISzdkdjzY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YADETasFRabTlqJ220ZvlhilhwoyBHAN2XDS9UAy/pO1Hd+Ll9tigK+8a0YdOUm3t
         AFJvohAca7vndhxcoqnejq5aLz+ljU0CzicuNyaL3ZUhvO9R/MfolWhPSgSTAMnc2c
         2LcYYOPcKKcj2bQ0BBc7x3W/lhN6VbLtrPBAQzjubMpJ0MYu+/1N/u83jg2hqCZ+jL
         Uw/LEvWNMYbPxvMJKqUniz35Tod2GEY3QOAnLLFyDiloWmUbFxAqFoREPnEyjJjaQG
         QnanjZkEAeXfDaZHDbAkrX1XWwmYbYBBwftrg8HFPj0Jq02uwhhQv9jM7gxbpdHK25
         keUvUm6xyrYMw==
Message-ID: <c4bfbf67-f193-fa3a-3518-2fe5c36a5fd9@kernel.org>
Date:   Mon, 10 Apr 2023 16:54:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 04/12] block: Requeue requests if a CPU is unplugged
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-5-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Requeue requests instead of sending these to the dispatch list if a CPU
> is unplugged to prevent reordering of zoned writes.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-mq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 57315395434b..77fdaed4e074 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3495,9 +3495,17 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  	if (list_empty(&tmp))
>  		return 0;
>  
> -	spin_lock(&hctx->lock);
> -	list_splice_tail_init(&tmp, &hctx->dispatch);
> -	spin_unlock(&hctx->lock);
> +	if (hctx->queue->elevator) {
> +		struct request *rq, *next;
> +
> +		list_for_each_entry_safe(rq, next, &tmp, queuelist)
> +			blk_mq_requeue_request(rq, false);
> +		blk_mq_kick_requeue_list(hctx->queue);
> +	} else {
> +		spin_lock(&hctx->lock);
> +		list_splice_tail_init(&tmp, &hctx->dispatch);
> +		spin_unlock(&hctx->lock);
> +	}
>  
>  	blk_mq_run_hw_queue(hctx, true);
>  	return 0;

