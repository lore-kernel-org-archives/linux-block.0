Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCA3C10DCE
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617892072D
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 10:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAYV1v4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFKEX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:04:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43120 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgCFKEX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 05:04:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id v9so1589876wrf.10
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2020 02:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHIQPGfuFmum/PwEKDVejwIheUVYeuohCB0aLHm12mA=;
        b=tAYV1v4Di2MauD4rVjCXpJ12ecWTmsMmgJZj9goRpmnE8mHnUYyZRzJvCJ0FDWkJ8L
         /lR/8mvLMBynuetc8NR0yLqPJjrh5dWbFmxv3FR1WEDYVDbgobDk8yHABmZRHk0K4hz/
         1HSqc4ANNGwEQPHs7Q7eGZVpwPYi7WM9UIRXhFNCIVABoYE+aZzDFWQOMthypaoWou72
         L0S5ZqTxVMMJJGU9m7Jue21Bfkrb3zT0e0dvwXGqLwcVxSijVgSTlJ2jtf+pPXO8MHHO
         6kZCQJw3FU1aQa4GzO5I4/vuAXbqO9MaQWOh9RBJNZKk5QyuqSH5RXtaSAkA265wEXYB
         IguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHIQPGfuFmum/PwEKDVejwIheUVYeuohCB0aLHm12mA=;
        b=nr5H+dqi1Km12ehCUt761rudj3K+en/uYNQI2ikXZXzicNGCS8dZ5I+LgMmxz63zcP
         Q4t7wG4zTZLFmbno2pXxUvzuIoJ79TZS1CUxelGECg3QR/TjC+DgRY1smprg/psWrSlZ
         OaZOuyN2LqPwNGif3faFZvYThzavzpjcZQbVBbxrYy1ufh41p+uI4xt02HrzKMU+A1zS
         w/SVkesspS+YSFF9AOsDho/gIB9FtlxoPGJsLILKFPfM7ZkQhfloS3EcqiXabh0rCGz6
         0wH3mnVUiBzNrni3tELzq+nDwqdwM3xgu12E8JF+/HaiHJNrSAqgSnexVBGZ4RA197bK
         Zx1w==
X-Gm-Message-State: ANhLgQ3/I6kplFS1/nUOfdbyyDWjMeBrybQjVVzB/9GZUMiGo46OgM7p
        3YQiXPip6Jzc0PP8jvm8GIwX2IZYZIvylVsD+gM=
X-Google-Smtp-Source: ADFU+vsmmOOXRt9PLNiptpYSg0p4o4/d9CrlNNZqPAlF7q3fz8UobMoupYP7gZoIFuLZsn5CpZGATP2YK53yg9XCAPI=
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr3155696wre.369.1583489061137;
 Fri, 06 Mar 2020 02:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20200221032243.9708-1-bvanassche@acm.org> <20200221032243.9708-3-bvanassche@acm.org>
 <20200225004727.GA27445@ming.t460p> <20200306024624.GC4552@ming.t460p>
In-Reply-To: <20200306024624.GC4552@ming.t460p>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 6 Mar 2020 18:04:09 +0800
Message-ID: <CACVXFVN3gxbu-9oo=8o6OF3midOBqNLPDgW=VLVCgyWcuXYgeQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 6, 2020 at 10:47 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Feb 25, 2020 at 08:47:27AM +0800, Ming Lei wrote:
> > On Thu, Feb 20, 2020 at 07:22:37PM -0800, Bart Van Assche wrote:
> > > blk_mq_map_queues() and multiple .map_queues() implementations expect that
> > > set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the number of hardware
> > > queues. Hence set .nr_queues before calling these functions. This patch
> > > fixes the following kernel warning:
> > >
> > > WARNING: CPU: 0 PID: 2501 at include/linux/cpumask.h:137
> > > Call Trace:
> > >  blk_mq_run_hw_queue+0x19d/0x350 block/blk-mq.c:1508
> > >  blk_mq_run_hw_queues+0x112/0x1a0 block/blk-mq.c:1525
> > >  blk_mq_requeue_work+0x502/0x780 block/blk-mq.c:775
> > >  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
> > >  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
> > >  kthread+0x361/0x430 kernel/kthread.c:255
> > >
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Ming Lei <ming.lei@redhat.com>
> > > Cc: Hannes Reinecke <hare@suse.com>
> > > Cc: Johannes Thumshirn <jth@kernel.org>
> > > Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
> > > Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > ---
> > >  block/blk-mq.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index f298500e6dda..a92444c077bc 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -3023,6 +3023,14 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> > >
> > >  static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
> > >  {
> > > +   /*
> > > +    * blk_mq_map_queues() and multiple .map_queues() implementations
> > > +    * expect that set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the
> > > +    * number of hardware queues.
> > > +    */
> > > +   if (set->nr_maps == 1)
> > > +           set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
> > > +
> > >     if (set->ops->map_queues && !is_kdump_kernel()) {
> > >             int i;
> > >
> > >
> >
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> >
>
> Hi Jens,
>
> This one and the 3rd patch may belong to 5.6, any chance to consider
> them to 5.6?

Just got test feedback from one RH partner, the patch fixes kernel oops
on NVMe FC when updating nr_hw_queues.


Thanks,
Ming Lei
