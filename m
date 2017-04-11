Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37232 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbdDKOTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 10:19:08 -0400
Received: by mail-wm0-f47.google.com with SMTP id u2so2022547wmu.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 07:19:08 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/3] lightnvm: convert sprintf into strlcpy
Date: Tue, 11 Apr 2017 16:18:58 +0200
Message-Id: <1491920338-2348-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
References: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Convert sprintf calls to strlcpy in order to make possible buffer
overflow more obvious.

Signed-off-by: Javier González <javier@cnexlabs.com>
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
2.7.4
