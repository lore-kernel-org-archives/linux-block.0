Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:48905 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753374AbdJMMrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id i124so21102136wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:14 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 08/58] lightnvm: pblk: fix message if L2P MAP is in device
Date: Fri, 13 Oct 2017 14:45:57 +0200
Message-Id: <20171013124647.32668-9-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

This usually happens if we are developing with qemu and ll2pmode has
default value. Improve description.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 05665a7..8c85779 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -914,7 +914,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	int ret;
 
 	if (dev->identity.dom & NVM_RSP_L2P) {
-		pr_err("pblk: device-side L2P table not supported. (%x)\n",
+		pr_err("pblk: host-side L2P table not supported. (%x)\n",
 							dev->identity.dom);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.9.3
