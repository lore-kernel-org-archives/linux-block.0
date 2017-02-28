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
Subject: Re: [PATCH 02/16] mmc: core: refactor asynchronous request finalization
Date: Tue, 28 Feb 2017 15:55:50 +0100
Message-id: <29187792.gZrQT0n5Uu@amdc3058>
In-reply-to: <20170209153403.9730-3-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-3-linus.walleij@linaro.org>
 <CGME20170228145552epcas5p4a43c23971d58b30ad6ab9d2c612abe9a@epcas5p4.samsung.com>
List-ID: <linux-block@vger.kernel.org>


On Thursday, February 09, 2017 04:33:49 PM Linus Walleij wrote:
> mmc_wait_for_data_req_done() is called in exactly one place,
> and having it spread out is making things hard to oversee.
> Factor this function into mmc_finalize_areq().
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
