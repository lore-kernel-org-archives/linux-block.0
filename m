Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932073AbdDOS5U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:57:20 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 19/19] lightnvm: fix some error code in pblk-init.c
Date: Sat, 15 Apr 2017 20:55:53 +0200
Message-ID: <20170415185553.16098-20-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

There were a bunch of places in pblk_lines_init() where we didn't set an
error code.  And in pblk_writer_init() we accidentally return 1 instead
of a correct error code, which would result in a Oops later.

Fixes: 11a5d6fdf919 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 94653b1..3996e4b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -543,7 +543,7 @@ static int pblk_lines_init(struct pblk *pblk)
 	long nr_bad_blks, nr_meta_blks, nr_free_blks;
 	int bb_distance;
 	int i;
-	int ret = 0;
+	int ret;
 
 	lm->sec_per_line = geo->sec_per_blk * geo->nr_luns;
 	lm->blk_per_line = geo->nr_luns;
@@ -638,12 +638,16 @@ static int pblk_lines_init(struct pblk *pblk)
 	}
 
 	l_mg->bb_template = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
-	if (!l_mg->bb_template)
+	if (!l_mg->bb_template) {
+		ret = -ENOMEM;
 		goto fail_free_meta;
+	}
 
 	l_mg->bb_aux = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
-	if (!l_mg->bb_aux)
+	if (!l_mg->bb_aux) {
+		ret = -ENOMEM;
 		goto fail_free_bb_template;
+	}
 
 	bb_distance = (geo->nr_luns) * geo->sec_per_pl;
 	for (i = 0; i < lm->sec_per_line; i += bb_distance)
@@ -667,8 +671,10 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	pblk->lines = kcalloc(l_mg->nr_lines, sizeof(struct pblk_line),
 								GFP_KERNEL);
-	if (!pblk->lines)
+	if (!pblk->lines) {
+		ret = -ENOMEM;
 		goto fail_free_bb_aux;
+	}
 
 	nr_free_blks = 0;
 	for (i = 0; i < l_mg->nr_lines; i++) {
@@ -682,8 +688,10 @@ static int pblk_lines_init(struct pblk *pblk)
 		spin_lock_init(&line->lock);
 
 		nr_bad_blks = pblk_bb_line(pblk, line);
-		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line)
+		if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line) {
+			ret = -EINVAL;
 			goto fail_free_lines;
+		}
 
 		line->blk_in_line = lm->blk_per_line - nr_bad_blks;
 		if (line->blk_in_line < lm->min_blk_line) {
@@ -733,7 +741,7 @@ static int pblk_writer_init(struct pblk *pblk)
 	pblk->writer_ts = kthread_create(pblk_write_ts, pblk, "pblk-writer-t");
 	if (IS_ERR(pblk->writer_ts)) {
 		pr_err("pblk: could not allocate writer kthread\n");
-		return 1;
+		return PTR_ERR(pblk->writer_ts);
 	}
 
 	return 0;
-- 
2.9.3
