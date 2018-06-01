Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37020 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeFANEw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:04:52 -0400
Received: by mail-lf0-f67.google.com with SMTP id r2-v6so14721968lff.4
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:04:51 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 06/18] lightnvm: pblk: return NVM_ error on failed submission
Date: Fri,  1 Jun 2018 15:04:20 +0200
Message-Id: <20180601130432.30866-7-mb@lightnvm.io>
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

Return a meaningful error when the sanity vector I/O check fails.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 2cad918434a7..0d4078805ecc 100644
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
2.11.0
