Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA8C2B9F2
	for <linux-block@archiver.kernel.org>; Sat, 22 May 2021 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD326120D
	for <linux-block@archiver.kernel.org>; Sat, 22 May 2021 07:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhEVHuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 May 2021 03:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhEVHuC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 May 2021 03:50:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28F3B611ED;
        Sat, 22 May 2021 07:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621669716;
        bh=ItPVf32V/JWLFVBmSIyXUA7rG+RBAb+2CJPBKMiVZxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEm6eeg5BkcM1lgPpCd68Ryv1MiH0N6mNy45DPSn+JHHkXJi3DZLeWvF5zXAWrmaU
         zpsF5frtYhW31/tAODKZrIMx7oLj4raJwSlhIhYX/AnyF03n6R8XvQcgVnjvnRYEKD
         Ya1EmiP88mP8eDKMv4Nlt25L/1kXpPFFCcajRaPo=
Date:   Sat, 22 May 2021 09:48:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <YKi3UpQm0HUxJi87@kroah.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
 <20210519202023.GU4332@42.do-not-panic.com>
 <YKgRsCzwp2O2mYcp@kroah.com>
 <20210521201618.GX4332@42.do-not-panic.com>
 <YKgbzO0AkYN4J7Ye@kroah.com>
 <20210521210817.GY4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521210817.GY4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 09:08:17PM +0000, Luis Chamberlain wrote:
> On Fri, May 21, 2021 at 10:45:00PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, May 21, 2021 at 08:16:18PM +0000, Luis Chamberlain wrote:
> > > On Fri, May 21, 2021 at 10:01:52PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, May 19, 2021 at 08:20:23PM +0000, Luis Chamberlain wrote:
> > > > > Greg,
> > > > > 
> > > > > your feedback would be appreciated here.
> > > > 
> > > > Appreciated where?  This is a zram patchset, what do I need to mess with
> > > > it for?
> > > 
> > > This patchset has 2 issues which I noted in the last series that are
> > > generic, and could best be dealt with on sysfs, and suggested
> > > how this could actually be dealt with on sysfs / kernfs.
> > > 
> > > > > Greg, can you comment on technical levels why a general core fix is not
> > > > > desirable upstream for those two issues?
> > > > 
> > > > What issues exactly?
> > > 
> > > When I suggested the generic way to fix this your main argument against
> > > a generic solution was that we don't support module removal. Given that
> > > argument did not seem to hold any water it begs the question if you
> > > still would rather not see this fixed in sysfs / kernfs.
> > > 
> > > If you however are more open to it now, I can instead take that work, and
> > > send a proper patch for review.
> > 
> > I looked at the last patch here and I really do not see the issue.
> > 
> > In order for the module to be removed, zram_exit() has to return, right?
> 
> Yes, but the race is for when a module removal is ongoing, in other
> words, it has not yet completed, and at the same time we race touching
> sysfs files.
> 
> > So how can a show/store function in zram_drv.c be called after
> > destroy_devices() returns?
> 
> The issue can come up if we have something poke at the sysfs files *while* a
> removal is happening.

And have you seen this in the real world?  I keep asking this as module
removal is not an automated process so what triggers this?

> > The changelog text in patch 4/4 is odd, destroy_devices() shouldn't be
> > racing with anything as devices have reference counts in order to
> > protect this type of thing from happening, right?
> 
> The race is beyond the scope of the driver in that the sysfs file can be
> poked at while a removal is ongoing. After that consider the possible
> races that can happen.
> 
> > How can a store
> > function be called when a device is somehow removed from memory at the
> > same time?  Don't we properly incremement/decrement the device
> > structure's reference count?  If not, wouldn't that be the simplest
> > solution here?
> 
> In this case the proper refcounting has to be down on the type of
> device, and so bdgrab(dev_to_bdev(dev)), because otherwise the pointer
> for the zram device is just not valid, so we can't do sanity checks
> on the sysfs calls for the zram device as the pointer can be invalid.
> To validate the pointer we must do refcounting below a layer. In this
> case for a disk.
> 
> And so genericaly this would be:
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4a8bf8cda52b..7c897e3f4135 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/sysfs.h>
>  #include <linux/dma-map-ops.h> /* for dma_default_coherent */
> +#include <linux/blkdev.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -1988,11 +1989,20 @@ static inline int device_is_not_partition(struct device *dev)
>  {
>  	return !(dev->type == &part_type);
>  }
> +static inline bool device_is_disk(struct device *dev)
> +{
> +	return (dev->type == &disk_type);
> +}
>  #else
>  static inline int device_is_not_partition(struct device *dev)
>  {
>  	return 1;
>  }
> +
> +static inline bool device_is_disk(struct device *dev)
> +{
> +	return false;
> +}
>  #endif
>  
>  static int
> @@ -2037,6 +2047,19 @@ const char *dev_driver_string(const struct device *dev)
>  }
>  EXPORT_SYMBOL(dev_driver_string);
>  
> +static int dev_type_get(struct device *dev)
> +{
> +	if (device_is_disk(dev))
> +		return !!bdgrab(dev_to_bdev(dev));
> +	return 1;
> +}

Why do you feel that block devices are somehow more "special" here?

They are not, either this is "broken" for everyone, or it works for
everyone, don't special-case one tiny class of devices for unknown
reasons.

Your change causes another problem, if a sysfs file has show/store
happening, the reference count will always be bumped and so the module
would NOT be able to be freed.  That looks like a lovely DoS that any
user could cause, right?

In sleeping on this the "correct" solution is to grab the bus lock (or
ktype lock) for the device during show/store so that the "delete device"
process can not race with it.  Also let's make sure that the kref of the
kobject is being properly bumped during show/store as well, I don't
think that's happening which isn't a good thing no matter what
(different type of bug).

If that lock addition ends up showing up in benchmarks, then we can
always move it to rcu.

So in conclusion, the "correct" thing here seems to be two independant
things:
	- make sure the reference count of the kobject is properly
	  incremented during show/store callbacks
	- grab the kobject's type/bus/whatever lock during show/store so
	  that it can not race with deleting the device.

No bus/type should be special cased here, block devices are not special
by any means.

And don't mess with module reference counts, that way lies madness.  We
want to lock data, not code :)

thanks,

greg k-h
