Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37642 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbdECJT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 05:19:27 -0400
Received: by mail-wm0-f47.google.com with SMTP id m123so49852529wma.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 02:19:27 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/2] lightnvm: create cmd before allocating request
Date: Wed,  3 May 2017 11:19:04 +0200
Message-Id: <1493803145-18082-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Create nvme command before allocating a request using
nvme_alloc_request, which uses the command direction. Up until now, the
command has been zeroized, so all commands have been allocated as a
read operation.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index de61a4a03d78..090bbeb655bc 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -503,6 +503,8 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	if (!cmd)
 		return -ENOMEM;
 
+	nvme_nvm_rqtocmd(rq, rqd, ns, cmd);
+
 	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY);
 	if (IS_ERR(rq)) {
 		kfree(cmd);
@@ -517,8 +519,6 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 		rq->__data_len = 0;
 	}
 
-	nvme_nvm_rqtocmd(rq, rqd, ns, cmd);
-
 	rq->end_io_data = rqd;
 
 	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
-- 
2.7.4
