Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E7C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 01:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC21E61369
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 01:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhDGBX6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 21:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDGBX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 21:23:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E38C06174A;
        Tue,  6 Apr 2021 18:23:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h25so11789981pgm.3;
        Tue, 06 Apr 2021 18:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6KvFpjitWE2M71REdtEXIgBjJz1CwbeZTnbvXxt51AQ=;
        b=D4tkcUpI9qx5koPGyD4RUbTMcgdcD+9c8ADP6ykzCOVV1HCLfJQ6D2iFofpGVPcQQk
         5S1Hf7iIQ0ruOxa0tynVE6lzFa3o2IzZ0dxI18hSp/QZSgC0GoiQXWTKJyMZKpbTW3O1
         9ffdmQiTm9H0ESsvkmk62Iq721Yh0+EyIDjmACNyWe5TdEjDdGiX81GMIZRHT0aCWsPz
         w1zn1sxaX5rR0QhHMpUc4fFUfMjKdrXWBOh2xsVt9hXNKKVqIehfDIE53e8QwpYVpacT
         xzwSs+3q7/90aElFIwPipZ4fEl45WRvIyJSLN4cpPJgbGUY/FZ/cMiY8qxYDEBczoRKF
         dCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6KvFpjitWE2M71REdtEXIgBjJz1CwbeZTnbvXxt51AQ=;
        b=cMabC5P9rPEw2SW4WUJWA874mHwgoc46lurRrqC2ndcPJbuKmcL8pe9+0ESbuz2Adr
         SDLawIS6mS9MuYY8jffV/cp6wwAvFOm1G2KtzRtO9OPipcqyhvmtwJY+AJTV/7wCbQ3D
         oVfzw1n7RJEWhbGasyAjtdCFmBb2eb4sudYSSIH7DnkJjLJsQhB9rgFfFWoQDa0nU4AE
         TxmdeFzQx6hahVGxJgwnk99GWCIca2l3gTfTsIgBDO8+3oc3nrggcYATcpEu3/cd8eCM
         gcO1bsKaVURUq8+JmzLeC9K7+grL9Utp78QmJCYy8eiCPMuO9jNsoSsmaGOkoQG6NyXJ
         bvGw==
X-Gm-Message-State: AOAM530V73VaW4MPDB94qsgDYNi2LvGvH57YVyLO/+ONeB3x4rxmW/H5
        jd6GkhZ19JxpeoY1vwSYzIg=
X-Google-Smtp-Source: ABdhPJybi/R6FL+dQhERuz2JkHwBysW1ib9wOcdjZ8nfxF3HceaeJEjhqEec2GuFbCWTnFPjUuiSDQ==
X-Received: by 2002:a62:76cf:0:b029:241:ba8d:eac1 with SMTP id r198-20020a6276cf0000b0290241ba8deac1mr836749pfc.71.1617758629188;
        Tue, 06 Apr 2021 18:23:49 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:5a8:9f08:98f1:7659])
        by smtp.gmail.com with ESMTPSA id t16sm89596pfc.94.2021.04.06.18.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 18:23:48 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 6 Apr 2021 18:23:46 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, dhowells@redhat.com, hch@infradead.org,
        mbenes@suse.com, gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YG0JouWqrJPHbpqz@google.com>
References: <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGtDzH0dEfEngCij@google.com>
 <20210405190023.GX4332@42.do-not-panic.com>
 <YGtrzXYDiO3Gf9Aa@google.com>
 <20210406002909.GY4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406002909.GY4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 06, 2021 at 12:29:09AM +0000, Luis Chamberlain wrote:
> On Mon, Apr 05, 2021 at 12:58:05PM -0700, Minchan Kim wrote:
> > On Mon, Apr 05, 2021 at 07:00:23PM +0000, Luis Chamberlain wrote:
> > > On Mon, Apr 05, 2021 at 10:07:24AM -0700, Minchan Kim wrote:
> > > > On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> > > > > And come to think of it the last patch I had sent with a new
> > > > > DECLARE_RWSEM(zram_unload) also has this same issue making most
> > > > > sysfs attributes rather fragile.
> > > > 
> > > > Thanks for looking the way. I agree the single zram_index_rwlock is
> > > > not the right approach to fix it. However, I still hope we find more
> > > > generic solution to fix them at once since I see it's zram instance
> > > > racing problem.
> > > 
> > > They are 3 separate different problems. Related, but different.
> > 
> > What are 3 different problems? I am asking since I remember only two:
> > one for CPU multistate and the other one for sysfs during rmmod.
> 
> The third one is the race to use sysfs attributes and those routines
> then derefernece th egendisk private_data.

