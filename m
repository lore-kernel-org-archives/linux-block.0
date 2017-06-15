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
Subject: [PATCH 5/5] mmc: block: Delete mmc_access_rpmb()
Date: Thu, 15 Jun 2017 14:12:59 +0200
Message-Id: <20170615121259.8281-6-linus.walleij@linaro.org>
In-Reply-To: <20170615121259.8281-1-linus.walleij@linaro.org>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This function is used by the block layer queue to bail out of
requests if the current request is an RPMB request.

However this makes no sense: RPMB is only used from ioctl():s,
there are no RPMB accesses coming from the block layer.
An RPMB ioctl() always switches to the RPMB partition and
then back to the main partition before completing.

The only (possible) use of this check must have been to
duct-tape over a race between RPMB ioctl()s colliding with
concurrent non-RPMB accesses to the same device.

This could happen in the past because the RPMB device was
created as a separate block device/disk with its own submit
queue competing with the main partition, and submitting
requests in parallel. This is now gone as we removed the
offending RPMB block device in another patch.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch is not an RFC since it is a logical consequence
of the RFC patch, not really much to discuss about it.
---
 drivers/mmc/core/block.c | 12 ------------
 drivers/mmc/core/queue.c |  2 +-
 drivers/mmc/core/queue.h |  2 --
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0a226bc23429..8bb97ac3be08 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1196,18 +1196,6 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
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
index ba689a2ffc51..9d3de2859c33 100644
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
2.9.4
