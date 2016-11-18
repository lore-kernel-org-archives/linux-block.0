Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35991 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbcKROoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:44:06 -0500
Received: by mail-wm0-f48.google.com with SMTP id g23so42651617wme.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:44:05 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 10/20] lightnvm: use constant name instead of value
Date: Fri, 18 Nov 2016 15:43:32 +0100
Message-Id: <1479480222-18790-11-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There is a constant to refer to free blocks. Use it when marking bad
blocks instead of using a constant value

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/gennvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index e969e3a..aee5b72 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -279,7 +279,7 @@ static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
 	lun = &gn->luns[(dev->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
 
 	for (i = 0; i < nr_blks; i++) {
-		if (blks[i] == 0)
+		if (blks[i] == NVM_BLK_T_FREE)
 			continue;
 
 		blk = &lun->vlun.blocks[i];
-- 
2.7.4

