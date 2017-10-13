Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56379 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbdJMMsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:48:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id l68so21515039wmd.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:48:01 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 57/58] lightnvm: fail fast on passthrough commands
Date: Fri, 13 Oct 2017 14:46:46 +0200
Message-Id: <20171013124647.32668-58-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Make LightNVM passhtrough commands fail fast. User space will then take
care of re-submitting.

Fixes: 84d4add793c6 ('lightnvm: add ioctls for vector I/Os')
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 1f79e3f..6017153 100644
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
2.9.3
