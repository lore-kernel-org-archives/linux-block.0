Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36990 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbdIFKwm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:42 -0400
Received: by mail-wm0-f50.google.com with SMTP id u26so29535421wma.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:41 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 05/18] lightnvm: pblk: initialize debug stat counter
Date: Wed,  6 Sep 2017 12:50:58 +0200
Message-Id: <1504695071-25928-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Initialize the stat counter for garbage collected reads.

Fixes: a4bd217b43268 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 1b0f61233c21..8459434edd89 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -944,6 +944,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	atomic_long_set(&pblk->recov_writes, 0);
 	atomic_long_set(&pblk->recov_writes, 0);
 	atomic_long_set(&pblk->recov_gc_writes, 0);
+	atomic_long_set(&pblk->recov_gc_reads, 0);
 #endif
 
 	atomic_long_set(&pblk->read_failed, 0);
-- 
2.7.4
