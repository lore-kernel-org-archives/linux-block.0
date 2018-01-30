Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36150 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbeA3N0R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 08:26:17 -0500
Received: by mail-lf0-f66.google.com with SMTP id t79so15333767lfe.3
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2018 05:26:16 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 2/2] lightnvm: remove multiple groups in 1.2 data structure
Date: Tue, 30 Jan 2018 14:26:05 +0100
Message-Id: <20180130132605.28635-2-m@bjorling.me>
In-Reply-To: <20180130132605.28635-1-m@bjorling.me>
References: <20180130132605.28635-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Only one id group from the 1.2 specification is supported. Make
sure that only the first group is accessible.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 16906327645e..e5544806fb0e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -167,7 +167,8 @@ struct nvme_nvm_id {
 	__le32			dom;
 	struct nvme_nvm_addr_format ppaf;
 	__u8			resv[228];
-	struct nvme_nvm_id_group groups[4];
+	struct nvme_nvm_id_group group;
+	__u8			resv2[2880];
 } __packed;
 
 struct nvme_nvm_bb_tbl {
@@ -209,7 +210,7 @@ static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
 	if (nvme_nvm_id->cgrps != 1)
 		return -EINVAL;
 
-	src = &nvme_nvm_id->groups[0];
+	src = &nvme_nvm_id->group;
 	grp = &nvm_id->grp;
 
 	grp->mtype = src->mtype;
-- 
2.11.0
