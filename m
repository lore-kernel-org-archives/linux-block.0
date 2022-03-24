Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB1C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbiCXN0R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiCXN0Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 09:26:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E7AA7752
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 06:24:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0EE6A2129B;
        Thu, 24 Mar 2022 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648128283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCXzEhY4GrdGOJj6LkNB5lbicvXRMhJaAguRALYPKWA=;
        b=u5ehJoQWQq1yrgfO5FuzgXmXUleRMNT51D41a3JDAkkRz83QsHD3Z6E54w9zlzUw1XWx2Y
        2EJ+7FUKZKjkLcTICm1EMyClhIn6qLdwIRij684u3ARf8sIGweSXGdrDQjbzsgJ98eTbSm
        0R5HZr41cBLqHGeTLPhF2tUaY/BU/J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648128283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCXzEhY4GrdGOJj6LkNB5lbicvXRMhJaAguRALYPKWA=;
        b=0ej5Pr6kpsYGtWiPKLP5rDIcke/IP03QPL/yIRQtK8HRPlQbYWBudJIH65pHrFceofL8Ef
        pO0zC3zHOVLL2PAg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE97DA3B88;
        Thu, 24 Mar 2022 13:24:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8F97A0610; Thu, 24 Mar 2022 14:24:42 +0100 (CET)
Date:   Thu, 24 Mar 2022 14:24:42 +0100
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
Subject: Re: [PATCH 04/13] block: add a disk_openers helper
Message-ID: <20220324132442.xrwtiielft4rexgf@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324075119.1556334-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 24-03-22 08:51:10, Christoph Hellwig wrote:
> Add a helper that returns the openers for a given gendisk to avoid having
> drivers poke into disk->part0 to get at this information in a somewhat
> cumbersome way.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/nbd.c           |  4 ++--
>  drivers/block/zram/zram_drv.c |  4 ++--
>  include/linux/blkdev.h        | 15 +++++++++++++++
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 795f65a5c9661..93af7587d5ed6 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1219,7 +1219,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>  
>  static void nbd_bdev_reset(struct nbd_device *nbd)
>  {
> -	if (nbd->disk->part0->bd_openers > 1)
> +	if (disk_openers(nbd->disk) > 1)
>  		return;
>  	set_capacity(nbd->disk, 0);
>  }
> @@ -1578,7 +1578,7 @@ static void nbd_release(struct gendisk *disk, fmode_t mode)
>  	struct nbd_device *nbd = disk->private_data;
>  
>  	if (test_bit(NBD_RT_DISCONNECT_ON_CLOSE, &nbd->config->runtime_flags) &&
> -			disk->part0->bd_openers == 0)
> +			disk_openers(disk) == 0)
>  		nbd_disconnect_and_put(nbd);
>  
>  	nbd_config_put(nbd);
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 863606f1722b1..2362385f782a9 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1800,7 +1800,7 @@ static ssize_t reset_store(struct device *dev,
>  
>  	mutex_lock(&disk->open_mutex);
>  	/* Do not reset an active device or claimed device */
> -	if (disk->part0->bd_openers || zram->claim) {
> +	if (disk_openers(disk) || zram->claim) {
>  		mutex_unlock(&disk->open_mutex);
>  		return -EBUSY;
>  	}
> @@ -1990,7 +1990,7 @@ static int zram_remove(struct zram *zram)
>  	bool claimed;
>  
>  	mutex_lock(&zram->disk->open_mutex);
> -	if (zram->disk->part0->bd_openers) {
> +	if (disk_openers(zram->disk)) {
>  		mutex_unlock(&zram->disk->open_mutex);
>  		return -EBUSY;
>  	}
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index eb27312a1b8f3..9824ebc9b4d31 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -176,6 +176,21 @@ static inline bool disk_live(struct gendisk *disk)
>  	return !inode_unhashed(disk->part0->bd_inode);
>  }
>  
> +/**
> + * disk_openers - returns how many openers are there for a disk
> + * @disk: disk to check
> + *
> + * This returns the number of openers for a disk.  Note that this value is only
> + * stable if disk->open_mutex is held.
> + *
> + * Note: Due to a quirk in the block layer open code, each open partition is
> + * only counted once even if there are multiple openers.
> + */
> +static inline unsigned int disk_openers(struct gendisk *disk)
> +{
> +	return disk->part0->bd_openers;
> +}
> +
>  /*
>   * The gendisk is refcounted by the part0 block_device, and the bd_device
>   * therein is also used for device model presentation in sysfs.
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
