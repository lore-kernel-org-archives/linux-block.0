Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38990 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeC2WHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id p142-v6so10344877lfd.6
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:02 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 06/37] lightnvm: remove mlc pairs structure
Date: Fri, 30 Mar 2018 00:04:53 +0200
Message-Id: <20180329220524.30363-7-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Matias Bjørling <m@bjorling.me>

The known implementations of the 1.2 specification, and upcoming 2.0
implementation all expose a sequential list of pages to write.
Remove the data structure, as it is no longer needed.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index f9c38a8d54e1..940c9b9a2a09 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -115,17 +115,6 @@ struct nvme_nvm_command {
 	};
 };
 
-#define NVME_NVM_LP_MLC_PAIRS 886
-struct nvme_nvm_lp_mlc {
-	__le16			num_pairs;
-	__u8			pairs[NVME_NVM_LP_MLC_PAIRS];
-};
-
-struct nvme_nvm_lp_tbl {
-	__u8			id[8];
-	struct nvme_nvm_lp_mlc	mlc;
-};
-
 struct nvme_nvm_id_group {
 	__u8			mtype;
 	__u8			fmtype;
@@ -149,8 +138,7 @@ struct nvme_nvm_id_group {
 	__le32			mpos;
 	__le32			mccap;
 	__le16			cpar;
-	__u8			reserved[10];
-	struct nvme_nvm_lp_tbl lptbl;
+	__u8			reserved[906];
 } __packed;
 
 struct nvme_nvm_addr_format {
-- 
2.11.0
