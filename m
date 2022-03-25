Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BEEC433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 09:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbiCYJt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbiCYJt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 05:49:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692745525
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 02:48:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 19DC5210DD;
        Fri, 25 Mar 2022 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648201701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2B5Ovp/AGoJP4vtJyXeHGTqSIm8bneVtY69YT9VYJtc=;
        b=hvI9NTZhfLPV/w92szaggCScpef2X2LqZu1ipID9LXgoFs32SDUw/GcBPokirvzxQhHM7d
        qSd3ZohC0wm9MzT5jSKQVA8Plfj+YrgtFWT9GkBgPrO5+pHQgQZNygXMPsH8Dxy/d4dSr3
        6N2+DKha9Zgux6jVIAvZPpPw/f9MXJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648201701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2B5Ovp/AGoJP4vtJyXeHGTqSIm8bneVtY69YT9VYJtc=;
        b=yHTPU0lYzShxBJAnTtcm5pM8bwSG3lVwNPqiYZBIdHF2XgHu4ir5b5nT6GH7ABvn9jXuUd
        X2x96Syk5KJfk0Dg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF907A3B88;
        Fri, 25 Mar 2022 09:48:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63245A0610; Fri, 25 Mar 2022 10:48:20 +0100 (CET)
Date:   Fri, 25 Mar 2022 10:48:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH 01/14] nbd: use the correct block_device in nbd_bdev_reset
Message-ID: <20220325094820.jxyqgjxdx7ulgmo2@quack3.lan>
References: <20220325063929.1773899-1-hch@lst.de>
 <20220325063929.1773899-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325063929.1773899-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 25-03-22 07:39:16, Christoph Hellwig wrote:
> The bdev parameter to ->ioctl contains the block device that the ioctl
> is called on, which can be the partition.  But the openers check in
> nbd_bdev_reset really needs to check use the whole device, so switch to
> using that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/nbd.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5a1f98494dddf..2f29da41fbc80 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1217,11 +1217,11 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>  	return -ENOSPC;
>  }
>  
> -static void nbd_bdev_reset(struct block_device *bdev)
> +static void nbd_bdev_reset(struct nbd_device *nbd)
>  {
> -	if (bdev->bd_openers > 1)
> +	if (nbd->disk->part0->bd_openers > 1)
>  		return;
> -	set_capacity(bdev->bd_disk, 0);
> +	set_capacity(nbd->disk, 0);
>  }
>  
>  static void nbd_parse_flags(struct nbd_device *nbd)
> @@ -1389,7 +1389,7 @@ static int nbd_start_device(struct nbd_device *nbd)
>  	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
>  }
>  
> -static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *bdev)
> +static int nbd_start_device_ioctl(struct nbd_device *nbd)
>  {
>  	struct nbd_config *config = nbd->config;
>  	int ret;
> @@ -1408,7 +1408,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>  	flush_workqueue(nbd->recv_workq);
>  
>  	mutex_lock(&nbd->config_lock);
> -	nbd_bdev_reset(bdev);
> +	nbd_bdev_reset(nbd);
>  	/* user requested, ignore socket errors */
>  	if (test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags))
>  		ret = 0;
> @@ -1422,7 +1422,7 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
>  {
>  	sock_shutdown(nbd);
>  	__invalidate_device(bdev, true);
> -	nbd_bdev_reset(bdev);
> +	nbd_bdev_reset(nbd);
>  	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
>  			       &nbd->config->runtime_flags))
>  		nbd_config_put(nbd);
> @@ -1468,7 +1468,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  		config->flags = arg;
>  		return 0;
>  	case NBD_DO_IT:
> -		return nbd_start_device_ioctl(nbd, bdev);
> +		return nbd_start_device_ioctl(nbd);
>  	case NBD_CLEAR_QUE:
>  		/*
>  		 * This is for compatibility only.  The queue is always cleared
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
