Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:9850 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdGMLWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 07:22:46 -0400
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Josef Bacik <jbacik@fb.com>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] nbd: kill unused ret in recv_work
Date: Thu, 13 Jul 2017 19:20:44 +0800
Message-ID: <1499944844-67183-1-git-send-email-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No need to return value in queue work, kill ret variable.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/block/nbd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index dea7d85..87a0a29 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -626,7 +626,6 @@ static void recv_work(struct work_struct *work)
 	struct nbd_device *nbd = args->nbd;
 	struct nbd_config *config = nbd->config;
 	struct nbd_cmd *cmd;
-	int ret = 0;
 
 	while (1) {
 		cmd = nbd_read_stat(nbd, args->index);
@@ -636,7 +635,6 @@ static void recv_work(struct work_struct *work)
 			mutex_lock(&nsock->tx_lock);
 			nbd_mark_nsock_dead(nbd, nsock, 1);
 			mutex_unlock(&nsock->tx_lock);
-			ret = PTR_ERR(cmd);
 			break;
 		}
 
-- 
1.8.3.1
