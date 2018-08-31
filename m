Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41658 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeHaRmS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 13:42:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so9062565edd.8
        for <linux-block@vger.kernel.org>; Fri, 31 Aug 2018 06:34:47 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/4] lightnvm: use right address format on 1.2 path
Date: Fri, 31 Aug 2018 15:34:34 +0200
Message-Id: <1535722477-31288-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

struct ppa_addr defines different address formats. When we are in the
1.2 path, use 1.2 addressing, even when the generic format works too.
This improves readability.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index f7154398ba38..e9f14c67f4f3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -998,8 +998,8 @@ static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
 				goto done;
 
 			ppa_gen.ppa = 0;
-			ppa_gen.a.ch = ch;
-			ppa_gen.a.lun = lun;
+			ppa_gen.g.ch = ch;
+			ppa_gen.g.lun = lun;
 			ppa_dev = generic_to_dev_addr(dev, ppa_gen);
 
 			ret = dev->ops->get_bb_tbl(dev, ppa_dev, blks);
-- 
2.7.4
