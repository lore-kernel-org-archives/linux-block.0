Return-Path: <ming.lei@redhat.com>
Date: Thu, 13 Jul 2017 18:43:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Message-ID: <20170713104341.GB19857@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-5-ming.lei@redhat.com>
 <db7526a0-d534-8bc2-93de-546f4dabccfb@kernel.dk>
 <20170712023028.GB13036@ming.t460p>
 <1499873952.2554.5.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499873952.2554.5.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 12, 2017 at 03:39:14PM +0000, Bart Van Assche wrote:
> On Wed, 2017-07-12 at 10:30 +0800, Ming Lei wrote:
> > On Tue, Jul 11, 2017 at 12:25:16PM -0600, Jens Axboe wrote:
> > > What happens with fluid congestion boundaries, with shared tags?
> > 
> > The approach in this patch should work, but the threshold may not
> > be accurate in this way, one simple method is to use the average
> > tag weight in EWMA, like this:
> > 
> > 	sbitmap_weight() / hctx->tags->active_queues
> 
> Hello Ming,
> 
> That approach would result in a severe performance degradation. "active_queues"
> namely represents the number of queues against which I/O ever has been queued.
> If e.g. 64 LUNs would be associated with a single SCSI host and all 64 LUNs are
> responding and if the queue depth would also be 64 then the approach you
> proposed will reduce the effective queue depth per LUN from 64 to 1.

No, this approach does _not_ reduce the effective queue depth, it only
stops the queue for a while when the queue is busy enough.

In this case, there may not have congestion because for blk-mq at most allows
to assign queue_depth/active_queues tags to each LUN, please see hctx_may_queue().
Then get_driver_tag() can only allow to return one pending tag at most to the
request_queue(LUN).

The algorithm in this patch only starts to work when congestion happens,
that said it is only run when BLK_STS_RESOURCE is returned from .queue_rq().
This approach is for avoiding to dispatch requests to one busy queue
unnecessarily, so that we don't need to heat CPU unnecessarily, and
merge gets improved meantime.

-- 
Ming
