Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B34FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 09:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356485AbiCYJfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344774AbiCYJfl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 05:35:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF874DD8
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 02:34:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 472DF1F38D;
        Fri, 25 Mar 2022 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648200846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsyCNFPN20seFERlWMYTQaTaBEboZs+FaC506U8jafA=;
        b=mRjSN0C5x5/qfjvU6Ss9HfYQZOOJXCqqhKZ+es4KVJD56MK67Um3jAPnp/sgLwgRswK+vJ
        SM8B8Ve+Lk7XZCSTfKfP0e9JskZkrKwC3izY9DSQQenCcjzn2I3TfHaw6Xz8cr97X89Hav
        bX8Kb9XOfaThCPpEaLLxQdm4du5WVdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648200846;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsyCNFPN20seFERlWMYTQaTaBEboZs+FaC506U8jafA=;
        b=3ljM2fy6nBKCwcPRBlrS4cJxaG8JjYNgZQ+ztp6d6J0XBiescOTwSIoYIqHxFL+PKa9nae
        zbnQEkVai11jJBBw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B14DBA3B96;
        Fri, 25 Mar 2022 09:34:05 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3289AA0610; Fri, 25 Mar 2022 10:34:05 +0100 (CET)
Date:   Fri, 25 Mar 2022 10:34:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 12/13] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220325093405.wfz2r5uyoptlwfcn@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-13-hch@lst.de>
 <20220324141321.pqesnshaswwk3svk@quack3.lan>
 <20220324171518.GC28007@lst.de>
 <20220324174701.GA28583@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324174701.GA28583@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 24-03-22 18:47:01, Christoph Hellwig wrote:
> On Thu, Mar 24, 2022 at 06:15:18PM +0100, Christoph Hellwig wrote:
> > On Thu, Mar 24, 2022 at 03:13:21PM +0100, Jan Kara wrote:
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > Looks good but I still think we need something like attached preparatory
> > > patch to not regress e.g. filesystem probing triggered by udev events. What
> > > do you think?
> > 
> > Yes, I think it makes sense to add that.
> 
> Actually, looking at it in a little more detail: this misses the
> explicit kobject_uevent calls for the capacity changes.  I think the
> best idea might be something like this:
> 
> ---
> From db5ab8ab0fbcf07af769023a894fafc22b662cd9 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Thu, 24 Mar 2022 18:41:28 +0100
> Subject: loop: suppress uevents while reconfiguring the device
> 
> Currently, udev change event is generated for a loop device before the
> device is ready for IO. Due to serialization on lo->lo_mutex in
> lo_open() this does not matter because anybody is able to open the
> device and do IO only after the configuration is finished. However this
> synchronization in lo_open() is going away so make sure userspace
> reacting to the change event will see the new device state by generating
> the event only when the device is setup.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, even better. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index b3170e8cdbe95..bfd21af7aa38b 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -572,6 +572,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  
>  	if (!file)
>  		return -EBADF;
> +
> +	/* suppress uevents while reconfiguring the device */
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> +
>  	is_loop = is_loop_device(file);
>  	error = loop_global_lock_killable(lo, is_loop);
>  	if (error)
> @@ -626,13 +630,18 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	fput(old_file);
>  	if (partscan)
>  		loop_reread_partitions(lo);
> -	return 0;
> +
> +	error = 0;
> +done:
> +	/* enable and uncork uevent now that we are done */
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> +	return error;
>  
>  out_err:
>  	loop_global_unlock(lo, is_loop);
>  out_putf:
>  	fput(file);
> -	return error;
> +	goto done;
>  }
>  
>  /* loop sysfs attributes */
> @@ -999,6 +1008,9 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	/* This is safe, since we have a reference from open(). */
>  	__module_get(THIS_MODULE);
>  
> +	/* suppress uevents while reconfiguring the device */
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> +
>  	/*
>  	 * If we don't hold exclusive handle for the device, upgrade to it
>  	 * here to avoid changing device under exclusive owner.
> @@ -1101,7 +1113,12 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  		loop_reread_partitions(lo);
>  	if (!(mode & FMODE_EXCL))
>  		bd_abort_claiming(bdev, loop_configure);
> -	return 0;
> +
> +	error = 0;
> +done:
> +	/* enable and uncork uevent now that we are done */
> +	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> +	return error;
>  
>  out_unlock:
>  	loop_global_unlock(lo, is_loop);
> @@ -1112,7 +1129,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	fput(file);
>  	/* This is safe: open() is still holding a reference. */
>  	module_put(THIS_MODULE);
> -	return error;
> +	goto done;
>  }
>  
>  static void __loop_clr_fd(struct loop_device *lo, bool release)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
