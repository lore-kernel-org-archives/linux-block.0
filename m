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
	Linus Walleij <linus.walleij@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 2/2 v6] mmc: block: Delete mmc_access_rpmb()
Date: Wed, 20 Sep 2017 10:02:01 +0200
Message-Id: <20170920080201.32438-2-linus.walleij@linaro.org>
In-Reply-To: <20170920080201.32438-1-linus.walleij@linaro.org>
References: <20170920080201.32438-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This function is used by the block layer queue to bail out of
requests if the current request is towards an RPMB
"block device".

This was done to avoid boot time scanning of this "block
device" which was never really a block device, thus duct-taping
over the fact that it was badly engineered.

This problem is now gone as we removed the offending RPMB block
device in another patch and replaced it with a character
device.

Cc: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLov v5->v6:
- Update the commit description with an accurate description
  of why this was done in the first place, and why it can now
  be removed.
ChangeLog v1->v5:
- Renumber to keep together with the rest of the series.
---
 drivers/mmc/core/block.c | 12 ------------
 drivers/mmc/core/queue.c |  2 +-
 drivers/mmc/core/queue.h |  2 --
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 6421d06b66bb..48521376b17e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1203,18 +1203,6 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
 	md->reset_done &= ~type;
 }
 
-int mmc_access_rpmb(struct mmc_queue *mq)
-{
-	struct mmc_blk_data *md = mq->blkdata;
-	/*
-	 * If this is a RPMB partition access, return ture
-	 */
-	if (md && md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
-		return true;
-
-	return false;
-}
-
 /*
  * The non-block commands come back from the block layer after it queued it and
  * processed it with all other requests and then they get issued in this
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index affa7370ba82..3baccbf16f3d 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -32,7 +32,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 {
 	struct mmc_queue *mq = q->queuedata;
 
-	if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
+	if (mq && mmc_card_removed(mq->card))
 		return BLKPREP_KILL;
 
 	req->rq_flags |= RQF_DONTPREP;
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index a2b6a9fcab01..7649ed6cbef7 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -89,6 +89,4 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 extern void mmc_queue_bounce_pre(struct mmc_queue_req *);
 extern void mmc_queue_bounce_post(struct mmc_queue_req *);
 
-extern int mmc_access_rpmb(struct mmc_queue *);
-
 #endif
-- 
2.13.5
