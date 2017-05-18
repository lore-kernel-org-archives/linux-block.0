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
Subject: [PATCH 6/6 v2] mmc: queue: delete mmc_req_is_special()
Date: Thu, 18 May 2017 11:29:36 +0200
Message-Id: <20170518092936.9277-6-linus.walleij@linaro.org>
In-Reply-To: <20170518092936.9277-1-linus.walleij@linaro.org>
References: <20170518092936.9277-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

commit cdf8a6fb48882651049e468e6b16956fb83db86c
"mmc: block: Introduce queue semantics"
deleted the last user of mmc_req_is_special() and it was
a horrible hack to classify requests as "special" or
"not special" to begin with, so delete the helper.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes, just include this patch with in my
  series.
---
 drivers/mmc/core/queue.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 8c76e7118c95..dfe481a8b5ed 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -12,14 +12,6 @@ static inline struct mmc_queue_req *req_to_mmc_queue_req(struct request *rq)
 	return blk_mq_rq_to_pdu(rq);
 }
 
-static inline bool mmc_req_is_special(struct request *req)
-{
-	return req &&
-		(req_op(req) == REQ_OP_FLUSH ||
-		 req_op(req) == REQ_OP_DISCARD ||
-		 req_op(req) == REQ_OP_SECURE_ERASE);
-}
-
 struct task_struct;
 struct mmc_blk_data;
 struct mmc_blk_ioc_data;
-- 
2.9.3
