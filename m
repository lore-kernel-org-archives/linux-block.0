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
Subject: Re: [PATCH 09/16] mmc: core: kill off the context info
Date: Tue, 28 Feb 2017 17:11:16 +0100
Message-id: <3635557.2oraLPAu9e@amdc3058>
In-reply-to: <20170209153403.9730-10-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-10-linus.walleij@linaro.org>
 <CGME20170228161117epcas5p20a6e62146733466b98c0ef4ea6efbb5f@epcas5p2.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Thursday, February 09, 2017 04:33:56 PM Linus Walleij wrote:
> The last member of the context info: is_waiting_last_req is
> just assigned values, never checked. Delete that and the whole
> context info as a result.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
