Return-Path: <hch@lst.de>
Date: Mon, 28 Aug 2017 11:06:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme
	subsystems
Message-ID: <20170828090620.GA4529@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-11-hch@lst.de> <84429b00-300f-a36b-c4ac-b7d930ca6c7e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84429b00-300f-a36b-c4ac-b7d930ca6c7e@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 10:23:33AM +0300, Sagi Grimberg wrote:
> This is really taking a lot into the nvme driver.

This patch adds about 100 lines of code, out of which 1/4th is the
parsing of status codes.  I don't think it's all that much..

> I'm not sure if
> this approach will be used in other block driver, but would it
> make sense to place the block_device node creation,

I really want to reduce the amount of boilerplate code for creating
a block queue and I have some ideas for that.  But that's not in
any way related to this multi-path code.

> the make_request

That basically just does a lookup (in a data structure we need for
tracking the siblings inside nvme anyway) and the submits the
I/O again.  The generic code all is in generic_make_request_fast.
There are two more things which could move into common code, one
reasonable, the other not:

 (1) the whole requeue_list list logic.  I thought about moving this
     to the block layer as I'd also have some other use cases for it,
     but decided to wait until those materialize to see if I'd really
     need it.
 (2) turning the logic inside out, e.g. providing a generic make_request
     and supplying a find_path callback to it.  This would require (1)
     but even then we'd save basically no code, add an indirect call
     in the fast path and make things harder to read.  This actually
     is how I started out and didn't like it.

> and failover logic

The big thing about the failover logic is looking a the detailed error
codes and changing the controller state, all of which is fundamentally
driver specific.  The only thing that could reasonably be common is
the requeue_list handling as mentioned above.  Note that this will
become even more integrated with the nvme driver once ANA support
lands.

> and maybe the path selection in the block layer
> leaving just the construction of the path mappings in nvme?

The point is that path selection fundamentally depends on your
actual protocol.  E.g. for NVMe we now look at the controller state
as that's what our keep alive work on, and what reflects that status
in PCIe. We could try to communicate this up, but it would just lead
to more data structure that get out of sync.  And this will become
much worse with ANA where we have even more fine grained state.
In the end path selection right now is less than 20 lines of code.

Path selection is complicated when you want non-trivial path selector
algorithms like round robin or service time, but I'd really avoid having
those on nvme - we already have multiple queues to go beyong the limits
of a single queue and use blk-mq for that, and once we're beyond the
limits of a single transport path for performance reasons I'd much
rather rely on ANA, numa nodes or static partitioning of namepsaces
than trying to do dynamic decicions in the fast path.  But if I don't
get what I want there and we'll need more complicated algorithms they
absolutely should be in common code.  In fact one of my earlier protoypes
moved the dm-mpath path selector algorithms to core block code and
tried to use them - it just turned out enabling them was pretty much
pointless.
