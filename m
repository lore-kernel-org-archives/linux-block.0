Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E08C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC8961350
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFVQxd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFVQxd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 12:53:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EDAC6128E;
        Tue, 22 Jun 2021 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624380676;
        bh=ZXlkTZX6Tudkgfar5PkNmeT+CT5P5hXiz5hIX/JI384=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmyNEqn3BE7FQPN4DjP5s4Nsy3d7Xe0JNycKT4NX/8kBIGRPPKjlLj5jJicRlP+XG
         j2G3XZvYVHJXy7PKr6vo9MmQspERB5jacRaXvvmxWeyiAra/fXCY9GDDcJuXRIBHNP
         +p6yf+JgFajCmahWTXH+vmqgFPpunOh3GXxDCaL4=
Date:   Tue, 22 Jun 2021 18:51:13 +0200
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
Message-ID: <YNIVAS45Lc5lWiCv@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGUIzh7aR3C/Hoz@kroah.com>
 <20210622152713.fqwyuqpamwgaxomc@garbanzo>
 <YNIPiDb3TPamz5cF@kroah.com>
 <20210622164027.656zda4gjy2kjr5z@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622164027.656zda4gjy2kjr5z@garbanzo>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 09:40:27AM -0700, Luis Chamberlain wrote:
> On Tue, Jun 22, 2021 at 06:27:52PM +0200, Greg KH wrote:
> > On Tue, Jun 22, 2021 at 08:27:13AM -0700, Luis Chamberlain wrote:
> > > On Tue, Jun 22, 2021 at 09:41:23AM +0200, Greg KH wrote:
> > > > On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > > > > +	ssize_t __ret; \
> > > > > +	if (!try_module_get(THIS_MODULE)) \
> > > > 
> > > > try_module_get(THIS_MODULE) is always racy and probably does not do what
> > > > you want it to do.  You always want to get/put module references from
> > > > code that is NOT the code calling these functions.
> > > 
> > > In this case, we want it to trump module removal if it succeeds. That's all.
> > 
> > True, but either you stop the race, or you do not right?  If you are so
> > invested in your load/unload test, this should show up with this code
> > eventually as well.
> 
> I still do not see how the race is possible give the goal to prevent
> module removal if a sysfs file is being used. If rmmod is taking
> place, this simply will bail out.
> 
> > > > > +		return -ENODEV; \
> > > > > +	__ret = _name ## _store(dev, attr, buf, len); \
> > > > > +	module_put(THIS_MODULE); \
> > > > 
> > > > This too is going to be racy.
> > > > 
> > > > While fun to poke at, I still think this is pointless.
> > > 
> > > If you have a better idea, which does not "DOS" module removal, please
> > > let me know!
> > 
> > I have yet to understand why you think that the load/unload in a loop is
> > a valid use case.
> 
> That is dependent upon the intrastructure tests built for a driver.
> 
> In the case of fstests and blktests we have drivers which *always* get
> removed and loaded on each test. Take for instance scsi_debug, which
> creates / destroys virtual devices on the per test. Likewise, to build
> confidence that failure rate is as close as possible to 0, one must run
> a test as many times as possible in a loop. And, to build confidence in
> a test, in some situations one ends up running modprobe / rmmod in a
> loop.
> 
> In this case a customer does have a complex system of tests, and by looking
> at the crash logs I managed to simplify the way to reproduce it using
> simple shell scripts.

And is _this_ change needed even with the changes in patch 1/3?

I think that commit fixes your issues given that you will not unload the
module until after the sysfs devices are removed from the system.  Have
you tried that alone with your test?

thanks,

greg k-h
