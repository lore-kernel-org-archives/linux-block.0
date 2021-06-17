Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3DC48BE8
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 03:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C163F6135C
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 03:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhFQDZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 23:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhFQDZs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 23:25:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA33D613E2;
        Thu, 17 Jun 2021 03:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623900222;
        bh=IX9qu+dkkKQ9s2fm1vXelS2dY1wdgE08Sy0O+VjqIUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyaIazuPhTaq+/1jmDgtrIErvl9VQ32F+FzxG4z2tM3ES8rFwS0OGJK+6bM8Aw5y2
         OPsDJADG2JYRGJjlNjvQyoTYcrK/ckENnA8gFmf4POr8cB1JQbFbvQ3UDfD1Xorg47
         VQkOicOZ8YN+LG3OVO384z4zmgU3Cz0eslXh9NFaU5I+i3usQrQvMiFkKsHveeiay0
         on6tpXMc9fCC3IOnYByfi0qMVt1ePSI1zB05NQcSH1IVagGxwa5CufUZHhIdXMQdic
         3+0lJL94glJiSgKVa5/iMjKyO53vMXlEqWqslI0R1FqEMkIt4B0eNtvNlAevChYiH6
         LKP6lKPW1Sssg==
Date:   Wed, 16 Jun 2021 20:23:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 08/10] dm: handle error from blk_ksm_register()
Message-ID: <YMrAPGdcyx6NjU/H@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-9-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-9-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:58PM +0000, Satya Tangirala wrote:
> Handle any error from blk_ksm_register() in the callers. Previously,
> the callers ignored the return value because blk_ksm_register() wouldn't
> fail as long as the request_queue didn't have integrity support too, but
> as this is no longer the case, it's safer for the callers to just handle
> the return value appropriately.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/md/dm-table.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 29cbfc3e3c4b..e44f304b5c1a 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1354,7 +1354,21 @@ static void dm_update_keyslot_manager(struct request_queue *q,
>  
>  	/* Make the ksm less restrictive */
>  	if (!q->ksm) {
> -		blk_ksm_register(t->ksm, q);
> +		/*
> +		 * This WARN_ON should never trigger since t->ksm isn't be
> +		 * "empty" (i.e. will support at least 1 crypto capability), the
> +		 * request queue doesn't support integrity (since
> +		 * dm_table_construct_keyslot_manager() checks that), and
> +		 * it also satisfies all the block layer constraints
> +		 * "sufficiently" (as in the constraints of the DM device's
> +		 * request queue won't preclude any of the intersection of the
> +		 * supported capabilities of the underlying devices, since if
> +		 * some capability were precluded by the DM device's request
> +		 * queue's constraints, that capability would also have been
> +		 * precluded by one of the child device's request queues)
> +		 */
> +		if (WARN_ON(!blk_ksm_register(t->ksm, q)))
> +			dm_destroy_keyslot_manager(t->ksm);

This comment seems to be in the wrong place, as dm_update_keyslot_manager()
already assumes that the crypto capabilities are either staying the same or
expanding.  This isn't something new that this WARN_ON() introduces.

I think this explanation should go in dm_table_construct_keyslot_manager()
instead, as that is where the new set of crypto capabilities is built.
I.e. in dm_table_construct_keyslot_manager() we should explain how we "know"
that the new set will really be equal or greater.

- Eric
