Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43279 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbeFLL3b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 07:29:31 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so35428844lfn.10
        for <linux-block@vger.kernel.org>; Tue, 12 Jun 2018 04:29:30 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 2/2] lightnvm: pblk: enable line minor version detection
Date: Tue, 12 Jun 2018 13:29:18 +0200
Message-Id: <20180612112918.25795-2-mb@lightnvm.io>
In-Reply-To: <20180612112918.25795-1-mb@lightnvm.io>
References: <20180612112918.25795-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When recovering a line, an extra check was added when debugging was
active, such that minor version where also checked. Unfortunately,
this used the ifdef NVM_DEBUG, which is not correct.

Instead use the proper DEBUG def, and now that it compiles, also fix
the variable.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Fixes: d0ab0b1ab991f ("lightnvm: pblk: check data lines version on recovery")
---
 drivers/lightnvm/pblk-recovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 598342833d0d..b1a91cb3ca4d 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -742,9 +742,10 @@ static int pblk_recov_check_line_version(struct pblk *pblk,
 		return 1;
 	}
 
-#ifdef NVM_DEBUG
+#ifdef CONFIG_NVM_PBLK_DEBUG
 	if (header->version_minor > EMETA_VERSION_MINOR)
-		pr_info("pblk: newer line minor version found: %d\n", line_v);
+		pr_info("pblk: newer line minor version found: %d\n",
+				header->version_minor);
 #endif
 
 	return 0;
-- 
2.11.0
