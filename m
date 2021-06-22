Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1186FC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC36461360
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFVRC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:02:27 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:35478 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFVRC0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 13:02:26 -0400
Received: by mail-pl1-f174.google.com with SMTP id b3so3103965plg.2;
        Tue, 22 Jun 2021 10:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ukZgckleaIh0b++pe9wauTAIqnu+pnTaHyS+Y4sePtY=;
        b=YmPLbZic/h+mL3oBMpWel9PL6Gu/gigi/a3oriPSIM95jzGfywdWDvnTqCb48yQ4z0
         mA8swahtoqZm6c04jEGM4OXO0JklWC1MK39L5oPQ3d0suLAj/nsMOKtc2RIsLlBg3f/4
         8qyfXTuf2QQijxM6rNgEWCAv59O29G9u6PtSk9RJU8SQiSXhajo0m37dyMNP0Kw+C4Kq
         ISjPTHEzFlUMx7+g7DPYkUy/Du4bMA1FTLDCmJnYTW05dv1XyBH5lNqy9I+vgsiT5Oio
         1rCI+mOW8oLtvR2nR9Hc2mf67JcdGQ28t1M+ByIDRd/9lntRfRkfTXKC90CFXBuTmpJv
         bA2g==
X-Gm-Message-State: AOAM530WrgxIYeVrPe23yXYi+wIuQb34VqbpzTmPu+hjYWgf6U6kOyyn
        CqA0Gy1ipoSgmb1SrrmnDqk=
X-Google-Smtp-Source: ABdhPJwUGGxgUVGgwnaFLgXLonCrkA89NCiVddv7o2kDnyXaho+bt5zGxOP/7niZOdrq3I3Pa75bRA==
X-Received: by 2002:a17:902:7c05:b029:11c:1e7d:c633 with SMTP id x5-20020a1709027c05b029011c1e7dc633mr23377607pll.48.1624381210368;
        Tue, 22 Jun 2021 10:00:10 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id c6sm10935279pfb.39.2021.06.22.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:00:09 -0700 (PDT)
Date:   Tue, 22 Jun 2021 10:00:06 -0700
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
Message-ID: <20210622170006.3c2jgi4aa4edrkax@garbanzo>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGUIzh7aR3C/Hoz@kroah.com>
 <20210622152713.fqwyuqpamwgaxomc@garbanzo>
 <YNIPiDb3TPamz5cF@kroah.com>
 <20210622164027.656zda4gjy2kjr5z@garbanzo>
 <YNIVAS45Lc5lWiCv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIVAS45Lc5lWiCv@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 06:51:13PM +0200, Greg KH wrote:
> On Tue, Jun 22, 2021 at 09:40:27AM -0700, Luis Chamberlain wrote:
> > On Tue, Jun 22, 2021 at 06:27:52PM +0200, Greg KH wrote:
> > > On Tue, Jun 22, 2021 at 08:27:13AM -0700, Luis Chamberlain wrote:
> > > > On Tue, Jun 22, 2021 at 09:41:23AM +0200, Greg KH wrote:
> > > > > On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > > > > > +	ssize_t __ret; \
> > > > > > +	if (!try_module_get(THIS_MODULE)) \
> > > > > 
> > > > > try_module_get(THIS_MODULE) is always racy and probably does not do what
> > > > > you want it to do.  You always want to get/put module references from
> > > > > code that is NOT the code calling these functions.
> > > > 
> > > > In this case, we want it to trump module removal if it succeeds. That's all.
> > > 
> > > True, but either you stop the race, or you do not right?  If you are so
> > > invested in your load/unload test, this should show up with this code
> > > eventually as well.
> > 
> > I still do not see how the race is possible give the goal to prevent
> > module removal if a sysfs file is being used. If rmmod is taking
> > place, this simply will bail out.
> > 
> > > > > > +		return -ENODEV; \
> > > > > > +	__ret = _name ## _store(dev, attr, buf, len); \
> > > > > > +	module_put(THIS_MODULE); \
> > > > > 
> > > > > This too is going to be racy.
> > > > > 
> > > > > While fun to poke at, I still think this is pointless.
> > > > 
> > > > If you have a better idea, which does not "DOS" module removal, please
> > > > let me know!
> > > 
> > > I have yet to understand why you think that the load/unload in a loop is
> > > a valid use case.
> > 
> > That is dependent upon the intrastructure tests built for a driver.
> > 
> > In the case of fstests and blktests we have drivers which *always* get
> > removed and loaded on each test. Take for instance scsi_debug, which
> > creates / destroys virtual devices on the per test. Likewise, to build
> > confidence that failure rate is as close as possible to 0, one must run
> > a test as many times as possible in a loop. And, to build confidence in
> > a test, in some situations one ends up running modprobe / rmmod in a
> > loop.
> > 
> > In this case a customer does have a complex system of tests, and by looking
> > at the crash logs I managed to simplify the way to reproduce it using
> > simple shell scripts.
> 
> And is _this_ change needed even with the changes in patch 1/3?

Oh absolutely. This patch is needed 100%. Without it, it is actually
pretty trivial to deadlock as noted in my instructions on how to
reproduce.

> I think that commit fixes your issues given that you will not unload the
> module until after the sysfs devices are removed from the system.  Have
> you tried that alone with your test?

I have tried that, and it does not resolve the deadlock.

It was *why* I have been insisting that this is a real issue, and why I
decided to instead try to implement something generic after I was hinted
by livepatch folks that they also had observed a similar deadlock, and
so that a generic solution would be appreciated by them.

  Luis
