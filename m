Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Fri, 7 Sep 2018 16:33:21 -0400
From: Dennis Zhou <dennisszhou@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] blkcg: convert blkg_lookup_create to find closest
 blkg
Message-ID: <20180907203320.GB97913@dennisz-mbp.dhcp.thefacebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-4-dennisszhou@gmail.com>
 <20180907172730.GB1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907172730.GB1100574@devbig004.ftw2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

Hi Tejun,

On Fri, Sep 07, 2018 at 10:27:30AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 06, 2018 at 05:10:36PM -0400, Dennis Zhou wrote:
> > @@ -2021,9 +2021,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
> >  {
> >  	if (unlikely(bio->bi_blkg))
> >  		return -EBUSY;
> > +	bio->bi_blkg = blkg_try_get_closest(blkg);
> >  	return 0;
> 
> It prolly would be a good idea to point out that the associated blkg
> might not be the same one passed in.  Maybe this gets cleared up later
> in the series?
> 

Heh. I added comments everywhere else but the place it's used. Updated.

In hindsight though, it does make it a little problematic here as you
may have a different blkg than css. FWIW, it makes the next few patches
easier to read as they don't need to do nontrivial error handling that
will eventually be ripped out. And this is to really handle the edge
cases of OOM and dying cgroups. If you think it's worth fixing I can go
back through the set and adjust it all.

> > @@ -298,14 +297,23 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
> >  	while (true) {
> >  		struct blkcg *pos = blkcg;
> >  		struct blkcg *parent = blkcg_parent(blkcg);
> > -
> > -		while (parent && !__blkg_lookup(parent, q, false)) {
> > +		struct blkcg_gq *ret_blkg = NULL;
> > +
> > +		while (parent) {
> > +			blkg = __blkg_lookup(parent, q, false);
> > +			if (blkg) {
> > +				/* remember closest blkg */
> > +				ret_blkg = blkg;
> > +				break;
> > +			}
> >  			pos = parent;
> >  			parent = blkcg_parent(parent);
> >  		}
> >  
> >  		blkg = blkg_create(pos, q, NULL);
> > -		if (pos == blkcg || IS_ERR(blkg))
> > +		if (IS_ERR(blkg))
> > +			return ret_blkg ?: q->root_blkg;
> 
> Why not ret_blkg here?
> 

ret_blkg is only set if a parent exists. I can move that up to the
definition to remove the extra branch.

Thanks,
Dennis
