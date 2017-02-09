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
Subject: [PATCH 05/16] mmc: core: add a kthread for completing requests
Date: Thu,  9 Feb 2017 16:33:52 +0100
Message-Id: <20170209153403.9730-6-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

As we want to complete requests autonomously from feeding the
host with new requests, we create a worker thread to deal with
this specifically in response to the callback from a host driver.

This patch just adds the worker, later patches will make use of
it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c  | 6 ++++++
 drivers/mmc/core/host.c  | 2 +-
 include/linux/mmc/host.h | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0972c649ea7a..663799240635 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2794,6 +2794,10 @@ void mmc_start_host(struct mmc_host *host)
 	host->f_init = max(freqs[0], host->f_min);
 	host->rescan_disable = 0;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
+	/* Worker for completing requests */
+	host->req_done_worker_task = kthread_run(kthread_worker_fn,
+				      &host->req_done_worker,
+				      "mmc%d-reqdone", host->index);
 
 	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
 		mmc_claim_host(host);
@@ -2818,6 +2822,8 @@ void mmc_stop_host(struct mmc_host *host)
 
 	host->rescan_disable = 1;
 	cancel_delayed_work_sync(&host->detect);
+	kthread_flush_worker(&host->req_done_worker);
+	kthread_stop(host->req_done_worker_task);
 
 	/* clear pm flags now and let card drivers set them as needed */
 	host->pm_flags = 0;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ffb4258..d33e2b260bf3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -388,7 +388,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
 	setup_timer(&host->retune_timer, mmc_retune_timer, (unsigned long)host);
-
+	kthread_init_worker(&host->req_done_worker);
 	/*
 	 * By default, hosts do not support SGIO or large requests.
 	 * They have to set these according to their abilities.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 97699d55b2ae..b04f8cd51c82 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/fault-inject.h>
+#include <linux/kthread.h>
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
@@ -375,6 +376,10 @@ struct mmc_host {
 	struct mmc_async_req	*areq;		/* active async req */
 	struct mmc_context_info	context_info;	/* async synchronization info */
 
+	/* finalization work thread, handles finalizing requests */
+	struct kthread_worker	req_done_worker;
+	struct task_struct	*req_done_worker_task;
+
 	/* Ongoing data transfer that allows commands during transfer */
 	struct mmc_request	*ongoing_mrq;
 
-- 
2.9.3
