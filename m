Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4D8C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 06:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDLGzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLGzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 02:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A442D49
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 23:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02A64629DC
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 06:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F88C433D2;
        Wed, 12 Apr 2023 06:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681282541;
        bh=ke2O0W/rDbFp9swY5bdJd7u9y2NDXxXxQcj9hYLUOWM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UxX3CAK7d/jnkeWyvgTncl1YMFOK4BwNjR9NXypQ6mSHT8M36kIXk+b4BvQYFJMck
         TS/Nfcp2OSWlgg270ni47AeXP1j2N0+JAFPCbhWOcbiiEdrXnlABcIV0y5IfjS9kKe
         f7MRJdJiraTfQ0rF7vHdtDptZzbLcVNknbHIJcQgmiM3uiTiHZt2tUICn1agYPuUue
         2Ib1Jlnno0oJuTYlok2z/QSXagi29MDjwddR+Uw1rEmLidDyycWolZoRHSUEwMYGnb
         OsfgDKR/F3fQtFSzsyTCn49r/KLImfVZYPOiUi3WFK+fZhwR6+foRxTGvZtQxprPGL
         cR+v+xOWBi3hw==
Message-ID: <7491bd80-1a66-791a-f38d-496bd9b97304@kernel.org>
Date:   Wed, 12 Apr 2023 15:55:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/18] blk-mq: don't plug for head insertions in
 blk_execute_rq_nowait
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-2-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Plugs never insert at head, so don't plug for head insertions.
> 
> Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 52f8e0099c7f4b..7908d19f140815 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1299,7 +1299,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
>  	 * device, directly accessing the plug instead of using blk_mq_plug()
>  	 * should not have any consequences.
>  	 */
> -	if (current->plug)
> +	if (current->plug && !at_head)
>  		blk_add_rq_to_plug(current->plug, rq);
>  	else
>  		blk_mq_sched_insert_request(rq, at_head, true, false);

