Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76119C433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiA1NiB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:38:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41502 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348829AbiA1NiB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:38:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7389F212B6;
        Fri, 28 Jan 2022 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643377080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p14uLMbcqMcWjcLH5TQCeRME7n0cE2dEr7vOnIFxtB4=;
        b=OL6pKLGQ84EojgIXLYIgUOh6c+SRzrNnwJwtYqmsitxKGpCOgeJEcRqjqecsJRk/17U/jL
        mqECq8lGlQFnjWpdWs7lV3F0EirQwmvSFgrXotKXJN2AggEK5Lo3djzsUyvpx0ESaqwgAn
        WbLzbb5+Y78galkMZlSU1pgPhEelZ0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643377080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p14uLMbcqMcWjcLH5TQCeRME7n0cE2dEr7vOnIFxtB4=;
        b=RKgk+eSOi4tgMx8w6VLFwTJZFWwB6B71hge/T1s+uf9XnR0pkeipl9HOBQUnkrKCh9ZOR6
        rNwFdWlhJwOGbcCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64AB9A3B81;
        Fri, 28 Jan 2022 13:38:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 32695A05A4; Fri, 28 Jan 2022 14:38:00 +0100 (CET)
Date:   Fri, 28 Jan 2022 14:38:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 5/8] loop: only take lo_mutex for the first reference in
 lo_open
Message-ID: <20220128133800.ylms4h4j4n4wawrq@quack3.lan>
References: <20220128130022.1750906-1-hch@lst.de>
 <20220128130022.1750906-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128130022.1750906-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 28-01-22 14:00:19, Christoph Hellwig wrote:
> lo_refcnt is only incremented in lo_open and decremented in lo_release,
> and thus protected by open_mutex.  Only take lo_mutex when lo_open is
> called the first time, as only for the first open there is any affect
> on the driver state (incremental opens on partitions don't end up in
> lo_open at all already).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index b58dc95f80d96..f349ddfc0e84a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1725,13 +1725,20 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
>  	struct loop_device *lo = bdev->bd_disk->private_data;
>  	int err;
>  
> +	/*
> +	 * Note: this requires disk->open_mutex to protect against races
> +	 * with lo_release.
> +	 */
> +	if (atomic_inc_return(&lo->lo_refcnt) > 1)
> +		return 0;
> +
>  	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)
>  		return err;
> -	if (lo->lo_state == Lo_deleting)
> +	if (lo->lo_state == Lo_deleting) {
> +		atomic_dec(&lo->lo_refcnt);
>  		err = -ENXIO;
> -	else
> -		atomic_inc(&lo->lo_refcnt);
> +	}
>  	mutex_unlock(&lo->lo_mutex);
>  	return err;
>  }
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
