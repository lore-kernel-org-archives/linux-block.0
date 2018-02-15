Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44537 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031968AbeBONMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Feb 2018 08:12:24 -0500
Received: by mail-lf0-f68.google.com with SMTP id c188so18082563lfc.11
        for <linux-block@vger.kernel.org>; Thu, 15 Feb 2018 05:12:23 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH v2 4/6] lightnvm: remove max_rq_size
Date: Thu, 15 Feb 2018 14:11:58 +0100
Message-Id: <20180215131200.3354-5-mb@lightnvm.io>
In-Reply-To: <20180215131200.3354-1-mb@lightnvm.io>
References: <20180215131200.3354-1-mb@lightnvm.io>
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
index 9b1255b3e05e..511c81c319ee 100644
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
