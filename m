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
Subject: Re: [PATCH 07/16] mmc: core: do away with is_done_rcv
Date: Tue, 28 Feb 2017 17:10:45 +0100
Message-id: <3255121.qvEu7RdUol@amdc3058>
In-reply-to: <20170209153403.9730-8-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-8-linus.walleij@linaro.org>
 <CGME20170228161047epcas1p2f307733cb1c441d0c290e794a04a06a8@epcas1p2.samsung.com>
List-ID: <linux-block@vger.kernel.org>

On Thursday, February 09, 2017 04:33:54 PM Linus Walleij wrote:
> The "is_done_rcv" in the context info for the host is no longer
> needed: it is clear from context (ha!) that as long as we are
> waiting for the asynchronous request to come to completion,
> we are not done receiving data, and when the finalization work
> has run and completed the completion, we are indeed done.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
