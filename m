Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46851 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeA3ObA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 09:31:00 -0500
Received: by mail-lf0-f65.google.com with SMTP id q194so15616379lfe.13
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2018 06:31:00 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: remove chnl_offset in nvme_nvm_identity
Date: Tue, 30 Jan 2018 15:30:50 +0100
Message-Id: <20180130143050.18355-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The identity structure is initialized to zero in the beginning of
the nvme_nvm_identity function. The chnl_offset is separately set to
zero. Since both the variable and assignment is never changed, remove
them.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e5544806fb0e..dc0b1335c7c6 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -59,8 +59,7 @@ struct nvme_nvm_identity {
 	__u64			rsvd[2];
 	__le64			prp1;
 	__le64			prp2;
-	__le32			chnl_off;
-	__u32			rsvd11[5];
+	__u32			rsvd11[6];
 };
 
 struct nvme_nvm_getbbtbl {
@@ -268,7 +267,6 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev, struct nvm_id *nvm_id)
 
 	c.identity.opcode = nvme_nvm_admin_identity;
 	c.identity.nsid = cpu_to_le32(ns->head->ns_id);
-	c.identity.chnl_off = 0;
 
 	nvme_nvm_id = kmalloc(sizeof(struct nvme_nvm_id), GFP_KERNEL);
 	if (!nvme_nvm_id)
-- 
2.11.0
