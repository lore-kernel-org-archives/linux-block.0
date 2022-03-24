Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C1C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 12:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349452AbiCXMWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350094AbiCXMWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 08:22:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9CC652C7
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 05:20:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A36461F745;
        Thu, 24 Mar 2022 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648124445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ru7twObJmkEeqX5kufO5l0DfRgeiRYwOwFdgSaymrM4=;
        b=YKfOAqryvTvf2cb0T6bddOnaL8IuSAiRiuq4uLh7fByzw4TfD8ZnOlQXK1ai2vCBJTQnl5
        9cWyBf5V81iIR4PCFupA6RtnH86UPGcIVNhhiIth1TSKVDQw8w1lDfSkJjhzX1kp039FBG
        f5NiJrd/7u4+MhFo3kv8EXgQ6rszUR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648124445;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ru7twObJmkEeqX5kufO5l0DfRgeiRYwOwFdgSaymrM4=;
        b=/7iwgfzxeB+5RF0lBjBDfbJ05jzoKJs7CCsAPVis2qoFRDYYpC6BOFOuUp3E3MmSfkteo3
        HvPEJ/UHsGzSvGCg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 827FDA3B87;
        Thu, 24 Mar 2022 12:20:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 35498A0610; Thu, 24 Mar 2022 13:20:41 +0100 (CET)
Date:   Thu, 24 Mar 2022 13:20:41 +0100
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
Subject: Re: [PATCH 01/13] nbd: use the correct block_device in nbd_ioctl
Message-ID: <20220324122041.itc55zladc5sax5p@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324075119.1556334-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 24-03-22 08:51:07, Christoph Hellwig wrote:
> The bdev parameter to ->ioctl contains the block device that the ioctl
> is called on, which can be the partition.  But the code in nbd_ioctl
> that uses it really wants the whole device for things like the bd_openers
> check.  Switch to not pass the bdev along and always use nbd->disk->part0
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/nbd.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5a1f98494dddf..795f65a5c9661 100644
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
> @@ -1417,12 +1417,11 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>  	return ret;
>  }
>  
> -static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
> -				 struct block_device *bdev)
> +static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
>  {
>  	sock_shutdown(nbd);
> -	__invalidate_device(bdev, true);
> -	nbd_bdev_reset(bdev);
> +	__invalidate_device(nbd->disk->part0, true);
> +	nbd_bdev_reset(nbd);
>  	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
>  			       &nbd->config->runtime_flags))
>  		nbd_config_put(nbd);
> @@ -1448,7 +1447,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  	case NBD_DISCONNECT:
>  		return nbd_disconnect(nbd);
>  	case NBD_CLEAR_SOCK:
> -		nbd_clear_sock_ioctl(nbd, bdev);
> +		nbd_clear_sock_ioctl(nbd);
>  		return 0;
>  	case NBD_SET_SOCK:
>  		return nbd_add_socket(nbd, arg, false);
> @@ -1468,7 +1467,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
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
