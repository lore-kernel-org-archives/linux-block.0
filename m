Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 27 Mar 2017 09:01:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Stephen Bates <sbates@raithlin.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 1/2] blk-stat: convert blk-stat bucket callback to signed
Message-ID: <20170327160103.GA12995@vader>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
 <1490494692-2416-2-git-send-email-sbates@raithlin.com>
 <20170326024922.GA6814@vader>
 <4CED8A46-D6F9-48AB-B3C9-C2546C1855FC@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4CED8A46-D6F9-48AB-B3C9-C2546C1855FC@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 27, 2017 at 04:00:08PM +0000, Stephen  Bates wrote:
> Thanks for the review Omar!
> 
> >>  
> >> -unsigned int blk_stat_rq_ddir(const struct request *rq)
> >> +int blk_stat_rq_ddir(const struct request *rq)
> >>  {
> >> -	return rq_data_dir(rq);
> >> +	return (int)rq_data_dir(rq);
> >
> >The cast here here isn't necessary, let's leave it off.
> >
> 
> OK, I will add that in the respin!
> 
> >>  }
> >>  EXPORT_SYMBOL_GPL(blk_stat_rq_ddir);
> >>  
> >> @@ -100,6 +100,8 @@ void blk_stat_add(struct request *rq)
> >>  	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
> >>  		if (blk_stat_is_active(cb)) {
> >>  			bucket = cb->bucket_fn(rq);
> >> +			if (bucket < 0)
> >> +				continue;
> >
> >You also need to change the declaration of bucket to int above.
> >
> 
> Ummmm, it is already is an int…

Yup, I was looking at the wrong place, sorry.
