Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] mmc: block: Tag is_rpmb as bool
Date: Wed, 10 May 2017 10:24:16 +0200
Message-Id: <20170510082418.10513-4-linus.walleij@linaro.org>
In-Reply-To: <20170510082418.10513-1-linus.walleij@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The variable is_rpmb is clearly a bool and even assigned true
and false, yet declared as an int.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index be782b8d4a0d..323f3790b629 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -443,7 +443,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
 	int err;
-	int is_rpmb = false;
+	bool is_rpmb = false;
 	u32 status = 0;
 
 	if (!card || !md || !idata)
-- 
2.9.3
