Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754704AbdHYMue (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 08:50:34 -0400
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
Subject: [PATCH V6 01/12] mmc: core: Move mmc_start_areq() declaration
Date: Fri, 25 Aug 2017 15:43:44 +0300
Message-Id: <1503665035-16231-2-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

mmc_start_areq() is an internal mmc core API. Move the declaration
accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.h  | 6 ++++++
 include/linux/mmc/core.h | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 55f543fd37c4..ca861091a776 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -107,6 +107,12 @@ static inline void mmc_unregister_pm_notifier(struct mmc_host *host) { }
 void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq);
 bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 
+struct mmc_async_req;
+
+struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
+				     struct mmc_async_req *areq,
+				     enum mmc_blk_status *ret_stat);
+
 int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		unsigned int arg);
 int mmc_can_erase(struct mmc_card *card);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index bf1788a224e6..178f699ac172 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -165,11 +165,7 @@ struct mmc_request {
 };
 
 struct mmc_card;
-struct mmc_async_req;
 
-struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
-				struct mmc_async_req *areq,
-				enum mmc_blk_status *ret_stat);
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
-- 
1.9.1
