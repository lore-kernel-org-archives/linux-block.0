Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39398 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeA3N0Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 08:26:16 -0500
Received: by mail-lf0-f65.google.com with SMTP id w27so15332440lfd.6
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2018 05:26:16 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 1/2] lightnvm: remove mlc pairs structure
Date: Tue, 30 Jan 2018 14:26:04 +0100
Message-Id: <20180130132605.28635-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The known implementations of the 1.2 specification, and upcoming 2.0
implementation all expose a sequential list of pages to write.
Remove the data structure, as it is no longer needed.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 50ef71ee3d86..16906327645e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -116,17 +116,6 @@ struct nvme_nvm_command {
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
@@ -150,8 +139,7 @@ struct nvme_nvm_id_group {
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
