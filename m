Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9A2C433ED
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 06:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44626112E
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 06:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhDCGN2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Apr 2021 02:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhDCGN2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 3 Apr 2021 02:13:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 712C961003;
        Sat,  3 Apr 2021 06:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617430406;
        bh=Y19EdsrdhGf3x4JlBmdYqbFPHgo2MjSKRdLJLeg8Gh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mczABvsMfhgjK6ovuwzaRpXDE1t3ZCGwGcKM0S5Zq1w2RIaq+DXk37t7xooFnNl10
         xC98CfHncCIgN+o5kVrZPvTB5ts3Ej/J/wa/34HxJtEGvyBnVlhUdbUlwpNyw9ti2z
         jBFfQQv8/gLlaBr+lQEO8NmejGFfiPW5uD+lQCVI=
Date:   Sat, 3 Apr 2021 08:13:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YGgHg7XCHD3rATIK@kroah.com>
References: <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
 <20210402183016.GU4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402183016.GU4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 02, 2021 at 06:30:16PM +0000, Luis Chamberlain wrote:
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
> > No, please no.  Module removal is a "best effort",
> 
> Not for live patching. I am not sure if I am missing any other valid
> use case?

live patching removes modules?  We have so many code paths that are
"best effort" when it comes to module unloading, trying to resolve this
one is a valiant try, but not realistic.

> > if the system dies when it happens, that's on you. 
> 
> I think the better approach for now is simply to call testers / etc to
> deal with this open coded. I cannot be sure that other than live
> patching there may be other valid use cases for module removal, and for
> races we really may care for where userspace *will* typically be mucking
> with sysfs attributes. Monitoring my systems's sysfs attributes I am
> actually quite surprised at the random pokes at them.
> 
> > I am not willing to expend extra energy
> > and maintance of core things like sysfs for stuff like this that does
> > not matter in any system other than a developer's box.
> 
> Should we document this as well? Without this it is unclear that tons of
> random tests are sanely nullified. At least this dead lock I spotted can
> be pretty common form on many drivers.

What other drivers have this problem?

> > Lock data, not code please.  Trying to tie data structure's lifespans
> > to the lifespan of code is a tangled mess, and one that I do not want to
> > add to in any form.
> 
> Driver developers will simply have to open code these protections. In
> light of what I see on LTP / fuzzing, I suspect the use case will grow
> and we'll have to revisit this in the future. But for now, sure, we can
> just open code the required protections everywhere to not crash on module
> removal.

LTP and fuzzing too do not remove modules.  So I do not understand the
root problem here, that's just something that does not happen on a real
system.

thanks,

greg k-h
