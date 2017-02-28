Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Paolo Valente <paolo.valente@linaro.org>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/16] mmc: block: shuffle retry and error handling
Date: Tue, 28 Feb 2017 18:45:20 +0100
Message-id: <22219053.LlSbdLjSYi@amdc3058>
In-reply-to: <20170209153403.9730-12-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-12-linus.walleij@linaro.org>
 <CGME20170228174522epcas5p34dce6477eb96f7e0fb38431c4de35f60@epcas5p3.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Thursday, February 09, 2017 04:33:58 PM Linus Walleij wrote:
> Instead of doing retries at the same time as trying to submit new
> requests, do the retries when the request is reported as completed
> by the driver, in the finalization worker.
> 
> This is achieved by letting the core worker call back into the block
> layer using mmc_blk_rw_done(), that will read the status and repeatedly
> try to hammer the request using single request etc by calling back to
> the core layer using mmc_restart_areq()
> 
> The beauty of it is that the completion will not complete until the
> block layer has had the opportunity to hammer a bit at the card using
> a bunch of different approaches in the while() loop in
> mmc_blk_rw_done()
> 
> The algorithm for recapture, retry and handle errors is essentially
> identical to the one we used to have in mmc_blk_issue_rw_rq(),
> only augmented to get called in another path.
> 
> We have to add and initialize a pointer back to the struct mmc_queue
> from the struct mmc_queue_req to find the queue from the asynchronous
> request.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

It seems that after this change we can end up queuing more
work for kthread from the kthread worker itself and wait
inside it for this nested work to complete.  I hope that
you've tested it with simulating errors and it all works.

Under this assumption:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Also some very minor nit:

+       case MMC_BLK_DATA_ERR: {
+               int err;
+                       err = mmc_blk_reset(md, host, type);

During the code movement CodingStyle suffered.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
