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
Subject: [PATCH 3/6 v2] mmc: block: Tag is_rpmb as bool
Date: Thu, 18 May 2017 11:29:33 +0200
Message-Id: <20170518092936.9277-3-linus.walleij@linaro.org>
In-Reply-To: <20170518092936.9277-1-linus.walleij@linaro.org>
References: <20170518092936.9277-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The variable is_rpmb is clearly a bool and even assigned true
and false, yet declared as an int.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes, just resending
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 5f29b5625216..f4dab1dfd2ab 100644
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
