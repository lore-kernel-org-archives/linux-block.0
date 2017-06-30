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
Subject: [PATCH 2/3 v4] mmc: ops: export mmc_get_status()
Date: Fri, 30 Jun 2017 14:06:48 +0200
Message-Id: <20170630120649.27007-2-linus.walleij@linaro.org>
In-Reply-To: <20170630120649.27007-1-linus.walleij@linaro.org>
References: <20170630120649.27007-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This function retrieves the status of the card with the default
number of retries. Since the block layer wants to use this, and
since the block layer is a loadable kernel module, we need to
export this symbol.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- No changes just resending
ChangeLog v2->v3:
- New patch to fix a build error, enumerating v3 to keep it
  together with the other patches.
---
 drivers/mmc/core/mmc_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5f7c5920231a..b56fa822ab6b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -83,6 +83,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 {
 	return __mmc_send_status(card, status, MMC_CMD_RETRIES);
 }
+EXPORT_SYMBOL_GPL(mmc_send_status);
 
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
-- 
2.9.4
