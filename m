Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDFFC27C7C
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 16:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjATQLq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjATQLq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 11:11:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C5233F4
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 08:11:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93D18CE294D
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 16:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C57C433D2;
        Fri, 20 Jan 2023 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674231101;
        bh=vGzuCuVFWpNpunlC5oBX0JstWy3X+YzLybXlD30vLB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwQf8/WeBFmedr2MX57iF3OUrCeqvwLi7wMQDmIE5ypCXPXJOwTFEmkNbx0w89UEp
         GHArpSGHiGNaQOcu2F+SlESOxuwJcJv2O901YgZlZdNaAiDfR9pzFAIjnt9QsY0bn/
         0XYjzrm7PT97xAwRgVdmSnxAGl6S6eBa8gtOZb82y/R0FfbTCYsYTV4DcZIHi1NDhq
         VwfwLUR1eEcFM9SvWVSymqXMbM/+Wr2jDuNwUC21wCuUhtJTIRcr56wHkCxnfgCRXb
         8DLH0lasKMWAe7NZLpZKE5fUGpSzXnGtGrCie6Hrm/cOBA7plJuzhgecCYatSqgC06
         OpClbNt6zmWXg==
Date:   Fri, 20 Jan 2023 09:11:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: treat poll queue enter similarly to timeouts
Message-ID: <Y8q9OvUjPxSzif/j@kbusch-mbp>
References: <9590debc-ce87-f044-b687-59b551c24219@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9590debc-ce87-f044-b687-59b551c24219@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 20, 2023 at 07:59:34AM -0700, Jens Axboe wrote:
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -869,7 +869,16 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
>  	 */
>  	blk_flush_plug(current->plug, false);
>  
> -	if (bio_queue_enter(bio))
> +	/*
> +	 * We need to be able to enter a frozen queue, similar to how
> +	 * timeouts also need to do that. If that is blocked, then we can
> +	 * have pending IO when a queue freeze is started, and then the
> +	 * wait for the freeze to finish will wait for polled requests to
> +	 * timeout as the poller is preventer from entering the queue and
> +	 * completing them. As long as we prevent new IO from being queued,
> +	 * that should be all that matters.
> +	 */
> +	if (!percpu_ref_tryget(&q->q_usage_counter))
>  		return 0;
>  	if (queue_is_mq(q)) {
>  		ret = blk_mq_poll(q, cookie, iob, flags);


Looks good!

Reviewed-by: Keith Busch <kbusch@kernel.org>
