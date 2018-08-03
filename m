Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42835 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeHCK6I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 06:58:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id u202-v6so3528411lff.9
        for <linux-block@vger.kernel.org>; Fri, 03 Aug 2018 02:02:46 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: remove minor version check for 2.0
Date: Fri,  3 Aug 2018 11:02:37 +0200
Message-Id: <20180803090237.2022-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A minor version number increase should not break backwards
compatibility.

Fixes: 3cb98f84d368b ("lightnvm: add minor version to generic geometry")
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index d9e4cccd5b66..a156fe3ca7d3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -414,12 +414,6 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	/* Set compacted version for upper layers */
 	geo->version = NVM_OCSSD_SPEC_20;
 
-	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
-		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
-				geo->major_ver_id, geo->minor_ver_id);
-		return -EINVAL;
-	}
-
 	geo->num_ch = le16_to_cpu(id->num_grp);
 	geo->num_lun = le16_to_cpu(id->num_pu);
 	geo->all_luns = geo->num_ch * geo->num_lun;
-- 
2.11.0
