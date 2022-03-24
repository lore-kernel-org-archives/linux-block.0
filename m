Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E42C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 13:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350366AbiCXNRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346345AbiCXNRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 09:17:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F705D5D9
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 06:15:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3E6BF210DC;
        Thu, 24 Mar 2022 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648127748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUb3QM5quNjZzhk9pi8FXbHKm8Oez4fkcBfiqy2RXkY=;
        b=vXX5hIIcpacWDgh6jmNReSzi9ShGpQv2cfnfSUXxqM2upV6Nq/JrLmWWmoU9XoXqGgtDxu
        EpE4Kq35fn1+O3TD0BVrXNtLA3Q9kRE75BSKsshSPsNu55xiupDq17fZ/l8CRvHtjxV6sm
        WuNbVqu+BPMQrkcsFdQAJrmGQxMJCpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648127748;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUb3QM5quNjZzhk9pi8FXbHKm8Oez4fkcBfiqy2RXkY=;
        b=J8Sqs+dMC0HJg0YHGW7vvcym64g2Gnqf4MBAMg4spx976X6zUMx2eI4rZJFEDoQ8V4Opqf
        q3QK+MzoVi4a0hAg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2A290A3B99;
        Thu, 24 Mar 2022 13:15:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CC153A0610; Thu, 24 Mar 2022 14:15:47 +0100 (CET)
Date:   Thu, 24 Mar 2022 14:15:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 03/13] zram: cleanup zram_remove
Message-ID: <20220324131547.btqbrcf4ynlunhj4@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324075119.1556334-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 24-03-22 08:51:09, Christoph Hellwig wrote:
> Remove the bdev variable and just use the gendisk pointed to by the
> zram_device directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/zram/zram_drv.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fd83fad59beb1..863606f1722b1 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1987,19 +1987,18 @@ static int zram_add(void)
>  
>  static int zram_remove(struct zram *zram)
>  {
> -	struct block_device *bdev = zram->disk->part0;
>  	bool claimed;
>  
> -	mutex_lock(&bdev->bd_disk->open_mutex);
> -	if (bdev->bd_openers) {
> -		mutex_unlock(&bdev->bd_disk->open_mutex);
> +	mutex_lock(&zram->disk->open_mutex);
> +	if (zram->disk->part0->bd_openers) {
> +		mutex_unlock(&zram->disk->open_mutex);
>  		return -EBUSY;
>  	}
>  
>  	claimed = zram->claim;
>  	if (!claimed)
>  		zram->claim = true;
> -	mutex_unlock(&bdev->bd_disk->open_mutex);
> +	mutex_unlock(&zram->disk->open_mutex);
>  
>  	zram_debugfs_unregister(zram);
>  
> @@ -2011,7 +2010,7 @@ static int zram_remove(struct zram *zram)
>  		;
>  	} else {
>  		/* Make sure all the pending I/O are finished */
> -		sync_blockdev(bdev);
> +		sync_blockdev(zram->disk->part0);
>  		zram_reset_device(zram);
>  	}
>  
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
