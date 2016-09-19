Return-Path: <agordeev@redhat.com>
Date: Mon, 19 Sep 2016 12:38:05 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 00/21] blk-mq: Introduce combined hardware queues
Message-ID: <20160919103805.GA22169@agordeev.lab.eng.brq.redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
 <20160916210448.GA1178@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160916210448.GA1178@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 16, 2016 at 05:04:48PM -0400, Keith Busch wrote:

CC-ing linux-block@vger.kernel.org

> I'm not sure I see how this helps. That probably means I'm not considering
> the right scenario. Could you elaborate on when having multiple hardware
> queues to choose from a given CPU will provide a benefit?

No, I do not keep in mind any particular scenario besides common
sense. Just an assumption deeper queues are better (in this RFC
a virtual combined queue consisting of multipe h/w queues).

Apparently, there could be positive effects only in systems where
# of queues / # of CPUs > 1 or # of queues / # of cores > 1. But
I do not happen to have ones. If I had numbers this would not be
the RFC and I probably would not have posted in the first place ;)

Would it be possible to give it a try on your hardware?

> If we're out of avaliable h/w tags, having more queues shouldn't
> improve performance. The tag depth on each nvme hw context is already
> deep enough that it should mean even one full queue has saturated the
> device capabilities.

Am I getting you right - a single full nvme hardware queue makes
other queues stalled?

> Having a 1:1 already seemed like the ideal solution since you can't
> simultaneously utilize more than that from the host, so there's no more
> h/w parallelisms from we can exploit. On the controller side, fetching
> commands is serialized memory reads, so I don't think spreading IO
> among more h/w queues helps the target over posting more commands to a
> single queue.

I take a notion of un-ordered commands completion you described below.
But I fail to realize why a CPU would not simultaneously utilize more
than one queue by posting to multiple. Is it due to nvme specifics or
you assume the host would not issue that many commands?

Besides, blk-mq-tag re-uses the latest freed tag and IO should not
actually get spred. Instead, if only currently used hardware queue is
full, the next available queue is chosen. But this is a speculation
without real benchmarks, of course.

> If a CPU has more than one to choose from, a command sent to a less
> used queue would be serviced ahead of previously issued commands on a
> more heavily used one from the same CPU thread due to how NVMe command
> arbitraration works, so it sounds like this would create odd latency
> outliers.

Yep, that sounds scary indeed. Still, any hints on benchmarking
are welcomed.

Many thanks!

> Thanks,
> Keith
