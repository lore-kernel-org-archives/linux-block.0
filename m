Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9952EC77B70
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 06:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDQG3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDQG3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCBAA6
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BEA561E54
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C583C433D2;
        Mon, 17 Apr 2023 06:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681712990;
        bh=UsOEtOgCGqfJW+ixnTRY3WrqSTasWYgGAz0XHUWpPnI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZEjV4J53p0gt2zBgWEepAtTafabhwOVGzS7B9xsHPRWQeb57GOUAUnePDEgFybkF/
         lbHY+m37wi9+oeLA3/hL7fL5YDhyj1AhwXUZsoL36Iv//f/H180abBU3Aqadr2Ec26
         L5IV0eY5MDcdax/XMML3aOsB5ZMpvZAUBaZIlOHGpnuZwtkU5cdlMK4t3t71EJkIE/
         1mU3bwyUOnGibV5/0Z1Ge5vLE19xEN9VPTg+DI42SQXB6ZM+GzLYbC8e77vjyXnsnH
         qG7qxUgamIaziZ8E9MznqQmp9RjhVfUb4u22c0MzlvOG7bwZ6appHC3Ipsb9GlTae8
         fIgQKOQJWs2dw==
Message-ID: <f6b64c7e-7d39-bf63-b1df-1f2b4a337a1e@kernel.org>
Date:   Mon, 17 Apr 2023 15:29:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/7] blk-mq: reflow blk_insert_flush
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-3-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230416200930.29542-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/23 05:09, Christoph Hellwig wrote:
> Use a switch statement to decide on the disposition of a flush request
> instead of multiple if statements, out of which one does checks that are
> more complex than required.  Also warn on a malformed request early
> on instead of doing a BUG_ON later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One nit below, but looks OK overall.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-flush.c | 53 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 422a6d5446d1c5..9fcfee7394f27d 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -402,6 +402,9 @@ void blk_insert_flush(struct request *rq)
>  	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
> +	/* FLUSH/FUA request must never be merged */
> +	WARN_ON_ONCE(rq->bio != rq->biotail);

This could be:

	if (WARN_ON_ONCE(rq->bio != rq->biotail)) {
		blk_mq_end_request(rq, BLK_STS_IOERR);
 		return;
	}

To avoid an oops on the malformed request later on ?


