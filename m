Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE926C388F9
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 08:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757732168B
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 08:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr3ph2Ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460901AbgJWI4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460855AbgJWI4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 04:56:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BBC0613CE
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2020 01:56:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x20so431197qkn.1
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2020 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/YQiMsUFukSYl8/Q/63HALDXai6O+hzeyfpXCt3Cdw=;
        b=Xr3ph2Ql/XKp8mxlVLS2ZBV4K44tNeItrZUi8ibIO4VZQDaUFB31GLPMUEJN3pm6ZS
         elcaVPSJCnPzOC4Z1Y7PMJSljhL9JX2sAnnl20l/A78+4jkWNhfVjBSyi8ok0y5XPGT/
         1d45MadXyTFcakaGaC/alRaBBkvj+pVF/Q/nqq81xBSANzVqm23/vlhcN5wWMiYfAn67
         i81mGZCbhsgC/4HM53eJ3GUXBwFPxeDm3JL7IJq2BJYiX/8M51yeD7Z+E5bqsJarwx5a
         DQjgiJKuYtfj9ie1pX+9VzJc1XRmmzDfVpZkSk4P7CLgTIfqSIeVSHq9akAN6lA/cHz6
         +zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/YQiMsUFukSYl8/Q/63HALDXai6O+hzeyfpXCt3Cdw=;
        b=dx6uK6yxjgK4uNgH8iTtT7dHDqzTyKSwuQFPcvV9aaIwkkJbfK0J56qY4ZkUaxi2Fk
         0dsvjzbn5Rv12A++lg/OyhabelX2ZyMV04QfV98WEBoASWl1Z7KKoIDu88UQKuUK288G
         MiSj/g2Psv6NlgV3VbLIRPLmESBYhenEfSVo22hfW5l1+rvXFwgTXfr+Ge+dvgcMA5Sf
         yzwtM1gfW2r9wyPM/l7quJ4SSuAQm9IkG0y1OMcveabckNERGzdzJ5tUqwdf7R5NmCKS
         3UpmWr0PdaGoGZdmqRuY8stNDnvbRQW0+9jvAgm87jbxIBagDgw5woiQW+aDhj46ZArV
         x6ng==
X-Gm-Message-State: AOAM532EjQgwWlWyQsCS88TwkuYH051j5BsZ+0foLaOGBd84cxjkFJrD
        keU+bON9iQQ3ZUxRz5SYmWxK+mFKyD9LrUi8E2k=
X-Google-Smtp-Source: ABdhPJx8ZT5eH89dthQpogidY/4paZDxzHMgHZ3NwTchQl+qKCLWfADfXpHu1t9o0mWdfdOz1cSPYYsh/p9yw6scycY=
X-Received: by 2002:a37:a55:: with SMTP id 82mr1234899qkk.142.1603443379324;
 Fri, 23 Oct 2020 01:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201023064621.GA16839@192.168.3.9> <20201023084653.GD1698172@T590>
In-Reply-To: <20201023084653.GD1698172@T590>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Fri, 23 Oct 2020 16:56:08 +0800
Message-ID: <CAA70yB6HQhaoGatAHhPnNbdMZfD3SdoEdpU+ip63JPXAvbL2iA@mail.gmail.com>
Subject: Re: [PATCH RFC] block: fix inaccurate io_ticks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 23, 2020 at 4:49 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Oct 23, 2020 at 02:46:32PM +0800, Weiping Zhang wrote:
> > Do not add io_ticks if there is no infligh io when start a new IO,
> > otherwise an extra 1 jiffy will be add to this IO.
> >
> > I run the following command on a host, with different kernel version.
> >
> > fio -name=test -ioengine=sync -bs=4K -rw=write
> > -filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
> > -runtime=300 -rate=2m,2m
> >
> > If we run fio in a sync direct io mode, IO will be proccessed one by one,
> > you can see that there are 512 IOs completed in one second.
> >
> > kernel: 4.19.0
> >
> > Device: rrqm/s wrqm/s  r/s    w/s rMB/s wMB/s avgrq-sz avgqu-sz await r_await w_await svctm %util
> > vda       0.00   0.00 0.00 512.00  0.00  2.00     8.00     0.21  0.40    0.00    0.40  0.40 20.60
> >
> > The averate io.latency is 0.4ms, so the disk time cost in one second
> > should be 0.4 * 512 = 204.8 ms, that means, %util should be 20%.
> >
> > Becase update_io_ticks will add a extra 1 jiffy(1ms) for every IO, the
> > io.latency io.latency will be 1 + 0.4 = 1.4ms,
> > 1.4 * 512 = 716.8ms, so the %util show it about 72%.
> >
> > Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> > vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  1.41  72.10
> >
> > After this patch:
> > Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> > vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  0.39  20.00
> >
> > Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> >  block/blk-core.c | 19 ++++++++++++++-----
> >  block/blk.h      |  1 +
> >  block/genhd.c    |  2 +-
> >  3 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index ac00d2fa4eb4..789a5c40b6a6 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1256,14 +1256,14 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
> >  }
> >  EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
> >
> > -static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> > +static void update_io_ticks(struct hd_struct *part, unsigned long now, bool inflight)
> >  {
> >       unsigned long stamp;
> >  again:
> >       stamp = READ_ONCE(part->stamp);
> >       if (unlikely(stamp != now)) {
> > -             if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> > -                     __part_stat_add(part, io_ticks, end ? now - stamp : 1);
> > +             if (likely(cmpxchg(&part->stamp, stamp, now) == stamp) && inflight)
> > +                     __part_stat_add(part, io_ticks, now - stamp);
> >       }
> >       if (part->partno) {
> >               part = &part_to_disk(part)->part0;
> > @@ -1310,13 +1310,20 @@ void blk_account_io_done(struct request *req, u64 now)
> >
> >  void blk_account_io_start(struct request *rq)
> >  {
> > +     struct hd_struct *part;
> > +     struct request_queue *q;
> > +     int inflight;
> > +
> >       if (!blk_do_io_stat(rq))
> >               return;
> >
> >       rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
> >
> >       part_stat_lock();
> > -     update_io_ticks(rq->part, jiffies, false);
> > +     part = rq->part;
> > +     q = part_to_disk(part)->queue;
> > +     inflight = blk_mq_in_flight(q, part);
> > +     update_io_ticks(part, jiffies, inflight > 0 ? true : false);
>
> Yeah, this account issue can be fixed by applying such 'inflight' info.
> However, blk_mq_in_flight() isn't cheap enough, I did get soft lockup
> report because of blk_mq_in_flight() called in I/O path.
>
> BTW, this way is just like reverting 5b18b5a73760 ("block: delete
> part_round_stats and switch to less precise counting").
>
>
Hello Ming,

Shall we switch it to atomic mode ? update inflight_count when
start/done for every IO.
Or any other cheaper way.

>
> Thanks,
> Ming
>
