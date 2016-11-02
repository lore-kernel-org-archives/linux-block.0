Return-Path: <jthumshirn@suse.de>
Date: Wed, 2 Nov 2016 10:40:32 -0600
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH 5/8] block: add code to track actual device queue depth
Message-ID: <20161102164032.yv4bu5wlpmtd6ji6@linux-x5ow.site>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-6-git-send-email-axboe@fb.com>
 <20161102145908.GI13964@lst.de>
 <c2295532-22a0-0c70-d6f9-7e13e76a1906@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <c2295532-22a0-0c70-d6f9-7e13e76a1906@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 02, 2016 at 09:02:08AM -0600, Jens Axboe wrote:
> On 11/02/2016 08:59 AM, Christoph Hellwig wrote:
> > On Tue, Nov 01, 2016 at 03:08:48PM -0600, Jens Axboe wrote:
> > > For blk-mq, ->nr_requests does track queue depth, at least at init
> > > time. But for the older queue paths, it's simply a soft setting.
> > > On top of that, it's generally larger than the hardware setting
> > > on purpose, to allow backup of requests for merging.
> > > 
> > > Fill a hole in struct request with a 'queue_depth' member, that
> > 
> > That would be struct request_queue..
> 
> Good catch, will fix.
> 
> > >  /**
> > > + * blk_set_queue_depth - tell the block layer about the device queue depth
> > > + * @q:		the request queue for the device
> > > + * @depth:		queue depth
> > > + *
> > > + */
> > > +void blk_set_queue_depth(struct request_queue *q, unsigned int depth)
> > > +{
> > > +	q->queue_depth = depth;
> > > +}
> > > +EXPORT_SYMBOL(blk_set_queue_depth);
> > 
> > Do we really need this wrapper?
> 
> Not necessarily, just seems like a nicer API than manually setting the
> field. Not a big deal to me, though.

A lot of block code uses this kind of setters so I _think_ it complies with
the overall style. But I have no strong opinion on this either...

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
