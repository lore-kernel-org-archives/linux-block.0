Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25419 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932747AbeEWMaw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 08:30:52 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        Igor Konopko <igor.j.konopko@intel.com>
Subject: [PATCH 3/3] lightnvm: Fix partial read error path
Date: Wed, 23 May 2018 14:29:56 +0200
Message-Id: <20180523122956.24137-4-igor.j.konopko@intel.com>
In-Reply-To: <20180523122956.24137-1-igor.j.konopko@intel.com>
References: <20180523122956.24137-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When error occurs during bio_add_page on partial read path, pblk tries to
free pages twice. This patch fixes that issue.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
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
2.14.3
