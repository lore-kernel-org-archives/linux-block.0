Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F98C433F5
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 10:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiEWKBJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 06:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiEWKAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 06:00:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9913565A6
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 03:00:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0B4991F8B8;
        Mon, 23 May 2022 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653300051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kjclq8HZk0uCZwVJjzDySbZDXmr+RzvN2W0O503t8EQ=;
        b=EqJZfLsrLA8Z1Y3fozFwk8s3pXckHQ28g6jfTEzvhwumDHse11V4zoAFr7P93IpkCOkb2x
        AIoer0ZxDw1OUNZERV0y6+ts/kv4a4XpfQuSIx5AeEekh8vG8EM20g/j1yW2oClIdW+ibx
        2F/q+lc6Ez4CddqUnF3m341BuFCvJPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653300051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kjclq8HZk0uCZwVJjzDySbZDXmr+RzvN2W0O503t8EQ=;
        b=NdIk+lnRpMAfECz4Hyglg6cEdLGcUI/OZYRXlbJ/ruTK+il3mx2Hdq+tLAbK74d8ZMDNcz
        5HR6pIjzDmRMgEBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ECD182C141;
        Mon, 23 May 2022 10:00:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6017CA0632; Mon, 23 May 2022 12:00:50 +0200 (CEST)
Date:   Mon, 23 May 2022 12:00:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] blk-mq: don't touch ->tagset in blk_mq_get_sq_hctx
Message-ID: <20220523100050.dlyzg6fjmveyxmpl@quack3.lan>
References: <20220522122350.743103-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522122350.743103-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun 22-05-22 20:23:50, Ming Lei wrote:
> blk_mq_run_hw_queues() could be run when there isn't queued request and
> after queue is cleaned up, at that time tagset is freed, because tagset
> lifetime is covered by driver, and often freed after blk_cleanup_queue()
> returns.
> 
> So don't touch ->tagset for figuring out current default hctx by the mapping
> built in request queue, so use-after-free on tagset can be avoided. Meantime
> this way should be fast than retrieving mapping from tagset.
> 
> Cc: "yukuai (C)" <yukuai3@huawei.com>
> Cc: Jan Kara <jack@suse.cz>
> Fixes: b6e68ee82585 ("blk-mq: Improve performance of non-mq IO schedulers with multiple HW queues")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thanks! This indeed looks better. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-mq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ed1869a305c4..5789e971ac83 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2174,8 +2174,7 @@ static bool blk_mq_has_sqsched(struct request_queue *q)
>   */
>  static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -
> +	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
>  	/*
>  	 * If the IO scheduler does not respect hardware queues when
>  	 * dispatching, we just don't bother with multiple HW queues and
> @@ -2183,8 +2182,8 @@ static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
>  	 * just causes lock contention inside the scheduler and pointless cache
>  	 * bouncing.
>  	 */
> -	hctx = blk_mq_map_queue_type(q, HCTX_TYPE_DEFAULT,
> -				     raw_smp_processor_id());
> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, 0, ctx);
> +
>  	if (!blk_mq_hctx_stopped(hctx))
>  		return hctx;
>  	return NULL;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
