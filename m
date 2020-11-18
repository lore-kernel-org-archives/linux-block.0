Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26522C5519F
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 05:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF22D24698
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 05:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0P6hCC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgKRFzV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Nov 2020 00:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKRFzV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Nov 2020 00:55:21 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205EC0613D4
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2020 21:55:20 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g20so873908qtu.4
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2020 21:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9+stv06XmqYfnxd4Gam5RDpKKF5YIl6UJbUAF1P1ys=;
        b=Q0P6hCC/ziN9pS44jx9RvewbjnL2cwPQF1+o+UstRGIGHGjc/ZXP6I7cRVsXHR5D6x
         GbZh7g/uJWqbbwVd8IcQWq48x0EOYHCB1zeSMvksQCeMVJHlG3yKlc01C7lAQ8QW4hvh
         FT/VOAez+f1YcmtsOlM8kUvjVcss14klohaa0G2C0BfEaBwvxBhie0dB7Rah0dsBwxiY
         FHasLuRqOoL5WTWzU2va9PO2XCSlwVOYz5Cr/F3nSLo6hX+C8n4jdS5RUQAeZobQldAZ
         PsUBCrHN6ExYRabArcyJXN3Lqg7aJai0X2y1Gz8TxGM60QmY89ivVW514r9muvhRVuKq
         Fj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9+stv06XmqYfnxd4Gam5RDpKKF5YIl6UJbUAF1P1ys=;
        b=iPbBxN3xNyabs7p7NgKPKxzb/cT0IblQ66k72zoYcamqkdUvsgE/doWMSTAJoCgojT
         sdBGzwhrZsuA5smvnBgE4d9xBxBaQzffSyPPL2YXE5+aOzoaGNe/VPqQFdcI+aC+OTa5
         debuEqNYuXVeW2R4XIxZEkm/VUNPnRXH+bVNsFtW/jPUIe87Nqq2GDaJXQDYiAuWjAhT
         0+nieN2sgPYBG1vYUMV+KWbYOOweU5HDKvfabbwCxOVkQusb59V/deF6JLu13WsmTWXd
         /2gZBJT2davfzPZVITRXSUOBnp1xqkgtmFjEuKT8YRXQDkAnCmm08/ILTGkirhS9/xjH
         2mjw==
X-Gm-Message-State: AOAM532keY0waSSjppqQ8IHWVnlNOGhbBEro3PbmHM2kzAq3Oy0LsX4o
        /jT4uRMjMNWHSx+Veb5Lq0vSn+pNzpWX2T45ZpcqXYCpkjUkag==
X-Google-Smtp-Source: ABdhPJzwtI1W2AJvSVb8eegz9BU9bY7/MfmBwxVYQe72bw1FGFbDpWonAgoaz2TkDASomsrQlIhtQS6FVtoGALBYfaI=
X-Received: by 2002:aed:2091:: with SMTP id 17mr3230644qtb.342.1605678919773;
 Tue, 17 Nov 2020 21:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20201027045411.GA39796@192.168.3.9> <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
 <CAA70yB6caVcKjJOTkEZa9ZBzZAHPgYrsr9nZWDgm-tfPMLGXHQ@mail.gmail.com>
 <20201117032756.GE56247@T590> <CAA70yB4G_1jHYRyVsf_mhHQA-_mGXzaZ6n4Bgtq9n-x1_Yz4rg@mail.gmail.com>
 <20201117074039.GA74954@T590>
In-Reply-To: <20201117074039.GA74954@T590>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 18 Nov 2020 13:55:08 +0800
Message-ID: <CAA70yB4c_mBxr3ftDd1omU=Piozxw2jKM0nyMmOP9P_hOYjNMQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] fix inaccurate io_ticks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 17, 2020 at 3:40 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Nov 17, 2020 at 12:59:46PM +0800, Weiping Zhang wrote:
> > On Tue, Nov 17, 2020 at 11:28 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Tue, Nov 17, 2020 at 11:01:49AM +0800, Weiping Zhang wrote:
> > > > Hi Jens,
> > > >
> > > > Ping
> > >
> > > Hello Weiping,
> > >
> > > Not sure we have to fix this issue, and adding blk_mq_queue_inflight()
> > > back to IO path brings cost which turns out to be visible, and I did
> > > get soft lockup report on Azure NVMe because of this kind of cost.
> > >
> > Have you test v5, this patch is different from v1, the v1 gets
> > inflight for each IO,
> > v5 has changed to get inflight every jiffer.
>
> I meant the issue can be reproduced on kernel before 5b18b5a73760("block:
> delete part_round_stats and switch to less precise counting").
>
> Also do we really need to fix this issue? I understand device
> utilization becomes not accurate at very small load, is it really
> worth of adding runtime load in fast path for fixing this issue?
>
Hello Ming,

The problem is user hard to know how busy disk is,
for small load, it shows high utilization, for heavy load it also shows
high utilization, that makes %util meaningless.

The following test case shows a big gap with same workload:

modprobe null_blk submit_queues=8 queue_mode=2 irqmode=2 completion_nsec=100000
fio -name=test -ioengine=sync -bs=4K -rw=write -filename=/dev/nullb0
-size=100M -time_based=1 -direct=1 -runtime=300 -rate=4m &

                        w/s   w_await  %util
-----------------------------------------------
before patch 1024         0.15  100
after   patch  1024         0.15  14.5

I know for hyper speed disk, add such accounting in fast path is harmful,
maybe we add an interface to enable/disable io_ticks accounting, like
what /sys/block/<disk>/queue/iostat does.

eg: /sys/block/<disk>/queue/iostat_io_ticks
when write 0 to it, just disable io_ticks totally.

Or any other good idea ?

> >
> > If for v5, can we reproduce it on null_blk ?
>
> No, I just saw report on Azure NVMe.
>
> >
> > > BTW, suppose the io accounting issue needs to be fixed, just wondering
> > > why not simply revert 5b18b5a73760 ("block: delete part_round_stats and
> > > switch to less precise counting"), and the original way had been worked
> > > for decades.
> > >
> > This patch is more better than before, it will break early when find there is
> > inflight io on any cpu, for the worst case(the io in running on the last cpu),
> > it iterates all cpus.
>
Yes, it's the worst case.
Actually v5 has two improvements compare to before 5b18b5a73760:
1. for io end, v5 do not get inflight count
2. for io start, v5 just find the first inflight io in any cpu, for
the worst case it does same as before.

> Please see the following case:
>
> 1) one device has 256 hw queues, and the system has 256 cpu cores, and
> each hw queue's depth is 1k.
>
> 2) there isn't any io load on CPUs(0 ~ 254)
>
> 3) heavy io load is run on CPU 255
>
> So with your trick the code still need to iterate hw queues from 0 to 254, and
> the load isn't something which can be ignored. Especially it is just for
> io accounting.
>
>
> Thanks,
> Ming
>
Thanks
