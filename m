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
Subject: [PATCH 01/16] mmc: core: move some code in mmc_start_areq()
Date: Thu,  9 Feb 2017 16:33:48 +0100
Message-Id: <20170209153403.9730-2-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

"previous" is a better name for the variable storing the previous
asynchronous request, better than the opaque name "data" atleast.
We see that we assign the return status to the returned variable
on all code paths, so we might as well just do that immediately
after calling mmc_finalize_areq().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 41b4cd01fccc..53065d1cebf7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -683,7 +683,7 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 {
 	enum mmc_blk_status status;
 	int start_err = 0;
-	struct mmc_async_req *data = host->areq;
+	struct mmc_async_req *previous = host->areq;
 
 	/* Prepare a new request */
 	if (areq)
@@ -691,13 +691,12 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 
 	/* Finalize previous request */
 	status = mmc_finalize_areq(host);
+	if (ret_stat)
+		*ret_stat = status;
 
 	/* The previous request is still going on... */
-	if (status == MMC_BLK_NEW_REQUEST) {
-		if (ret_stat)
-			*ret_stat = status;
+	if (status == MMC_BLK_NEW_REQUEST)
 		return NULL;
-	}
 
 	/* Fine so far, start the new request! */
 	if (status == MMC_BLK_SUCCESS && areq)
@@ -716,9 +715,7 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 	else
 		host->areq = areq;
 
-	if (ret_stat)
-		*ret_stat = status;
-	return data;
+	return previous;
 }
 EXPORT_SYMBOL(mmc_start_areq);
 
-- 
2.9.3
