Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E3C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF26461166
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFVRSz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFVRSw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 13:18:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A5F960FF4;
        Tue, 22 Jun 2021 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624382196;
        bh=w6U62n6dQJTAbUF5zXazzxp2tkkGudWqrWLJjkhLwTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdP324mGM7jY89KaTZe2mJ5JA6jOgiD63DPKCEj24gPQRdCbUoK0ucK4rAKo4xqDi
         ZMpRmFQ7NLYSi5Sj4DN5lLJx13no+eythFqJNTc+9H8/gUK9nSwv29jI0i196Q/m50
         QLKEpbfbDUconjaQHRB1+rPIzoEQaF3yH6MpIlsI=
Date:   Tue, 22 Jun 2021 19:16:34 +0200
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
Message-ID: <YNIa8tym7TmZFWaZ@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGVI/vKSBAM8dlh@kroah.com>
 <20210622163208.epx4lf3pv2x2d5b4@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622163208.epx4lf3pv2x2d5b4@garbanzo>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 09:32:08AM -0700, Luis Chamberlain wrote:
> On Tue, Jun 22, 2021 at 09:45:39AM +0200, Greg KH wrote:
> > On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > > When sysfs attributes use a lock also used on driver removal we can
> > > potentially deadlock. This happens when for instance a sysfs file on
> > > a driver is used, then at the same time we have driver removal trigger.
> > > The driver removal code holds a lock, and then the sysfs file entry waits
> > > for the same lock. While holding the lock the driver removal tries to
> > > remove the sysfs entries, but these cannot be removed yet as one is
> > > waiting for a lock. This won't complete as the lock is already held.
> > > Likewise module removal cannot complete, and so we deadlock.
> > 
> > This is all about removing modules, not about "driver removal" from a
> > device.  Please make the subject line here more explicit.
> 
> Sure.
> 
> > > To fix this we just *try* to get a refcount to the module when a shared
> > > lock is used, prior to mucking with a sysfs attribute. If this fails we
> > > just give up right away.
> > > 
> > > We use a try method as a full lock means we'd then make our sysfs attributes
> > > busy us out from possible module removal, and so userspace could force denying
> > > module removal, a silly form of "DOS" against module removal. A try lock on
> > > the module removal ensures we give priority to module removal and interacting
> > > with sysfs attributes only comes second. Using a full lock could mean for
> > > instance that if you don't stop poking at sysfs files you cannot remove a
> > > module.
> > > 
> > > This deadlock was first reported with the zram driver, a sketch of how
> > > this can happen follows:
> > > 
> > > CPU A                              CPU B
> > >                                    whatever_store()
> > > module_unload
> > >   mutex_lock(foo)
> > >                                    mutex_lock(foo)
> > >    del_gendisk(zram->disk);
> > >      device_del()
> > >        device_remove_groups()
> > 
> > Can you duplicate this in a real-world situation?
> > 
> > What tools remove the zram module from the system on the fly?
> 
> A customer did run into it through a series of automated tests. I was
> able to finally reproduce with the instructions given below. I
> simplified it given that the series of test the customer was running
> was much more complex.
> 
> > > In this situation whatever_store() is waiting for the mutex foo to
> > > become unlocked, but that won't happen until module removal is complete.
> > > But module removal won't complete until the syfs file being poked completes
> > > which is waiting for a lock already held.
> > > 
> > > This is a generic kernel issue with sysfs files which use any lock also
> > > used on module removal. Different generic solutions have been proposed.
> > > One approach proposed is by directly by augmenting attributes with module
> > > information [0]. This patch implements a solution by adding macros with
> > > the prefix MODULE_DEVICE_ATTR_*() which accomplish the same. Until we
> > > don't have a generic agreed upon solution for this shared between drivers,
> > > we must implement a fix for this on each driver.
> > > 
> > > We make zram use the new MODULE_DEVICE_ATTR_*() helpers, and completely
> > > open code the solution for class attributes as there are only a few of
> > > those.
> > > 
> > > This issue can be reproduced easily on the zram driver as follows:
> > > 
> > > Loop 1 on one terminal:
> > > 
> > > while true;
> > > 	do modprobe zram;
> > > 	modprobe -r zram;
> > > done
> > > 
> > > Loop 2 on a second terminal:
> > > while true; do
> > > 	echo 1024 >  /sys/block/zram0/disksize;
> > > 	echo 1 > /sys/block/zram0/reset;
> > > done
> > 
> > As fun as this is, it's not a real workload, please do not pretend that
> > it is.
> 
> Whoever said that it was? This is just a way to reproduce an issue which
> was reported.
> 
> > And your code is still racy, see below.  You just made the window even
> > smaller, which you still should be objecting to as you somehow feel this
> > is a valid usecase :)
> > 
> > > @@ -2048,13 +2048,19 @@ static ssize_t hot_add_show(struct class *class,
> > >  {
> > >  	int ret;
> > >  
> > > +	if (!try_module_get(THIS_MODULE))
> > > +		return -ENODEV;
> > > +
> > 
> > You can not increment/decrement your own module's reference count and
> > expect it to work properly, as it is still a race.
> 
> The goal here is to prevent an rmmod call if this succeeds. If it
> succeeds then any subsequent rmmod will fail. Can you explain how
> this is still racy?

{sigh}

What happens if the driver core is just about to call hot_add_show() and
the module is removed from the system.  It then calls to the memory
location that hot_add_show() was previously at, but now that is not a
valid pointer to code, and boom.

That all happened _BEFORE_ you were even able to call try_module_get().

You have to check if a function pointer is valid _BEFORE_ you call into
it.

So you might have reduced the race, but it is still there.  Odds are you
can reproduce it if you enable "overwrite module memory with 0xff when
removed" debug options.

greg k-h
