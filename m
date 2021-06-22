Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FFC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3AE56128C
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhFVQmt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:42:49 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38827 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFVQmt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 12:42:49 -0400
Received: by mail-pf1-f182.google.com with SMTP id c8so15885pfp.5;
        Tue, 22 Jun 2021 09:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rpBPQ0Bg9AW0+TXD5fCXhcoX1goVIJufNTKJdx3B4pk=;
        b=C1h4isNdHxO88Mgc284locmC6kjJ2NQk3Fr8oBlgtLN9dcr8q2w5xnB6qSfgsmZmZF
         xKLfDqAEnq/kCM67xsnCW8qpvA1x4Lpts8X69nLyIAZHglv+Eu7EdOu++pM88xmc1TVb
         xipKq1A9c08Wb5LgPy0Rpi8yO8QxSznwSn3qSqNIBW4DiPgUvRhFBMmjSZahWAbrIB1V
         4aYvIn10UxgGj6ns5HI/V+d+hnrXFYlZJt3kINdNalpVrhQjQjLGgtuq/4aHuJsEMSS2
         eO/gE9+6P17D10dg/7Occrd0fdU1bO2sgkgIJW6zrYbKKisuffTwBsJ7Vnq2fmIPgwW9
         fauQ==
X-Gm-Message-State: AOAM531bAknPcQGpA8DNrfE9GoQ6Mb/lfGFqv9tWFtQLKcPtkrCJDZZw
        dnz7CNNIFDLox/odfOa8fTY=
X-Google-Smtp-Source: ABdhPJyHafNB0OjHID7n6XgBio9TIRONBDbHrgBM55AGmAW1gDxh6zWNv8L2U6EuSyvUhG6GFU1h/Q==
X-Received: by 2002:a65:6a05:: with SMTP id m5mr4500990pgu.319.1624380032851;
        Tue, 22 Jun 2021 09:40:32 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id n33sm13290751pgm.55.2021.06.22.09.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:40:31 -0700 (PDT)
Date:   Tue, 22 Jun 2021 09:40:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] zram: fix deadlock with sysfs attribute usage and
 driver removal
Message-ID: <20210622164027.656zda4gjy2kjr5z@garbanzo>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGUIzh7aR3C/Hoz@kroah.com>
 <20210622152713.fqwyuqpamwgaxomc@garbanzo>
 <YNIPiDb3TPamz5cF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIPiDb3TPamz5cF@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 06:27:52PM +0200, Greg KH wrote:
> On Tue, Jun 22, 2021 at 08:27:13AM -0700, Luis Chamberlain wrote:
> > On Tue, Jun 22, 2021 at 09:41:23AM +0200, Greg KH wrote:
> > > On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > > > +	ssize_t __ret; \
> > > > +	if (!try_module_get(THIS_MODULE)) \
> > > 
> > > try_module_get(THIS_MODULE) is always racy and probably does not do what
> > > you want it to do.  You always want to get/put module references from
> > > code that is NOT the code calling these functions.
> > 
> > In this case, we want it to trump module removal if it succeeds. That's all.
> 
> True, but either you stop the race, or you do not right?  If you are so
> invested in your load/unload test, this should show up with this code
> eventually as well.

I still do not see how the race is possible give the goal to prevent
module removal if a sysfs file is being used. If rmmod is taking
place, this simply will bail out.

> > > > +		return -ENODEV; \
> > > > +	__ret = _name ## _store(dev, attr, buf, len); \
> > > > +	module_put(THIS_MODULE); \
> > > 
> > > This too is going to be racy.
> > > 
> > > While fun to poke at, I still think this is pointless.
> > 
> > If you have a better idea, which does not "DOS" module removal, please
> > let me know!
> 
> I have yet to understand why you think that the load/unload in a loop is
> a valid use case.

That is dependent upon the intrastructure tests built for a driver.

In the case of fstests and blktests we have drivers which *always* get
removed and loaded on each test. Take for instance scsi_debug, which
creates / destroys virtual devices on the per test. Likewise, to build
confidence that failure rate is as close as possible to 0, one must run
a test as many times as possible in a loop. And, to build confidence in
a test, in some situations one ends up running modprobe / rmmod in a
loop.

In this case a customer does have a complex system of tests, and by looking
at the crash logs I managed to simplify the way to reproduce it using
simple shell scripts.

  Luis
