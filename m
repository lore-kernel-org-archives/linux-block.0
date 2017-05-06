Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35239 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbdEFPed (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 May 2017 11:34:33 -0400
From: Geliang Tang <geliangtang@gmail.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: fix error return code of memdup_user
Date: Sat,  6 May 2017 23:34:24 +0800
Message-Id: <f0f70c9326edab0cc56731f24244e86f8ba84ef4.1493727412.git.geliangtang@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The error return code of memdup_user() should be -ENOMEM or -EFAULT.
So this patch changed it to PTR_ERR(info).

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 54a06c3..e8b5edd 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1164,7 +1164,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 
 	info = memdup_user(arg, sizeof(struct nvm_ioctl_info));
 	if (IS_ERR(info))
-		return -EFAULT;
+		return PTR_ERR(info);
 
 	info->version[0] = NVM_VERSION_MAJOR;
 	info->version[1] = NVM_VERSION_MINOR;
-- 
2.9.3
