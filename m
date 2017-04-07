Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35532 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755407AbdDGSbX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2017 14:31:23 -0400
Received: by mail-wm0-f41.google.com with SMTP id w64so4865212wma.0
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2017 11:31:22 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/4] lightnvm: fix cleanup order of disk on init error
Date: Fri,  7 Apr 2017 20:31:12 +0200
Message-Id: <1491589874-26818-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
References: <1491589874-26818-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reorder disk allocation such that the disk structure can be put
safely.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index da4c082..28e69a7 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -263,15 +263,15 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
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
@@ -307,9 +307,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
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
2.7.4
