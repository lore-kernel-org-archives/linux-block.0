Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5067AC433EF
	for <linux-block@archiver.kernel.org>; Tue,  3 May 2022 20:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiECUYk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 May 2022 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiECUYA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 16:24:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B651838D
        for <linux-block@vger.kernel.org>; Tue,  3 May 2022 13:20:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w17-20020a17090a529100b001db302efed6so2935288pjh.4
        for <linux-block@vger.kernel.org>; Tue, 03 May 2022 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g5LMtzys1skROqctswA1eSWK0eTDWKiAn7NGQSidIZ8=;
        b=BREJx6tAx/fQvPlYpl4Uo/zS5moXnNOfMhTESF/9dCVZliZ4tq+mpwOxxwnfA90MoA
         NrMnaxy4YIdHkpbIiWgkoDb+xRJGkpuavfMoHkIbD5ZlV46gmuien4XGCYl51+5/Ee+N
         jPia7+ih7FvPezhkw1ah94WEYJVGzDynsi5YfWGt+1IRL5Hvlqq2tdBz2pbt5jh9D3b+
         RCpu2lpbpiGdHwgou7UkhmIqwW16KWrzykscrCVafBC9qC/2dw2hCxaRVQXq//VgCI3p
         /JBh69beByf8tzLGvex9RI2IWkfPIkCNC9x+x5nBqdnB7kL5FDDUZ0G52F4se0ehBzwV
         jazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5LMtzys1skROqctswA1eSWK0eTDWKiAn7NGQSidIZ8=;
        b=Yjqle1YwWUS7gcYVukI/kMi9tsGUj/LQnbYfYBrbOGI4ifOlosojEg/OwmVWMVNTUJ
         t4fwTaUdVm/qbMrsd3DMGRJ4VNdtmpoM228eDMNn7GwowVObKfZ0/xsHUvWuWSl4NxuJ
         aO06P3HJf1r7brFkmZxo/4bIkq+JCvYandKDTCRyGrWlRVS5SeLbCKBoLwgItvdR1xwu
         nkMWHF+WKzNA2ASVDTiUoNu3nWfR1iGQFQUPND27sUugSjQhbHg5aj6/N7wCYjG40xhe
         Wq7fJOEXVblPzRvWoNSaei8210SoB3frxqM0WYsAgzRb0w/r53dw0TzhuCoFEMchcInW
         FENQ==
X-Gm-Message-State: AOAM5336xvrnEbGoBQnM+3AoloyrGgu7/gKXO3ZX3JgqP+X5txkngak+
        1Yu6F+y/KzO8ZiKiRED7zNROcfEgJtpSOw==
X-Google-Smtp-Source: ABdhPJyforDBpRYBVZ3C0B2Mxjoeow4PVxHh9oFjctvDWM7Ww1pA3rQO0GDp/CxexjvcCQ6SWEjypA==
X-Received: by 2002:a17:902:7109:b0:15c:e11e:efd with SMTP id a9-20020a170902710900b0015ce11e0efdmr18276641pll.110.1651609226172;
        Tue, 03 May 2022 13:20:26 -0700 (PDT)
Received: from localhost ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902784100b0015e8d4eb1e5sm6740525pln.47.2022.05.03.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:20:25 -0700 (PDT)
Date:   Tue, 3 May 2022 16:20:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: Nullblk configfs oddities
Message-ID: <YnGOiIrhVkRfit8m@localhost.localdomain>
References: <Yl3aQQtPQvkskXcP@localhost.localdomain>
 <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
 <b1fcc3dc-71a5-4a07-8f18-75f5e6cd7153@kernel.dk>
 <827699fb-e21b-2cad-6a6d-0a21c49f444e@nvidia.com>
 <bc93d84b-3c10-07ed-5203-9eba485fb108@kernel.dk>
 <c5418ac1-460f-348f-d7a3-d7c3a1aaad71@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5418ac1-460f-348f-d7a3-d7c3a1aaad71@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 19, 2022 at 01:23:22PM +0900, Damien Le Moal wrote:
> On 4/19/22 07:24, Jens Axboe wrote:
> > On 4/18/22 4:21 PM, Chaitanya Kulkarni wrote:
> >> On 4/18/22 15:14, Jens Axboe wrote:
> >>> On 4/18/22 3:54 PM, Chaitanya Kulkarni wrote:
> >>>> On 4/18/22 14:38, Josef Bacik wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I'm trying to add a test to fsperf and it requires the use of nullblk.  I'm
> >>>>> trying to use the configfs thing, and it's doing some odd things.  My basic
> >>>>> reproducer is
> >>>>>
> >>>>> modprobe null_blk
> >>>>> mkdir /sys/kernel/config/nullb/nullb0
> >>>>> echo some shit into the config
> >>>>> echo 1 > /sys/kernel/config/nullb/nullb0/power
> >>>>>
> >>>>> Now null_blk apparently defaults to nr_devices == 1, so it creates nullb0 on
> >>>>> modprobe.  But this doesn't show up in the configfs directory.  There's no way
> >>>>> to find this out until when I try to mkfs my nullb0 and it doesn't work.  The
> >>>>> above steps gets my device created at /dev/nullb1, but there's no actual way to
> >>>>> figure out that's what happened.  If I do something like
> >>>>> /sys/kernel/config/nullb/nullbfsperf I still just get nullb<number>, I don't get
> >>>>> my fancy name.
> >>>>>
> >>>>
> >>>> when you load module with default module parameter it will create a
> >>>> default device with no memory backed mode, that will not be visible in
> >>>> the configfs.
> >>>
> >>> Right, the problem is really that pre-configured devices (via nr_devices
> >>> being bigger than 0, which is the default) don't show up in configfs.
> >>> That, to me, is the real issue here, because it means you need to know
> >>> which ones are already setup before doing mkdir for a new one.
> >>>
> >>> On top of that, it's also odd that they don't show up there to begin
> >>> with.
> >>>
> >>
> >> it is indeed confusing, maybe we need to find a way to populate the
> >> configfs when loading the module? but I'm not sure if that is
> >> the right approach since configs ideally should be populated by
> >> user.
> >>
> >> OTOH we can make the memory_backed module param [1] so user can
> >> tentatively not use configfs and only rely on default configuration ?
> > 
> > Arguably configfs should just be disabled if loading with nr_devices
> > larger than 0, as it's a mess of an API as it stands. But probably too
> > late for that. The fact that we also have an option that's specific to
> > configfs just makes it even worse.
> > 
> > I don't know much about configfs, but pre-populating with the configured
> > devices and options would be ideal and completely solve this. I think
> > that would be the best solution given the current situation. Not that
> > it's THAT important, null_blk is a developer tool and as such can have
> > some sharper and rouger edges. Still would be nice to make it saner,
> > though.
> > 
> 
> I came up with this. It does prepopulate configfs nullb directory with the
> devices created on modprobe. But... doing an rmmod now always gives a
> "rmmod: ERROR: Module null_blk is in use" because configfs takes a ref on
> nullblk module for each entry. So the user now must do an rmdir of all
> prepopulated devices before doing rmmod. Not ideal. And messing up with
> the module references is probably not a good idea...
> 

I meant to reply to this previously, I tried this and it worked fine for me.
I'll leave it up to you guys if the new behavior is acceptable to you, but for
me this worked.  Thanks,

Josef
