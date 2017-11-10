Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/12 v5] mmc: core: move the asynchronous post-processing
Date: Fri, 10 Nov 2017 11:01:32 +0100
Message-Id: <20171110100143.12256-2-linus.walleij@linaro.org>
In-Reply-To: <20171110100143.12256-1-linus.walleij@linaro.org>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
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

In the later patch named "mmc: core: replace waitqueue with
worker" we move the finalization to a worker started by
mmc_request_done() and in the patch named
"mmc: block: issue requests in massive parallel" we introduce
a forked success/failure path that can quickly complete
requests when they come back from the hardware.

These two later patches together restore the same optimization
but in a more elegant manner that avoids the need to flush the
two-stage pipleline with NULL, something we remove between these
two patches in the commit named
"mmc: queue: stop flushing the pipeline with NULL".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v5:
- Rebasing on the "next" branch in the MMC tree.
---
 drivers/mmc/core/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f0f44f4dd5f..e2366a82eebe 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -746,6 +746,9 @@ static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
 		mmc_start_bkops(host->card, true);
 	}
 
+	/* Successfully postprocess the old request at this point */
+	mmc_post_req(host, host->areq->mrq, 0);
+
 	return status;
 }
 
@@ -790,10 +793,6 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
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
2.13.6
