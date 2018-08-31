Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33013 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeHaRmT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 13:42:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id d8-v6so1009683edv.0
        for <linux-block@vger.kernel.org>; Fri, 31 Aug 2018 06:34:48 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/4] lightnvm: assign block address before slba
Date: Fri, 31 Aug 2018 15:34:35 +0200
Message-Id: <1535722477-31288-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In 1.2, the chunk slba is set to the physical representation of the
block. Thus, assigning the block to the ppa must occur before the slba
is assign.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index e9f14c67f4f3..efb976a863d2 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -945,6 +945,8 @@ static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
 			}
 		}
 
+		ppa.g.blk = blk;
+
 		meta->wp = 0;
 		meta->type = NVM_CHK_TP_W_SEQ;
 		meta->wi = 0;
@@ -952,7 +954,6 @@ static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
 		meta->cnlb = dev->geo.clba;
 
 		if (blktype == NVM_BLK_T_FREE) {
-			ppa.a.blk = blk;
 			ret = nvm_bb_chunk_scan(dev, ppa, meta);
 			if (ret)
 				return ret;
-- 
2.7.4
