Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 16/17] mtd_blkdevs: convert to blk-mq
Date: Thu, 11 Oct 2018 23:18:55 +0200
Message-ID: <19488748.6iqVKhkDGp@blindfold>
In-Reply-To: <263ca89f-94e4-1238-e396-8fb0a0111f97@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk> <CAFLxGvy04s++HExKixU02=e86kx4yqcz+boeepxi9=uDU94sQg@mail.gmail.com> <263ca89f-94e4-1238-e396-8fb0a0111f97@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Jens,

Am Donnerstag, 11. Oktober 2018, 23:14:07 CEST schrieb Jens Axboe:
> On 10/11/18 3:03 PM, Richard Weinberger wrote:
> > Jens,
> > 
> > On Thu, Oct 11, 2018 at 7:00 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> Straight forward conversion, using an internal list to enable the
> >> driver to pull requests at will.
> >>
> >> Dynamically allocate the tag set to avoid having to pull in the
> >> block headers for blktrans.h, since various mtd drivers use
> >> block conflicting names for defines and functions.
> > 
> > This explodes on my test system. :-/
> 
> I think I see it, that was pretty stupid... Can you try with this one
> on top as well?
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index c26d692781af..e8f8fddce063 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -187,8 +187,8 @@ static void mtd_blktrans_work(struct mtd_blktrans_dev *dev)
>  		mutex_unlock(&dev->lock);
>  
>  		if (!blk_update_request(req, res, blk_rq_cur_bytes(req))) {
> -			req = NULL;
>  			__blk_mq_end_request(req, res);
> +			req = NULL;

Hehe. :-)
With this fix applied it works and passes my trivial test.

Thanks,
//richard
