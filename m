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
Date: Wed, 01 Mar 2017 12:45:57 +0100
Message-id: <1718299.ToPxjyb5YA@amdc3058>
In-reply-to: <22219053.LlSbdLjSYi@amdc3058>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-12-linus.walleij@linaro.org>
 <22219053.LlSbdLjSYi@amdc3058>
 <CGME20170301114559epcas5p1a0c32fbc3a5573a6f1c6291792ea1b2e@epcas5p1.samsung.com>
List-ID: <linux-block@vger.kernel.org>


Hi,

On Tuesday, February 28, 2017 06:45:20 PM Bartlomiej Zolnierkiewicz wrote:
> On Thursday, February 09, 2017 04:33:58 PM Linus Walleij wrote:
> > Instead of doing retries at the same time as trying to submit new
> > requests, do the retries when the request is reported as completed
> > by the driver, in the finalization worker.
> > 
> > This is achieved by letting the core worker call back into the block
> > layer using mmc_blk_rw_done(), that will read the status and repeatedly
> > try to hammer the request using single request etc by calling back to
> > the core layer using mmc_restart_areq()
> > 
> > The beauty of it is that the completion will not complete until the
> > block layer has had the opportunity to hammer a bit at the card using
> > a bunch of different approaches in the while() loop in
> > mmc_blk_rw_done()
> > 
> > The algorithm for recapture, retry and handle errors is essentially
> > identical to the one we used to have in mmc_blk_issue_rw_rq(),
> > only augmented to get called in another path.
> > 
> > We have to add and initialize a pointer back to the struct mmc_queue
> > from the struct mmc_queue_req to find the queue from the asynchronous
> > request.
> > 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It seems that after this change we can end up queuing more
> work for kthread from the kthread worker itself and wait
> inside it for this nested work to complete.  I hope that

On the second look it seems that there is no waiting for
the retried areq to complete so I cannot see what protects
us from racing and trying to run two areq-s in parallel:

1st areq being retried (in the completion kthread):

	mmc_blk_rw_done()->mmc_restart_areq()->__mmc_start_data_req()

2nd areq coming from the second request in the queue
(in the queuing kthread):

	mmc_blk_issue_rw_rq()->mmc_start_areq()->__mmc_start_data_req()

(after mmc_blk_rw_done() is done in mmc_finalize_areq() 1st
areq is marked as completed by the completion kthread and
the waiting on host->areq in mmc_start_areq() of the queuing
kthread is done and 2nd areq is started while the 1st one
is still being retried)

?

Also retrying of areqs for MMC_BLK_RETRY status case got broken
(before change do {} while() loop increased retry variable,
now the loop is gone and retry variable will not be increased
correctly and we can loop forever).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
