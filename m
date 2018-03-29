Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42610 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeC2WHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:04 -0400
Received: by mail-lf0-f65.google.com with SMTP id a22-v6so10327198lfg.9
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:03 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 07/37] lightnvm: remove multiple groups in 1.2 data structure
Date: Fri, 30 Mar 2018 00:04:54 +0200
Message-Id: <20180329220524.30363-8-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Only one id group from the 1.2 specification is supported. Make
sure that only the first group is accessible.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 940c9b9a2a09..dc0b1335c7c6 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -166,7 +166,8 @@ struct nvme_nvm_id {
 	__le32			dom;
 	struct nvme_nvm_addr_format ppaf;
 	__u8			resv[228];
-	struct nvme_nvm_id_group groups[4];
+	struct nvme_nvm_id_group group;
+	__u8			resv2[2880];
 } __packed;
 
 struct nvme_nvm_bb_tbl {
@@ -208,7 +209,7 @@ static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
 	if (nvme_nvm_id->cgrps != 1)
 		return -EINVAL;
 
-	src = &nvme_nvm_id->groups[0];
+	src = &nvme_nvm_id->group;
 	grp = &nvm_id->grp;
 
 	grp->mtype = src->mtype;
-- 
2.11.0
