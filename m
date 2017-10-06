Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55975 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbdJFN0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 09:26:38 -0400
Received: by mail-wm0-f42.google.com with SMTP id u138so7928106wmu.4
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 06:26:37 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/2] lightnvm: fail fast on passthrough commands
Date: Fri,  6 Oct 2017 15:26:24 +0200
Message-Id: <1507296385-6045-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1507296385-6045-1-git-send-email-javier@cnexlabs.com>
References: <1507296385-6045-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make LightNVM passhtrough commands fail fast. User space will then take
care of re-submitting.

Fixes: 84d4add793c6 ('lightnvm: add ioctls for vector I/Os')
Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 1f79e3f141e6..6017153c2439 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -600,8 +600,6 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 
 	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
 
-	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
-
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
 		if (!ppa_list) {
-- 
2.7.4
