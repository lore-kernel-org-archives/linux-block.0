Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55173 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755920AbdKCKDA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2017 06:03:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id r68so343816wmr.3
        for <linux-block@vger.kernel.org>; Fri, 03 Nov 2017 03:02:59 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: hch@lst.de, sagi@grimberg.me, keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/3] nvme: compare NQN string with right size
Date: Fri,  3 Nov 2017 11:02:49 +0100
Message-Id: <1509703370-20379-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Compare subnqns using NVMF_NQN_SIZE as it is < 256

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bd1d5ff911c9..ae8ab0a1ef0d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1743,7 +1743,7 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strcpy(ctrl->subnqn, id->subnqn);
+		strncpy(ctrl->subnqn, id->subnqn, NVMF_NQN_SIZE);
 		return;
 	}
 
-- 
2.7.4
