Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB8CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 11:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbiA0LBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:01:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38680 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiA0LBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 06:01:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3728B210F7;
        Thu, 27 Jan 2022 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643281304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fd7CG+Azqk7QfK7H7Kku67pNRR7HPlN3QZuYhrXgk+4=;
        b=fu2I2OniRx2oQcdz3vg5jot1d8ts8CzxelmwJK/MyNC00fihMryb1TWrkBMh40+xmE940t
        Pkyvi0RIU8eOSAr85Q8lp/L9Vo6pgrG55f/nuwNCQLkHvTtAaW5IcbNHhPPAGuMhmYQ8ql
        YQPW945ZSXdSDoqFxrJgryIq9hp5qoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643281304;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fd7CG+Azqk7QfK7H7Kku67pNRR7HPlN3QZuYhrXgk+4=;
        b=IDtY9ylIETbGLKE6y4ul8qDCFgK4L6SfDbtJnuiDKsQERC3l0sAeFxFcKUCanp1V87ld2Q
        xRckOq6AlOstG8DA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2617CA3B83;
        Thu, 27 Jan 2022 11:01:44 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CAAC9A05E6; Thu, 27 Jan 2022 12:01:43 +0100 (CET)
Date:   Thu, 27 Jan 2022 12:01:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 7/8] loop: only freeze the queue in __loop_clr_fd when
 needed
Message-ID: <20220127110143.g3jsi3z5vpxhotep@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126155040.1190842-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 26-01-22 16:50:39, Christoph Hellwig wrote:
> ->release is only called after all outstanding I/O has completed, so only
> freeze the queue when clearing the backing file of a live loop device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. I was just wondering: Is there anything which prevents us from
moving blk_mq_freeze_queue() & blk_mq_unfreeze_queue() calls to
loop_clr_fd() around __loop_clr_fd() call?

Anyway feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d9a0e2205762f..fc0cdd1612b1d 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1110,7 +1110,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	return error;
>  }
>  
> -static void __loop_clr_fd(struct loop_device *lo)
> +static void __loop_clr_fd(struct loop_device *lo, bool release)
>  {
>  	struct file *filp;
>  	gfp_t gfp = lo->old_gfp_mask;
> @@ -1139,8 +1139,13 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
>  		blk_queue_write_cache(lo->lo_queue, false, false);
>  
> -	/* freeze request queue during the transition */
> -	blk_mq_freeze_queue(lo->lo_queue);
> +	/*
> +	 * Freeze the request queue when unbinding on a live file descriptor and
> +	 * thus an open device.  When called from ->release we are guaranteed
> +	 * that there is no I/O in progress already.
> +	 */
> +	if (!release)
> +		blk_mq_freeze_queue(lo->lo_queue);
>  
>  	destroy_workqueue(lo->workqueue);
>  	loop_free_idle_workers(lo, true);
> @@ -1163,7 +1168,8 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	/* let user-space know about this change */
>  	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  	mapping_set_gfp_mask(filp->f_mapping, gfp);
> -	blk_mq_unfreeze_queue(lo->lo_queue);
> +	if (!release)
> +		blk_mq_unfreeze_queue(lo->lo_queue);
>  
>  	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
>  
> @@ -1201,7 +1207,7 @@ static void loop_rundown_workfn(struct work_struct *work)
>  	struct block_device *bdev = lo->lo_device;
>  	struct gendisk *disk = lo->lo_disk;
>  
> -	__loop_clr_fd(lo);
> +	__loop_clr_fd(lo, true);
>  	kobject_put(&bdev->bd_device.kobj);
>  	module_put(disk->fops->owner);
>  	loop_rundown_completed(lo);
> @@ -1247,7 +1253,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	lo->lo_state = Lo_rundown;
>  	mutex_unlock(&lo->lo_mutex);
>  
> -	__loop_clr_fd(lo);
> +	__loop_clr_fd(lo, false);
>  	loop_rundown_completed(lo);
>  	return 0;
>  }
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
