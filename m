Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25F2C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40F3610CF
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 08:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhDHI4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 04:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhDHI4I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 04:56:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E798610CF;
        Thu,  8 Apr 2021 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617872156;
        bh=/gCV8q264AbYItnyZblsnp9HILxQ2LYQ2c+GJrkxghA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWoY/XxwMP+/96DP+j6tHTYDnIJE+TR2kRqp689xLMoUvkE6itIthdYry6s40o+8m
         GQBKK8NtxNcTs78VQpv4qZnDZXV0b4iGUKprrEn6+cGmf++pjdH8zJLaoDw1CIPwDJ
         FBF4mI6MVTfNnvdPZ9jkDAKDyoQ5F0EJhKHgYPAI=
Date:   Thu, 8 Apr 2021 10:55:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YG7FGRNhIfDTqgUz@kroah.com>
References: <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
 <87blap4kum.ffs@nanos.tec.linutronix.de>
 <YG6fpgmYSg/PwOrU@kroah.com>
 <nycvar.YFH.7.76.2104080957580.18270@cbobk.fhfr.pm>
 <YG66OWzum5DGcSTn@kroah.com>
 <nycvar.YFH.7.76.2104081015340.18270@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2104081015340.18270@cbobk.fhfr.pm>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 10:35:17AM +0200, Jiri Kosina wrote:
> On Thu, 8 Apr 2021, Greg KH wrote:
> 
> > > If there is a driver/subsystem code that can't handle the reverse 
> > > operation to modprobe, it clearly can't handle error handling during 
> > > modprobe (which, one would hope, is supported), and should be fixed.
> > 
> > Huh?  No, that's not the issue here, it's the issue of different
> > userspace code paths into the module at the same time that it is trying
> > to be unloaded.  That has nothing to do with loading the module the
> > first time as userspace is not touching those apis yet.
> 
> So do you claim that once the first (out of possibly many) 
> userspace-visible sysfs entry has been created during module insertion and 
> made available to userspace, there is never going to be rollback happening 
> that'd be removing that first sysfs entry again?

{sigh}

I'm not trying to argue that, no.

What I am arguing is that the complexity that the original patch was
not worth the low probablity of this actually being an issue hit in
real-life operations.

That's all, messing around with sysfs entries and module reference
counts is tricky and complex and a total mess.  We have a separation
between normal sysfs files and devices being removed that should handle
the normal operations but there are still some crazy corner cases, of
which this seems to be one.

Module removal is not a "normal" operation that can be triggered by a
system automatically without a user asking for it.  As someone reminded
me on IRC, we used to do this "automatically" for many problematic
drivers years ago for suspend/resume, that should all now be long fixed
up.

So to add crazy complexity to the kernel, for an operation that can only
be triggered manually by a root user, is not worth it in my opinion, as
the maintainer of that code the complexity was asked to be made to.

My throw-away comment of "module unloading is not supported" was an
attempt to summarize all of the above into one single sentence that
seems to have struck a nerve with a lot of people, and I appologize for
that :(

thanks,

greg k-h
