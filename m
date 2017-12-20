Return-Path: <shli@kernel.org>
Date: Wed, 20 Dec 2017 08:35:49 -0800
From: Shaohua Li <shli@kernel.org>
To: xuejiufei <xuejiufei@gmail.com>
Cc: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2] block-throttle: avoid double charge
Message-ID: <20171220163549.b3agmjax25xrh5fx@kernel.org>
References: <23857cbf1d586e904bd01196fa05705fb0161785.1510605343.git.shli@fb.com>
 <cf5ecd43-dd44-feb4-e62f-18c079a8e39b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <cf5ecd43-dd44-feb4-e62f-18c079a8e39b@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 20, 2017 at 02:42:20PM +0800, xuejiufei wrote:
> Hi Shaohua,
> 
> I noticed that the splitted bio will goto the scheduler directly while
> the cloned bio entering the generic_make_request again. So can we just
> leave the BIO_THROTTLED flag in the original bio and do not copy the
> flag to new splitted bio, so it is not necessary to remove the flag in
> bio_set_dev()? Or there are other different situations?

but we can still send the original bio to a different bdev, for example stacked
disks. That bit will prevent throttling for underlayer disks.

Thanks,
Shaohua
 
> On 2017/11/14 上午4:37, Shaohua Li wrote:
> > If a bio is throttled and splitted after throttling, the bio could be
> > resubmited and enters the throttling again. This will cause part of the
> > bio is charged multiple times. If the cgroup has an IO limit, the double
> > charge will significantly harm the performance. The bio split becomes
> > quite common after arbitrary bio size change.
> > 
> > To fix this, we always set the BIO_THROTTLED flag if a bio is throttled.
> > If the bio is cloned/slitted, we copy the flag to new bio too to avoid
> > double charge. However cloned bio could be directed to a new disk,
> > keeping the flag will have problem. The observation is we always set new
> > disk for the bio in this case, so we can clear the flag in
> > bio_set_dev().
> > 
> > This issue exists a long time, arbitrary bio size change makes it worse,
> > so this should go into stable at least since v4.2.
> > 
> > V1-> V2: Not add extra field in bio based on discussion with Tejun
> > 
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > ---
> >  block/bio.c          | 2 ++
> >  block/blk-throttle.c | 8 +-------
> >  include/linux/bio.h  | 2 ++
> >  3 files changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 8338304..d1d4d51 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -598,6 +598,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
> >  	 */
> >  	bio->bi_disk = bio_src->bi_disk;
> >  	bio_set_flag(bio, BIO_CLONED);
> > +	if (bio_flagged(bio_src, BIO_THROTTLED))
> > +		bio_set_flag(bio, BIO_THROTTLED);
> >  	bio->bi_opf = bio_src->bi_opf;
> >  	bio->bi_write_hint = bio_src->bi_write_hint;
> >  	bio->bi_iter = bio_src->bi_iter;
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index ee6d7b0..f90fec1 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -2222,13 +2222,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
> >  out_unlock:
> >  	spin_unlock_irq(q->queue_lock);
> >  out:
> > -	/*
> > -	 * As multiple blk-throtls may stack in the same issue path, we
> > -	 * don't want bios to leave with the flag set.  Clear the flag if
> > -	 * being issued.
> > -	 */
> > -	if (!throttled)
> > -		bio_clear_flag(bio, BIO_THROTTLED);
> > +	bio_set_flag(bio, BIO_THROTTLED);
> >  
> >  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> >  	if (throttled || !td->track_bio_latency)
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 9c75f58..27b5bac 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -504,6 +504,8 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
> >  
> >  #define bio_set_dev(bio, bdev) 			\
> >  do {						\
> > +	if ((bio)->bi_disk != (bdev)->bd_disk)	\
> > +		bio_clear_flag(bio, BIO_THROTTLED);\
> >  	(bio)->bi_disk = (bdev)->bd_disk;	\
> >  	(bio)->bi_partno = (bdev)->bd_partno;	\
> >  } while (0)
> > 
