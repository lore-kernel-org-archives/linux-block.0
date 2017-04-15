Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:42825
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755983AbdDOS5U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:57:20 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 18/19] lightnvm: fix some WARN() messages
Date: Sat, 15 Apr 2017 20:55:52 +0200
Message-ID: <20170415185553.16098-19-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

WARN_ON() takes a condition, not an error message.  I slightly tweaked
some conditions so hopefully it's more clear.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c     | 12 ++++++------
 drivers/lightnvm/pblk-recovery.c |  2 +-
 drivers/lightnvm/pblk-write.c    |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index eff0982..bce7ed5 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -49,8 +49,8 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	int i, j = 0;
 
 	/* logic error: lba out-of-bounds. Ignore read request */
-	if (!(blba + nr_secs < pblk->rl.nr_secs)) {
-		WARN_ON("pblk: read lbas out of bounds\n");
+	if (blba + nr_secs >= pblk->rl.nr_secs) {
+		WARN(1, "pblk: read lbas out of bounds\n");
 		return;
 	}
 
@@ -254,8 +254,8 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	sector_t lba = pblk_get_lba(bio);
 
 	/* logic error: lba out-of-bounds. Ignore read request */
-	if (!(lba < pblk->rl.nr_secs)) {
-		WARN_ON("pblk: read lba out of bounds\n");
+	if (lba >= pblk->rl.nr_secs) {
+		WARN(1, "pblk: read lba out of bounds\n");
 		return;
 	}
 
@@ -411,8 +411,8 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 	int valid_secs = 0;
 
 	/* logic error: lba out-of-bounds */
-	if (!(lba < pblk->rl.nr_secs)) {
-		WARN_ON("pblk: read lba out of bounds\n");
+	if (lba >= pblk->rl.nr_secs) {
+		WARN(1, "pblk: read lba out of bounds\n");
 		goto out;
 	}
 
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 0d50f41..f8f8508 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -167,7 +167,7 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 		if (le64_to_cpu(lba_list[i]) == ADDR_EMPTY) {
 			spin_lock(&line->lock);
 			if (test_and_set_bit(i, line->invalid_bitmap))
-				WARN_ON_ONCE("pblk: rec. double invalidate:\n");
+				WARN_ONCE(1, "pblk: rec. double invalidate:\n");
 			else
 				line->vsc--;
 			spin_unlock(&line->lock);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index ee57db9..74f7413 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -141,7 +141,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
 
 		/* Logic error */
 		if (bit > c_ctx->nr_valid) {
-			WARN_ON_ONCE("pblk: corrupted write request\n");
+			WARN_ONCE(1, "pblk: corrupted write request\n");
 			goto out;
 		}
 
-- 
2.9.3
