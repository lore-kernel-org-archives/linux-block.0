Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2EC64E75
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 11:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BABD206B7
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 11:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzZ1XQmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgKZLXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKZLXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 06:23:35 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C1DC0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 03:23:31 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so852633qtq.12
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrSNwmjeL2xlBSl2tAZW+HijmvvVQH72wAR8vpGnQXo=;
        b=GzZ1XQmgS87zZBJRslZquPaF4ObKOxIO/s+5mLl6L1sC3htxeKLJnHI2XWWIdThUBl
         gLzkAAsUmxC/M4XJu6MEtigLGtF/BfNURNaIgYwrrcF8cwqnkUFiq6619exAqxYlBBGw
         tUF/qCIXjGnp3fuj8SbrfCXpyz/srBM5qUZBf78mCauQ1s840wadRY/FFayxLNOU+O0R
         khaD44weWsS/1PJWg5C7YJs5dW5e8mvJOz4KGknHMoQS/xRLALpmdi6umX1nrZBESpeX
         qZ7mhXqe8pwhC0RAeuootBgha1lWcmRKv8vwlwbKapii8ehoxC4TV/9/zfm2qDGV+ou9
         62sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrSNwmjeL2xlBSl2tAZW+HijmvvVQH72wAR8vpGnQXo=;
        b=EOwNmRDix7h+s8iALiz1hNlr3ATNCnyPsVfFxXEsocAz9snhRdWAlVC/Ivd94EiLpF
         opVbPV1VEoGHAZKDrbLwdfyZjGvzenGhE2MMhr6g7D5cexmdHYkh5fynCLCB18LUhxxr
         187P8aSYOA1sFKrNwoefKYk1q87b4i/J14PNoeYhJT/vkxT/BJxEppPgneWMCHSci/ez
         w3nJ8pyq0VxBnTLHgI9A/WTJA3tvO8SPjwKG3OhStiLUEAS5g2igoLRHXpzgur6tMP8i
         2OFbxsRmC9BccRigAhA76lR2Yd2Pk5V6TUzQxCr2NmIFa1etPFoR+5zqekSRC0kKV8dc
         2HfA==
X-Gm-Message-State: AOAM5311rV4F+wKcv+xkYn+jCeVgPZlAmDan9BlCIx4YNI20MIOs+HZY
        9WJh69r7O1Vkt9ST5ux12rMEKMZw3nErxNv4/NY=
X-Google-Smtp-Source: ABdhPJxERWLDQCH71Gu4XFavYkzWv+DeUvRDcTysmZVW7sunLy88fsXZ0Lb3S9KAEsUZrMqKiYq9ZQ8E+NIa9m/f51k=
X-Received: by 2002:aed:3144:: with SMTP id 62mr2584286qtg.342.1606389810870;
 Thu, 26 Nov 2020 03:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20201027045411.GA39796@192.168.3.9> <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
 <CAA70yB6caVcKjJOTkEZa9ZBzZAHPgYrsr9nZWDgm-tfPMLGXHQ@mail.gmail.com>
 <20201117032756.GE56247@T590> <CAA70yB4G_1jHYRyVsf_mhHQA-_mGXzaZ6n4Bgtq9n-x1_Yz4rg@mail.gmail.com>
 <20201117074039.GA74954@T590> <CAA70yB4c_mBxr3ftDd1omU=Piozxw2jKM0nyMmOP9P_hOYjNMQ@mail.gmail.com>
In-Reply-To: <CAA70yB4c_mBxr3ftDd1omU=Piozxw2jKM0nyMmOP9P_hOYjNMQ@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Thu, 26 Nov 2020 19:23:19 +0800
Message-ID: <CAA70yB76dWneSJvtyA=1BFSJit3jzyvBAzJQYO-UHo-KACSZ9g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] fix inaccurate io_ticks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping

On Wed, Nov 18, 2020 at 1:55 PM Weiping Zhang <zwp10758@gmail.com> wrote:
>
> On Tue, Nov 17, 2020 at 3:40 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Nov 17, 2020 at 12:59:46PM +0800, Weiping Zhang wrote:
> > > On Tue, Nov 17, 2020 at 11:28 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Tue, Nov 17, 2020 at 11:01:49AM +0800, Weiping Zhang wrote:
> > > > > Hi Jens,
> > > > >
> > > > > Ping
> > > >
> > > > Hello Weiping,
> > > >
> > > > Not sure we have to fix this issue, and adding blk_mq_queue_inflight()
> > > > back to IO path brings cost which turns out to be visible, and I did
> > > > get soft lockup report on Azure NVMe because of this kind of cost.
> > > >
> > > Have you test v5, this patch is different from v1, the v1 gets
> > > inflight for each IO,
> > > v5 has changed to get inflight every jiffer.
> >
> > I meant the issue can be reproduced on kernel before 5b18b5a73760("block:
> > delete part_round_stats and switch to less precise counting").
> >
> > Also do we really need to fix this issue? I understand device
> > utilization becomes not accurate at very small load, is it really
> > worth of adding runtime load in fast path for fixing this issue?
> >
> Hello Ming,
>
> The problem is user hard to know how busy disk is,
> for small load, it shows high utilization, for heavy load it also shows
> high utilization, that makes %util meaningless.
>
> The following test case shows a big gap with same workload:
>
> modprobe null_blk submit_queues=8 queue_mode=2 irqmode=2 completion_nsec=100000
> fio -name=test -ioengine=sync -bs=4K -rw=write -filename=/dev/nullb0
> -size=100M -time_based=1 -direct=1 -runtime=300 -rate=4m &
>
>                         w/s   w_await  %util
> -----------------------------------------------
> before patch 1024         0.15  100
> after   patch  1024         0.15  14.5
>
> I know for hyper speed disk, add such accounting in fast path is harmful,
> maybe we add an interface to enable/disable io_ticks accounting, like
> what /sys/block/<disk>/queue/iostat does.
>
> eg: /sys/block/<disk>/queue/iostat_io_ticks
> when write 0 to it, just disable io_ticks totally.
>
> Or any other good idea ?
>
> > >
> > > If for v5, can we reproduce it on null_blk ?
> >
> > No, I just saw report on Azure NVMe.
> >
> > >
> > > > BTW, suppose the io accounting issue needs to be fixed, just wondering
> > > > why not simply revert 5b18b5a73760 ("block: delete part_round_stats and
> > > > switch to less precise counting"), and the original way had been worked
> > > > for decades.
> > > >
> > > This patch is more better than before, it will break early when find there is
> > > inflight io on any cpu, for the worst case(the io in running on the last cpu),
> > > it iterates all cpus.
> >
> Yes, it's the worst case.
> Actually v5 has two improvements compare to before 5b18b5a73760:
> 1. for io end, v5 do not get inflight count
> 2. for io start, v5 just find the first inflight io in any cpu, for
> the worst case it does same as before.
>
> > Please see the following case:
> >
> > 1) one device has 256 hw queues, and the system has 256 cpu cores, and
> > each hw queue's depth is 1k.
> >
> > 2) there isn't any io load on CPUs(0 ~ 254)
> >
> > 3) heavy io load is run on CPU 255
> >
> > So with your trick the code still need to iterate hw queues from 0 to 254, and
> > the load isn't something which can be ignored. Especially it is just for
> > io accounting.
> >
> >
> > Thanks,
> > Ming
> >
> Thanks
