Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35042 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdECVkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 17:40:32 -0400
Received: by mail-pg0-f53.google.com with SMTP id o3so1162135pgn.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 14:40:32 -0700 (PDT)
Date: Wed, 3 May 2017 14:40:29 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/4] blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
Message-ID: <20170503214029.GA27440@vader>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-2-ming.lei@redhat.com>
 <20170503164631.GA10775@vader>
 <CACVXFVNXeq6S9GZZ=DnY7iSziyBav0XXvY0kRnUCuddqVe-MgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVNXeq6S9GZZ=DnY7iSziyBav0XXvY0kRnUCuddqVe-MgA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 04, 2017 at 04:13:51AM +0800, Ming Lei wrote:
> On Thu, May 4, 2017 at 12:46 AM, Omar Sandoval <osandov@osandov.com> wrote:
> > On Fri, Apr 28, 2017 at 11:15:36PM +0800, Ming Lei wrote:
> >> When blk-mq I/O scheduler is used, we need two tags for
> >> submitting one request. One is called scheduler tag for
> >> allocating request and scheduling I/O, another one is called
> >> driver tag, which is used for dispatching IO to hardware/driver.
> >> This way introduces one extra per-queue allocation for both tags
> >> and request pool, and may not be as efficient as case of none
> >> scheduler.
> >>
> >> Also currently we put a default per-hctx limit on schedulable
> >> requests, and this limit may be a bottleneck for some devices,
> >> especialy when these devices have a quite big tag space.
> >>
> >> This patch introduces BLK_MQ_F_SCHED_USE_HW_TAG so that we can
> >> allow to use hardware/driver tags directly for IO scheduling if
> >> devices's hardware tag space is big enough. Then we can avoid
> >> the extra resource allocation and make IO submission more
> >> efficient.
> >>
> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >> ---
> >>  block/blk-mq-sched.c   | 10 +++++++++-
> >>  block/blk-mq.c         | 35 +++++++++++++++++++++++++++++------
> >>  include/linux/blk-mq.h |  1 +
> >>  3 files changed, 39 insertions(+), 7 deletions(-)
> >
> > One more note on this: if we're using the hardware tags directly, then
> > we are no longer limited to q->nr_requests requests in-flight. Instead,
> > we're limited to the hw queue depth. We probably want to maintain the
> > original behavior,
> 
> That need further investigation, and generally scheduler should be happy with
> more requests which can be scheduled.
> 
> We can make it as one follow-up.

If we say nr_requests is 256, then we should honor that. So either
update nr_requests to reflect the actual depth we're using or resize the
hardware tags.

> > so I think we need to resize the hw tags in blk_mq_init_sched() if we're using hardware tags.
> 
> That might not be good since hw tags are used by both scheduler and dispatching.

What do you mean? If we have BLK_MQ_F_SCHED_USE_HW_TAG set, then they
are not used for dispatching, and of course we shouldn't resize the
hardware tags if we are using scheduler tags.
