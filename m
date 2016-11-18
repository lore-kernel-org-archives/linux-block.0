Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35226 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbcKRLjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 06:39:07 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so5275247wme.2
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 03:39:06 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, keith.busch@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 1/2] nvme: lightnvm: frees wrong cmd structure
Date: Fri, 18 Nov 2016 12:38:13 +0100
Message-Id: <1479469094-1337-2-git-send-email-m@bjorling.me>
In-Reply-To: <1479469094-1337-1-git-send-email-m@bjorling.me>
References: <1479469094-1337-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When struct nvme_request was introduced, the nvme_nvm_submit_io was
converted to the new interface. The interface moves nvme_nvm_command
data structure into the struct request pdu. On io completion, rq->cmd is
freed, which should have been the dereferenced pdu nvme_request->cmd.

Fixes: d49187e97e94 "nvme: introduce struct nvme_request"
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 442f677..de3dc87 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -477,7 +477,7 @@ static void nvme_nvm_end_io(struct request *rq, int error)
 	rqd->ppa_status = nvme_req(rq)->result.u64;
 	nvm_end_io(rqd, error);
 
-	kfree(rq->cmd);
+	kfree(nvme_req(rq)->cmd);
 	blk_mq_free_request(rq);
 }
 
-- 
2.1.4

