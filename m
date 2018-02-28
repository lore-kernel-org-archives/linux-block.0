Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53219 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933622AbeB1PuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 10:50:00 -0500
Received: by mail-wm0-f65.google.com with SMTP id t3so5887701wmc.2
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2018 07:49:59 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 10/15] lightnvm: pblk: check for supported version
Date: Wed, 28 Feb 2018 16:49:30 +0100
Message-Id: <1519832975-25432-11-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
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
index 11424beb214c..b67b5b11ae16 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -991,9 +991,15 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
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
