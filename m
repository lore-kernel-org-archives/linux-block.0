Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36945 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbeBZMLq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 07:11:46 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] lightnvm: centralize permission check for lightnvm ioctl
Date: Mon, 26 Feb 2018 13:11:33 +0100
Message-Id: <20180226121133.16727-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently all functions for handling the lightnvm core ioctl commands
do a check for CAP_SYS_ADMIN.

Change this to fail early in nvm_ctl_ioctl(), so we don't have to
duplicate the permission checks all over.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/lightnvm/core.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index dcc9e621e651..74d0bda94c11 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1040,9 +1040,6 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 	struct nvm_tgt_type *tt;
 	int tgt_iter = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	info = memdup_user(arg, sizeof(struct nvm_ioctl_info));
 	if (IS_ERR(info))
 		return -EFAULT;
@@ -1081,9 +1078,6 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 	struct nvm_dev *dev;
 	int i = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	devices = kzalloc(sizeof(struct nvm_ioctl_get_devices), GFP_KERNEL);
 	if (!devices)
 		return -ENOMEM;
@@ -1124,9 +1118,6 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_create create;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (copy_from_user(&create, arg, sizeof(struct nvm_ioctl_create)))
 		return -EFAULT;
 
@@ -1162,9 +1153,6 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 	struct nvm_dev *dev;
 	int ret = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
 		return -EFAULT;
 
@@ -1189,9 +1177,6 @@ static long nvm_ioctl_dev_init(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_dev_init init;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (copy_from_user(&init, arg, sizeof(struct nvm_ioctl_dev_init)))
 		return -EFAULT;
 
@@ -1208,9 +1193,6 @@ static long nvm_ioctl_dev_factory(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_dev_factory fact;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (copy_from_user(&fact, arg, sizeof(struct nvm_ioctl_dev_factory)))
 		return -EFAULT;
 
@@ -1226,6 +1208,9 @@ static long nvm_ctl_ioctl(struct file *file, uint cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case NVM_INFO:
 		return nvm_ioctl_info(file, argp);
-- 
2.13.6
