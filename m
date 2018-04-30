Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54158 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeD3JKW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:10:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id a67so4328669wmf.3
        for <linux-block@vger.kernel.org>; Mon, 30 Apr 2018 02:10:22 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 06/11] lightnvm: pblk: return NVM_ error on failed submission
Date: Mon, 30 Apr 2018 11:10:04 +0200
Message-Id: <1525079409-6588-7-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
References: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Return a meaningful error when the sanity vector I/O check fails.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 128101f9e606..6bc0c7f61aac 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -467,16 +467,13 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 
+	atomic_inc(&pblk->inflight_io);
+
 #ifdef CONFIG_NVM_DEBUG
-	int ret;
-
-	ret = pblk_check_io(pblk, rqd);
-	if (ret)
-		return ret;
+	if (pblk_check_io(pblk, rqd))
+		return NVM_IO_ERR;
 #endif
 
-	atomic_inc(&pblk->inflight_io);
-
 	return nvm_submit_io(dev, rqd);
 }
 
@@ -484,16 +481,13 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 
+	atomic_inc(&pblk->inflight_io);
+
 #ifdef CONFIG_NVM_DEBUG
-	int ret;
-
-	ret = pblk_check_io(pblk, rqd);
-	if (ret)
-		return ret;
+	if (pblk_check_io(pblk, rqd))
+		return NVM_IO_ERR;
 #endif
 
-	atomic_inc(&pblk->inflight_io);
-
 	return nvm_submit_io_sync(dev, rqd);
 }
 
-- 
2.7.4
