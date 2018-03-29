Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46374 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbeC2WHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id j68-v6so10302467lfg.13
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:15 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 16/37] lightnvm: remove max_rq_size
Date: Fri, 30 Mar 2018 00:05:03 +0200
Message-Id: <20180329220524.30363-17-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The field is no longer used.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c  | 1 -
 include/linux/lightnvm.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 521f520a1bb4..a59ad29600c3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -874,7 +874,6 @@ static int nvm_core_init(struct nvm_dev *dev)
 	geo->sec_size = id->csecs;
 	geo->oob_size = id->sos;
 	geo->mccap = id->mccap;
-	geo->max_rq_size = dev->ops->max_phys_sect * geo->sec_size;
 
 	geo->sec_per_chk = id->clba;
 	geo->sec_per_lun = geo->sec_per_chk * geo->nr_chks;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index b717c000b712..67b4fa8e4906 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -295,8 +295,6 @@ struct nvm_geo {
 	int ws_seq;
 	int ws_per_chk;
 
-	int max_rq_size;
-
 	int op;
 
 	struct nvm_addr_format ppaf;
-- 
2.11.0
