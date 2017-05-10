Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbdEJHZf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2017 03:25:35 -0400
Date: Wed, 10 May 2017 15:25:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/4] blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
Message-ID: <20170510072517.GA2480@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-2-ming.lei@redhat.com>
 <20170503164631.GA10775@vader>
 <CACVXFVNXeq6S9GZZ=DnY7iSziyBav0XXvY0kRnUCuddqVe-MgA@mail.gmail.com>
 <20170503214029.GA27440@vader>
 <CACVXFVMLuGioTLCJt3AF6NBkpb=7T48mEm0b1q-ATJs2PFYjYg@mail.gmail.com>
 <b7f4f8cf-30d1-8995-4256-c96184522992@fb.com>
 <20170504025150.GA16218@ming.t460p>
 <0a927231-c04e-72aa-a756-4f2ae896ce53@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0a927231-c04e-72aa-a756-4f2ae896ce53@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

On Thu, May 04, 2017 at 08:06:15AM -0600, Jens Axboe wrote:
...
> 
> No we do not. 256 is a LOT. I realize most of the devices expose 64K *
> num_hw_queues of depth. Expecting to utilize all that is insane.
> Internally, these devices have nowhere near that amount of parallelism.
> Hence we'd go well beyond the latency knee in the curve if we just allow
> tons of writeback to queue up, for example. Reaching peak performance on
> these devices do not require more than 256 requests, in fact it can be
> done much sooner. For a default setting, I'd actually argue that 256 is
> too much, and that we should set it lower.

After studying SSD and NVMe a bit, I think your point of '256 is a LOT'
is correct:

1) inside SSD, the channel number won't be big, which is often about 10
in high-end SSD, so 256 should be big enough to maximize the utilization
of each channel, even though multi-bank, multi-die or multi-plane are
considered.

2) For NVMe, the IO queue depth(size) is at most 64K according to spec,
now the driver limits it at most 1024, but the queue itself is totally
allocated from system memory, then big queue size won't increase NVMe
chip cost.

So I think we can respect .nr_requests via resizing hw tags in
blk_mq_init_sched(), as suggested by Omar. If you don't object that,
I will send out V3 soon.

Thanks,
Ming
