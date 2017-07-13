Return-Path: <ming.lei@redhat.com>
Date: Thu, 13 Jul 2017 23:32:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Message-ID: <20170713153240.GA25313@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-5-ming.lei@redhat.com>
 <db7526a0-d534-8bc2-93de-546f4dabccfb@kernel.dk>
 <20170712023028.GB13036@ming.t460p>
 <1499873952.2554.5.camel@wdc.com>
 <20170713104341.GB19857@ming.t460p>
 <1499957797.2740.2.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499957797.2740.2.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 13, 2017 at 02:56:38PM +0000, Bart Van Assche wrote:
> On Thu, 2017-07-13 at 18:43 +0800, Ming Lei wrote:
> > On Wed, Jul 12, 2017 at 03:39:14PM +0000, Bart Van Assche wrote:
> > > On Wed, 2017-07-12 at 10:30 +0800, Ming Lei wrote:
> > > > On Tue, Jul 11, 2017 at 12:25:16PM -0600, Jens Axboe wrote:
> > > > > What happens with fluid congestion boundaries, with shared tags?
> > > > 
> > > > The approach in this patch should work, but the threshold may not
> > > > be accurate in this way, one simple method is to use the average
> > > > tag weight in EWMA, like this:
> > > > 
> > > > 	sbitmap_weight() / hctx->tags->active_queues
> > > 
> > > Hello Ming,
> > > 
> > > That approach would result in a severe performance degradation. "active_queues"
> > > namely represents the number of queues against which I/O ever has been queued.
> > > If e.g. 64 LUNs would be associated with a single SCSI host and all 64 LUNs are
> > > responding and if the queue depth would also be 64 then the approach you
> > > proposed will reduce the effective queue depth per LUN from 64 to 1.
> > 
> > No, this approach does _not_ reduce the effective queue depth, it only
> > stops the queue for a while when the queue is busy enough.
> >
> > In this case, there may not have congestion because for blk-mq at most allows
> > to assign queue_depth/active_queues tags to each LUN, please see hctx_may_queue().
> 
> Hello Ming,
> 
> hctx_may_queue() severely limits the queue depth if many LUNs are associated
> with the same SCSI host. I think that this is a performance regression
> compared to scsi-sq and that this performance regression should be fixed.

IMO, it is hard to evaluate/compare perf between scsi-mq vs scsi-sq:

	- how many LUNs do you run IO on concurrently?
	- evaluate the perf on single LUN or multi LUN?

BTW, active_queues is a runtime variable which accounts the actual active
queues in use.

-- 
Ming
