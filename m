Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E1EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiA1NhR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:37:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41462 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbiA1NhR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:37:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A5D0210FE;
        Fri, 28 Jan 2022 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643377036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2Orx8M56qagGVRT1wgFs8rGF36BYpo4SlZHgPVm2Bs=;
        b=ruMzIjvvDxT0iqyTmn0IPyKaWCZoUfQSxHGaevEUh2AZSLxqHSpPlpDJJD6697IF6OTakn
        b702809X60ACWkeIt0nrCixnnNj+ewTrxgbfkhqoDpP16prfQs2Qz+d97qWGmT0pBhKTFY
        X9BL84Z7GxySf3imeliJ9LytP78Jbgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643377036;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2Orx8M56qagGVRT1wgFs8rGF36BYpo4SlZHgPVm2Bs=;
        b=4XKT/va5YEe9SrhNniGYq3L/rr2H17K1csIVvx+Beym8pGE50ecFeLraT3S79TRSeF2En/
        dkmmYXcbMrtQpCDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC970A3B92;
        Fri, 28 Jan 2022 13:37:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BB4E4A05A4; Fri, 28 Jan 2022 14:37:15 +0100 (CET)
Date:   Fri, 28 Jan 2022 14:37:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 4/8] loop: only take lo_mutex for the last reference in
 lo_release
Message-ID: <20220128133715.7cpnjt7f5v7wotg2@quack3.lan>
References: <20220128130022.1750906-1-hch@lst.de>
 <20220128130022.1750906-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128130022.1750906-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 28-01-22 14:00:18, Christoph Hellwig wrote:
> lo_refcnt is only incremented in lo_open and decremented in lo_release,
> and thus protected by open_mutex.  Only take lo_mutex when lo_release
> actually takes action for the final release.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d3a7f281ce1b6..b58dc95f80d96 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1740,10 +1740,14 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct loop_device *lo = disk->private_data;
>  
> -	mutex_lock(&lo->lo_mutex);
> -	if (atomic_dec_return(&lo->lo_refcnt))
> -		goto out_unlock;
> +	/*
> +	 * Note: this requires disk->open_mutex to protect against races
> +	 * with lo_open.
> +	 */
> +	if (!atomic_dec_and_test(&lo->lo_refcnt))
> +		return;
>  
> +	mutex_lock(&lo->lo_mutex);
>  	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
>  		if (lo->lo_state != Lo_bound)
>  			goto out_unlock;
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
