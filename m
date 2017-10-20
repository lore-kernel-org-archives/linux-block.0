Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:47673 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbdJTJjp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2017 05:39:45 -0400
Received: by mail-it0-f54.google.com with SMTP id p138so13353858itp.2
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2017 02:39:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508435243.2429.42.camel@wdc.com>
References: <20171018102206.26020-1-roman.penyaev@profitbricks.com> <1508435243.2429.42.camel@wdc.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Fri, 20 Oct 2017 11:39:24 +0200
Message-ID: <CAJrWOzCyLSNYAmEY6afoVjPYK8KaoH1HSs63iGpDuCwesjwBLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RFC] blk-mq: fix queue stalling on shared hctx restart
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

On Thu, Oct 19, 2017 at 7:47 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Wed, 2017-10-18 at 12:22 +0200, Roman Pen wrote:
>> the patch below fixes queue stalling when shared hctx marked for restart
>> (BLK_MQ_S_SCHED_RESTART bit) but q->shared_hctx_restart stays zero.  The
>> root cause is that hctxs are shared between queues, but 'shared_hctx_restart'
>> belongs to the particular queue, which in fact may not need to be restarted,
>> thus we return from blk_mq_sched_restart() and leave shared hctx of another
>> queue never restarted.
>>
>> The fix is to make shared_hctx_restart counter belong not to the queue, but
>> to tags, thereby counter will reflect real number of shared hctx needed to
>> be restarted.
>
> Hello Roman,
>
> The patch you posted looks fine to me but seeing this patch and the patch
> description makes me wonder why this had not been noticed before.

This is a good question, which I could not answer.  I tried to simulate the
same behaviour (completion timings, completion pinning, number of submission
queues, shared tags, etc) on null block.  but what I see is that
*_sched_restart()
never observes 'shared_hctx_restart',  literally never (I made a counter when
we take a path and start looking for a hctx to restart, and a counter stays 0).

That makes me nervous and then I gave up.  After some time I want return to
that and try to reproduce the problem on something else, say nvme.

> Are you perhaps using a block driver that returns BLK_STS_RESOURCE more
> often than other block drivers? Did you perhaps run into this with the
> Infiniband network block device (IBNBD) driver?

Yep, this is IBNBD, but in these tests I tested with mq scheduler, shared tags
and 1 hctx for each queue (blk device),  thus I never run out of internal tags
and never return BLK_STS_RESOURCE.

Indeed, not modified IBNBD does internal tags management.  This was needed
because each queue (block device) was created with hctx number (nr_hw_queues)
equal to number of cpus on the system, but blk-mq tags set is shared only
between hctx, not globally, which led to need to return BLK_STS_RESOURCE
and queues restarts.

But, with mq scheduler situation changed: 1 hctx with shared tags can be
specified for all hundreds of devices without any performance impact.

Testing this configuration (1 hctx, shared tags, mq-deadline) immediately
shows these two problems: request stalling and slow loops inside
blk_mq_sched_restart().

> No matter what driver triggered this, I think this bug should be fixed.

Yes, queue stalling can be easily fixed.  I can resend current patch with
shorter description which targets only this particular bug, if no one else
has objections/comments etc.

But what bothers me is these looong loops inside blk_mq_sched_restart(),
and since you are the author of the original 6d8c6c0f97ad ("blk-mq: Restart
a single queue if tag sets are shared") I want to ask what was the original
problem which you attempted to fix?  Likely I am missing some test scenario
which would be great to know about.

--
Roman
