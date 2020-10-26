Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D203C4363A
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 11:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D15922263
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 11:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYmg6Wog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772744AbgJZLDX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 07:03:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43726 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772763AbgJZLDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 07:03:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id e6so6311638qtw.10
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2020 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFcwxqFvj0RRk921Odeux/vFUDtVQ7VYEq6VUwfS6zQ=;
        b=QYmg6Wog7duMWbnuTcC97Ia8vmRsbxSWXVskPvLoZN53moClmusFjiH/I8J4mmSj5i
         MJCiikk94+FlQoaI7BeB3VqoXtGx7aF/kFnI5tIBfn4D3lWhpWgaEwCNgZURu1/rbBCE
         3u2USCHn8KHR2ptXkz/r8XQ/XPox9IfsmkgM1e3ZzWK3uaRfPlvRMTbMJY+rlSjVnAg1
         rSdqRHKXx7PmW9GbsaTFPLxZNf794Gc8406IW4xR6WiBeOfyVrB084Y6zOX/38Q1+JCt
         TXtWjwOSRf+kcEIHDPSZ2tGA9SXpeGjc/zud3BivHvv84IekmB4Qid/yAxqh0MkXTm0L
         wqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFcwxqFvj0RRk921Odeux/vFUDtVQ7VYEq6VUwfS6zQ=;
        b=rvGWn0dm3ECfEKQ4ZB91/NhDop6BsoCkUk0bs5p6vPV8Ikv9zP0/sgimMkPCbjs9xJ
         P0hUu9PFv9gdLKwsi3TuFbRUzTK+8jqhaiJvnEAuCZ8jUS35KTvU5yvVfXbeFIunRT4F
         ko2KjYXN1WESj4/4dkXZSF+PSs+ScAgDRpyhYWxHaI9vs6LWYCBIuZ2T541ntGK5gEej
         GXztVm+3ess19nfIWlR4Qrg6igwGqdbAg2aNNrtvsWCF8oK3de6DjTiK0Sh7/TIYZpzP
         wI9njCi/GOGxl9D/6oy74nAPwmmRsJqsTaYkrgEMlOSEutH+cPwMUQEIXpFUxxBWqpV9
         YAbA==
X-Gm-Message-State: AOAM531pArmprzIDIDLb+mwW+LGsOAQal3rksK9OGgusleB3bjrTUd0R
        gL9DzVQGg4YxQcfiLlKsv1CFnHwGnbt2BM85yy4=
X-Google-Smtp-Source: ABdhPJw5s2ALEweDcIZrfM0lYp8nFyqEaRcxNJNOLs8sZU5wFjtqpCmNPDCfNBP5wCNevPbfeNZd/daHNZDM0y3hyO0=
X-Received: by 2002:ac8:4c9b:: with SMTP id j27mr1987026qtv.342.1603710201058;
 Mon, 26 Oct 2020 04:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201026061533.GA23974@192.168.3.9> <20201026092118.GA1779085@T590>
In-Reply-To: <20201026092118.GA1779085@T590>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Mon, 26 Oct 2020 19:03:10 +0800
Message-ID: <CAA70yB6m0E2oFq-C_qoy-HriZ_qPe687OUkZgnqJLw1M3Wd=Ww@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] block: fix inaccurate io_ticks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 26, 2020 at 6:15 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Oct 26, 2020 at 02:15:34PM +0800, Weiping Zhang wrote:
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
> > io.latency will be 1 + 0.4 = 1.4ms, 1.4 * 512 = 716.8ms,
> > so the %util show it about 72%.
> >
> > Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> > vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  1.41  72.10
> >
> > After this patch:
> > Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> > vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  0.39  20.00
> >
> > Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> > Fixes: 2b8bd423614c ("block/diskstats: more accurate approximation of io_ticks for slow disks")
> > Reported-by: Yabin Li <liyabinliyabin@didiglobal.com>
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> >  block/blk-core.c | 19 ++++++++++++++-----
> >  block/blk-mq.c   | 26 ++++++++++++++++++++++++++
> >  block/blk-mq.h   |  1 +
> >  block/blk.h      |  1 +
> >  block/genhd.c    | 13 +++++++++++++
> >  5 files changed, 55 insertions(+), 5 deletions(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index ac00d2fa4eb4..9dad92355125 100644
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
> > +     bool inflight;
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
> > +     inflight = blk_mq_part_is_in_flight(q, part);
> > +     update_io_ticks(part, jiffies, inflight);
>
> This way is much worse than before commit 5b18b5a73760("block: delete part_round_stats
> and switch to less precise counting") which only reads inflight once in every jiffy.
>
> But you switch to read inflight for _every_ IO, and this way is too bad, IMO.
>

Ya, the inflight count should be counted when part's stamp was changed,
How about like this:

+static int blk_part_get_inflight(struct hd_struct *part)
+{
+       struct request_queue *q;
+       int inflight;
+
+       q = part_to_disk(part)->queue;
+       if (queue_is_mq(q))
+               inflight = blk_mq_part_is_in_flight(q, part);
+       else
+               inflight = part_is_in_flight(part);
+
+       return inflight;
+}
+
+static void update_io_ticks(struct hd_struct *part, unsigned long
now, bool end)
 {
        unsigned long stamp;
+       int inflight = -1;
 again:
        stamp = READ_ONCE(part->stamp);
        if (unlikely(stamp != now)) {
-               if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)
&& inflight)
-                       __part_stat_add(part, io_ticks, now - stamp);
+               if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
+                       if(end) {
+                               __part_stat_add(part, io_ticks, now - stamp);
+                       } else {
+                               if (inflight == -1)
+                                       inflight = blk_part_get_inflight(part);
+                               if (inflight > 0)
+                                       __part_stat_add(part,
io_ticks, now - stamp);
+                       }
+               }
        }

> Thanks,
> Ming
>
