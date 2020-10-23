Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19280C388F9
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 09:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9A4241A4
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 09:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnttPICi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461195AbgJWJLd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Oct 2020 05:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461106AbgJWJLc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 05:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603444291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ijQ6kK0YtRWVe5HPUr2IQosPARcuDmczPugAjgLMw9s=;
        b=YnttPICiN8yIQ6QDP18kC1E0721PCiKNIcHkFxaRjulte12C93y8oxNokSL6hPVV6aRYJ0
        r3Z/pB2ISiXobCqio/rMnpeT7Hs3YpznQ9egNEwYgMuLON7vNEPS6rUsXEISRYIydU0ffu
        Xi9QHA3VUjqPzf6RPfx3tXf3qELeWLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-yReuvm70MBCwbq_2wD-Yxw-1; Fri, 23 Oct 2020 05:11:29 -0400
X-MC-Unique: yReuvm70MBCwbq_2wD-Yxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7046210E2197;
        Fri, 23 Oct 2020 09:11:24 +0000 (UTC)
Received: from T590 (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 082415B4B3;
        Fri, 23 Oct 2020 09:11:06 +0000 (UTC)
Date:   Fri, 23 Oct 2020 17:11:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC] block: fix inaccurate io_ticks
Message-ID: <20201023091103.GE1698172@T590>
References: <20201023064621.GA16839@192.168.3.9>
 <20201023084653.GD1698172@T590>
 <CAA70yB6HQhaoGatAHhPnNbdMZfD3SdoEdpU+ip63JPXAvbL2iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB6HQhaoGatAHhPnNbdMZfD3SdoEdpU+ip63JPXAvbL2iA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 23, 2020 at 04:56:08PM +0800, Weiping Zhang wrote:
> On Fri, Oct 23, 2020 at 4:49 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Oct 23, 2020 at 02:46:32PM +0800, Weiping Zhang wrote:
> > > Do not add io_ticks if there is no infligh io when start a new IO,
> > > otherwise an extra 1 jiffy will be add to this IO.
> > >
> > > I run the following command on a host, with different kernel version.
> > >
> > > fio -name=test -ioengine=sync -bs=4K -rw=write
> > > -filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
> > > -runtime=300 -rate=2m,2m
> > >
> > > If we run fio in a sync direct io mode, IO will be proccessed one by one,
> > > you can see that there are 512 IOs completed in one second.
> > >
> > > kernel: 4.19.0
> > >
> > > Device: rrqm/s wrqm/s  r/s    w/s rMB/s wMB/s avgrq-sz avgqu-sz await r_await w_await svctm %util
> > > vda       0.00   0.00 0.00 512.00  0.00  2.00     8.00     0.21  0.40    0.00    0.40  0.40 20.60
> > >
> > > The averate io.latency is 0.4ms, so the disk time cost in one second
> > > should be 0.4 * 512 = 204.8 ms, that means, %util should be 20%.
> > >
> > > Becase update_io_ticks will add a extra 1 jiffy(1ms) for every IO, the
> > > io.latency io.latency will be 1 + 0.4 = 1.4ms,
> > > 1.4 * 512 = 716.8ms, so the %util show it about 72%.
> > >
> > > Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> > > vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  1.41  72.10
> > >
> > > After this patch:
> > > Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> > > vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  0.39  20.00
> > >
> > > Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > ---
> > >  block/blk-core.c | 19 ++++++++++++++-----
> > >  block/blk.h      |  1 +
> > >  block/genhd.c    |  2 +-
> > >  3 files changed, 16 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > index ac00d2fa4eb4..789a5c40b6a6 100644
> > > --- a/block/blk-core.c
> > > +++ b/block/blk-core.c
> > > @@ -1256,14 +1256,14 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
> > >  }
> > >  EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
> > >
> > > -static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> > > +static void update_io_ticks(struct hd_struct *part, unsigned long now, bool inflight)
> > >  {
> > >       unsigned long stamp;
> > >  again:
> > >       stamp = READ_ONCE(part->stamp);
> > >       if (unlikely(stamp != now)) {
> > > -             if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> > > -                     __part_stat_add(part, io_ticks, end ? now - stamp : 1);
> > > +             if (likely(cmpxchg(&part->stamp, stamp, now) == stamp) && inflight)
> > > +                     __part_stat_add(part, io_ticks, now - stamp);
> > >       }
> > >       if (part->partno) {
> > >               part = &part_to_disk(part)->part0;
> > > @@ -1310,13 +1310,20 @@ void blk_account_io_done(struct request *req, u64 now)
> > >
> > >  void blk_account_io_start(struct request *rq)
> > >  {
> > > +     struct hd_struct *part;
> > > +     struct request_queue *q;
> > > +     int inflight;
> > > +
> > >       if (!blk_do_io_stat(rq))
> > >               return;
> > >
> > >       rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
> > >
> > >       part_stat_lock();
> > > -     update_io_ticks(rq->part, jiffies, false);
> > > +     part = rq->part;
> > > +     q = part_to_disk(part)->queue;
> > > +     inflight = blk_mq_in_flight(q, part);
> > > +     update_io_ticks(part, jiffies, inflight > 0 ? true : false);
> >
> > Yeah, this account issue can be fixed by applying such 'inflight' info.
> > However, blk_mq_in_flight() isn't cheap enough, I did get soft lockup
> > report because of blk_mq_in_flight() called in I/O path.
> >
> > BTW, this way is just like reverting 5b18b5a73760 ("block: delete
> > part_round_stats and switch to less precise counting").
> >
> >
> Hello Ming,
> 
> Shall we switch it to atomic mode ? update inflight_count when
> start/done for every IO.

That is more expensive than blk_mq_in_flight().

> Or any other cheaper way.

I guess it is hard to figure out one cheaper way to figure out
IO in-flight count especially in case of multiple CPU cores and
Millions of IOPS.

Thanks,
Ming

