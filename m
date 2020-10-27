Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643A4C4363A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 04:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA2F21556
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 04:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpD1actg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505399AbgJ0E0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 00:26:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37152 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505398AbgJ0E0q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 00:26:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id h19so160711qtq.4
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2020 21:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oMvcF1c8a21/0G+yKHJFxhJNQuYsqkizB3YeUNdN0o=;
        b=DpD1actgnnfTgbMVlgZoSNAOBLJ4S1t7151TltvxtSX0AqO9BAtvqKYULt1OfKUJV8
         L42AofpEAkORbR+VsszI1xf2xuDSbw5RtB51b82VUjCL39FtTSC4YOhh8nX9SjRkIE0t
         RzLtU0/5DQLHMlt0eHq6fFz9iaL3h4mO52aJVjx1TDJl2feOvvU7jIzEVUihY5hRksJ6
         FWT55U3zQt08rESSbVq6rSEy/z5WynvCyHkdWNWrXijdCADiYEypsteg3i/vO3YX9aJf
         qLFwNto3EmRfs1h7hrymJ/cW1n+RaFXVi+apR55QxvwwMLv2d18JuzX1OSsoBbGx9Kzm
         301w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oMvcF1c8a21/0G+yKHJFxhJNQuYsqkizB3YeUNdN0o=;
        b=mV6dKK48WtJZ5ZWmCFfjVQt8t5xKx7gJiN7hOdAHYWOp6G9OnOXST7SLhys149QA8+
         f+YZWwGd8AsFRu24bCIovY0RjjZ7HBGU5H5yHn3SGNX2FAEQeZ7WOA34aSiPHY0xH9+I
         6QVitoG6IbDlIPcTbCiqoiGIlxjIafI/oLpwSrAg/3rogb5Xgl7tnbspOhfZYK7oNR3y
         U+lzCQtpEiqHZvgeX0j7ZHw41DFhg6J1Nb9cCM1OfQzflUNEVcAIMkIwfJbMJj62AAQl
         EY+iirXrpfkf10IPrS2lrkEVeqY6jsdFQ7/HC42DZnTrQFSwSRld48xXb1+lxVQdRXTx
         yfbA==
X-Gm-Message-State: AOAM532b5fjGT1jrl35hHW5x06/dsTYZh8eDujuga43hZPQyTD4eRbhm
        MAX5FAZJ/N0wnm3ZKevlzDSOcMXhJkN+XWGfsihgc1qdqdl3sA==
X-Google-Smtp-Source: ABdhPJzjf7o72ZRWFXxT0ubUA6BrABUawNWdQe7BsNtjgCyx8w1Ol3SmzZ1hHHYnl3z3bvQEt5jUlpKNUkAobvHz2Mo=
X-Received: by 2002:ac8:67c3:: with SMTP id r3mr429494qtp.297.1603772804804;
 Mon, 26 Oct 2020 21:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200324031942.GA3060@ming.t460p> <20200324035313.GE30700@redhat.com>
 <CAA70yB5mFgKKBbJRQ=3Nv+XbVXbSUjmnAGOsUtBT2+s9f4az+Q@mail.gmail.com>
 <CAA70yB73hVgt-KppSYaXuh_yOpmJ0zQi3hWP-236a0oUTnOxpg@mail.gmail.com> <156351603710306@mail.yandex-team.ru>
