Return-Path: <keith.busch@intel.com>
Date: Tue, 20 Sep 2016 11:00:37 -0400
From: Keith Busch <keith.busch@intel.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 00/21] blk-mq: Introduce combined hardware queues
Message-ID: <20160920150037.GA11190@keith>
References: <cover.1474014910.git.agordeev@redhat.com>
 <20160916210448.GA1178@localhost.localdomain>
 <20160919103805.GA22169@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919103805.GA22169@agordeev.lab.eng.brq.redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 19, 2016 at 12:38:05PM +0200, Alexander Gordeev wrote:
> On Fri, Sep 16, 2016 at 05:04:48PM -0400, Keith Busch wrote:
> 
> > Having a 1:1 already seemed like the ideal solution since you can't
> > simultaneously utilize more than that from the host, so there's no more
> > h/w parallelisms from we can exploit. On the controller side, fetching
> > commands is serialized memory reads, so I don't think spreading IO
> > among more h/w queues helps the target over posting more commands to a
> > single queue.
> 
> I take a notion of un-ordered commands completion you described below.
> But I fail to realize why a CPU would not simultaneously utilize more
> than one queue by posting to multiple. Is it due to nvme specifics or
> you assume the host would not issue that many commands?

What I mean is that if you have N CPUs, you can't possibly simultaneously
write more than N submission queue entries. The benefit of having 1:1
for the queue <-> CPU mapping is that each CPU can post a command to
its queue without lock contention at the same time as another thread.
Having more to choose from doesn't let the host post commands any faster
than we can today.

When we're out of tags, the request currently just waits for one to
become available, increasing submission latency. You can fix that by
increasing the available tags with deeper or more h/w queues, but that
just increases completion latency since the device can't process them
any faster. It's six of one, half dozen of the other.

The depth per queue defaults to 1k. If your process really is able to use
all those resources, the hardware is completely saturated and you're not
going to benefit from introducing more tags [1]. It could conceivably
be worse by reducing cache-hits, or hit inappropriate timeout handling
with the increased completion latency.

 [1] http://lists.infradead.org/pipermail/linux-nvme/2014-July/001064.html
