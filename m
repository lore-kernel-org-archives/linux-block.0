Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:46761 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbdDMTfY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2017 15:35:24 -0400
Date: Thu, 13 Apr 2017 22:35:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Matias Bjorling <mb@lightnvm.io>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] lightnvm: fix some error code in pblk-init.c
Message-ID: <20170413193512.GB591@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There were a bunch of places in pblk_lines_init() where we didn't set an
error code.  And in pblk_writer_init() we accidentally return 1 instead
of a correct error code, which would result in a Oops later.

Fixes: 11a5d6fdf919 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 94653b1f1300..3996e4b8fb0e 100644
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
