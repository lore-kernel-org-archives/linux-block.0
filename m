Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:47760 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752148AbdKUNoH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 08:44:07 -0500
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V14 11/24] mmc: block: Add error-handling comments
Date: Tue, 21 Nov 2017 15:42:37 +0200
Message-Id: <1511271770-3444-12-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add error-handling comments to explain what would also be done for blk-mq
if it used the legacy error-handling.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 607774fcb9f5..56624853d3d3 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1966,7 +1966,11 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 		case MMC_BLK_SUCCESS:
 		case MMC_BLK_PARTIAL:
 			/*
-			 * A block was successfully transferred.
+			 * Reset success, and accept bytes_xfered. For
+			 * MMC_BLK_PARTIAL re-submit the remaining request. For
+			 * MMC_BLK_SUCCESS error out the remaining request (it
+			 * could not be re-submitted anyway if a next request
+			 * had already begun).
 			 */
 			mmc_blk_reset_success(md, type);
 
@@ -1986,6 +1990,14 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			}
 			break;
 		case MMC_BLK_CMD_ERR:
+			/*
+			 * For SD cards, get bytes written, but do not accept
+			 * bytes_xfered if that fails. For MMC cards accept
+			 * bytes_xfered. Then try to reset. If reset fails then
+			 * error out the remaining request, otherwise retry
+			 * once (N.B mmc_blk_reset() will not succeed twice in a
+			 * row).
+			 */
 			req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
 			if (mmc_blk_reset(md, card->host, type)) {
 				if (req_pending)
@@ -2002,11 +2014,20 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			}
 			break;
 		case MMC_BLK_RETRY:
+			/*
+			 * Do not accept bytes_xfered, but retry up to 5 times,
+			 * otherwise same as abort.
+			 */
 			retune_retry_done = brq->retune_retry_done;
 			if (retry++ < 5)
 				break;
 			/* Fall through */
 		case MMC_BLK_ABORT:
+			/*
+			 * Do not accept bytes_xfered, but try to reset. If
+			 * reset succeeds, try once more, otherwise error out
+			 * the request.
+			 */
 			if (!mmc_blk_reset(md, card->host, type))
 				break;
 			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
@@ -2015,6 +2036,13 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 		case MMC_BLK_DATA_ERR: {
 			int err;
 
+			/*
+			 * Do not accept bytes_xfered, but try to reset. If
+			 * reset succeeds, try once more. If reset fails with
+			 * ENODEV which means the partition is wrong, then error
+			 * out the request. Otherwise attempt to read one sector
+			 * at a time.
+			 */
 			err = mmc_blk_reset(md, card->host, type);
 			if (!err)
 				break;
@@ -2026,6 +2054,10 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			/* Fall through */
 		}
 		case MMC_BLK_ECC_ERR:
+			/*
+			 * Do not accept bytes_xfered. If reading more than one
+			 * sector, try reading one sector at a time.
+			 */
 			if (brq->data.blocks > 1) {
 				/* Redo read one sector at a time */
 				pr_warn("%s: retrying using single block read\n",
@@ -2047,10 +2079,12 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			}
 			break;
 		case MMC_BLK_NOMEDIUM:
+			/* Do not accept bytes_xfered. Error out the request */
 			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
 			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
 			return;
 		default:
+			/* Do not accept bytes_xfered. Error out the request */
 			pr_err("%s: Unhandled return value (%d)",
 					old_req->rq_disk->disk_name, status);
 			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-- 
1.9.1