First of all, thanks for keeping discussion, Luis.

That was the one I thought race between sysfs and during rmmod.

> 
> > > If the idea then is to busy out rmmod if a sysfs attribute is being
> > > read, that could then mean rmmod can sometimes never complete. Hogging
> > > up / busying out sysfs attributes means the module cannto be removed.
> > 
> > It's true but is it a big problem? There are many cases that system
> > just return error if it's busy and rely on the admin. IMHO, rmmod should
> > be part of them.
> 
> It depends on existing userspace scripts which are used to test and
> expectations set. Consider existing tests, you would know better, and
> since you are the maintainer you decide.
> 
> I at least know for many other types of device drivers an rmmod is
> a sledge hammer.
> 
> You decide. I just thought it would be good to highlight the effect now
> rather than us considering it later.

To me, the rmmod faillure is not a big problem for zram since it's
common cases in the system with -EBUSY(Having said, I agree that's the
best if we could avoid the fail-and-retrial. IOW, -EBUSY should be
last resort unless we have nicer way.)

> 
> > > Which is why the *try_module_get()* I think is much more suitable, as
> > > it will always fails if we're already going down.
> > 
> > How does the try_module_get solved the problem?
> 
> The try stuff only resolves the deadlock. The bget() / bdput() resolves
> the race to access to the gendisk private_data.

That's the one I missed in this discussion. Now I am reading your [2/2]
in original patch. I thought it was just zram instance was destroyed
by sysfs race problem so you had seen the deadlock. I might miss the
point here, too. 

Hmm, we are discussing several problems all at once. I feel it's time
to jump v2 with your way in this point. You said three different
problems. As I asked, please write it down with more detail with
code sequence as we discussed other thread. If you mean a deadlock,
please write what specific locks was deadlock with it.
It would make discussion much easier. Let's discuss the issue
one by one in each thread.

> 
> > > > I see one of the problems is how I could make new zram object's
> > > > attribute group for zram knobs under /sys/block/zram0 since block
> > > > layer already made zram0 kobject via device_add_disk.
> > > 
> > > Right.. well the syfs attribute races uncovered here actually do
> > > apply to any block driver as well. And which is why I was aiming
> > > for something generic if possible.
> > 
> > It would be great but that's not the one we have atm so want to
> > proceed to fix anyway.
> 
> What is not the one we have atm? I *do* have a proposed generic solution
> for 2/3 issues we have been disussing:
> 
>  a) deadlock on sysfs access

This is the one I didn't understand.

>  b) gendisk private_data race

Yub.

> 
> But so far Greg does not see enough justification for a), so we can either
> show how wider this issue is (which I can do using coccinelle), or we
> just open code the try_module_get() / put on each driver that needs it
> for now. Either way it would resolve the issue.

I second if it's general problem for drivers, I agree it's worth to
addresss in the core unless the driver introduce the mess. I have
no idea here since I didn't understand the problem, yet.

> 
> As for b), given that I think even you had missed my attempt to
> generialzie the bdget/bdput solution for any attribute type (did you see
> my dev_type_get() and dev_type_put() proposed changes?), I don't think
> this problem is yet well defined in a generic way for us to rule it out.
> It is however easier to simply open code this per driver that needs it
> for now given that I don't think Greg is yet convinced the deadlock is
> yet a widespread issue. I however am pretty sure both races races *do*
> exist outside of zram in many places.

It would be good sign to propose general solution.

> 
> > > I am not sure if you missed the last hunks of the generic solution,
> > > but that would resolve the issue you noted. Here is the same approach
> > > but in a non-generic solution, specific to just one attribute so far
> > > and to zram:
> > 
> > So idea is refcount of the block_device's inode 
> 
> Yes that itself prevents races against the gendisk private_data from
> being invalid. Why because a bdget() would not be successful after
> del_gendisk():
> 
> del_gendisk() --> invalidate_partition() --> __invalidate_device() --> invalidate_inodes()
> 
> > and module_exit path
> > checks also the inode refcount to make rmmod failure?
> 
> They try_module_get() approach resolves the deadlock race, but it does
> so in a lazy way. I mean lazy in that then rmmod wins over sysfs knobs.
> So touching sysfs knobs won't make an rmmod fail. I think that's more
> typical expected behaviour. Why? Because I find it odd that looping
> forever touching sysfs attributes should prevent a module removal. But
> that's a personal preference.

I agree with you that would be better but let's see how it could go
clean.

FYI, please look at hot_remove_store which also can remove zram
instance on demand. I am looking forward to seeing your v2.

Thanks for your patience, Luis.
