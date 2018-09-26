Return-Path: <jthumshirn@suse.de>
Date: Wed, 26 Sep 2018 16:43:57 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 7/8] block: Make blk_get_request() block for non-PM
 requests while suspended
Message-ID: <20180926144357.GC13588@linux-x5ow.site>
References: <20180921203122.49743-1-bvanassche@acm.org>
 <20180921203122.49743-8-bvanassche@acm.org>
 <20180926142740.GE8604@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180926142740.GE8604@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 26, 2018 at 04:27:40PM +0200, Christoph Hellwig wrote:
> >  		list_for_each_entry(rq, &q->queue_head, queuelist) {
> > -			if (blk_pm_allow_request(rq))
> > -				return rq;
> > -
> > -			if (rq->rq_flags & RQF_SOFTBARRIER)
> > -				break;
> > +#ifdef CONFIG_PM
> > +			/*
> > +			 * If a request gets queued in state RPM_SUSPENDED
> > +			 * then that's a kernel bug.
> > +			 */
> > +			WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);
> > +#endif
> 
> I hate this ifdef, but it probably isnt worth adding a helper for this
> assert, so I guess we'll have to live with it..

How about:
			if (IS_ENABLED(CONFIG_PM))
			   WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
