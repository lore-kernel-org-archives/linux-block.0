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
	Avri Altman <Avri.Altman@sandisk.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/6] mmc: block: remove req back pointer
Date: Fri, 19 May 2017 15:37:27 +0200
Message-Id: <20170519133732.27470-2-linus.walleij@linaro.org>
In-Reply-To: <20170519133732.27470-1-linus.walleij@linaro.org>
References: <20170519133732.27470-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Just as we can use blk_mq_rq_from_pdu() to get the per-request
tag we can use blk_mq_rq_to_pdu() to get a request from a tag.
Introduce a static inline helper so we are on the clear what
is happening.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c |  8 ++++----
 drivers/mmc/core/queue.c | 13 +++++--------
 drivers/mmc/core/queue.h |  8 +++++++-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e9737987956f..553ab4d1db94 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1366,7 +1366,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 	struct mmc_queue_req *mq_mrq = container_of(areq, struct mmc_queue_req,
 						    areq);
 	struct mmc_blk_request *brq = &mq_mrq->brq;
-	struct request *req = mq_mrq->req;
+	struct request *req = mmc_queue_req_to_req(mq_mrq);
 	int need_retune = card->host->need_retune;
 	bool ecc_err = false;
 	bool gen_err = false;
@@ -1473,7 +1473,7 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	struct mmc_blk_request *brq = &mqrq->brq;
-	struct request *req = mqrq->req;
+	struct request *req = mmc_queue_req_to_req(mqrq);
 
 	/*
 	 * Reliable writes are used to implement Forced Unit Access and
@@ -1578,7 +1578,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 {
 	u32 readcmd, writecmd;
 	struct mmc_blk_request *brq = &mqrq->brq;
-	struct request *req = mqrq->req;
+	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
 
@@ -1760,7 +1760,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 		 */
 		mq_rq =	container_of(old_areq, struct mmc_queue_req, areq);
 		brq = &mq_rq->brq;
-		old_req = mq_rq->req;
+		old_req = mmc_queue_req_to_req(mq_rq);
 		type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 		mmc_queue_bounce_post(mq_rq);
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index c18c41289ecf..4bf9978b707a 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -184,8 +184,6 @@ static int mmc_init_request(struct request_queue *q, struct request *req,
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 
-	mq_rq->req = req;
-
 	if (card->bouncesz) {
 		mq_rq->bounce_buf = kmalloc(card->bouncesz, gfp);
 		if (!mq_rq->bounce_buf)
@@ -223,8 +221,6 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
 
 	kfree(mq_rq->sg);
 	mq_rq->sg = NULL;
-
-	mq_rq->req = NULL;
 }
 
 /**
@@ -374,12 +370,13 @@ unsigned int mmc_queue_map_sg(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 	unsigned int sg_len;
 	size_t buflen;
 	struct scatterlist *sg;
+	struct request *req = mmc_queue_req_to_req(mqrq);
 	int i;
 
 	if (!mqrq->bounce_buf)
-		return blk_rq_map_sg(mq->queue, mqrq->req, mqrq->sg);
+		return blk_rq_map_sg(mq->queue, req, mqrq->sg);
 
-	sg_len = blk_rq_map_sg(mq->queue, mqrq->req, mqrq->bounce_sg);
+	sg_len = blk_rq_map_sg(mq->queue, req, mqrq->bounce_sg);
 
 	mqrq->bounce_sg_len = sg_len;
 
@@ -401,7 +398,7 @@ void mmc_queue_bounce_pre(struct mmc_queue_req *mqrq)
 	if (!mqrq->bounce_buf)
 		return;
 
-	if (rq_data_dir(mqrq->req) != WRITE)
+	if (rq_data_dir(mmc_queue_req_to_req(mqrq)) != WRITE)
 		return;
 
 	sg_copy_to_buffer(mqrq->bounce_sg, mqrq->bounce_sg_len,
@@ -417,7 +414,7 @@ void mmc_queue_bounce_post(struct mmc_queue_req *mqrq)
 	if (!mqrq->bounce_buf)
 		return;
 
-	if (rq_data_dir(mqrq->req) != READ)
+	if (rq_data_dir(mmc_queue_req_to_req(mqrq)) != READ)
 		return;
 
 	sg_copy_from_buffer(mqrq->bounce_sg, mqrq->bounce_sg_len,
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index dfe481a8b5ed..2793020a3c8c 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -12,6 +12,13 @@ static inline struct mmc_queue_req *req_to_mmc_queue_req(struct request *rq)
 	return blk_mq_rq_to_pdu(rq);
 }
 
+struct mmc_queue_req;
+
+static inline struct request *mmc_queue_req_to_req(struct mmc_queue_req *mqr)
+{
+	return blk_mq_rq_from_pdu(mqr);
+}
+
 struct task_struct;
 struct mmc_blk_data;
 struct mmc_blk_ioc_data;
@@ -26,7 +33,6 @@ struct mmc_blk_request {
 };
 
 struct mmc_queue_req {
-	struct request		*req;
 	struct mmc_blk_request	brq;
 	struct scatterlist	*sg;
 	char			*bounce_buf;
-- 
2.9.3
