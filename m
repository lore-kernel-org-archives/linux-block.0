Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34202 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753309AbdEDCBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 22:01:33 -0400
Received: by mail-ua0-f193.google.com with SMTP id u40so41955uaf.1
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 19:01:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170503214029.GA27440@vader>
References: <20170428151539.25514-1-ming.lei@redhat.com> <20170428151539.25514-2-ming.lei@redhat.com>
 <20170503164631.GA10775@vader> <CACVXFVNXeq6S9GZZ=DnY7iSziyBav0XXvY0kRnUCuddqVe-MgA@mail.gmail.com>
 <20170503214029.GA27440@vader>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 4 May 2017 10:01:31 +0800
Message-ID: <CACVXFVMLuGioTLCJt3AF6NBkpb=7T48mEm0b1q-ATJs2PFYjYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
To: Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 4, 2017 at 5:40 AM, Omar Sandoval <osandov@osandov.com> wrote:
> On Thu, May 04, 2017 at 04:13:51AM +0800, Ming Lei wrote:
>> On Thu, May 4, 2017 at 12:46 AM, Omar Sandoval <osandov@osandov.com> wrote:
>> > On Fri, Apr 28, 2017 at 11:15:36PM +0800, Ming Lei wrote:
>> >> When blk-mq I/O scheduler is used, we need two tags for
>> >> submitting one request. One is called scheduler tag for
>> >> allocating request and scheduling I/O, another one is called
>> >> driver tag, which is used for dispatching IO to hardware/driver.
>> >> This way introduces one extra per-queue allocation for both tags
>> >> and request pool, and may not be as efficient as case of none
>> >> scheduler.
>> >>
>> >> Also currently we put a default per-hctx limit on schedulable
>> >> requests, and this limit may be a bottleneck for some devices,
>> >> especialy when these devices have a quite big tag space.
>> >>
>> >> This patch introduces BLK_MQ_F_SCHED_USE_HW_TAG so that we can
>> >> allow to use hardware/driver tags directly for IO scheduling if
>> >> devices's hardware tag space is big enough. Then we can avoid
>> >> the extra resource allocation and make IO submission more
>> >> efficient.
>> >>
>> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> >> ---
>> >>  block/blk-mq-sched.c   | 10 +++++++++-
>> >>  block/blk-mq.c         | 35 +++++++++++++++++++++++++++++------
>> >>  include/linux/blk-mq.h |  1 +
>> >>  3 files changed, 39 insertions(+), 7 deletions(-)
>> >
>> > One more note on this: if we're using the hardware tags directly, then
>> > we are no longer limited to q->nr_requests requests in-flight. Instead,
>> > we're limited to the hw queue depth. We probably want to maintain the
>> > original behavior,
>>
>> That need further investigation, and generally scheduler should be happy with
>> more requests which can be scheduled.
>>
>> We can make it as one follow-up.
>
> If we say nr_requests is 256, then we should honor that. So either
> update nr_requests to reflect the actual depth we're using or resize the
> hardware tags.

Firstly nr_requests is set as 256 from blk-mq inside instead of user
space, it won't be
a big deal to violate that.

Secondly, when there is enough tags available, it might hurt
performance if we don't
use them all.

>
>> > so I think we need to resize the hw tags in blk_mq_init_sched() if we're using hardware tags.
>>
>> That might not be good since hw tags are used by both scheduler and dispatching.
>
> What do you mean? If we have BLK_MQ_F_SCHED_USE_HW_TAG set, then they
> are not used for dispatching, and of course we shouldn't resize the
> hardware tags if we are using scheduler tags.

The tag is used by both sched and dispatching actually, and if you
resize the hw tags,
the tag space for dispatching is resized(decreased) too.


Thanks,
Ming Lei
