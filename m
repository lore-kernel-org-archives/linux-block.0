Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B35DC4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EED60EB5
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhGWQqQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhGWQqQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 12:46:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60A2F60EB1;
        Fri, 23 Jul 2021 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627061209;
        bh=61tmtz2gl+/5WsyTpX2fSMaphxwIAinFjgKGpsgLcgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qee8qdlwQxL4Dxje6UNCbGFj2WAGRxHe7xDwZKt9buwUuexQy2KhFFowzVEvIHZk/
         gJ9eylrCtwCM85E0jVwV2ubesI2pSRQAPpqdZ0VY7Ygf7qa0arpoVRSssdFTQDefgR
         v8k6Ll2XfV/xLNWyM+IQKhLC2vWLGYIt62A4dXO22PhyIE8QdEauPXEo0zmTVg0MUd
         Rk+BPOsuqvelku8EhxLQ/a4eicOpV9xE6RnuNQR/bqwAt2s5LnVFHdvnXbJWGBHLgr
         eckzX+2UWnQGvlamdQN5G/zDXZN5/vYYx3eftT/4L3QbUjlXB7qAq89B0wRaJAIvCE
         lL/3QvmIG20mw==
Date:   Fri, 23 Jul 2021 10:26:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v4 7/9] dm: handle error from blk_ksm_register()
Message-ID: <YPr71wM9IFdWY9FK@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <20210707052943.3960-8-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-8-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:41PM -0700, Satya Tangirala wrote:
> From: Satya Tangirala <satyat@google.com>
> 
> Handle any error from blk_ksm_register() in the callers. Previously,
> the callers ignored the return value because blk_ksm_register() wouldn't
> fail as long as the request_queue didn't have integrity support too, but
> as this is no longer the case, it's safer for the callers to just handle
> the return value appropriately.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/md/dm-table.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 29cbfc3e3c4b..c79c0fbe80dd 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1343,6 +1343,20 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
>  	 */
>  	t->ksm = ksm;
>  
> +	/*
> +	 * At this point, t->ksm is either NULL or *not* empty (i.e. will support
> +	 * at least 1 crypto capability), the request queue doesn't support
> +	 * integrity, and it also satisfies all the block layer constraints
> +	 * "sufficiently" (as in the constraints of the DM device's request queue
> +	 * won't preclude any of the intersection of the supported capabilities
> +	 * of the underlying devices, since if some capability were precluded by
> +	 * the DM device's request queue's constraints, that capability would
> +	 * also have been precluded by one of the child device's request queues).
> +	 *
> +	 * Hence any future attempt to call blk_ksm_register() on t->ksm (if it's
> +	 * not NULL) will succeed.
> +	 */
> +
>  	return 0;

I don't think this properly answers the question I had on the previous version
of this patch, which was not just how we know that blk_ksm_register() will
succeed later, but also how we know that the blk_ksm_is_superset() check done
above is valid when some of the crypto capabilities may be cleared by
blk_ksm_register() later.  Is the assumption actually that in the device-mapper
case, blk_ksm_register() will never clear any crypto capabilities at all?
If so, can that be explained properly?

- Eric
