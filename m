Return-Path: <SRS0=qssB=EA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B695AC388F7
	for <linux-block@archiver.kernel.org>; Sun, 25 Oct 2020 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F9822400
	for <linux-block@archiver.kernel.org>; Sun, 25 Oct 2020 11:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvn+usdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415447AbgJYLeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Oct 2020 07:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415446AbgJYLeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Oct 2020 07:34:15 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864F0C0613CE
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2020 04:34:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id r8so4724381qtp.13
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2020 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUQ48pjBk7UvXx6KggugK7HVt+7Lxj3VhXbBgs+/wkI=;
        b=nvn+usdXmyHCJ+Kdmo87D4sCPIvZ5vJwhWrmm6MUAhbafGNylAp0+gKTkIotABQ0ch
         i9D6nfzeEK3xXA0qC71GxON6gwBlgqsn3xDcYWO+ihzMqsZkIfA1sQLx+nyzheR8rNr0
         8G3dtUZ7xBnnEhPbZYbHUldJyXWLa9viXCXrz6qF0su1W5PX0ktJDGhMx3lS1HTgdgB5
         Y4aGvo47TOhN+6F5bVofQi6UgEMUtJz3R+yMJOYhSg71zFyHq7YkCctVs7pFYpEui94L
         Hzzb/9kvs2S/sz8GyBsiBFboBfCSsZErTpLV8DJo0QiliJU54+NTHoUqu1P8HgCWxvZc
         Bs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUQ48pjBk7UvXx6KggugK7HVt+7Lxj3VhXbBgs+/wkI=;
        b=d1j+cFyVieY2291k8xX03HGFg4ebGZeKlHvbC1GrB2jNYw85QGgxQ6q67YImxYp5b+
         hIlqhl/GCMu5PUsCD24Xf1SsxhCqS6GvxKYOa7SFIpeaReFNj+IEPvXn2pgsFR9lfUb7
         ITjqHSpVO7eO0y9EamwJ0kvKLR78Yt/8i00bISTwGlXJr/CQUfy6ujls/y60oLrhf2PP
         aW97IxaSyMM6eIsZLLt8fgPAW4oLHi8Lb5Tuy1TmaxBxejZVRE/96cCzSW4/PB3MNKDs
         t82TeZpjCC7ezC9DQH/BOQEkwXSDuGiCQokczyytrT3uxf+z4oRdQmoAeHFQEEkZQbBF
         4V9g==
X-Gm-Message-State: AOAM5306jTfTzrZ+fO+zTxd/AAbiheY65ywtZ4IrtwWhKJ0G8SrnZQTp
        NY/jJEo8cudIVopSvUxjXVLXSm04r/V42wx55XXAdwhq
X-Google-Smtp-Source: ABdhPJzCZIbbU1SeOZSunw9Qt6kLnysg/fdIqMqNfkvIQjFzSyZ+eZGgOxQCF2u24GzCr0CuAaDKMy0WNw5ygGbnejc=
X-Received: by 2002:ac8:4a0a:: with SMTP id x10mr11118847qtq.3.1603625654645;
 Sun, 25 Oct 2020 04:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201023064621.GA16839@192.168.3.9> <20201023084653.GD1698172@T590>
 <CAA70yB6HQhaoGatAHhPnNbdMZfD3SdoEdpU+ip63JPXAvbL2iA@mail.gmail.com> <20201023091103.GE1698172@T590>
