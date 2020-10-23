Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB0AC388F9
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 05:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0121534
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 05:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie8BUaiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371865AbgJWFvC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Oct 2020 01:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371860AbgJWFvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 01:51:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CA6C0613CE
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2020 22:51:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e6so133095qtw.10
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2020 22:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajRV6ZwtcrKEQ0PxHOG+UDbYC2WSEiAZW87OH6D71EY=;
        b=Ie8BUaiMcwR8gR9Swi1hTnUJqmiYE0vTHT57U4gL4O5X1Cq4EwNxN+pYEYrH1k3Nkt
         C4Cx1VO2pbI8KNLKuAPKFix/KaaLanAjv8xmgzKBYocGoO3pz1mLoDejtuvYfiH1qFgN
         3sPjRkSHjEVx81MaMKGOFiHUTHWpoG4WjTV8RZlAYG64XSmhX6MKL3/qdaxs82h66Kmo
         u0xo6339yzLu/9YJs9JHyrrdMl3TRhuhMgFXtTl9C+CVbI5D1oTJ4L8XhA2wpBLAw47d
         HOeV6q1ZYrCqEjquLnAPVJB5Vm8ZrFvP/7KkbR1/Oym+9Ias8o1V9mqF1FYFhSY/L4oM
         v4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajRV6ZwtcrKEQ0PxHOG+UDbYC2WSEiAZW87OH6D71EY=;
        b=O2a4QpKuixCQ1Ulrrl+oEjfGnxGzDPE2KQ9SRewDYrFhEqwRp8MySuo8g0Hgwu46by
         91YZOKrQfW/ckX6tBtge/sZZyK70/tV5mwEmYWoh263wBXrj6s5zZGdN9aJ782c0hWge
         3avAFMa+ZXaON6mMU/PsGPGrcQpfitpgY6lJ31VGMMvdaB/ZYMButSUCCEfavQGNciuE
         olY2GilRJgDGWzaZktJ5XqThnIVUKmc41tirFt2mmMYmP9Qt71fTaOGNB/Q75NflbLEw
         EcVzKSkKvfOut0xphHTHq0koSdTGe+4ZUDHdX+10B0i9l98mVGC24lK/QmXWBfeGKuun
         nHAg==
X-Gm-Message-State: AOAM532s7WFLqg35NjyxgmUKbrgqBTOkilqf6Wz9JTyNgGuaOGOcUrZp
        XuWF70u+gUrTNuDoXvEquehzQ8GM2iBA0G0UR4c=
X-Google-Smtp-Source: ABdhPJwQTLgCXohv2mBaUa8ALLv0v8Xjz5VPFkQpq2Zm/oA/+epbsJURPW2F8tD8CoQd3mlEg37nz3rYOQuD/BgHie0=
X-Received: by 2002:ac8:4a0a:: with SMTP id x10mr600415qtq.3.1603432260888;
 Thu, 22 Oct 2020 22:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200324031942.GA3060@ming.t460p> <20200324035313.GE30700@redhat.com>
 <CAA70yB5mFgKKBbJRQ=3Nv+XbVXbSUjmnAGOsUtBT2+s9f4az+Q@mail.gmail.com>
