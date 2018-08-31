Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Fri, 31 Aug 2018 16:20:40 -0400
From: Dennis Zhou <dennisszhou@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiufei Xue <jiufei.xue@linux.alibaba.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 03/15] blkcg: use tryget logic when associating a blkg
 with a bio
Message-ID: <20180831202040.GB20194@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-4-dennisszhou@gmail.com>
 <20180831153007.nybnuyx43adn76rm@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831153007.nybnuyx43adn76rm@destiny>
List-ID: <linux-block@vger.kernel.org>

Hi Josef,

On Fri, Aug 31, 2018 at 11:30:08AM -0400, Josef Bacik wrote:
> On Thu, Aug 30, 2018 at 09:53:44PM -0400, Dennis Zhou wrote:
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index a3eede00d302..c626e1f7cdcd 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -2129,8 +2129,9 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
> >  static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
> >  {
> >  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> > -	if (bio->bi_css)
> > -		bio_associate_blkg(bio, tg_to_blkg(tg));
> > +	/* fallback to root_blkg if we fail to get a blkg ref */
> > +	if (bio->bi_css && bio_associate_blkg(bio, tg_to_blkg(tg)))
> > +		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
> 
> Except if we've already assocated a blkg this is just extra, can we do
> 
> if (bio->bi_css && (bio_associate_blkg(bio, tg_to_blkg(tg)) == -ENODEV))
> 
> to make it clear that we're only attaching it to the root if we failed to attach
> a blkg at all?  Thanks,

Done in v2.

Thanks,
Dennis
