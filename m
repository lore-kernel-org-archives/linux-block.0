Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38292 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbdIVMou (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 08:44:50 -0400
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V9 11/15] mmc: core: Export mmc_start_request()
Date: Fri, 22 Sep 2017 15:37:00 +0300
Message-Id: <1506083824-4024-12-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Export mmc_start_request() so that the block driver can use it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 3 ++-
 drivers/mmc/core/core.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 10d7101164e4..eaa6ece946b2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -344,7 +344,7 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 	return 0;
 }
 
-static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
+int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 	int err;
 
@@ -366,6 +366,7 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	return 0;
 }
+EXPORT_SYMBOL(mmc_start_request);
 
 /*
  * mmc_wait_data_done() - done callback for data request
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 159b2ca301ec..92d157246271 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -109,6 +109,8 @@ static inline void mmc_unregister_pm_notifier(struct mmc_host *host) { }
 void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq);
 bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 
+int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
+
 struct mmc_async_req;
 
 struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
-- 
1.9.1
