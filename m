Return-Path: <00moses.alexander00@gmail.com>
Return-Path: <00moses.alexander00@gmail.com>
Date: Wed, 11 Apr 2018 23:23:20 +0200
From: Alexandru Moise <00moses.alexander00@gmail.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: "tj@kernel.org" <tj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411212320.GA26747@gmail.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
 <20180411190027.GA21274@gmail.com>
 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 11, 2018 at 01:55:25PM -0600, Bart Van Assche wrote:
> On 04/11/18 13:00, Alexandru Moise wrote:
> > But the root cause of it is in blkcg_init_queue() when blkg_create() returns
> > an ERR ptr, because it tries to insert into a populated index into blkcg->blkg_tree,
> > the entry that we fail to remove at __blk_release_queue().
> 
> Hello Alex,
> 
> Had you considered something like the untested patch below?
> 
> Thanks,
> 
> Bart.
> 
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 1c16694ae145..f2ced19e74b8 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1191,14 +1191,17 @@ int blkcg_init_queue(struct request_queue *q)
>  	if (preloaded)
>  		radix_tree_preload_end();
> 
> -	if (IS_ERR(blkg))
> -		return PTR_ERR(blkg);
> +	if (IS_ERR(blkg)) {
> +		ret = PTR_ERR(blkg);
> +		goto destroy_all;
> +	}
> 
>  	q->root_blkg = blkg;
>  	q->root_rl.blkg = blkg;
> 
>  	ret = blk_throtl_init(q);
>  	if (ret) {
> +destroy_all:
>  		spin_lock_irq(q->queue_lock);
>  		blkg_destroy_all(q);
>  		spin_unlock_irq(q->queue_lock);
> 

Hi, I tested it, it doesn't solve the problem.
By the time you get here it's already too late, my patch
prevents this from failing in the first place.

I would have liked this more than my solution though.

../Alex
