Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36620 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbdDJSwA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 14:52:00 -0400
Received: by mail-wm0-f51.google.com with SMTP id o81so46299218wmb.1
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2017 11:51:59 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/3] lightnvm: convert sprintf into snprintf
Date: Mon, 10 Apr 2017 20:51:36 +0200
Message-Id: <1491850297-18235-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Convert sprintf calls to snprintf in order to make possible buffer
overflow more obvious.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index c3340ef..bdbb333 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -272,7 +272,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		goto err_disk;
 	blk_queue_make_request(tqueue, tt->make_rq);
 
-	sprintf(tdisk->disk_name, "%s", create->tgtname);
+	snprintf(tdisk->disk_name, sizeof(tdisk->disk_name), "%s",
+							create->tgtname);
 	tdisk->flags = GENHD_FL_EXT_DEVT;
 	tdisk->major = 0;
 	tdisk->first_minor = 0;
@@ -1195,13 +1196,13 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 	list_for_each_entry(dev, &nvm_devices, devices) {
 		struct nvm_ioctl_device_info *info = &devices->info[i];
 
-		sprintf(info->devname, "%s", dev->name);
+		snprintf(info->devname, sizeof(info->devname), "%s", dev->name);
 
 		/* kept for compatibility */
 		info->bmversion[0] = 1;
 		info->bmversion[1] = 0;
 		info->bmversion[2] = 0;
-		sprintf(info->bmname, "%s", "gennvm");
+		snprintf(info->bmname, sizeof(info->bmname), "%s", "gennvm");
 		i++;
 
 		if (i > 31) {
-- 
2.7.4