In-Reply-To: <156351603710306@mail.yandex-team.ru>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 27 Oct 2020 12:26:33 +0800
Message-ID: <CAA70yB6_vKHtWLqpkQhN9xdVsbtGxOFt6P2j5u8J1Y2SCXMvdQ@mail.gmail.com>
Subject: Re: very inaccurate %util of iostat
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 26, 2020 at 7:17 PM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> 23.10.2020, 08:51, "Weiping Zhang" <zwp10758@gmail.com>:
>
> On Fri, Oct 23, 2020 at 10:48 AM Weiping Zhang <zwp10758@gmail.com> wrote:
>
>
>  On Tue, Mar 24, 2020 at 11:54 AM Mike Snitzer <snitzer@redhat.com> wrote:
>  >
>  > On Mon, Mar 23 2020 at 11:19pm -0400,
>  > Ming Lei <ming.lei@redhat.com> wrote:
>  >
>  > > Hi Guys,
>  > >
>  > > Commit 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
>  > > changes calculation of 'io_ticks' a lot.
>  > >
>  > > In theory, io_ticks counts the time when there is any IO in-flight or in-queue,
>  > > so it has to rely on in-flight counting of IO.
>  > >
>  > > However, commit 5b18b5a73760 changes io_ticks's accounting into the
>  > > following way:
>  > >
>  > > stamp = READ_ONCE(part->stamp);
>  > > if (unlikely(stamp != now)) {
>  > > if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
>  > > __part_stat_add(part, io_ticks, 1);
>  > > }
>  > >
>  > > So this way doesn't use any in-flight IO's info, simply adding 1 if stamp
>  > > changes compared with previous stamp, no matter if there is any in-flight
>  > > IO or not.
>  > >
>  > > Now when there is very heavy IO on disks, %util is still much less than
>  > > 100%, especially on HDD, the reason could be that IO latency can be much more
>  > > than 1ms in case of 1000HZ, so the above calculation is very inaccurate.
>  > >
>  > > Another extreme example is that if IOs take long time to complete, such
>  > > as IO stall, %util may show 0% utilization, instead of 100%.
>  >
>  > Hi Ming,
>  >
>  > Your email triggered a memory of someone else (Konstantin Khlebnikov)
>  > having reported and fixed this relatively recently, please see this
>  > patchset: https://lkml.org/lkml/2020/3/2/336
>  >
>  > Obviously this needs fixing. If you have time to review/polish the
>  > proposed patches that'd be great.
>  >
>  > Mike
>  >
>
>  Hi,
>
>  commit 5b18b5a73760 makes io.util larger than the real, when IO
>  inflight count <= 1,
>  even with the commit 2b8bd423614, the problem is exist too.
>
>  static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>  {
>          unsigned long stamp;
>  again:
>          stamp = READ_ONCE(part->stamp);
>          if (unlikely(stamp != now)) {
>                  if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
>                          __part_stat_add(part, io_ticks, end ? now - stamp : 1);
>          }
>
>  when a new start, blk_account_io_start => update_io_ticks and add 1 jiffy to
>  io_ticks, even there is no IO before, so it will always add an extra 1 jiffy.
>  So we should know is there any inflight IO before.
>
>
>
>  Before commit 5b18b5a73760,
>  The io_ticks will not be added, if there is no inflight when start a new IO.
>  static void part_round_stats_single(struct request_queue *q,
>                                      struct hd_struct *part, unsigned long now,
>                                      unsigned int inflight)
>  {
>          if (inflight) {
>                  __part_stat_add(part, time_in_queue,
>                                  inflight * (now - part->stamp));
>                  __part_stat_add(part, io_ticks, (now - part->stamp));
>          }
>          part->stamp = now;
>  }
>
>
>  Reproduce:
>  fio -name=test -ioengine=sync -bs=4K -rw=write
>  -filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
>  -runtime=300 -rate=2m,2m
>
>
>
>
> Let's explain in more detail.
>
> I run the following command on a host, with different kernel version.
>
> fio -name=test -ioengine=sync -bs=4K -rw=write
> -filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
> -runtime=300 -rate=2m,2m
>
> If we run fio in a sync direct io mode, IO will be proccessed one by one,
> you can see that there are 512 IOs completed in one second.
>
>
> kernel: 4.19.0
>
> Device: rrqm/s wrqm/s r/s w/s rMB/s wMB/s
> avgrq-sz avgqu-sz await r_await w_await svctm %util
> vda 0.00 0.00 0.00 512.00 0.00 2.00
> 8.00 0.21 0.40 0.00 0.40 0.40 20.60
>
> The averate io.latency is 0.4ms
> So the disk time cost in one second should be 0.4 * 512 = 204.8 ms,
> that means, %util should be 20%.
>
>
> kernel: commit f9893351ac
> In the latest kernel commit f9893351ac, I got the follow number,
> Becase update_io_ticks will add a extra 1 jiffy(1ms) for every IO, the
> io.latency io.latency will be 1 + 0.4 = 1.4ms,
> 1.4 * 512 = 716.8ms, so the %util show it about 72%.
>
> Device r/s w/s rMB/s wMB/s rrqm/s wrqm/s
> %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm %util
> vda 0.00 512.00 0.00 2.00 0.00 0.00
> 0.00 0.00 0.00 0.40 0.20 0.00 4.00 1.41 72.10
>
> There is a big gap for %util.
>
>
> Yep. Meaning of this statistics has changed. Now it approximates count of jiffies where was running at last one request. I.e. every tiny request always accounts whole jiffy were it started/finished.
>
When Q2Q >= 1 jiffy, an extra 1jiffy was added when IO start, it's
really not reasonable,


modprobe null_blk submit_queues=8 queue_mode=2 irqmode=2 completion_nsec=100000
fio -name=test -ioengine=sync -bs=4K -rw=write -filename=/dev/nullb0
-size=100M -time_based=1 -direct=1 -runtime=300 -rate=4m &

                        w/s   w_await  %util
-----------------------------------------------
before patch 1024         0.15  100
after   patch  1024         0.15  14.5

The gap is really unacceptable.

The test patch:
https://github.com/dublio/linux/commits/fix_util_v5

> %util is still useful - it shows how disk activity is grouped across time.
>
> You could get precise "utilization" in form of average queue depth from read/write time.
It's hard to get the percent of overlap each other for inflight IOs
when device has high queue depth.