In-Reply-To: <20201023091103.GE1698172@T590>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Sun, 25 Oct 2020 19:34:03 +0800
Message-ID: <CAA70yB71_xNYTJLJ9CFfz2_CG13918SCyN3iYwhNhoohkHZ4Ww@mail.gmail.com>
Subject: Re: [PATCH RFC] block: fix inaccurate io_ticks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 23, 2020 at 5:11 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Oct 23, 2020 at 04:56:08PM +0800, Weiping Zhang wrote:
> > On Fri, Oct 23, 2020 at 4:49 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Fri, Oct 23, 2020 at 02:46:32PM +0800, Weiping Zhang wrote:
> > > > Do not add io_ticks if there is no infligh io when start a new IO,
> > > > otherwise an extra 1 jiffy will be add to this IO.
> > > >
> > > > I run the following command on a host, with different kernel version.
> > > >
> > > > fio -name=test -ioengine=sync -bs=4K -rw=write
> > > > -filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
> > > > -runtime=300 -rate=2m,2m
> > > >
> > > > If we run fio in a sync direct io mode, IO will be proccessed one by one,
> > > > you can see that there are 512 IOs completed in one second.
> > > >
> > > > kernel: 4.19.0
> > > >
> > > > Device: rrqm/s wrqm/s  r/s    w/s rMB/s wMB/s avgrq-sz avgqu-sz await r_await w_await svctm %util
> > > > vda       0.00   0.00 0.00 512.00  0.00  2.00     8.00     0.21  0.40    0.00    0.40  0.40 20.60
> > > >
> > > > The averate io.latency is 0.4ms, so the disk time cost in one second
> > > > should be 0.4 * 512 = 204.8 ms, that means, %util should be 20%.
> > > >
> > > > Becase update_io_ticks will add a extra 1 jiffy(1ms) for every IO, the
> > > > io.latency io.latency will be 1 + 0.4 = 1.4ms,
> > > > 1.4 * 512 = 716.8ms, so the %util show it about 72%.
> > > >
> > > > Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> > > > vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  1.41  72.10
> > > >
> > > > After this patch:
> > > > Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> > > > vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  0.39  20.00
> > > >
> > > > Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > > ---
> > > >  block/blk-core.c | 19 ++++++++++++++-----
> > > >  block/blk.h      |  1 +
> > > >  block/genhd.c    |  2 +-
> > > >  3 files changed, 16 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > > index ac00d2fa4eb4..789a5c40b6a6 100644
> > > > --- a/block/blk-core.c
> > > > +++ b/block/blk-core.c
> > > > @@ -1256,14 +1256,14 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
> > > >
> > > > -static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> > > > +static void update_io_ticks(struct hd_struct *part, unsigned long now, bool inflight)
> > > >  {
> > > >       unsigned long stamp;
> > > >  again:
> > > >       stamp = READ_ONCE(part->stamp);
> > > >       if (unlikely(stamp != now)) {
> > > > -             if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> > > > -                     __part_stat_add(part, io_ticks, end ? now - stamp : 1);
> > > > +             if (likely(cmpxchg(&part->stamp, stamp, now) == stamp) && inflight)
> > > > +                     __part_stat_add(part, io_ticks, now - stamp);
> > > >       }
> > > >       if (part->partno) {
> > > >               part = &part_to_disk(part)->part0;
> > > > @@ -1310,13 +1310,20 @@ void blk_account_io_done(struct request *req, u64 now)
> > > >
> > > >  void blk_account_io_start(struct request *rq)
> > > >  {
> > > > +     struct hd_struct *part;
> > > > +     struct request_queue *q;
> > > > +     int inflight;
> > > > +
> > > >       if (!blk_do_io_stat(rq))
> > > >               return;
> > > >
> > > >       rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
> > > >
> > > >       part_stat_lock();
> > > > -     update_io_ticks(rq->part, jiffies, false);
> > > > +     part = rq->part;
> > > > +     q = part_to_disk(part)->queue;
> > > > +     inflight = blk_mq_in_flight(q, part);
> > > > +     update_io_ticks(part, jiffies, inflight > 0 ? true : false);
> > >
> > > Yeah, this account issue can be fixed by applying such 'inflight' info.
> > > However, blk_mq_in_flight() isn't cheap enough, I did get soft lockup
> > > report because of blk_mq_in_flight() called in I/O path.
Hello Ming,

Can you share your test script ?
> > > BTW, this way is just like reverting 5b18b5a73760 ("block: delete
> > > part_round_stats and switch to less precise counting").
> > >
> > >
> > Hello Ming,
> >
> > Shall we switch it to atomic mode ? update inflight_count when
> > start/done for every IO.
>
> That is more expensive than blk_mq_in_flight().
>
> > Or any other cheaper way.
>
> I guess it is hard to figure out one cheaper way to figure out
> IO in-flight count especially in case of multiple CPU cores and
> Millions of IOPS.
>

For io_ticks, we only need to know if there is any inflight IO and do
not care how many
inflight IOs. So an optimization at here is to test any set bit in
tagset, return true directly,
it will save some cpu cycles in most of case. Send v2 later.

Thanks
Weiping
