Return-Path: <ming.lei@redhat.com>
Date: Thu, 12 Apr 2018 07:06:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"tj@kernel.org" <tj@kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: fix race between complete and BLK_EH_RESET_TIMER
Message-ID: <20180411230647.GC31433@ming.t460p>
References: <20180411205529.31145-1-ming.lei@redhat.com>
 <2ed5dc7a4d1553c7ba3f9bbe43aac313eba29dc8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2ed5dc7a4d1553c7ba3f9bbe43aac313eba29dc8.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 11, 2018 at 10:49:51PM +0000, Bart Van Assche wrote:
> On Thu, 2018-04-12 at 04:55 +0800, Ming Lei wrote:
> > +again:
> >  	switch (ret) {
> >  	case BLK_EH_HANDLED:
> >  		__blk_mq_complete_request(req);
> >  		break;
> >  	case BLK_EH_RESET_TIMER:
> >  		[ ... ]
> > +		spin_lock_irqsave(req->q->queue_lock, flags);
> > +		if (blk_mq_rq_state(req) != MQ_RQ_COMPLETE_IN_RESET) {
> > +			blk_mq_rq_update_aborted_gstate(req, 0);
> > +			blk_add_timer(req);
> > +		} else {
> > +			blk_mq_rq_update_state(req, MQ_RQ_IN_FLIGHT);
> > +			ret = BLK_EH_HANDLED;
> > +			goto again;
> > +		}
> > +		spin_unlock_irqrestore(req->q->queue_lock, flags);
> 
> Does the above chunk introduce a backwards goto from inside a region around
> which a spinlock is held to outside that region? Can such a goto result in
> anything else than a deadlock?

Yes, it is being fixed in my local V2, :-)

-- 
Ming
