Return-Path: <hch@lst.de>
Date: Thu, 18 May 2017 11:32:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 2/6 v2] mmc: core: Allocate per-request data using the
	block layer core
Message-ID: <20170518093239.GA9250@lst.de>
References: <20170518092936.9277-1-linus.walleij@linaro.org> <20170518092936.9277-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518092936.9277-2-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Btw, you can also remove the struct request backpointer in
struct mmc_queue_req now - blk_mq_rq_from_pdu will do it for you
without the need for a pointer.
