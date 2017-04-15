Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755101AbdDOS4b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:31 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 09/19] lightnvm: fix cleanup order of disk on init error
Date: Sat, 15 Apr 2017 20:55:43 +0200
Message-ID: <20170415185553.16098-10-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Reorder disk allocation such that the disk structure can be put
safely.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5eea3d5..5f84d2a 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -264,15 +264,15 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		goto err_t;
 	}
 
+	tdisk = alloc_disk(0);
+	if (!tdisk)
+		goto err_dev;
+
 	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
 	if (!tqueue)
-		goto err_dev;
+		goto err_disk;
 	blk_queue_make_request(tqueue, tt->make_rq);
 
-	tdisk = alloc_disk(0);
-	if (!tdisk)
-		goto err_queue;
-
 	sprintf(tdisk->disk_name, "%s", create->tgtname);
 	tdisk->flags = GENHD_FL_EXT_DEVT;
 	tdisk->major = 0;
@@ -308,9 +308,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	if (tt->exit)
 		tt->exit(targetdata);
 err_init:
-	put_disk(tdisk);
-err_queue:
 	blk_cleanup_queue(tqueue);
+err_disk:
+	put_disk(tdisk);
 err_dev:
 	nvm_remove_tgt_dev(tgt_dev, 0);
 err_t:
-- 
2.9.3
