Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 16/17] mtd_blkdevs: convert to blk-mq
Date: Thu, 11 Oct 2018 23:31:31 +0200
Message-ID: <3224309.SPdaaRQAfj@blindfold>
In-Reply-To: <6ac34916-e35d-d8d7-77d5-da83260714fc@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk> <19488748.6iqVKhkDGp@blindfold> <6ac34916-e35d-d8d7-77d5-da83260714fc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Am Donnerstag, 11. Oktober 2018, 23:21:56 CEST schrieb Jens Axboe:
> >>  		if (!blk_update_request(req, res, blk_rq_cur_bytes(req))) {
> >> -			req = NULL;
> >>  			__blk_mq_end_request(req, res);
> >> +			req = NULL;
> > 
> > Hehe. :-)
> > With this fix applied it works and passes my trivial test.
> 
> Great, thanks for testing! Can I add your tested-by to it?

Sure.

Thanks,
//richard
