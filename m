Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A3DC4708C
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB25610FA
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhE1M2M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 08:28:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234668AbhE1M2I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 08:28:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622204792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1XjWXhgbzdRPj0RShc011BFnLv4BM2eN559Oijo3E0g=;
        b=SJ5Ccc8Sr8Cj4WoqOEN2SSvWyG3GmdEwtJrFa4SRay+9c0u2Xle+5qe//7fBy/5KTP/N1/
        Ruqna0CDY1xupyc+qYv64YBZjTGAfdA3dC7PVehCH9JWVBkUykIMSQ/m8DK+R3ltPeUu1E
        t3brz/bWT9y1/rbr0QSu1FSJ6BH6u9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622204792;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1XjWXhgbzdRPj0RShc011BFnLv4BM2eN559Oijo3E0g=;
        b=3nTq7UlxhtA61RpA8sWiZE6a9C+QKkXe2GwnyTjf8l6OpLZAj5wemLszfNQspbfSr/E8fy
        IBsvFE0r2XgvWrCQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A8E7B14E;
        Fri, 28 May 2021 12:26:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C86441E0D30; Fri, 28 May 2021 14:26:31 +0200 (CEST)
Date:   Fri, 28 May 2021 14:26:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] blk-mq: update hctx->dispatch_busy in case of real
 scheduler
Message-ID: <20210528122631.GA28653@quack2.suse.cz>
References: <20210528032055.2242080-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528032055.2242080-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 28-05-21 11:20:55, Ming Lei wrote:
> Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> starts to support io batching submission by using hctx->dispatch_busy.
> 
> However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
> in that commit, so fix the issue by updating hctx->dispatch_busy in case
> of real scheduler.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 3 ---
>  1 file changed, 3 deletions(-)

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW: Do you plan to submit also your improvement to
__blk_mq_do_dispatch_sched() to update dispatch_busy during the fetching
requests from the scheduler to avoid draining all requests from the IO
scheduler?

								Honza
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f11d4018ce2e..4930f7119f22 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1224,9 +1224,6 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
>  {
>  	unsigned int ewma;
>  
> -	if (hctx->queue->elevator)
> -		return;
> -
>  	ewma = hctx->dispatch_busy;
>  
>  	if (!ewma && !busy)
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
