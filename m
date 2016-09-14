Return-Path: <BATV+6a0d0451059a4bcd7d0f+4770+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 14 Sep 2016 05:36:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove remnant refs to hardsect
Message-ID: <20160914123610.GA17806@infradead.org>
References: <1473856372-22204-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473856372-22204-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 14, 2016 at 02:32:52PM +0200, Linus Walleij wrote:
> commit e1defc4ff0cf57aca6c5e3ff99fa503f5943c1f1
> "block: Do away with the notion of hardsect_size"
> removed the notion of "hardware sector size" from
> the kernel in favor of logical block size, but
> references remain in comments and documentation.
> 
> Update the remaining sites mentioning hardsect.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
