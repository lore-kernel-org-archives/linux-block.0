Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45151 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdKHJ7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 04:59:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id y80so9147921wmd.0
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2017 01:59:17 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: hch@lst.de, sagi@grimberg.me, keith.busch@intel.com,
        joe@perches.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH v2] nvme: compare NQN string with right size
Date: Wed,  8 Nov 2017 10:59:03 +0100
Message-Id: <1510135144-1557-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Copy subnqns using NVMF_NQN_SIZE as it is < 256

Changes since V1:
  - Fix commit message to indicate that it is a copy and not a comparison.

Signed-off-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37f9039bb9ca..b3bc9fb39a6c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1744,7 +1744,7 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strcpy(ctrl->subnqn, id->subnqn);
+		strncpy(ctrl->subnqn, id->subnqn, NVMF_NQN_SIZE);
 		return;
 	}
 
-- 
2.7.4
