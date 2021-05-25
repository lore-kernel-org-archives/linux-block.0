Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4ECC2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 07:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D2E600D4
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 07:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhEYHnB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 03:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhEYHm6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 03:42:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29E356128B;
        Tue, 25 May 2021 07:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621928488;
        bh=mnSdzU4kDqVu/oeffPnpMRe1Roz53wwY5PebJ67NT48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GE15/BxAzsLFgOjQLkoHCfu3zZt8jiS0Edxn1m5IEKu8SP9+nWFXxShnzShpKwinB
         KWWyRMr5rC04uXakcrWBomsl9JGp+mcAEbOAC6AwczeXCVdnqLMAIEMX5+q1gtITNy
         kMjttCONro9CvC7T3cYAjJHFYJ/CY7BSNZG+++a4=
Date:   Tue, 25 May 2021 09:41:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <YKyqJsvds9eH3IZ7@kroah.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
 <20210519202023.GU4332@42.do-not-panic.com>
 <YKgRsCzwp2O2mYcp@kroah.com>
 <20210521201618.GX4332@42.do-not-panic.com>
 <YKgbzO0AkYN4J7Ye@kroah.com>
 <20210521210817.GY4332@42.do-not-panic.com>
 <YKi3UpQm0HUxJi87@kroah.com>
 <20210525011607.GG4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525011607.GG4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 25, 2021 at 01:16:07AM +0000, Luis Chamberlain wrote:
> On Sat, May 22, 2021 at 09:48:34AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, May 21, 2021 at 09:08:17PM +0000, Luis Chamberlain wrote:
> > > On Fri, May 21, 2021 at 10:45:00PM +0200, Greg Kroah-Hartman wrote:
> > > > I looked at the last patch here and I really do not see the issue.
> > > > 
> > > > In order for the module to be removed, zram_exit() has to return, right?
> > > 
> > > Yes, but the race is for when a module removal is ongoing, in other
> > > words, it has not yet completed, and at the same time we race touching
> > > sysfs files.
> > > 
> > > > So how can a show/store function in zram_drv.c be called after
> > > > destroy_devices() returns?
> > > 
> > > The issue can come up if we have something poke at the sysfs files *while* a
> > > removal is happening.
> > 
> > And have you seen this in the real world?  I keep asking this as module
> > removal is not an automated process so what triggers this?
> 
> No, its not seen in the real world. It was theoretical, and noted as
> possible by Minchan Kim. I reviewed it, and I agree the race is
> possible.

Ok, then really, it's not a big deal :)

> > Why do you feel that block devices are somehow more "special" here?
> 
> I am not saying they are.

Your patch made them "special", don't do that.

> > They are not, either this is "broken" for everyone, or it works for
> > everyone, don't special-case one tiny class of devices for unknown
> > reasons.
> 
> The reason dev_type_get() was implemented was precisely to allow for
> this to be expanded with the other types as they the *get* is specific to
> the type.

No, that's the wrong thing to do.

> > Your change causes another problem, if a sysfs file has show/store
> > happening, the reference count will always be bumped and so the module
> > would NOT be able to be freed.  That looks like a lovely DoS that any
> > user could cause, right?
> 
> Yes true. I think the better way to resolve that is to introduce and use
> *try* methods, and so rmmod always trumps a new *get* for these
> operations.

No, "try" methods suck, as the Yoda quote says.

> That would sole the possible "DOS" issue, precisely how I resolved this
> same concern for resolving the deadlock with try_module_get().

Should not be needed.

> > In sleeping on this 
> 
> Sorry, did you mean you thought about this, or you meant sleep as in
> the sleep context?

I thought about this, sorry for the confusion.

> > So in conclusion, the "correct" thing here seems to be two independant
> > things:
> > 	- make sure the reference count of the kobject is properly
> > 	  incremented during show/store callbacks
> > 	- grab the kobject's type/bus/whatever lock during show/store so
> > 	  that it can not race with deleting the device.
> 
> Yup. The above was a proof of concept solution using type, but indeed,
> the downside is we'd have to implement try methods when not found, and
> likely the list of types is endless.
> 
> Are there places where we cannot use the bus?

Not that I know of, all objects live on some sort of "type/bus", that's
the way the driver model works.

> > No bus/type should be special cased here, block devices are not special
> > by any means.
> > 
> > And don't mess with module reference counts, that way lies madness.  We
> > want to lock data, not code :)
> 
> Live patching needs to lock code ;) and hey it works ;)

Live patching is vodoo magic.  But it just "adds" code paths, and later,
when it feels all is good, then it can remove stuff (if it even does,
I do not remember).  Adding is easy, removing is hard.

> Addressing the kobject refecount here should in theory address most
> deadlocks (what my third patch addresses) as well becuase, as you imply,
> our protection of the kobject should prevent removal, but that's not
> always the case. I think you're failing to consider a shared global
> driver lock, which can be used on sysfs files, which in turn have
> *nothing* kref'd. And so the module removal can still try to nuke sysfs
> files, if those sysfs files like to mess with the shared global driver
> lock.

If any driver has that kind of crud, they deserve the nightmare that
would happen if it interacts this way.  Don't worry about that, it's not
a pattern that anyone should be using.

And again, if the code and data is still there, the lock is ok to grab,
there should not be a problem.  If so, we can fix the driver.

thanks,

greg k-h
