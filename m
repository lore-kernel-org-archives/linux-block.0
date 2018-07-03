Return-Path: <ming.lei@redhat.com>
Date: Tue, 3 Jul 2018 09:23:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V3 3/3] blk-mq: dequeue request one by one from sw queue
 iff hctx is busy
Message-ID: <20180703012346.GA24254@ming.t460p>
References: <20180702093600.10315-1-ming.lei@redhat.com>
 <20180702093600.10315-4-ming.lei@redhat.com>
 <f120df41-a378-23e5-3dab-28398cd49d4e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f120df41-a378-23e5-3dab-28398cd49d4e@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 02, 2018 at 11:30:17AM -0600, Jens Axboe wrote:
> On 7/2/18 3:36 AM, Ming Lei wrote:
> > It won't be efficient to dequeue request one by one from sw queue,
> > but we have to do that when queue is busy for better merge performance.
> > 
> > This patch takes EWMA to figure out if queue is busy, then only dequeue
> > request one by one from sw queue when queue is busy.
> 
> Just one minor comment, since you're going to be updating this one
> anyway:
> 
> > @@ -1209,8 +1234,11 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> >  		else if (needs_restart && (ret == BLK_STS_RESOURCE))
> >  			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> >  
> > +		blk_mq_update_hctx_busy(hctx, true);
> > +
> >  		return false;
> 
> Kill that newline between update and return.
> 
> Rest looks fine to me now, though I do agree with Christophs comments on
> making the weight and factor in caps.
> 
> Applying 1-2/3 so far.

Hi Jens,

Not sure if 3 is applied now given your for-4.19/block isn't public yet.
So please let me know if you need me to re-send 3.

Thanks,
Ming
