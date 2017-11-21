Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:47760 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbdKUNoD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 08:44:03 -0500
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
Subject: [PATCH V14 10/24] mmc: core: Make mmc_pre_req() and mmc_post_req() available
Date: Tue, 21 Nov 2017 15:42:36 +0200
Message-Id: <1511271770-3444-11-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make mmc_pre_req() and mmc_post_req() available to the card drivers. Later
patches will make use of this.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 31 -------------------------------
 drivers/mmc/core/core.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f0f44f4dd5f..7ca6e4866a8b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -658,37 +658,6 @@ bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq)
 EXPORT_SYMBOL(mmc_is_req_done);
 
 /**
- *	mmc_pre_req - Prepare for a new request
- *	@host: MMC host to prepare command
- *	@mrq: MMC request to prepare for
- *
- *	mmc_pre_req() is called in prior to mmc_start_req() to let
- *	host prepare for the new request. Preparation of a request may be
- *	performed while another request is running on the host.
- */
-static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq)
-{
-	if (host->ops->pre_req)
-		host->ops->pre_req(host, mrq);
-}
-
-/**
- *	mmc_post_req - Post process a completed request
- *	@host: MMC host to post process command
- *	@mrq: MMC request to post process for
- *	@err: Error, if non zero, clean up any resources made in pre_req
- *
- *	Let the host post process a completed request. Post processing of
- *	a request may be performed while another reuqest is running.
- */
-static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
-			 int err)
-{
-	if (host->ops->post_req)
-		host->ops->post_req(host, mrq, err);
-}
-
-/**
  * mmc_finalize_areq() - finalize an asynchronous request
  * @host: MMC host to finalize any ongoing request on
  *
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 71e6c6d7ceb7..f564ddfbe070 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -152,4 +152,35 @@ static inline void mmc_claim_host(struct mmc_host *host)
 void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_cqe_recovery(struct mmc_host *host);
 
+/**
+ *	mmc_pre_req - Prepare for a new request
+ *	@host: MMC host to prepare command
+ *	@mrq: MMC request to prepare for
+ *
+ *	mmc_pre_req() is called in prior to mmc_start_req() to let
+ *	host prepare for the new request. Preparation of a request may be
+ *	performed while another request is running on the host.
+ */
+static inline void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	if (host->ops->pre_req)
+		host->ops->pre_req(host, mrq);
+}
+
+/**
+ *	mmc_post_req - Post process a completed request
+ *	@host: MMC host to post process command
+ *	@mrq: MMC request to post process for
+ *	@err: Error, if non zero, clean up any resources made in pre_req
+ *
+ *	Let the host post process a completed request. Post processing of
+ *	a request may be performed while another reuqest is running.
+ */
+static inline void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
+				int err)
+{
+	if (host->ops->post_req)
+		host->ops->post_req(host, mrq, err);
+}
+
 #endif
-- 
1.9.1
