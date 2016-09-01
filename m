Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20160831220949.GD5967@sirena.org.uk>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
 <20160808131954.GA12647@infradead.org> <20160831220949.GD5967@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Sep 2016 10:39:46 +0200
Message-ID: <CACRpkdZjMcOyn6C-xV3yLsQM0hxZ1JUMGmmS8VqaDpx1xiL1ZA@mail.gmail.com>
Subject: Re: [PATCH V2 00/22] Replace the CFQ I/O Scheduler with BFQ
To: Mark Brown <broonie@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 1, 2016 at 12:09 AM, Mark Brown <broonie@kernel.org> wrote:

>  - Do some benchmarks on the current status of the various branches on
>    relevant hardware (including trying to convert some of these slower
>    devices to blk-mq and seeing what happens).  Linus has been working
>    on this already in the context of MMC.

I'm trying to do a patch switching MMC to use blk-mq, so I can
benchmark performance before/after this.

While we expect mq to perform worse on single-hardware-queue
devices like these, we don't know until we tried, so I'm trying.

Yours,
Linus Walleij
