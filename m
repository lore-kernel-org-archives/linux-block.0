Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270A6C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 18:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C659611CE
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 18:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhFVSI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232938AbhFVSHb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 14:07:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30D1A611CE;
        Tue, 22 Jun 2021 18:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624385114;
        bh=hj2bshCn9HBakp2MkmnYVsO61MtgN57iW/F3DQnoags=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cf9pRhYlwSRCPu89O5QR+6/xOtfPpeBSjR3NYitaLjaIyOcLmYpY3h7eFLEXYlHFF
         t18IzywdZk/Y7NEAtnJA+0LPKuZDil+Uv0SmPiAo33L7xft3EI4/TIVEdKZ4zBHUNj
         bpizRuiPTnNfmS3LdYCLMg/8UXeKUW1Qr7YzoOpU=
Date:   Tue, 22 Jun 2021 20:05:12 +0200
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
Message-ID: <YNImWFPbVDrpTFQP@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGVI/vKSBAM8dlh@kroah.com>
 <20210622163208.epx4lf3pv2x2d5b4@garbanzo>
 <YNIa8tym7TmZFWaZ@kroah.com>
 <20210622172712.3bdlxnsghmbn6nry@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622172712.3bdlxnsghmbn6nry@garbanzo>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 10:27:12AM -0700, Luis Chamberlain wrote:
> On Tue, Jun 22, 2021 at 07:16:34PM +0200, Greg KH wrote:
> > On Tue, Jun 22, 2021 at 09:32:08AM -0700, Luis Chamberlain wrote:
> > > On Tue, Jun 22, 2021 at 09:45:39AM +0200, Greg KH wrote:
> > > > On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > > > > @@ -2048,13 +2048,19 @@ static ssize_t hot_add_show(struct class *class,
> > > > >  {
> > > > >  	int ret;
> > > > >  
> > > > > +	if (!try_module_get(THIS_MODULE))
> > > > > +		return -ENODEV;
> > > > > +
> > > > 
> > > > You can not increment/decrement your own module's reference count and
> > > > expect it to work properly, as it is still a race.
> > > 
> > > The goal here is to prevent an rmmod call if this succeeds. If it
> > > succeeds then any subsequent rmmod will fail. Can you explain how
> > > this is still racy?
> > 
> > {sigh}
> > 
> > What happens if the driver core is just about to call hot_add_show() and
> > the module is removed from the system.  It then calls to the memory
> > location that hot_add_show() was previously at, but now that is not a
> > valid pointer to code, and boom.
> 
> The new kobject_get() on patch 3/3 ensures that the device will be up
> throughout the entire life of the store call, and thus prevent the
> code being executed being removed, no?

I do not know, I no longer remember what is in that patch at the moment
as it is long-gone from my queue.

Also, if the device will be "up" for the whole lifetime, why do you need
to increment the module reference count?

thanks,

greg k-h
