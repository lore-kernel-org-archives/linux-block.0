Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5218C77B76
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 06:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDQGrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDQGrA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3331729
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4603761017
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056F3C433EF;
        Mon, 17 Apr 2023 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681714017;
        bh=GNVwPiyxbmjO5NcnnW1gR1INAkLW1gDfyu6xBD17pP8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fSIjR3MF7WUJK6HrX2Vv0uZd+7zhj5XrEdSkxXCqMD/Neep1Z3jJQsfE7dz3BydbG
         z6papYPvx1lXQrOqWCcD/zvSVcRLPlZrYQdMwLnp+O2ZOtzZkSKQwDPhAFSW9aKvvQ
         KoKGoRmwRXCq2EbcAwz4L4rEb2gTUqSxyjOlAgPA1SNEnbI+bcelQ1caP7E6VFM5rC
         tVql/2XZUhgfmulyE/diNX9Lsl9IKSD6oM+B9RgsoA/P1YHh7oGUgdBmGsQ+ULxmdp
         dn1YPe03LIedGxGuQAOmE7LVVdlnc1LcE9Q+vvJ6FC6deRQ0DsaNPjXTz5VIAm8SZ2
         L2e1mHdzbY1tg==
Message-ID: <8c835175-1c12-4d9b-a2a4-ed1377a5645b@kernel.org>
Date:   Mon, 17 Apr 2023 15:46:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-8-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230416200930.29542-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/23 05:09, Christoph Hellwig wrote:
> Currently both requeues of commands that were already sent to the
> driver and flush commands submitted from the flush state machine
> share the same requeue_list struct request_queue, despite requeues
> doing head insertations and flushes not.  Switch to using two
> separate lists instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-flush.c      |  9 +++++++--
>  block/blk-mq-debugfs.c |  1 -
>  block/blk-mq.c         | 36 +++++++++++++++---------------------
>  block/blk-mq.h         |  1 -
>  include/linux/blk-mq.h |  4 +---
>  include/linux/blkdev.h |  1 +
>  6 files changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 69e9806f575455..231d3780e74ad1 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -188,7 +188,9 @@ static void blk_flush_complete_seq(struct request *rq,
>  
>  	case REQ_FSEQ_DATA:
>  		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
> -		blk_mq_add_to_requeue_list(rq, 0);
> +		spin_lock(&q->requeue_lock);
> +		list_add_tail(&rq->queuelist, &q->flush_list);
> +		spin_unlock(&q->requeue_lock);
>  		blk_mq_kick_requeue_list(q);

With this change, this function name is a little misleading... But I do not have
a better name to propose :)


