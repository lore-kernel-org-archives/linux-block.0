Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4A8C43460
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 06:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646E261165
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 06:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhDHGSh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 02:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDHGSf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 02:18:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67CA5610E6;
        Thu,  8 Apr 2021 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617862704;
        bh=LLpGNyyaEfTjFDfZsFVz/KgbgvxlPflrA1HYb4wICzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fd2VC2NULo+VYsMZDFWiBsDRCAy1NIZrdJvFzcwcBasVpVgoGsqNl5DC0vx8THQQY
         2OPW3R+idDLnTgAvMx5URPv2y/iU2Gzgi6D87dCRQfohRQi76ObCr4Bza/WbKLV93F
         /M/yYa1hAcLugm0uENUa2/oKw7FEjHqlV8xGfnh0=
Date:   Thu, 8 Apr 2021 08:18:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YG6gLd9bnDsXhrNx@kroah.com>
References: <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
 <20210407201746.ueijmegmpbyq5quv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407201746.ueijmegmpbyq5quv@treble>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 07, 2021 at 03:17:46PM -0500, Josh Poimboeuf wrote:
> On Fri, Apr 02, 2021 at 09:54:12AM +0200, Greg KH wrote:
> > On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> > > As for the syfs deadlock possible with drivers, this fixes it in a generic way:
> > > 
> > > commit fac43d8025727a74f80a183cc5eb74ed902a5d14
> > > Author: Luis Chamberlain <mcgrof@kernel.org>
> > > Date:   Sat Mar 27 14:58:15 2021 +0000
> > > 
> > >     sysfs: add optional module_owner to attribute
> > >     
> > >     This is needed as otherwise the owner of the attribute
> > >     or group read/store might have a shared lock used on driver removal,
> > >     and deadlock if we race with driver removal.
> > >     
> > >     Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > No, please no.  Module removal is a "best effort", if the system dies
> > when it happens, that's on you.  I am not willing to expend extra energy
> > and maintance of core things like sysfs for stuff like this that does
> > not matter in any system other than a developer's box.
> 
> So I mentioned this on IRC, and some folks were surprised to hear that
> module unloading is unsupported and is just a development aid.
> 
> Is this stance documented anywhere?
> 
> If we really believe this to be true, we should make rmmod taint the
> kernel.

My throw-away comment here seems to have gotten way more attention than
it deserved, sorry about that everyone.

Nothing is supported for anything here, it's all "best effort" :)

And I would love a taint for rmmod, but what is that going to help out
with?

thanks,

greg k-h
