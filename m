Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:38016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755698AbdDOS4w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 14:56:52 -0400
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [GIT PULL 15/19] lightnvm: convert sprintf into strlcpy
Date: Sat, 15 Apr 2017 20:55:49 +0200
Message-ID: <20170415185553.16098-16-matias@cnexlabs.com>
In-Reply-To: <20170415185553.16098-1-matias@cnexlabs.com>
References: <20170415185553.16098-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Convert sprintf calls to strlcpy in order to make possible buffer
overflow more obvious.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 258007a..2c26af3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -273,7 +273,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		goto err_disk;
 	blk_queue_make_request(tqueue, tt->make_rq);
 
-	sprintf(tdisk->disk_name, "%s", create->tgtname);
+	strlcpy(tdisk->disk_name, create->tgtname, sizeof(tdisk->disk_name));
 	tdisk->flags = GENHD_FL_EXT_DEVT;
 	tdisk->major = 0;
 	tdisk->first_minor = 0;
@@ -1198,13 +1198,13 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 	list_for_each_entry(dev, &nvm_devices, devices) {
 		struct nvm_ioctl_device_info *info = &devices->info[i];
 
-		sprintf(info->devname, "%s", dev->name);
+		strlcpy(info->devname, dev->name, sizeof(info->devname));
 
 		/* kept for compatibility */
 		info->bmversion[0] = 1;
 		info->bmversion[1] = 0;
 		info->bmversion[2] = 0;
-		sprintf(info->bmname, "%s", "gennvm");
+		strlcpy(info->bmname, "gennvm", sizeof(info->bmname));
 		i++;
 
 		if (i > 31) {
-- 
2.9.3
