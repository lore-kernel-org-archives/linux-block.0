Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8705AC433B4
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 19:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E88613BB
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 19:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhDET6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhDET6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 15:58:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBBC061756;
        Mon,  5 Apr 2021 12:58:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 11so7133334pfn.9;
        Mon, 05 Apr 2021 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A9T+LWp/vTRXkrZ9kJMSDgrFw8oLJG+cfVUXVIt5Nyw=;
        b=UYNBwqKcFlQ5oEh0Ok+QGFjLm2dYvGKnf5wtLeTG18o1G7wq0YZMJ/Q5r8uvAeZuJb
         AiTyZ6qECDxMiM+akejbNj4UR3V/empx+bFYAur3Ab31RSgZg3QDtGm4RGT0EyvKjw9E
         c4dHkbJ+XaKjBassYWeHUosZtWhERtswtw0RajKT2L/9VTI+kCcEL0z5jH2ZaTENbcxY
         R4+nl7iMDtlY4fx4mSsOOQSrrw2r6rKBF40a+/kV3nhuOz1RKDlAMguNtPFBXaq+QLjH
         ypaS9Rkx/233fxsSfP9aSjvP3aGFaA33VMyeK2fZEPMNba03UCmLmXed/NeRsfTGr+BJ
         MAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=A9T+LWp/vTRXkrZ9kJMSDgrFw8oLJG+cfVUXVIt5Nyw=;
        b=Ntov3ydN1TScHLIdIuxPW9OcMXaGjRDyjEisItHDf/48DKb0LMWsSGZ6QkOMNN8yw/
         NMLSd6rTCXxLUOZpB7e3W0Jpc0EXPUdc5jpaDy/Habqs0mjHlyAqCmdOD4aHXvF1uWkg
         PPp4Q4nY5z1w7e8017W30xwuLNbxICexYGmlMDP169bZ3N0uWHu2MScIihRHslJikIJJ
         L58gEPEK/AA08QqcaR/rWIbUdbf4pEf/4tDNmaPKjCBCKCPyFq9rRaDYesWSKorq9D2r
         nHpDSUpbBQU09itlzxHbuyAJ9ta5b0QtDnb7uG/V4Ng7tSheWikXIE+9RQUdJ9UHsP9d
         4fOA==
X-Gm-Message-State: AOAM532VqJtylBOHrFIJa7gfNPPf00zFlhFcbhJk+pX3Un0roga3+syg
        uoQvUe9YUKQOm+jFpb/5GmE=
X-Google-Smtp-Source: ABdhPJwAUNsUJ3ZO+jCzhAgKN56xrf3NeLsca+JMOWEp+bo+Z6wu+0oeKDR/7TKWKzfuCQQM7gAmng==
X-Received: by 2002:a63:5562:: with SMTP id f34mr18666329pgm.391.1617652688713;
        Mon, 05 Apr 2021 12:58:08 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:30d6:b5a3:92ae:5a02])
        by smtp.gmail.com with ESMTPSA id o4sm16595316pfk.15.2021.04.05.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 12:58:07 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 5 Apr 2021 12:58:05 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, dhowells@redhat.com, hch@infradead.org,
        mbenes@suse.com, gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YGtrzXYDiO3Gf9Aa@google.com>
References: <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGtDzH0dEfEngCij@google.com>
 <20210405190023.GX4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405190023.GX4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 05, 2021 at 07:00:23PM +0000, Luis Chamberlain wrote:
> On Mon, Apr 05, 2021 at 10:07:24AM -0700, Minchan Kim wrote:
> > On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> > > And come to think of it the last patch I had sent with a new
> > > DECLARE_RWSEM(zram_unload) also has this same issue making most
> > > sysfs attributes rather fragile.
> > 
> > Thanks for looking the way. I agree the single zram_index_rwlock is
> > not the right approach to fix it. However, I still hope we find more
> > generic solution to fix them at once since I see it's zram instance
> > racing problem.
> 
> They are 3 separate different problems. Related, but different.

What are 3 different problems? I am asking since I remember only two:
one for CPU multistate and the other one for sysfs during rmmod.
The missing one from my view would help why you are saying they
are all different problems(even though it's a bit releated).

> At this point I think it would be difficult to resolve all 3
> with one solution without creating side issues, but hey,
> I'm curious if you find a solution that does not create other
> issues.

Yeah, let me try something with kobject stuff how I could go far
but let me understand what I was missing from problems your mentioned
above.

> 
> > A approach I am considering is to make struct zram include kobject
> > and then make zram sysfs auto populated under the kobject. So, zram/sysfs
> > lifetime should be under the kobject. With it, sysfs race probem I
> > mentioned above should be gone. Furthermore, zram_remove should fail
> > if one of the alive zram objects is existing
> > (i.e., zram->kobject->refcount > 1) so module_exit will fail, too.
> 
> If the idea then is to busy out rmmod if a sysfs attribute is being
> read, that could then mean rmmod can sometimes never complete. Hogging
> up / busying out sysfs attributes means the module cannto be removed.

It's true but is it a big problem? There are many cases that system
just return error if it's busy and rely on the admin. IMHO, rmmod should
be part of them.

> Which is why the *try_module_get()* I think is much more suitable, as
> it will always fails if we're already going down.

How does the try_module_get solved the problem? I thought it's
general problem on every sysfs knobs in zram. Do you mean
you will add module_get/put for every sysfs knobs in zram?

> 
> > I see one of the problems is how I could make new zram object's
> > attribute group for zram knobs under /sys/block/zram0 since block
> > layer already made zram0 kobject via device_add_disk.
> 
> Right.. well the syfs attribute races uncovered here actually do
> apply to any block driver as well. And which is why I was aiming
> for something generic if possible.

It would be great but that's not the one we have atm so want to
proceed to fix anyway.

> 
> I am not sure if you missed the last hunks of the generic solution,
> but that would resolve the issue you noted. Here is the same approach
> but in a non-generic solution, specific to just one attribute so far
> and to zram:

So idea is refcount of the block_device's inode and module_exit path
checks also the inode refcount to make rmmod failure?
Hmm, might work but I am not sure it's right layerm, too.

> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 494695ff227e..b566916e4ad9 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1724,6 +1724,11 @@ static ssize_t disksize_store(struct device *dev,
>  
>  	mutex_lock(&zram_index_mutex);
>  
> +	if (!bdgrab(dev_to_bdev(dev))) {
> +		err = -ENODEV;
> +		goto out_nodev;
> +	}
> +
>  	if (!zram_up || zram->claim) {
>  		err = -ENODEV;
>  		goto out;
> @@ -1760,6 +1765,7 @@ static ssize_t disksize_store(struct device *dev,
>  	zram->disksize = disksize;
>  	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
>  	up_write(&zram->init_lock);
> +	bdput(dev_to_bdev(dev);
>  
>  	mutex_unlock(&zram_index_mutex);
>  
> @@ -1770,6 +1776,8 @@ static ssize_t disksize_store(struct device *dev,
>  out_unlock:
>  	up_write(&zram->init_lock);
>  out:
> +	bdput(dev_to_bdev(dev);
> +out_nodev:
>  	mutex_unlock(&zram_index_mutex);
>  	return err;
>  }
