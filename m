Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E048C2B9F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 01:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6561E613F9
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 01:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhEYBRk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 21:17:40 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:36659 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhEYBRk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 21:17:40 -0400
Received: by mail-pl1-f178.google.com with SMTP id a7so6824972plh.3;
        Mon, 24 May 2021 18:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/peoYV4qfip+Dwi6jSaAkkCqQ4rv2ijweu+Ayxgdr4=;
        b=YTl1Y6TQKfmmPxiKy3vkU6V2+cGpZy86YiZowbbWoHT0TkeuvpVTHQYQ+DiYNOM2TD
         pz6zPRh7ua1g2QpH9tFsX4QneDLbfRQ68lf4IbAKSfQULrFysb8WFfZSFlnXO4y3hAFV
         iSKtsbMuZz/ajQp8ozKCvCTdOCA4mBFSxXNcXNbc8h3k4n4vYU12WrtPKyJdtJLHybyY
         87sH5NWDcMH/jsJJZmfDR2BgORLXj7/mUuw2s+9vAqViN+qctAPVH9lYotKDZsF2BkD0
         z1OCYOnprm8i7ZROJcxuNb27sj4XSmtChHD1Hh1apb+NF1agbV6wzKWdOy7IkJ6qeyCC
         G9sA==
X-Gm-Message-State: AOAM533Rday2aY1/YraKF2dJ09EEe1w24bKWhEBwodDOnukhdrhwTMB0
        TsTbwfoM++x5HYQu1aiddtE=
X-Google-Smtp-Source: ABdhPJzYJitVnQtIvnlWUqvDZsOPAXFl5JCXJTdVYLBDTD3VuKj3wdspErXHeHie8oFHzeVrRl7vNg==
X-Received: by 2002:a17:902:7c94:b029:e6:e1d7:62b7 with SMTP id y20-20020a1709027c94b02900e6e1d762b7mr28252285pll.29.1621905370455;
        Mon, 24 May 2021 18:16:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r28sm12304686pgm.53.2021.05.24.18.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:16:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 099CA4025E; Tue, 25 May 2021 01:16:08 +0000 (UTC)
Date:   Tue, 25 May 2021 01:16:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <20210525011607.GG4332@42.do-not-panic.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
 <20210519202023.GU4332@42.do-not-panic.com>
 <YKgRsCzwp2O2mYcp@kroah.com>
 <20210521201618.GX4332@42.do-not-panic.com>
 <YKgbzO0AkYN4J7Ye@kroah.com>
 <20210521210817.GY4332@42.do-not-panic.com>
 <YKi3UpQm0HUxJi87@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKi3UpQm0HUxJi87@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 22, 2021 at 09:48:34AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 21, 2021 at 09:08:17PM +0000, Luis Chamberlain wrote:
> > On Fri, May 21, 2021 at 10:45:00PM +0200, Greg Kroah-Hartman wrote:
> > > I looked at the last patch here and I really do not see the issue.
> > > 
> > > In order for the module to be removed, zram_exit() has to return, right?
> > 
> > Yes, but the race is for when a module removal is ongoing, in other
> > words, it has not yet completed, and at the same time we race touching
> > sysfs files.
> > 
> > > So how can a show/store function in zram_drv.c be called after
> > > destroy_devices() returns?
> > 
> > The issue can come up if we have something poke at the sysfs files *while* a
> > removal is happening.
> 
> And have you seen this in the real world?  I keep asking this as module
> removal is not an automated process so what triggers this?

No, its not seen in the real world. It was theoretical, and noted as
possible by Minchan Kim. I reviewed it, and I agree the race is
possible.

> > And so genericaly this would be:
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4a8bf8cda52b..7c897e3f4135 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/sched/mm.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/dma-map-ops.h> /* for dma_default_coherent */
> > +#include <linux/blkdev.h>
> >  
> >  #include "base.h"
> >  #include "power/power.h"
> > @@ -1988,11 +1989,20 @@ static inline int device_is_not_partition(struct device *dev)
> >  {
> >  	return !(dev->type == &part_type);
> >  }
> > +static inline bool device_is_disk(struct device *dev)
> > +{
> > +	return (dev->type == &disk_type);
> > +}
> >  #else
> >  static inline int device_is_not_partition(struct device *dev)
> >  {
> >  	return 1;
> >  }
> > +
> > +static inline bool device_is_disk(struct device *dev)
> > +{
> > +	return false;
> > +}
> >  #endif
> >  
> >  static int
> > @@ -2037,6 +2047,19 @@ const char *dev_driver_string(const struct device *dev)
> >  }
> >  EXPORT_SYMBOL(dev_driver_string);
> >  
> > +static int dev_type_get(struct device *dev)
> > +{
> > +	if (device_is_disk(dev))
> > +		return !!bdgrab(dev_to_bdev(dev));
> > +	return 1;
> > +}
> 
> Why do you feel that block devices are somehow more "special" here?

I am not saying they are.

> They are not, either this is "broken" for everyone, or it works for
> everyone, don't special-case one tiny class of devices for unknown
> reasons.

The reason dev_type_get() was implemented was precisely to allow for
this to be expanded with the other types as they the *get* is specific to
the type.

> Your change causes another problem, if a sysfs file has show/store
> happening, the reference count will always be bumped and so the module
> would NOT be able to be freed.  That looks like a lovely DoS that any
> user could cause, right?

Yes true. I think the better way to resolve that is to introduce and use
*try* methods, and so rmmod always trumps a new *get* for these
operations.

That would sole the possible "DOS" issue, precisely how I resolved this
same concern for resolving the deadlock with try_module_get().

> In sleeping on this 

Sorry, did you mean you thought about this, or you meant sleep as in
the sleep context?

> the "correct" solution is to grab the bus lock (or
> ktype lock) for the device during show/store so that the "delete device"
> process can not race with it.

The still presents the DOS issue, which I actually did want to avoid.
I avoided it on the other deadlock issue, and so ideally I'd also
want to avoid it here. But indeed, the bus route is simple and clean.
And an alternative to the DOS issue is we just use capability checks,
if we don't do that already.

> Also let's make sure that the kref of the
> kobject is being properly bumped during show/store as well, I don't
> think that's happening which isn't a good thing no matter what
> (different type of bug).

Yup...

> If that lock addition ends up showing up in benchmarks, then we can
> always move it to rcu.

OK.

> So in conclusion, the "correct" thing here seems to be two independant
> things:
> 	- make sure the reference count of the kobject is properly
> 	  incremented during show/store callbacks
> 	- grab the kobject's type/bus/whatever lock during show/store so
> 	  that it can not race with deleting the device.

Yup. The above was a proof of concept solution using type, but indeed,
the downside is we'd have to implement try methods when not found, and
likely the list of types is endless.

Are there places where we cannot use the bus?

> No bus/type should be special cased here, block devices are not special
> by any means.
> 
> And don't mess with module reference counts, that way lies madness.  We
> want to lock data, not code :)

Live patching needs to lock code ;) and hey it works ;)

Addressing the kobject refecount here should in theory address most
deadlocks (what my third patch addresses) as well becuase, as you imply,
our protection of the kobject should prevent removal, but that's not
always the case. I think you're failing to consider a shared global
driver lock, which can be used on sysfs files, which in turn have
*nothing* kref'd. And so the module removal can still try to nuke sysfs
files, if those sysfs files like to mess with the shared global driver
lock.

  Luis
