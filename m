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
Subject: Re: [PATCH 05/16] mmc: core: add a kthread for completing requests
Date: Tue, 28 Feb 2017 15:57:17 +0100
Message-id: <2092930.gXijKn7316@amdc3058>
In-reply-to: <20170209153403.9730-6-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-6-linus.walleij@linaro.org>
 <CGME20170228145719epcas5p33d013fd48483bfba477b3f607dcdccb4@epcas5p3.samsung.com>
List-ID: <linux-block@vger.kernel.org>


On Thursday, February 09, 2017 04:33:52 PM Linus Walleij wrote:
> As we want to complete requests autonomously from feeding the
> host with new requests, we create a worker thread to deal with
> this specifically in response to the callback from a host driver.
> 
> This patch just adds the worker, later patches will make use of
> it.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
