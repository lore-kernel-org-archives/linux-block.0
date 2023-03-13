Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD5C6FD19
	for <linux-block@archiver.kernel.org>; Mon, 13 Mar 2023 16:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCMQux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCMQuo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 12:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA37C9C5
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 09:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3C666135A
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 16:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1012C433EF;
        Mon, 13 Mar 2023 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678726213;
        bh=2hGobYbIxdPT7KHsB4X4fUDeTA65yEk6Jxe0NBXzhbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYs/6VLKULVX9QcG3i2+2EFsx4h9aVvfw0BX5PvRFzY1aeAgB2Ht7WQOyaIqbVT9s
         u7tRFZJiGqrvpNio+ybjwreVAjQai/S6aI41x0Vcu0/2/MEg3coatjIyAXDDuFoEn9
         UOKpoc1vSbf4//BbjoGIfho7b93ljiPKrtZtapAZAfsc2dc6aI77kzNlSZUhEt1tTc
         +NayBs/y6zxlYufyKhjWjIu0dSorDeG5nf4hQ7QUoBUmrDgIlcsMhZeyUOMceqU72J
         LF698YLE/hUaD3/LFUQUPBt+FNwv4svREWG2aqF5m48QOoFpRWB5drk7k9gzd8cEhJ
         VlzLbhblpO+vQ==
Date:   Mon, 13 Mar 2023 10:50:10 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: execute complete callback for fake timeout
 request
Message-ID: <ZA9UQgy/wy03xQ1j@kbusch-mbp.dhcp.thefacebook.com>
References: <20230312123556.12298-1-akinobu.mita@gmail.com>
 <49cfce8b-042e-7248-928f-4a5c5f7d0e31@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cfce8b-042e-7248-928f-4a5c5f7d0e31@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 13, 2023 at 10:00:30AM +0900, Damien Le Moal wrote:
> On 3/12/23 21:35, Akinobu Mita wrote:
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 4c601ca9552a..52d689aa3171 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1413,7 +1413,7 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
>         case NULL_IRQ_SOFTIRQ:
>                 switch (cmd->nq->dev->queue_mode) {
>                 case NULL_Q_MQ:
> -                       if (likely(!blk_should_fake_timeout(cmd->rq->q)))
> +                       if (!cmd->fake_timeout)
>                                 blk_mq_complete_request(cmd->rq);

I think you can remove the fake_timeout check from here now since this function
is never called when it's true.

>                         break;
>                 case NULL_Q_BIO:
> @@ -1675,7 +1675,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>         cmd->rq = bd->rq;
>         cmd->error = BLK_STS_OK;
>         cmd->nq = nq;
> -       cmd->fake_timeout = should_timeout_request(bd->rq);
> +       cmd->fake_timeout = should_timeout_request(bd->rq) ||
> +               blk_should_fake_timeout(bd->rq->q);
> 
>         blk_mq_start_request(bd->rq);
