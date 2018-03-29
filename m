Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37885 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeC2WHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id m200-v6so4581171lfm.4
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:24 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 20/37] lightnvm: centralize permission check for lightnvm ioctl
Date: Fri, 30 Mar 2018 00:05:07 +0200
Message-Id: <20180329220524.30363-21-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

Currently all functions for handling the lightnvm core ioctl commands
do a check for CAP_SYS_ADMIN.

Change this to fail early in nvm_ctl_ioctl(), so we don't have to
duplicate the permission checks all over.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 3eec948d1b7e..5b197d6bb6d9 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1019,9 +1019,6 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 	struct nvm_tgt_type *tt;
 	int tgt_iter = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	info = memdup_user(arg, sizeof(struct nvm_ioctl_info));
 	if (IS_ERR(info))
 		return -EFAULT;
@@ -1060,9 +1057,6 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 	struct nvm_dev *dev;
 	int i = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	devices = kzalloc(sizeof(struct nvm_ioctl_get_devices), GFP_KERNEL);
 	if (!devices)
 		return -ENOMEM;
@@ -1103,9 +1097,6 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_create create;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (copy_from_user(&create, arg, sizeof(struct nvm_ioctl_create)))
 		return -EFAULT;
 
@@ -1141,9 +1132,6 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 	struct nvm_dev *dev;
 	int ret = 0;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
 		return -EFAULT;
 
@@ -1168,9 +1156,6 @@ static long nvm_ioctl_dev_init(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_dev_init init;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (copy_from_user(&init, arg, sizeof(struct nvm_ioctl_dev_init)))
 		return -EFAULT;
 
@@ -1187,9 +1172,6 @@ static long nvm_ioctl_dev_factory(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_dev_factory fact;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	if (copy_from_user(&fact, arg, sizeof(struct nvm_ioctl_dev_factory)))
 		return -EFAULT;
 
@@ -1205,6 +1187,9 @@ static long nvm_ctl_ioctl(struct file *file, uint cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case NVM_INFO:
 		return nvm_ioctl_info(file, argp);
-- 
2.11.0
