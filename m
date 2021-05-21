Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A62C04FF3
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AF3613F3
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhEUUq0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 16:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhEUUq0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 16:46:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43F4061057;
        Fri, 21 May 2021 20:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621629902;
        bh=dBtJPUN27yn1jdn6pT1FgfxJTpAhtUkIalvXAWXaQ9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqr3GPWqf47A1mgxeCi7tGC1wge27Kkw6lpjXDv2axY0wonq553ob+pg6ZwU8Uy2c
         6CU7KQTdXKpITcRe2dawwSfa5irggEmitsFSvN1TRHrulR0JudDglp27+s5OCAQIUM
         Mb3fVYMolOn0szRmRWaK6JfsvL6BJSEnKs0Aj5pQ=
Date:   Fri, 21 May 2021 22:45:00 +0200
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
Message-ID: <YKgbzO0AkYN4J7Ye@kroah.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
 <20210519202023.GU4332@42.do-not-panic.com>
 <YKgRsCzwp2O2mYcp@kroah.com>
 <20210521201618.GX4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521201618.GX4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 08:16:18PM +0000, Luis Chamberlain wrote:
> On Fri, May 21, 2021 at 10:01:52PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 19, 2021 at 08:20:23PM +0000, Luis Chamberlain wrote:
> > > Greg,
> > > 
> > > your feedback would be appreciated here.
> > 
> > Appreciated where?  This is a zram patchset, what do I need to mess with
> > it for?
> 
> This patchset has 2 issues which I noted in the last series that are
> generic, and could best be dealt with on sysfs, and suggested
> how this could actually be dealt with on sysfs / kernfs.
> 
> > > Greg, can you comment on technical levels why a general core fix is not
> > > desirable upstream for those two issues?
> > 
> > What issues exactly?
> 
> When I suggested the generic way to fix this your main argument against
> a generic solution was that we don't support module removal. Given that
> argument did not seem to hold any water it begs the question if you
> still would rather not see this fixed in sysfs / kernfs.
> 
> If you however are more open to it now, I can instead take that work, and
> send a proper patch for review.

I looked at the last patch here and I really do not see the issue.

In order for the module to be removed, zram_exit() has to return, right?
And that function calls destroy_devices() which will then remove all
devices in sysfs that are associated with this driver.  At that point in
time, sysfs detaches the attributes from kernfs so that any open file
handle that happened to be around for an attribute file will not call
back into the show/store function for that device.

Then destroy_devices() returns, and zram_exit() returns, and the module
is unloaded.

So how can a show/store function in zram_drv.c be called after
destroy_devices() returns?

The changelog text in patch 4/4 is odd, destroy_devices() shouldn't be
racing with anything as devices have reference counts in order to
protect this type of thing from happening, right?  How can a store
function be called when a device is somehow removed from memory at the
same time?  Don't we properly incremement/decrement the device
structure's reference count?  If not, wouldn't that be the simplest
solution here?

And who is ripping out zram drivers while the system is running anyway?
What workflow causes this to happen so much so that the sysfs files need
to be "protected"?  What tool/script/whatever is hammering on those
sysfs files so much while someone wants to unload the module?

What am I missing?

thanks,

greg k-h
