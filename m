Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Thu, 6 Sep 2018 16:43:06 -0400
From: Dennis Zhou <dennisszhou@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] blkcg: consolidate bio_issue_init and blkg
 association
Message-ID: <20180906204305.GB26048@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-8-dennisszhou@gmail.com>
 <20180831154225.zoiztxvdvcfaat5r@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831154225.zoiztxvdvcfaat5r@destiny>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 31, 2018 at 11:42:26AM -0400, Josef Bacik wrote:
> On Thu, Aug 30, 2018 at 09:53:48PM -0400, Dennis Zhou wrote:
> > diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> > index 22b2ff0440cc..9d7052bad6f7 100644
> > --- a/block/blk-iolatency.c
> > +++ b/block/blk-iolatency.c
> > @@ -395,34 +395,12 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
> >  				     spinlock_t *lock)
> >  {
> >  	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
> > -	struct blkcg *blkcg;
> > -	struct blkcg_gq *blkg;
> > -	struct request_queue *q = rqos->q;
> > +	struct blkcg_gq *blkg = bio->bi_blkg;
> >  	bool issue_as_root = bio_issue_as_root_blkg(bio);
> >  
> >  	if (!blk_iolatency_enabled(blkiolat))
> >  		return;
> >  
> > -	rcu_read_lock();
> > -	bio_associate_blkcg(bio, NULL);
> > -	blkcg = bio_blkcg(bio);
> > -	blkg = blkg_lookup(blkcg, q);
> > -	if (unlikely(!blkg)) {
> > -		if (!lock)
> > -			spin_lock_irq(q->queue_lock);
> > -		blkg = __blkg_lookup_create(blkcg, q);
> > -		if (IS_ERR(blkg))
> > -			blkg = NULL;
> > -		if (!lock)
> > -			spin_unlock_irq(q->queue_lock);
> > -	}
> > -	if (!blkg)
> > -		goto out;
> > -
> > -	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
> > -	bio_associate_blkg(bio, blkg);
> > -out:
> > -	rcu_read_unlock();
> 
> Move this removal to the previous patch, so you keep this patch soley about the
> bio_issue_init.  Thanks,
> 

I've moved this removal to the previous patch and addressed the kbuild
errors.

Thanks,
Dennis
