Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52224 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423502AbeCBPWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Mar 2018 10:22:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id t3so3817548wmc.2
        for <linux-block@vger.kernel.org>; Fri, 02 Mar 2018 07:22:04 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 09/12] lightnvm: pblk: check for supported version
Date: Fri,  2 Mar 2018 16:21:17 +0100
Message-Id: <1520004080-27760-10-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1520004080-27760-1-git-send-email-javier@cnexlabs.com>
References: <1520004080-27760-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

At this point, only 1.2 spec is supported, thus check for it. Also,
since device-side L2P is only supported in the 1.2 spec, make sure to
only check its value under 1.2.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 72806bd96d8f..0ad06fa8c7c7 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1016,9 +1016,15 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	struct pblk *pblk;
 	int ret;
 
-	if (dev->geo.dom & NVM_RSP_L2P) {
+	if (geo->version != NVM_OCSSD_SPEC_12) {
+		pr_err("pblk: OCSSD version not supported (%u)\n",
+							geo->version);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
 		pr_err("pblk: host-side L2P table not supported. (%x)\n",
-							dev->geo.dom);
+							geo->dom);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.7.4
