Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19323C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37F96128E
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFVHr7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhFVHr6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 03:47:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17805611BF;
        Tue, 22 Jun 2021 07:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624347942;
        bh=DHrhi+ReYAlzR9QUt9I0fZ/6wnGPc4XCNadLvDK7hps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsu9/SngL9Ee7mR3K31l/FEJ/z4KOd5rPJOFeh05GM2saa60m8hipNQAq+la4lhLx
         EIVeUW6SLpej5o1l9o8RY+00ARoJb4Odo7knTv8ryx8ph5ef47byy+WUOrRF7ZzKj+
         b5gLIBp48x7DUM0a8dqQ6Pm9G0SN/m0FGSTARsiI=
Date:   Tue, 22 Jun 2021 09:45:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] zram: fix deadlock with sysfs attribute usage and
 driver removal
Message-ID: <YNGVI/vKSBAM8dlh@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621233634.595649-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> When sysfs attributes use a lock also used on driver removal we can
> potentially deadlock. This happens when for instance a sysfs file on
> a driver is used, then at the same time we have driver removal trigger.
> The driver removal code holds a lock, and then the sysfs file entry waits
> for the same lock. While holding the lock the driver removal tries to
> remove the sysfs entries, but these cannot be removed yet as one is
> waiting for a lock. This won't complete as the lock is already held.
> Likewise module removal cannot complete, and so we deadlock.

This is all about removing modules, not about "driver removal" from a
device.  Please make the subject line here more explicit.

> 
> To fix this we just *try* to get a refcount to the module when a shared
> lock is used, prior to mucking with a sysfs attribute. If this fails we
> just give up right away.
> 
> We use a try method as a full lock means we'd then make our sysfs attributes
> busy us out from possible module removal, and so userspace could force denying
> module removal, a silly form of "DOS" against module removal. A try lock on
> the module removal ensures we give priority to module removal and interacting
> with sysfs attributes only comes second. Using a full lock could mean for
> instance that if you don't stop poking at sysfs files you cannot remove a
> module.
> 
> This deadlock was first reported with the zram driver, a sketch of how
> this can happen follows:
> 
> CPU A                              CPU B
>                                    whatever_store()
> module_unload
>   mutex_lock(foo)
>                                    mutex_lock(foo)
>    del_gendisk(zram->disk);
>      device_del()
>        device_remove_groups()

Can you duplicate this in a real-world situation?

What tools remove the zram module from the system on the fly?

> In this situation whatever_store() is waiting for the mutex foo to
> become unlocked, but that won't happen until module removal is complete.
> But module removal won't complete until the syfs file being poked completes
> which is waiting for a lock already held.
> 
> This is a generic kernel issue with sysfs files which use any lock also
> used on module removal. Different generic solutions have been proposed.
> One approach proposed is by directly by augmenting attributes with module
> information [0]. This patch implements a solution by adding macros with
> the prefix MODULE_DEVICE_ATTR_*() which accomplish the same. Until we
> don't have a generic agreed upon solution for this shared between drivers,
> we must implement a fix for this on each driver.
> 
> We make zram use the new MODULE_DEVICE_ATTR_*() helpers, and completely
> open code the solution for class attributes as there are only a few of
> those.
> 
> This issue can be reproduced easily on the zram driver as follows:
> 
> Loop 1 on one terminal:
> 
> while true;
> 	do modprobe zram;
> 	modprobe -r zram;
> done
> 
> Loop 2 on a second terminal:
> while true; do
> 	echo 1024 >  /sys/block/zram0/disksize;
> 	echo 1 > /sys/block/zram0/reset;
> done

As fun as this is, it's not a real workload, please do not pretend that
it is.

And your code is still racy, see below.  You just made the window even
smaller, which you still should be objecting to as you somehow feel this
is a valid usecase :)

> @@ -2048,13 +2048,19 @@ static ssize_t hot_add_show(struct class *class,
>  {
>  	int ret;
>  
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +

You can not increment/decrement your own module's reference count and
expect it to work properly, as it is still a race.

thanks,

greg k-h
