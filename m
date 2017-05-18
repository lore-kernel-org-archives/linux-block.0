Return-Path: <hch@lst.de>
Date: Thu, 18 May 2017 11:36:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 4/6 v2] mmc: block: move single ioctl() commands to
	block requests
Message-ID: <20170518093614.GB9250@lst.de>
References: <20170518092936.9277-1-linus.walleij@linaro.org> <20170518092936.9277-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518092936.9277-4-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 18, 2017 at 11:29:34AM +0200, Linus Walleij wrote:
> We are storing the ioctl() in/out argument as a pointer in
> the per-request struct mmc_blk_request container.

Btw, for the main ioctl data (not the little reponse field) it might
make sense to use blk_rq_map_user, which will do a get_user_pages
on the user data if the alignment fits, and otherwise handle the
kernel bounce buffering for you.  This should simplify the code
quite a bit more, and in the case where you can access the user
memory directly provide a nice little performance boost.
