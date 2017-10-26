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
Subject: [PATCH 02/12 v4] mmc: core: add a workqueue for completing requests
Date: Thu, 26 Oct 2017 14:57:47 +0200
Message-Id: <20171026125757.10200-3-linus.walleij@linaro.org>
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

As we want to complete requests autonomously from feeding the
host with new requests, we create a workqueue to deal with
this specifically in response to the callback from a host driver.
This is necessary to exploit parallelism properly.

This patch just adds the workqueu, later patches will make use of
it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c  | 9 +++++++++
 drivers/mmc/core/host.c  | 1 -
 include/linux/mmc/host.h | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3d1270b9aec4..9c3baaddb1bd 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2828,6 +2828,14 @@ void mmc_start_host(struct mmc_host *host)
 	host->f_init = max(freqs[0], host->f_min);
 	host->rescan_disable = 0;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
+	/* Workqueue for completing requests */
+	host->req_done_wq = alloc_workqueue("mmc%d-reqdone",
+				WQ_FREEZABLE | WQ_HIGHPRI | WQ_MEM_RECLAIM,
+				0, host->index);
+	if (!host->req_done_wq) {
+		dev_err(mmc_dev(host), "could not allocate workqueue\n");
+		return;
+	}
 
 	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
 		mmc_claim_host(host);
@@ -2849,6 +2857,7 @@ void mmc_stop_host(struct mmc_host *host)
 
 	host->rescan_disable = 1;
 	cancel_delayed_work_sync(&host->detect);
+	destroy_workqueue(host->req_done_wq);
 
 	/* clear pm flags now and let card drivers set them as needed */
 	host->pm_flags = 0;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e58be39b1568..8193363a5a46 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -381,7 +381,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
 	INIT_DELAYED_WORK(&host->sdio_irq_work, sdio_irq_work);
 	setup_timer(&host->retune_timer, mmc_retune_timer, (unsigned long)host);
-
 	/*
 	 * By default, hosts do not support SGIO or large requests.
 	 * They have to set these according to their abilities.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c296f4351c1d..94a646eebf05 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/fault-inject.h>
+#include <linux/workqueue.h>
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
@@ -423,6 +424,9 @@ struct mmc_host {
 	struct mmc_async_req	*areq;		/* active async req */
 	struct mmc_context_info	context_info;	/* async synchronization info */
 
+	/* finalization workqueue, handles finalizing requests */
+	struct workqueue_struct	*req_done_wq;
+
 	/* Ongoing data transfer that allows commands during transfer */
 	struct mmc_request	*ongoing_mrq;
 
-- 
2.13.6
