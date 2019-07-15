Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7B5C7618A
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 04:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA262067C
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 04:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfGOE6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 00:58:10 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:59176 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfGOE6K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 00:58:10 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x6F4w7NR055490
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 15 Jul 2019 00:58:08 -0400
Received: by mail-lj1-f179.google.com with SMTP id d24so14756901ljg.8;
        Sun, 14 Jul 2019 21:58:08 -0700 (PDT)
X-Gm-Message-State: APjAAAUquadBHdEk7tXfMrFHNTA8XxABrqse6uQUDRCTCGWSgc/6QCyH
        FTHxqDHdaZsdyFQMEZBxRSQN4K6abArsUN7ApJc=
X-Google-Smtp-Source: APXvYqw7bjzk5JgPCfj0SZ6gpRSy1WzzbhX/WmJACvYoEVXzu7A6fi9r+HTDgtk6QADKDwxb+1xcb62uVjg+PrfoDaA=
X-Received: by 2002:a2e:8681:: with SMTP id l1mr13133432lji.166.1563166687219;
 Sun, 14 Jul 2019 21:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <1563087801-7373-1-git-send-email-wang6495@umn.edu> <CACVXFVOXZCtYtt3UuYBa7OYHEwsMkYFznfpL=1q9HkJV8xcx0Q@mail.gmail.com>
In-Reply-To: <CACVXFVOXZCtYtt3UuYBa7OYHEwsMkYFznfpL=1q9HkJV8xcx0Q@mail.gmail.com>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Sun, 14 Jul 2019 23:57:31 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fyp5__wW6No1aLsnB+TO5UZMTWKc2u7r3H0+cDy2aSXw@mail.gmail.com>
Message-ID: <CAAa=b7fyp5__wW6No1aLsnB+TO5UZMTWKc2u7r3H0+cDy2aSXw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix a memory leak bug
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 14, 2019 at 8:26 PM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Sun, Jul 14, 2019 at 3:04 PM Wenwen Wang <wang6495@umn.edu> wrote:
> >
> > From: Wenwen Wang <wenwen@cs.uga.edu>
> >
> > In blk_mq_init_allocated_queue(), a kernel buffer is allocated through
> > kcalloc_node() to hold hardware dispatch queues in the request queue 'q',
> > i.e., 'q->queue_hw_ctx'.  Later on, if the blk-mq device has no scheduler
> > set, a scheduler will be initialized through elevator_init_mq(). If this
> > initialization fails, blk_mq_init_allocated_queue() needs to be terminated
> > with an error code returned to indicate this failure. However, the
> > allocated buffer is not freed on this execution path, leading to a memory
> > leak bug. Moreover, the required cleanup work is also missed on this path.
> >
> > To fix the above issues, free the allocated buffer and invoke the cleanup
> > functions.
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  block/blk-mq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index e5ef40c..04fe077 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2845,6 +2845,8 @@ static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
> >  struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> >                                                   struct request_queue *q)
> >  {
> > +       int ret = -ENOMEM;
> > +
>
> The above isn't necessary because the function always returns
> ERR_PTR(-ENOMEM) in case of failure.
>
> >         /* mark the queue as mq asap */
> >         q->mq_ops = set->ops;
> >
> > @@ -2906,11 +2908,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> >         blk_mq_map_swqueue(q);
> >
> >         if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
> > -               int ret;
> > -
> >                 ret = elevator_init_mq(q);
> >                 if (ret)
> > -                       return ERR_PTR(ret);
> > +                       goto err_hctxs;
>
> The above change itself is fine.
>
> However, elevator_init_mq() shouldn't return failure since none should
> work any time.
> That said 'none' should be fallback to in case that default
> mq-deadline can't be initialized.

Thanks for your comments! I agree that 'none' is the fallback if
'mq-deadline' cannot be initialized.

But, the error-handling branch after elevator_init_mq() is still
necessary, unless elevator_init_mq() always returns zero, which is not
true.

Thanks!
Wenwen
