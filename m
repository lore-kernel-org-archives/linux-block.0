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
Subject: Re: [PATCH 06/16] mmc: core: replace waitqueue with worker
Date: Tue, 28 Feb 2017 17:10:20 +0100
Message-id: <2260559.bkoArrBzfR@amdc3058>
In-reply-to: <20170209153403.9730-7-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-7-linus.walleij@linaro.org>
 <CGME20170228161023epcas5p3916c2e171d57b8c7814be7841fbab3aa@epcas5p3.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Thursday, February 09, 2017 04:33:53 PM Linus Walleij wrote:
> The waitqueue in the host context is there to signal back from
> mmc_request_done() through mmc_wait_data_done() that the hardware
> is done with a command, and when the wait is over, the core
> will typically submit the next asynchronous request that is pending
> just waiting for the hardware to be available.
> 
> This is in the way for letting the mmc_request_done() trigger the
> report up to the block layer that a block request is finished.
> 
> Re-jig this as a first step, remvoving the waitqueue and introducing
> a work that will run after a completed asynchronous request,
> finalizing that request, including retransmissions, and eventually
> reporting back with a completion and a status code to the
> asynchronous issue method.
> 
> This had the upside that we can remove the MMC_BLK_NEW_REQUEST
> status code and the "new_request" state in the request queue
> that is only there to make the state machine spin out
> the first time we send a request.
> 
> Introduce a workqueue in the host for handling just this, and
> then a work and completion in the asynchronous request to deal
> with this mechanism.
> 
> This is a central change that let us do many other changes since
> we have broken the submit and complete code paths in two, and we
> can potentially remove the NULL flushing of the asynchronous
> pipeline and report block requests as finished directly from
> the worker.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
