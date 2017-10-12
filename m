Return-Path: <zwp10758@gmail.com>
Return-Path: <zwp10758@gmail.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Thu, 12 Oct 2017 14:26:08 +0800
To: Jens Axboe <axboe@kernel.dk>
Cc: jthumshirn@suse.de, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blkcg: add sanity check for blkcg policy operations
Message-ID: <20171012062608.GA11125@source.didichuxing.com>
References: <20171011094619.GA37417@localhost.didichuxing.com>
 <3397954d-e59d-09d5-7aab-cb5f5ac4ce63@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3397954d-e59d-09d5-7aab-cb5f5ac4ce63@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 11, 2017 at 10:51:32AM -0600, Jens Axboe wrote:
> On 10/11/2017 03:46 AM, weiping zhang wrote:
> > blkcg policy should keep cpd/pd's alloc_fn and free_fn in pairs,
> > otherwise policy would register fail.
> > 
> > Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> > ---
> >  block/blk-cgroup.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index e7ec676..67b01c5 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -1419,6 +1419,16 @@ int blkcg_policy_register(struct blkcg_policy *pol)
> >  	if (i >= BLKCG_MAX_POLS)
> >  		goto err_unlock;
> >  
> > +	/* Make sure cpd_alloc_fn and cpd_free_fn in pairs */
> > +	if ((pol->cpd_alloc_fn && !pol->cpd_free_fn) ||
> > +		(!pol->cpd_alloc_fn && pol->cpd_free_fn))
> > +		goto err_unlock;
> 
> This might be cleaner (and more readable) as:
> 
>         if (!pol->cpd_alloc_fn ^ !pol->cpd_free_fn)
>                 goto err_unlock;
> 
> Ditto for the pd part.
> 
Really nice, I'll send v3.

Thanks
