Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032E2C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 12:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350110AbiCXMXZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350124AbiCXMXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 08:23:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD41A8EEF
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 05:21:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 847DD1F38D;
        Thu, 24 Mar 2022 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648124509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/SgrAHhNM52Kgw80tCE7Vvrlpci9B4/FExqlYShfv74=;
        b=tPqUlztaenx6IkGCpH/rFRC/GxCowwU4IkJW2ahmRpb3GJRAXbqtJSs9++VdCQ/D8Ab9QJ
        ibr4hN6i5tDy/IGAmnlIRarQUSBhhcfwNiEXEwihqAPRP9oFPtrUo3R40ERQIIQWCcxNMa
        HFKA+8BCjxgoHSeXfLxx48ywYxcBYHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648124509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/SgrAHhNM52Kgw80tCE7Vvrlpci9B4/FExqlYShfv74=;
        b=7SDTKz8XUD2tyk7TC3Njzh6FUR8ryyS8NzPh8NRo0grA3NQXem/NLUMmqwH5H/vTmETzKY
        7R3dmWsCADtIQrBQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 73A75A3B9E;
        Thu, 24 Mar 2022 12:21:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 23655A0610; Thu, 24 Mar 2022 13:21:49 +0100 (CET)
Date:   Thu, 24 Mar 2022 13:21:49 +0100
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
Subject: Re: [PATCH 02/13] zram: cleanup reset_store
Message-ID: <20220324122149.iu63vrljelo6jq2x@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324075119.1556334-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 24-03-22 08:51:08, Christoph Hellwig wrote:
> Use a local variable for the gendisk instead of the part0 block_device,
> as the gendisk is what this function actually operates on.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/zram/zram_drv.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index e9474b02012de..fd83fad59beb1 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1786,7 +1786,7 @@ static ssize_t reset_store(struct device *dev,
>  	int ret;
>  	unsigned short do_reset;
>  	struct zram *zram;
> -	struct block_device *bdev;
> +	struct gendisk *disk;
>  
>  	ret = kstrtou16(buf, 10, &do_reset);
>  	if (ret)
> @@ -1796,26 +1796,26 @@ static ssize_t reset_store(struct device *dev,
>  		return -EINVAL;
>  
>  	zram = dev_to_zram(dev);
> -	bdev = zram->disk->part0;
> +	disk = zram->disk;
>  
> -	mutex_lock(&bdev->bd_disk->open_mutex);
> +	mutex_lock(&disk->open_mutex);
>  	/* Do not reset an active device or claimed device */
> -	if (bdev->bd_openers || zram->claim) {
> -		mutex_unlock(&bdev->bd_disk->open_mutex);
> +	if (disk->part0->bd_openers || zram->claim) {
> +		mutex_unlock(&disk->open_mutex);
>  		return -EBUSY;
>  	}
>  
>  	/* From now on, anyone can't open /dev/zram[0-9] */
>  	zram->claim = true;
> -	mutex_unlock(&bdev->bd_disk->open_mutex);
> +	mutex_unlock(&disk->open_mutex);
>  
>  	/* Make sure all the pending I/O are finished */
> -	sync_blockdev(bdev);
> +	sync_blockdev(disk->part0);
>  	zram_reset_device(zram);
>  
> -	mutex_lock(&bdev->bd_disk->open_mutex);
> +	mutex_lock(&disk->open_mutex);
>  	zram->claim = false;
> -	mutex_unlock(&bdev->bd_disk->open_mutex);
> +	mutex_unlock(&disk->open_mutex);
>  
>  	return len;
>  }
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
