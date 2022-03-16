Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 10:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbiCPKbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355117AbiCPKbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 06:31:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1935D5DD
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 03:30:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 370A31F391;
        Wed, 16 Mar 2022 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647426616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1BaTeGp5jG6Xu8i2DUbvZzOPavtg1jJf0C7nTzIVVQ=;
        b=dc2OVgJj+uPrhNy9D8/5/1MYrnWXBde3hSuUS8wSyFqC84QcE3d6prrPAmCAfnvv2qu+Dk
        a+C9AC3wc951WgUJbtHnpIwXaayFPFlGGH4Hs0t3NYGMj3GmvqmzgX1m9wOypS7m8O6xsU
        nuTPfy6sZPDlJeyrRn66UJ3pqXGqxNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647426616;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1BaTeGp5jG6Xu8i2DUbvZzOPavtg1jJf0C7nTzIVVQ=;
        b=6WiUDIVyePKOVfSOOnMct3HncGgOAy2U5CGc9DMQPv93wQn0483FKuyj6GaY8M+JbN3sfb
        yOz8m3Vm8T8loPBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 26C71A3B87;
        Wed, 16 Mar 2022 10:30:16 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D23F1A0615; Wed, 16 Mar 2022 11:30:15 +0100 (CET)
Date:   Wed, 16 Mar 2022 11:30:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/8] loop: implement ->free_disk
Message-ID: <20220316103015.ynica2tab47nu4pz@quack3.lan>
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316084519.2850118-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 16-03-22 09:45:17, Christoph Hellwig wrote:
> Ensure that the lo_device which is stored in the gendisk private
> data is valid until the gendisk is freed.  Currently the loop driver
> uses a lot of effort to make sure a device is not freed when it is
> still in use, but to to fix a potential deadlock this will be relaxed
> a bit soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0813f63d5bbd2..cbaa18bcad1fe 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1765,6 +1765,14 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>  	mutex_unlock(&lo->lo_mutex);
>  }
>  
> +static void lo_free_disk(struct gendisk *disk)
> +{
> +	struct loop_device *lo = disk->private_data;
> +
> +	mutex_destroy(&lo->lo_mutex);
> +	kfree(lo);
> +}
> +
>  static const struct block_device_operations lo_fops = {
>  	.owner =	THIS_MODULE,
>  	.open =		lo_open,
> @@ -1773,6 +1781,7 @@ static const struct block_device_operations lo_fops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl =	lo_compat_ioctl,
>  #endif
> +	.free_disk =	lo_free_disk,
>  };
>  
>  /*
> @@ -2064,14 +2073,13 @@ static void loop_remove(struct loop_device *lo)
>  {
>  	/* Make this loop device unreachable from pathname. */
>  	del_gendisk(lo->lo_disk);
> -	blk_cleanup_disk(lo->lo_disk);
> +	blk_cleanup_queue(lo->lo_disk->queue);
>  	blk_mq_free_tag_set(&lo->tag_set);
>  	mutex_lock(&loop_ctl_mutex);
>  	idr_remove(&loop_index_idr, lo->lo_number);
>  	mutex_unlock(&loop_ctl_mutex);
> -	/* There is no route which can find this loop device. */
> -	mutex_destroy(&lo->lo_mutex);
> -	kfree(lo);
> +
> +	put_disk(lo->lo_disk);
>  }
>  
>  static void loop_probe(dev_t dev)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
