Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B59C43460
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 00:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C53613EB
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 00:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbhDFA3T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 20:29:19 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:37573 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242987AbhDFA3S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 20:29:18 -0400
Received: by mail-pg1-f179.google.com with SMTP id k8so9157477pgf.4;
        Mon, 05 Apr 2021 17:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bpTDpMwxa167NjcxbJJbniTo0V4vg9vOXn8pffBW4T4=;
        b=uT4x4vlUavRKSzeBdlPNLHyu34PV4kjVJ+4Vy7xONLAmYWxGFLjm+W5NCNyIxO1caD
         SnKq5wJtCQ4vaiPD7sYefShbFlPswIL0d4I1sAC3lYjtjAnquWOMhwX1VUCbwV4yDGM2
         fE8ywxPO0itR5w/UjJlr/asZoOMNOGNtobtZqgQccXlV4SalZ8DntWC1S8C5KM0pGZ9q
         xFxaRAZxdSGAU5LmIbcn47OqX2fPp0DyPZQQdKWNHANvJvkhg+IMvBcIjUyjUjFb2qU+
         TU4D/qzV65TXKKnXC3G0HD56fBGZKct7iRS+02REVLQEQcvYPJllluIhO+GRiDknsjLk
         af/g==
X-Gm-Message-State: AOAM532CURCkrYLr5bw+GXhdo6UVwSs2aGJ1M3gN8+rbZRfWQmSZgKhU
        yCXJrp6JS0r3UVFuafTpJveA8I3oxdYRjA==
X-Google-Smtp-Source: ABdhPJwb/1kNIyhCHO/72Z1GaZkbWKJ9Jab2a5CE8S13XqXSP0wnONtDOX996VGMBiXkHor/aBufMw==
X-Received: by 2002:aa7:8648:0:b029:1fd:85ae:169b with SMTP id a8-20020aa786480000b02901fd85ae169bmr25935586pfo.28.1617668951346;
        Mon, 05 Apr 2021 17:29:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p11sm508754pjo.48.2021.04.05.17.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 17:29:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9BAB5404D5; Tue,  6 Apr 2021 00:29:09 +0000 (UTC)
Date:   Tue, 6 Apr 2021 00:29:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     keescook@chromium.org, dhowells@redhat.com, hch@infradead.org,
        mbenes@suse.com, gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210406002909.GY4332@42.do-not-panic.com>
References: <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGtDzH0dEfEngCij@google.com>
 <20210405190023.GX4332@42.do-not-panic.com>
 <YGtrzXYDiO3Gf9Aa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGtrzXYDiO3Gf9Aa@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 05, 2021 at 12:58:05PM -0700, Minchan Kim wrote:
> On Mon, Apr 05, 2021 at 07:00:23PM +0000, Luis Chamberlain wrote:
> > On Mon, Apr 05, 2021 at 10:07:24AM -0700, Minchan Kim wrote:
> > > On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> > > > And come to think of it the last patch I had sent with a new
> > > > DECLARE_RWSEM(zram_unload) also has this same issue making most
> > > > sysfs attributes rather fragile.
> > > 
> > > Thanks for looking the way. I agree the single zram_index_rwlock is
> > > not the right approach to fix it. However, I still hope we find more
> > > generic solution to fix them at once since I see it's zram instance
> > > racing problem.
> > 
> > They are 3 separate different problems. Related, but different.
> 
> What are 3 different problems? I am asking since I remember only two:
> one for CPU multistate and the other one for sysfs during rmmod.

The third one is the race to use sysfs attributes and those routines
then derefernece th egendisk private_data.

> > If the idea then is to busy out rmmod if a sysfs attribute is being
> > read, that could then mean rmmod can sometimes never complete. Hogging
> > up / busying out sysfs attributes means the module cannto be removed.
> 
> It's true but is it a big problem? There are many cases that system
> just return error if it's busy and rely on the admin. IMHO, rmmod should
> be part of them.

It depends on existing userspace scripts which are used to test and
expectations set. Consider existing tests, you would know better, and
since you are the maintainer you decide.

I at least know for many other types of device drivers an rmmod is
a sledge hammer.

You decide. I just thought it would be good to highlight the effect now
rather than us considering it later.

> > Which is why the *try_module_get()* I think is much more suitable, as
> > it will always fails if we're already going down.
> 
> How does the try_module_get solved the problem?

The try stuff only resolves the deadlock. The bget() / bdput() resolves
the race to access to the gendisk private_data.

> > > I see one of the problems is how I could make new zram object's
> > > attribute group for zram knobs under /sys/block/zram0 since block
> > > layer already made zram0 kobject via device_add_disk.
> > 
> > Right.. well the syfs attribute races uncovered here actually do
> > apply to any block driver as well. And which is why I was aiming
> > for something generic if possible.
> 
> It would be great but that's not the one we have atm so want to
> proceed to fix anyway.

What is not the one we have atm? I *do* have a proposed generic solution
for 2/3 issues we have been disussing:

 a) deadlock on sysfs access
 b) gendisk private_data race

But so far Greg does not see enough justification for a), so we can either
show how wider this issue is (which I can do using coccinelle), or we
just open code the try_module_get() / put on each driver that needs it
for now. Either way it would resolve the issue.

As for b), given that I think even you had missed my attempt to
generialzie the bdget/bdput solution for any attribute type (did you see
my dev_type_get() and dev_type_put() proposed changes?), I don't think
this problem is yet well defined in a generic way for us to rule it out.
It is however easier to simply open code this per driver that needs it
for now given that I don't think Greg is yet convinced the deadlock is
yet a widespread issue. I however am pretty sure both races races *do*
exist outside of zram in many places.

> > I am not sure if you missed the last hunks of the generic solution,
> > but that would resolve the issue you noted. Here is the same approach
> > but in a non-generic solution, specific to just one attribute so far
> > and to zram:
> 
> So idea is refcount of the block_device's inode 

Yes that itself prevents races against the gendisk private_data from
being invalid. Why because a bdget() would not be successful after
del_gendisk():

del_gendisk() --> invalidate_partition() --> __invalidate_device() --> invalidate_inodes()

> and module_exit path
> checks also the inode refcount to make rmmod failure?

They try_module_get() approach resolves the deadlock race, but it does
so in a lazy way. I mean lazy in that then rmmod wins over sysfs knobs.
So touching sysfs knobs won't make an rmmod fail. I think that's more
typical expected behaviour. Why? Because I find it odd that looping
forever touching sysfs attributes should prevent a module removal. But
that's a personal preference.

  Luis
