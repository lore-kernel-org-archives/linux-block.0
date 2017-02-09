Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/16] mmc: core: move the asynchronous post-processing
Date: Thu,  9 Feb 2017 16:33:51 +0100
Message-Id: <20170209153403.9730-5-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This moves the asynchronous post-processing of a request over
to the finalization function.

The patch has a slight semantic change:

Both places will be in the code path for if (host->areq) and
in the same sequence, but before this patch, the next request
was started before performing post-processing.

The effect is that whereas before, the post- and preprocessing
happened after starting the next request, now the preprocessing
will happen after the request is done and before the next has
started which would cut half of the pre/post optimizations out.

The idea is to later move the finalization to a worker started
by mmc_request_done() and introduce a completion where the code
now has a TODO comment so that we can push in a new request
as soon as the host has completed the previous one.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8dbed198750f..0972c649ea7a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -643,6 +643,9 @@ static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
 		mmc_start_bkops(host->card, true);
 	}
 
+	/* Successfully postprocess the old request at this point */
+	mmc_post_req(host, host->areq->mrq, 0);
+
 	return status;
 }
 
@@ -687,10 +690,6 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 	if (status == MMC_BLK_SUCCESS && areq)
 		start_err = __mmc_start_data_req(host, areq->mrq);
 
-	/* Postprocess the old request at this point */
-	if (host->areq)
-		mmc_post_req(host, host->areq->mrq, 0);
-
 	/* Cancel a prepared request if it was not started. */
 	if ((status != MMC_BLK_SUCCESS || start_err) && areq)
 		mmc_post_req(host, areq->mrq, -EINVAL);
-- 
2.9.3
