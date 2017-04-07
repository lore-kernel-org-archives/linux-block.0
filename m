Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38019 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755778AbdDGSbY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2017 14:31:24 -0400
Received: by mail-wm0-f43.google.com with SMTP id t189so13754094wmt.1
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2017 11:31:23 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/4] lightnvm: bad type conversion for nvme control bits
Date: Fri,  7 Apr 2017 20:31:13 +0200
Message-Id: <1491589874-26818-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
References: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The NVMe I/O command control bits are 16 bytes, but is interpreted as
32 bytes in the lightnvm user I/O data path.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 2c8f933..83e7ea2 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -754,7 +754,7 @@ static int nvme_nvm_user_vcmd(struct nvme_ns *ns, int admin,
 	c.common.cdw2[1] = cpu_to_le32(vcmd.cdw3);
 	/* cdw11-12 */
 	c.ph_rw.length = cpu_to_le16(vcmd.nppas);
-	c.ph_rw.control  = cpu_to_le32(vcmd.control);
+	c.ph_rw.control  = cpu_to_le16(vcmd.control);
 	c.common.cdw10[3] = cpu_to_le32(vcmd.cdw13);
 	c.common.cdw10[4] = cpu_to_le32(vcmd.cdw14);
 	c.common.cdw10[5] = cpu_to_le32(vcmd.cdw15);
-- 
2.7.4
