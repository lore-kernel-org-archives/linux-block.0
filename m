Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Thu, 6 Sep 2018 16:41:54 -0400
From: Dennis Zhou <dennisszhou@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] blkcg: always associate a bio with a blkg
Message-ID: <20180906204153.GA26048@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-7-dennisszhou@gmail.com>
 <20180831231609.GD1488037@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831231609.GD1488037@devbig004.ftw2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 31, 2018 at 04:16:09PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 30, 2018 at 09:53:47PM -0400, Dennis Zhou wrote:
> > From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> > 
> > Previously, blkg's were only assigned as needed by blk-iolatency and
> > blk-throttle. bio->css was also always being associated while blkg was
> > being looked up and then thrown away in blkcg_bio_issue_check.
> > 
> > This patch beings the cleanup of bio->css and bio->bi_blkg by always
>              ^
> 	     begins
> 

Thanks!

> > +int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
> > +{
> > +	struct blkcg *blkcg;
> > +	struct blkcg_gq *blkg;
> > +	int ret = 0;
> > +
> > +	/* someone has already associated this bio with a blkg */
> > +	if (bio->bi_blkg)
> > +		return ret;
> > +
> > +	rcu_read_lock();
> > +
> > +	bio_associate_blkcg(bio, NULL);
> > +	blkcg = bio_blkcg(bio);
> > +
> > +	if (!blkcg->css.parent) {
> > +		ret = bio_associate_blkg(bio, q->root_blkg);
> > +		goto assoc_out;
> > +	}
> > +
> > +	blkg = blkg_lookup_create(blkcg, q);
> > +	if (IS_ERR(blkg))
> > +		blkg = q->root_blkg;
> > +
> > +	ret = bio_associate_blkg(bio, blkg);
> > +assoc_out:
> 
> Maybe if/else instead of goto?
> 

Yeah, no need for goto.

Thanks,
Dennis
