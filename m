Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755018AbdHYMvE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 08:51:04 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH V6 08/12] mmc: block: Use local variables in mmc_blk_data_prep()
Date: Fri, 25 Aug 2017 15:43:51 +0300
Message-Id: <1503665035-16231-9-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use local variables in mmc_blk_data_prep() in preparation for adding CQE
support which doesn't use the output variables.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2f00d11adfa9..cc950cb1cfd7 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1534,21 +1534,22 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 }
 
 static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
-			      int disable_multi, bool *do_rel_wr,
-			      bool *do_data_tag)
+			      int disable_multi, bool *do_rel_wr_p,
+			      bool *do_data_tag_p)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request *brq = &mqrq->brq;
 	struct request *req = mmc_queue_req_to_req(mqrq);
+	bool do_rel_wr, do_data_tag;
 
 	/*
 	 * Reliable writes are used to implement Forced Unit Access and
 	 * are supported only on MMCs.
 	 */
-	*do_rel_wr = (req->cmd_flags & REQ_FUA) &&
-		     rq_data_dir(req) == WRITE &&
-		     (md->flags & MMC_BLK_REL_WR);
+	do_rel_wr = (req->cmd_flags & REQ_FUA) &&
+		    rq_data_dir(req) == WRITE &&
+		    (md->flags & MMC_BLK_REL_WR);
 
 	memset(brq, 0, sizeof(struct mmc_blk_request));
 
@@ -1596,18 +1597,18 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 						brq->data.blocks);
 	}
 
-	if (*do_rel_wr)
+	if (do_rel_wr)
 		mmc_apply_rel_rw(brq, card, req);
 
 	/*
 	 * Data tag is used only during writing meta data to speed
 	 * up write and any subsequent read of this meta data
 	 */
-	*do_data_tag = card->ext_csd.data_tag_unit_size &&
-		       (req->cmd_flags & REQ_META) &&
-		       (rq_data_dir(req) == WRITE) &&
-		       ((brq->data.blocks * brq->data.blksz) >=
-			card->ext_csd.data_tag_unit_size);
+	do_data_tag = card->ext_csd.data_tag_unit_size &&
+		      (req->cmd_flags & REQ_META) &&
+		      (rq_data_dir(req) == WRITE) &&
+		      ((brq->data.blocks * brq->data.blksz) >=
+		       card->ext_csd.data_tag_unit_size);
 
 	mmc_set_data_timeout(&brq->data, card);
 
@@ -1636,6 +1637,12 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 	mqrq->areq.mrq = &brq->mrq;
 
 	mmc_queue_bounce_pre(mqrq);
+
+	if (do_rel_wr_p)
+		*do_rel_wr_p = do_rel_wr;
+
+	if (do_data_tag_p)
+		*do_data_tag_p = do_data_tag;
 }
 
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
-- 
1.9.1
