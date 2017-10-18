Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39829 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762102AbdJRHnC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2017 03:43:02 -0400
Date: Wed, 18 Oct 2017 10:42:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Matias Bjorling <mb@lightnvm.io>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] lightnvm: pblk: fix error codes in pblk_submit_read_gc()
Message-ID: <20171018074246.nmi75jmrpuu5g74y@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There is a missing error code if pblk_bio_map_addr() fails.  This
function used to return NVM_IO_ERR on error and it still returns
NVM_IO_OK (which is zero) on success, but now it returns negative error
codes on failure.  I decided to use a standard error code and remove the
reference to NVM_IO_OK so that no one was confused.

Fixes: d340121eb770 ("lightnvm: pblk: simplify data validity check on GC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index ca79d8fb3e60..c26f527dbf86 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -528,7 +528,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 	struct bio *bio;
 	struct nvm_rq rqd;
 	int data_len;
-	int ret = NVM_IO_OK;
+	int ret;
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
@@ -561,6 +561,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		pr_err("pblk: could not allocate GC bio (%lu)\n", PTR_ERR(bio));
+		ret = PTR_ERR(bio);
 		goto err_free_dma;
 	}
 
@@ -595,7 +596,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 
 out:
 	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
-	return ret;
+	return 0;
 
 err_free_bio:
 	bio_put(bio);
