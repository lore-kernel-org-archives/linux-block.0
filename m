Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 14 Dec 2017 11:26:26 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 4/6] blk-mq: make blk_abort_request() trigger timeout path
Message-ID: <20171214192626.GC3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-5-tj@kernel.org>
 <1513277814.2475.45.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513277814.2475.45.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Dec 14, 2017 at 06:56:55PM +0000, Bart Van Assche wrote:
> On Tue, 2017-12-12 at 11:01 -0800, Tejun Heo wrote:
> >  void blk_abort_request(struct request *req)
> >  {
> > -	if (blk_mark_rq_complete(req))
> > -		return;
> >  
> >  	if (req->q->mq_ops) {
> > -		blk_mq_rq_timed_out(req, false);
> > +		req->deadline = jiffies;
> > +		mod_timer(&req->q->timeout, 0);
> >  	} else {
> > +		if (blk_mark_rq_complete(req))
> > +			return;
> >  		blk_delete_timer(req);
> >  		blk_rq_timed_out(req);
> >  	}
> 
> This patch makes blk_abort_request() asynchronous for blk-mq. Have all callers
> been audited to verify whether this change is safe?

I *think* so.  For all the ata related parts, I know they're.
mtip32xx and dasd_ioctl, it seems safe, but I can't tell for sure.
Will cc the respective maintainers on the next posting.

Thanks.

-- 
tejun
