Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751616AbdDOS41 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:27 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 07/19] lightnvm: don't check for failure from mempool_alloc()
Date: Sat, 15 Apr 2017 20:55:41 +0200
Message-ID: <20170415185553.16098-8-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: NeilBrown <neilb@suse.com>

mempool_alloc() cannot fail if the gfp flags allow it to
sleep, and both GFP_KERNEL and GFP_NOIO allows for sleeping.

So rrpc_move_valid_pages() and rrpc_make_rq() don't need to
test the return value.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/rrpc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 4e4c299..a8acf9e 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -318,10 +318,6 @@ static int rrpc_move_valid_pages(struct rrpc *rrpc, struct rrpc_block *rblk)
 	}
 
 	page = mempool_alloc(rrpc->page_pool, GFP_NOIO);
-	if (!page) {
-		bio_put(bio);
-		return -ENOMEM;
-	}
 
 	while ((slot = find_first_zero_bit(rblk->invalid_pages,
 					    nr_sec_per_blk)) < nr_sec_per_blk) {
@@ -1006,11 +1002,6 @@ static blk_qc_t rrpc_make_rq(struct request_queue *q, struct bio *bio)
 	}
 
 	rqd = mempool_alloc(rrpc->rq_pool, GFP_KERNEL);
-	if (!rqd) {
-		pr_err_ratelimited("rrpc: not able to queue bio.");
-		bio_io_error(bio);
-		return BLK_QC_T_NONE;
-	}
 	memset(rqd, 0, sizeof(struct nvm_rq));
 
 	err = rrpc_submit_io(rrpc, bio, rqd, NVM_IOTYPE_NONE);
-- 
2.9.3
