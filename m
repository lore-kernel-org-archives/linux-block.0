Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637F0C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 06:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3124A61155
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 06:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhDHGQV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 02:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhDHGQV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 02:16:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 607ED6113E;
        Thu,  8 Apr 2021 06:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617862569;
        bh=USnkVxDQRrxu4qDsMgGinsxsKYzl9bMPrFjvuUl3TGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mH4+/i7+M/oGewHr7GPLh6g9nKk+i5PrJHX1T7CFUrpJiktIx93A7icZZL26vHeXy
         2z71d98G1GZVRTxBOXVEhocaA60BFGBZYJltX8imVVXrLVUetIilhWP6/w748XbkI+
         l05j1IWPXZL/p4UDOdBRlrrEDU7skpzXz4pRr574=
Date:   Thu, 8 Apr 2021 08:16:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YG6fpgmYSg/PwOrU@kroah.com>
References: <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
 <87blap4kum.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blap4kum.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 03:37:53AM +0200, Thomas Gleixner wrote:
> Greg,
> 
> On Fri, Apr 02 2021 at 09:54, Greg KH wrote:
> > On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> >> As for the syfs deadlock possible with drivers, this fixes it in a generic way:
> >> 
> >> commit fac43d8025727a74f80a183cc5eb74ed902a5d14
> >> Author: Luis Chamberlain <mcgrof@kernel.org>
> >> Date:   Sat Mar 27 14:58:15 2021 +0000
> >> 
> >>     sysfs: add optional module_owner to attribute
> >>     
> >>     This is needed as otherwise the owner of the attribute
> >>     or group read/store might have a shared lock used on driver removal,
> >>     and deadlock if we race with driver removal.
> >>     
> >>     Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> >
> > No, please no.  Module removal is a "best effort", if the system dies
> > when it happens, that's on you.  I am not willing to expend extra energy
> > and maintance of core things like sysfs for stuff like this that does
> > not matter in any system other than a developer's box.
> >
> > Lock data, not code please.  Trying to tie data structure's lifespans
> > to the lifespan of code is a tangled mess, and one that I do not want to
> > add to in any form.
> >
> > sorry,
> 
> Sorry, but you are fundamentaly off track here. This has absolutely
> nothing to do with module removal.
> 
> The point is that module removal is the reverse operation of module
> insertion. So far so good.
> 
> But module insertion can fail. So if you have nested functionalities
> which hang off or are enabled by moduled insertion then any fail in that
> sequence has to be able to roll back and clean up properly no matter
> what.
> 
> Which it turn makes modules removal a reverse operation of module
> insertion.
> 
> If you think otherwise, then please provide a proper plan how nested
> operations like sysfs - not to talk about more complex things like multi
> instance discovery which can happen inside a module insertion sequence
> can be properly rolled back.
> 
> Just declaring that rmmod is evil does not cut it. rmmod is the least of
> the problems. If that fails, then a lot of rollback, failure handling
> mechanisms are missing in the setup path already.
> 
> Anything which cannot cleanly rollback no matter whether the fail or
> rollback request happens at insertion time or later is broken by design.
> 
> So either you declare module removal as disfunctional or you stop making
> up semantically ill defined and therefore useless claims about it.
> 
> Your argument in:
> 
>  https://lore.kernel.org/linux-block/YGbNpLKXfWpy0ZZa@kroah.com/
> 
>  "Lock data, not code please.  Trying to tie data structure's lifespans
>   to the lifespan of code is a tangled mess, and one that I do not want to
>   add to in any form"
> 
> is just useless blurb because the fundamental purpose of discovery code
> is to create the data structures which are tied to the code which is
> associated to it.
> 
> Please stop this 'module removal' is not supported nonsense unless you
> can prove a complete indepenence of module init/discovery code to
> subsequent discovered entities depending on it.

Ok, but to be fair, trying to add the crazy hacks that were being
proposed to sysfs for something that is obviously not a code path that
can be taken by a normal user or operation is just not going to fly.

Removing a module from a system has always been "let's try it and see!"
type of operation for a very long time.  While we try our best, doing
horrible hacks for this rare type of thing are generally not considered
a good idea which is why I said that.

thanks,

greg k-h
