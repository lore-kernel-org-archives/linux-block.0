Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B744EC433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928D56128D
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 14:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348811AbhDGOut (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 10:50:49 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:38605 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353149AbhDGOuX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 10:50:23 -0400
Received: by mail-pj1-f50.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso1421865pji.3;
        Wed, 07 Apr 2021 07:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=boi2GdDjBf4aaH3bA5w/2O331cszGc1eNxLpxWY9wsg=;
        b=KDSINOB9bR4hD4AaYffX7/zaOA0yDEULFYnxpO7/E8Udst94nzZtqLe3m9fk0iHoWH
         dY9rtxPH6z344OrmNvEAx0uCrIKki7IkVXqQA1n2umTbFwNpN1gXB0W2ZQ/YWyxA2BSy
         k2Y3YAnv4487I7uALlNnSGLo0/8PJlbuns4m1uVH5S+rBmDjhkmbJ/3jTVUo+BC1nLWh
         IHV9zMBRr44uvIsH0Mju7oCodA1w+mxWmzAUuIdQzJ4dsg8In4Ua/qYVTf6JvFXZPLL1
         bKVai0BmqMabAa1CIrHc5KQMI3BagJeP312sX80jV0hyWxa+Yuh7gd7XAuZnjAfCunK/
         Gmrw==
X-Gm-Message-State: AOAM531zVkpAuxAjAqY/6/2hrRewR9zFTTy/VevqqCBNc1Mqx49Sf90/
        aJZfMOyXun5VlcRyVBJebyojTti2AKRN6g==
X-Google-Smtp-Source: ABdhPJy9mZKEqarLu0bzco6v8rONCslZUVdW4sUn63A9oHt3bKbnCOrgUMgvX5BnXtvtmNez+rg/QQ==
X-Received: by 2002:a17:90a:4d86:: with SMTP id m6mr3587807pjh.197.1617807013349;
        Wed, 07 Apr 2021 07:50:13 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f17sm21732898pgj.86.2021.04.07.07.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:50:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C40D1402D7; Wed,  7 Apr 2021 14:50:11 +0000 (UTC)
Date:   Wed, 7 Apr 2021 14:50:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     keescook@chromium.org, dhowells@redhat.com, hch@infradead.org,
        mbenes@suse.com, gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210407145011.GC4332@42.do-not-panic.com>
References: <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGtDzH0dEfEngCij@google.com>
 <20210405190023.GX4332@42.do-not-panic.com>
 <YGtrzXYDiO3Gf9Aa@google.com>
 <20210406002909.GY4332@42.do-not-panic.com>
 <YG0JouWqrJPHbpqz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG0JouWqrJPHbpqz@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 06, 2021 at 06:23:46PM -0700, Minchan Kim wrote:
> On Tue, Apr 06, 2021 at 12:29:09AM +0000, Luis Chamberlain wrote:
> > On Mon, Apr 05, 2021 at 12:58:05PM -0700, Minchan Kim wrote:
> > > On Mon, Apr 05, 2021 at 07:00:23PM +0000, Luis Chamberlain wrote:
> > > > Which is why the *try_module_get()* I think is much more suitable, as
> > > > it will always fails if we're already going down.
> > > 
> > > How does the try_module_get solved the problem?
> > 
> > The try stuff only resolves the deadlock. The bget() / bdput() resolves
> > the race to access to the gendisk private_data.
> 
> That's the one I missed in this discussion. Now I am reading your [2/2]
> in original patch. I thought it was just zram instance was destroyed
> by sysfs race problem so you had seen the deadlock.

Patch [2/2] indeed dealt with a zram instance race but the issue was not
a crash due to indirection, it was because of a deadlock. The deadlock
happens because a shared mutex is used both at sysfs and also on __exit.
I'll expand on the example as you request so that both issues are
clearly understood.

The zram race you spotted which could lead to a derefence and crash is
a separate one, which the bget() / bdput() on sysfs knobs resolves. That
race happens because zram's sysfs knobs don't prevent del_gendisk() from
completing currently, and so a dereference can happen.

> Hmm, we are discussing several problems all at once. I feel it's time
> to jump v2 with your way in this point. You said three different
> problems. As I asked, please write it down with more detail with
> code sequence as we discussed other thread. If you mean a deadlock,
> please write what specific locks was deadlock with it.
> It would make discussion much easier. Let's discuss the issue
> one by one in each thread.

Sure. Will post a v2.

> > But so far Greg does not see enough justification for a), so we can either
> > show how wider this issue is (which I can do using coccinelle), or we
> > just open code the try_module_get() / put on each driver that needs it
> > for now. Either way it would resolve the issue.
> 
> I second if it's general problem for drivers, I agree it's worth to
> addresss in the core unless the driver introduce the mess. I have
> no idea here since I didn't understand the problem, yet.

I suspect these issue are generic, however hard to reproduce, but this
just means busying out sysfs knobs and doing module removal can likely
cause crashes to some kernel drivers.

Since it seems the position to take is module removal is best effort,
if crashes on module removal are important to module maintainers, the
position to take is that such races are best addressed on the driver
side, not core.

> > As for b), given that I think even you had missed my attempt to
> > generialzie the bdget/bdput solution for any attribute type (did you see
> > my dev_type_get() and dev_type_put() proposed changes?), I don't think
> > this problem is yet well defined in a generic way for us to rule it out.
> > It is however easier to simply open code this per driver that needs it
> > for now given that I don't think Greg is yet convinced the deadlock is
> > yet a widespread issue. I however am pretty sure both races races *do*
> > exist outside of zram in many places.
> 
> It would be good sign to propose general solution.

Same situation here, as the race is with module removal.

Even in the case where module removal is possible today and likely
"supported" -- on livepatching, it seems we're shying away slowly from
that situation, and will likely expose a knob to ensure removing a
livepatch (and do module removal) will require a knob to be flipped
to say, "Yes, I know what I am doing").

> > They try_module_get() approach resolves the deadlock race, but it does
> > so in a lazy way. I mean lazy in that then rmmod wins over sysfs knobs.
> > So touching sysfs knobs won't make an rmmod fail. I think that's more
> > typical expected behaviour. Why? Because I find it odd that looping
> > forever touching sysfs attributes should prevent a module removal. But
> > that's a personal preference.
> 
> I agree with you that would be better but let's see how it could go
> clean.

OK great.

> FYI, please look at hot_remove_store which also can remove zram
> instance on demand. I am looking forward to seeing your v2.

Sure, I'll address all sysfs knobs in v2.

  Luis
