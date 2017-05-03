Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38500 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbdECJTb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 05:19:31 -0400
Received: by mail-wm0-f53.google.com with SMTP id r190so50217359wme.1
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 02:19:30 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: fix bad back free on error path
Date: Wed,  3 May 2017 11:19:05 +0200
Message-Id: <1493803145-18082-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
References: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Free memory correctly when an allocation fails on a loop and we free
backwards previously successful allocations.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 54a06c3a2b8c..6a4aa608ad95 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -74,7 +74,7 @@ static int nvm_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end)
 
 	return 0;
 err:
-	while (--i > lun_begin)
+	while (--i >= lun_begin)
 		clear_bit(i, dev->lun_map);
 
 	return -EBUSY;
@@ -211,7 +211,7 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
 
 	return tgt_dev;
 err_ch:
-	while (--i > 0)
+	while (--i >= 0)
 		kfree(dev_map->chnls[i].lun_offs);
 	kfree(luns);
 err_luns:
-- 
2.7.4
