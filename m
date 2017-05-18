Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170518093239.GA9250@lst.de>
References: <20170518092936.9277-1-linus.walleij@linaro.org>
 <20170518092936.9277-2-linus.walleij@linaro.org> <20170518093239.GA9250@lst.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 May 2017 14:39:51 +0200
Message-ID: <CACRpkdb3GR3oe6HGd4e2cvAhb_7Hrj6VERxRCRHtuv8fv8ye_g@mail.gmail.com>
Subject: Re: [PATCH 2/6 v2] mmc: core: Allocate per-request data using the
 block layer core
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, May 18, 2017 at 11:32 AM, Christoph Hellwig <hch@lst.de> wrote:

> Btw, you can also remove the struct request backpointer in
> struct mmc_queue_req now - blk_mq_rq_from_pdu will do it for you
> without the need for a pointer.

Thanks I made a patch for this in the front of my next clean-up
series.

Yours,
Linus Walleij
