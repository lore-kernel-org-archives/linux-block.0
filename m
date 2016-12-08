Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44845 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753428AbcLHOwx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Dec 2016 09:52:53 -0500
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <nbd-general@lists.sourceforge.net>,
        <axboe@fb.com>, <kernel-team@fb.com>
Subject: [PATCH] nbd: reset the setup task for NBD_CLEAR_SOCK
Date: Thu, 8 Dec 2016 09:52:35 -0500
Message-ID: <1481208755-24700-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If an app exits before running NBD_DO_IT but after adding sockets we can
end up not being allowed to do a new nbd device.  Fix this by making
NBD_CLEAR_SOCK reset the setup_task.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 0e6e52df..99c8446 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -705,6 +705,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 			kfree(nbd->socks);
 			nbd->socks = NULL;
 			nbd->num_connections = 0;
+			nbd->task_setup = NULL;
 		}
 		return 0;
 
-- 
2.5.5

