Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38525 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdIFKwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:43 -0400
Received: by mail-wm0-f53.google.com with SMTP id 187so29403326wmn.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:42 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 06/18] lightnvm: pblk: use right flag for GC allocation
Date: Wed,  6 Sep 2017 12:50:59 +0200
Message-Id: <1504695071-25928-7-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The data buffer for the GC path allocates virtual memory through
vmalloc. When this change was introduced, a flag signaling kmalloc'ed
memory was wrongly introduced. Use the right flag when creating a bio
from this buffer.

Fixes: de54e703a422 ("lightnvm: pblk: use vmalloc for GC data buffer")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index db9a3b575f62..9bbdca8a65ab 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -490,7 +490,7 @@ int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 
 	data_len = (*secs_to_gc) * geo->sec_size;
 	bio = pblk_bio_map_addr(pblk, data, *secs_to_gc, data_len,
-						PBLK_KMALLOC_META, GFP_KERNEL);
+						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		pr_err("pblk: could not allocate GC bio (%lu)\n", PTR_ERR(bio));
 		goto err_free_dma;
@@ -510,7 +510,7 @@ int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 	if (ret) {
 		bio_endio(bio);
 		pr_err("pblk: GC read request failed\n");
-		goto err_free_dma;
+		goto err_free_bio;
 	}
 
 	if (!wait_for_completion_io_timeout(&wait,
@@ -532,10 +532,13 @@ int pblk_submit_read_gc(struct pblk *pblk, u64 *lba_list, void *data,
 	atomic_long_sub(*secs_to_gc, &pblk->inflight_reads);
 #endif
 
+	bio_put(bio);
 out:
 	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 	return NVM_IO_OK;
 
+err_free_bio:
+	bio_put(bio);
 err_free_dma:
 	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
 	return NVM_IO_ERR;
-- 
2.7.4
