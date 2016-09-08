Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <17539224.xnQ9OR2lcz@amdc1976>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
 <20160831220949.GD5967@sirena.org.uk> <CACRpkdZjMcOyn6C-xV3yLsQM0hxZ1JUMGmmS8VqaDpx1xiL1ZA@mail.gmail.com>
 <17539224.xnQ9OR2lcz@amdc1976>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Sep 2016 13:51:12 +0200
Message-ID: <CACRpkdbU72KdBdRnNEFFBovrdGWsrNaPf-uYgxDXwCNmD33b4w@mail.gmail.com>
Subject: Re: [PATCH V2 00/22] Replace the CFQ I/O Scheduler with BFQ
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 5, 2016 at 5:56 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> I did this (switched MMC to blk-mq) some time ago.  Patches are
> extremely ugly and hacky (basically the whole MMC block layer
> glue code needs to be re-done) so I'm rather reluctant to
> sharing them yet (to be honest I would like to rewrite them
> completely before posting).

You're right, I can also see the quick and dirty replacement path,
but that is not an honest patch, we need to make a patch that takes
advantage of the new features of the MQ tag set.

There is a bit of mechanisms in mq for handling parallell work
better so that e.g. the request stacking with calling out to
.pre_req() and .post_req() need to be done
differently and sglist handling can be simplified AFAICT (still
reading up on it).

> I only did linear read tests (using dd) so far and results that
> I got were mixed (BTW the hardware I'm doing this work on is
> Odroid-XU3).  Pure block performance under maximum CPU frequency
> was slightly worse (5-12%) but the CPU consumption was reduced so
> when CPU was scaled down manually (or ondemand CPUfreq governor
> was used) blk-mq mode results were better then vanilla ones (up
> to 10% when CPU was scaled down to minimum frequency and even
> up to 50% when using ondemand governor - this finding is very
> interesting and needs to be investigated further).

Hm right, it is important to keep in mind that we may be trading
performance for scalability here.

Naive storage development only care about performance to hitting
the media and it may be a bit of narrow usecase to just get a
figure on the paper. In reality the system load when doing this
matters.

Yours,
Linus Walleij
