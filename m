Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755302AbdDOS4d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:33 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 10/19] lightnvm: bad type conversion for nvme control bits
Date: Sat, 15 Apr 2017 20:55:44 +0200
Message-ID: <20170415185553.16098-11-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

The NVMe I/O command control bits are 16 bytes, but is interpreted as
32 bytes in the lightnvm user I/O data path.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 12c5a40..4b78090 100644
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
2.9.3