In-Reply-To: <CAA70yB5mFgKKBbJRQ=3Nv+XbVXbSUjmnAGOsUtBT2+s9f4az+Q@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Fri, 23 Oct 2020 13:50:49 +0800
Message-ID: <CAA70yB73hVgt-KppSYaXuh_yOpmJ0zQi3hWP-236a0oUTnOxpg@mail.gmail.com>
Subject: Re: very inaccurate %util of iostat
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, mpatocka@redhat.com,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 23, 2020 at 10:48 AM Weiping Zhang <zwp10758@gmail.com> wrote:
>
> On Tue, Mar 24, 2020 at 11:54 AM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> > On Mon, Mar 23 2020 at 11:19pm -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> >
> > > Hi Guys,
> > >
> > > Commit 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> > > changes calculation of 'io_ticks' a lot.
> > >
> > > In theory, io_ticks counts the time when there is any IO in-flight or in-queue,
> > > so it has to rely on in-flight counting of IO.
> > >
> > > However, commit 5b18b5a73760 changes io_ticks's accounting into the
> > > following way:
> > >
> > >       stamp = READ_ONCE(part->stamp);
> > >       if (unlikely(stamp != now)) {
> > >               if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> > >                       __part_stat_add(part, io_ticks, 1);
> > >       }
> > >
> > > So this way doesn't use any in-flight IO's info, simply adding 1 if stamp
> > > changes compared with previous stamp, no matter if there is any in-flight
> > > IO or not.
> > >
> > > Now when there is very heavy IO on disks, %util is still much less than
> > > 100%, especially on HDD, the reason could be that IO latency can be much more
> > > than 1ms in case of 1000HZ, so the above calculation is very inaccurate.
> > >
> > > Another extreme example is that if IOs take long time to complete, such
> > > as IO stall, %util may show 0% utilization, instead of 100%.
> >
> > Hi Ming,
> >
> > Your email triggered a memory of someone else (Konstantin Khlebnikov)
> > having reported and fixed this relatively recently, please see this
> > patchset: https://lkml.org/lkml/2020/3/2/336
> >
> > Obviously this needs fixing.  If you have time to review/polish the
> > proposed patches that'd be great.
> >
> > Mike
> >
>
> Hi,
>
> commit 5b18b5a73760   makes io.util larger than the real, when IO
> inflight count <= 1,
> even with the commit 2b8bd423614, the problem is exist too.
>
> static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> {
>         unsigned long stamp;
> again:
>         stamp = READ_ONCE(part->stamp);
>         if (unlikely(stamp != now)) {
>                 if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
>                         __part_stat_add(part, io_ticks, end ? now - stamp : 1);
>         }
>
> when a new start, blk_account_io_start => update_io_ticks and add 1 jiffy to
> io_ticks, even there is no IO before, so it will always add an extra 1 jiffy.
> So we should know is there any inflight IO before.
>
>
>
> Before commit 5b18b5a73760,
> The io_ticks will not be added, if there is no inflight when start a new IO.
> static void part_round_stats_single(struct request_queue *q,
>                                     struct hd_struct *part, unsigned long now,
>                                     unsigned int inflight)
> {
>         if (inflight) {
>                 __part_stat_add(part, time_in_queue,
>                                 inflight * (now - part->stamp));
>                 __part_stat_add(part, io_ticks, (now - part->stamp));
>         }
>         part->stamp = now;
> }
>
>
> Reproduce:
> fio -name=test -ioengine=sync -bs=4K -rw=write
> -filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
> -runtime=300 -rate=2m,2m



Let's explain in more detail.

I run the following command on a host, with different kernel version.

fio -name=test -ioengine=sync -bs=4K -rw=write
-filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
-runtime=300 -rate=2m,2m

If we run fio in a sync direct io mode, IO will be proccessed one by one,
you can see that there are 512 IOs completed in one second.


kernel: 4.19.0

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00  512.00     0.00     2.00
8.00     0.21    0.40    0.00    0.40   0.40  20.60

The averate io.latency is 0.4ms
So the disk time cost in one second should be 0.4 * 512 = 204.8 ms,
that means, %util should be 20%.


kernel: commit f9893351ac
In the latest kernel commit f9893351ac, I got the follow number,
Becase update_io_ticks will add a extra 1 jiffy(1ms) for every IO, the
io.latency io.latency will be 1 + 0.4 = 1.4ms,
1.4 * 512 = 716.8ms, so the %util show it about 72%.

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s
%rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00  512.00      0.00      2.00     0.00     0.00
0.00   0.00    0.00    0.40   0.20     0.00     4.00   1.41  72.10

There is a big gap for %util.
