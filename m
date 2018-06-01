Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:42415 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeFANFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:05:15 -0400
Received: by mail-lf0-f51.google.com with SMTP id v135-v6so14745119lfa.9
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:05:14 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 16/18] lightnvm: fix partial read error path
Date: Fri,  1 Jun 2018 15:04:30 +0200
Message-Id: <20180601130432.30866-17-mb@lightnvm.io>
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

When error occurs during bio_add_page on partial read path, pblk
tries to free pages twice.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index a2e678de428f..fa7b60f852d9 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -256,7 +256,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
 
 	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
-		goto err;
+		goto err_add_pages;
 
 	if (nr_holes != new_bio->bi_vcnt) {
 		pr_err("pblk: malformed bio\n");
@@ -347,10 +347,10 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 	return NVM_IO_OK;
 
 err:
-	pr_err("pblk: failed to perform partial read\n");
-
 	/* Free allocated pages in new bio */
-	pblk_bio_free_pages(pblk, bio, 0, new_bio->bi_vcnt);
+	pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
+err_add_pages:
+	pr_err("pblk: failed to perform partial read\n");
 	__pblk_end_io_read(pblk, rqd, false);
 	return NVM_IO_ERR;
 }
-- 
2.11.0
