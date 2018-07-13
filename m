Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41350 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbeGMJDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:01 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so11931371ply.8
        for <linux-block@vger.kernel.org>; Fri, 13 Jul 2018 01:49:21 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 03/10] lightnvm: pblk: enable line minor version detection
Date: Fri, 13 Jul 2018 10:48:38 +0200
Message-Id: <20180713084845.19511-4-mb@lightnvm.io>
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
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
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 3a5069183859..d83466b3821b 100644
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
