Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54860 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757978AbdJMMrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id i124so21513131wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:11 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 04/58] lightnvm: remove already calculated nr_chnls
Date: Fri, 13 Oct 2017 14:45:53 +0200
Message-Id: <20171013124647.32668-5-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

Remove repeated calculation for number of channels while creating a
target device.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index ee2b6d7..798964f 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -139,7 +139,6 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
 	int prev_nr_luns;
 	int i, j;
 
-	nr_chnls = nr_luns / dev->geo.luns_per_chnl;
 	nr_chnls = (nr_chnls_mod == 0) ? nr_chnls : nr_chnls + 1;
 
 	dev_map = kmalloc(sizeof(struct nvm_dev_map), GFP_KERNEL);
-- 
2.9.3
