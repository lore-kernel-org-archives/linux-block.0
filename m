Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9DDC4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 14:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1017D2310C
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 14:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgLJO7A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:59:00 -0500
Received: from mx4.veeam.com ([104.41.138.86]:40640 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgLJO6q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 09:58:46 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 363EEB219A;
        Thu, 10 Dec 2020 17:57:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1607612277; bh=h8a8tajbRrtrh8f5rnpNkpWh2JRypLoe0PfOlseQFmY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=m2f1Ew3ZV8l4OJZd0aGWFA/czFEQA1Jp7o2bi+jHk0Qtgntm9fmboqnTu/zDex5EJ
         oAE0wh7/T5sD9S6lmUhK/05rFX8LV/XIWTvmfUyQyoXQwynrPfLdzaMCmcyUyvIXiP
         LEizbnfdikHDXZIAhefSRgZ3PJOktQpBCGjA1d50=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 10 Dec 2020
 15:57:55 +0100
Date:   Thu, 10 Dec 2020 17:58:14 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
Message-ID: <20201210145814.GA31521@veeam.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201209135148.GA32720@redhat.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A627066
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 12/09/2020 16:51, Mike Snitzer wrote:
> On Wed, Dec 09 2020 at  8:01am -0500,
> Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
> 
> > Hi all.
> > 
> > I try to suggest the Block Layer Interposer (blk_interposer) again.
> > It`s allows to intercept bio requests, remap bio to another devices
> > or add new bios.
> > 
> > Initially, blk_interposer was designed to be compatible with
> > device mapper. Our (my and Hannes) previous attempt to offer
> > blk_interposer integrated with device mapper did not receive
> > any comments from the dm-devel team, and without their help
> > I will not be able to make a full implementation. I hope later
> > they will have time to support blk_interposer in device mapper.
> 
> Excuse me?  I gave you quite a bit of early feedback!  I then went on
> PTO for ~10 days, when I returned last week I had to deal with fixing
> some 5.10 dm/block bio splitting regressions that only got resolved this
> past Saturday in time for 5.10-rc7.

Mike,

I would like to clarify some points that I've made, and also try 
to repair the damage from the misunderstandings that I think have occured.

First of all, I actually meant the feedback on Hannes's patch which was
sent on the 19th of November:
https://lore.kernel.org/linux-block/20201119164924.74401-1-hare@suse.de/

Your feedback from the 18th of November ("[PATCH 4/4] dm_interposer - 
Try to use blk_interpose in dm") is very valuable, but I am not sure that
I am currently capable of implementing the proposed DM changes.
The overall architecture of DM is still not clear to me, and I am studying
it right now.

This new patch (the one that Hannes sent on the 19th of November) is also
compatibile with DM and should not pose any problems - the architecture is
the same. There are some changes that make blk_interposer simpler and better,
plus the sample is added.

> 
> blk_interposer was/is on my short list to review closer (Hannes' version
> that refined yours a bit more).. primarily to see if I could avoid the
> extra clone and endio hooking.

Glad to hear that! In order to avoid the additional copying one can only
change an intercepted bio, which might be dangerous.

> 
> The development window for 5.11 is past, so you pushing this without
> using the approach discussed (in terms of DM) doesn't help your cause.
> 
> > And my blk-snap module requires an architecture change to
> > support blk_interposer.
> > 
> > This time I offer it along with a sample.
> > Despite the fact that blk_interposer is quite simple,
> > there are a few non-obvious points that I would like to clarify.
> > 
> > However, I suggest the blk_interposer now so that people
> > could discuss it and use it in their projects as soon as possible.
> 
> So you weren't willing to put the work in on something DM oriented
> because you expected me to do the work for you?  And now you're looking
> to side-step the consensus that was built because I didn't contribute
> quick enough?  That's pretty messed up.

I just think that no one can implement integration of DM with
blk_interposer better than dm-devel team. I will certainly try my best,
but I am afraid that such efforts will only produce incongruous
DM patches that will be a waste of time (yours and mine).

> 
> In the time-scale that is Linux kernel development.. you've really
> jumped the gun and undercut my enthusiasm to work through the details.
> I'd rather not read into your actions more than I already have here, but
> I'm not liking what you've done here.  Kind of left in dismay with how
> you decided to go down this path without a followup note to me or others
> (that I'm aware of).

I am very sorry that I undercut your enthusiasm, but, as you rightly
pointed out, another development windows is closing, and my product
is still not able to work on newer Linux versions starting from 5.8.
That fact makes me particularly sad and forces me to search for different
means to draw some attention to blk_interposer. I've seen an RHEL 8.4
alpha recently, all looks very cool there but made me even more sad ...

Also I certainly remember a separate email that was sent to you on the
7th of December. Maybe it should have been written in the already
existing thread instead.

> 
> But I'm still willing to make blk_interposer work as we all discussed
> (in terms of DM).

I want it too. However, there is a certain difficulty with usage of DM
for backup copying. For instance, there is no changed block tracking (CBT)
and right now I don't have any clue how it could be implemented
considering the existing architecture. I still hope that sometime
in future I could be offer my blk-snap module which was specifically
created for backup copying purposes.

I apologize for causing all that confusion and mess and making you upset.
I hope that all of the above makes sense to you and you will not think
that I was slacking and tried to offload all the work to your team.

> 
> Mike
> 
> > Sergei Shtepa (3):
> >   block: blk_interposer - Block Layer Interposer
> >   block: blk_interposer - sample
> >   block: blk_interposer - sample config
> > 
> >  block/blk-core.c                        |  32 +++
> >  include/linux/blk_types.h               |   6 +-
> >  include/linux/genhd.h                   |  12 +-
> >  samples/Kconfig                         |   7 +
> >  samples/Makefile                        |   1 +
> >  samples/blk_interposer/Makefile         |   2 +
> >  samples/blk_interposer/blk-interposer.c | 276 ++++++++++++++++++++++++
> >  7 files changed, 333 insertions(+), 3 deletions(-)
> >  create mode 100644 samples/blk_interposer/Makefile
> >  create mode 100644 samples/blk_interposer/blk-interposer.c
> > 
> > --
> > 2.20.1
> > 
> 

-- 
Sergei Shtepa
Veeam Software developer.
