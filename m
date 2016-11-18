Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35928 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbcKROoD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:44:03 -0500
Received: by mail-wm0-f44.google.com with SMTP id g23so42648736wme.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:44:02 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 06/20] lightnvm: remove sysfs configuration interface
Date: Fri, 18 Nov 2016 15:43:28 +0100
Message-Id: <1479480222-18790-7-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

LightNVM used to be managed and configured through sysfs. Since the
introduction of management ioctls this interface is redundant and
outdated. Get rid of it.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 134 ------------------------------------------------
 1 file changed, 134 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 6527cf6..d4433d3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -780,140 +780,6 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 	return dev->mt->create_tgt(dev, create);
 }
 
-#ifdef CONFIG_NVM_DEBUG
-static int nvm_configure_show(const char *val)
-{
-	struct nvm_dev *dev;
-	char opcode, devname[DISK_NAME_LEN];
-	int ret;
-
-	ret = sscanf(val, "%c %32s", &opcode, devname);
-	if (ret != 2) {
-		pr_err("nvm: invalid command. Use \"opcode devicename\".\n");
-		return -EINVAL;
-	}
-
-	down_write(&nvm_lock);
-	dev = nvm_find_nvm_dev(devname);
-	up_write(&nvm_lock);
-	if (!dev) {
-		pr_err("nvm: device not found\n");
-		return -EINVAL;
-	}
-
-	if (!dev->mt)
-		return 0;
-
-	dev->mt->lun_info_print(dev);
-
-	return 0;
-}
-
-static int nvm_configure_remove(const char *val)
-{
-	struct nvm_ioctl_remove remove;
-	struct nvm_dev *dev;
-	char opcode;
-	int ret = 0;
-
-	ret = sscanf(val, "%c %256s", &opcode, remove.tgtname);
-	if (ret != 2) {
-		pr_err("nvm: invalid command. Use \"d targetname\".\n");
-		return -EINVAL;
-	}
-
-	remove.flags = 0;
-
-	list_for_each_entry(dev, &nvm_devices, devices) {
-		ret = dev->mt->remove_tgt(dev, &remove);
-		if (!ret)
-			break;
-	}
-
-	return ret;
-}
-
-static int nvm_configure_create(const char *val)
-{
-	struct nvm_ioctl_create create;
-	char opcode;
-	int lun_begin, lun_end, ret;
-
-	ret = sscanf(val, "%c %256s %256s %48s %u:%u", &opcode, create.dev,
-						create.tgtname, create.tgttype,
-						&lun_begin, &lun_end);
-	if (ret != 6) {
-		pr_err("nvm: invalid command. Use \"opcode device name tgttype lun_begin:lun_end\".\n");
-		return -EINVAL;
-	}
-
-	create.flags = 0;
-	create.conf.type = NVM_CONFIG_TYPE_SIMPLE;
-	create.conf.s.lun_begin = lun_begin;
-	create.conf.s.lun_end = lun_end;
-
-	return __nvm_configure_create(&create);
-}
-
-
-/* Exposes administrative interface through /sys/module/lnvm/configure_by_str */
-static int nvm_configure_by_str_event(const char *val,
-					const struct kernel_param *kp)
-{
-	char opcode;
-	int ret;
-
-	ret = sscanf(val, "%c", &opcode);
-	if (ret != 1) {
-		pr_err("nvm: string must have the format of \"cmd ...\"\n");
-		return -EINVAL;
-	}
-
-	switch (opcode) {
-	case 'a':
-		return nvm_configure_create(val);
-	case 'd':
-		return nvm_configure_remove(val);
-	case 's':
-		return nvm_configure_show(val);
-	default:
-		pr_err("nvm: invalid command\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int nvm_configure_get(char *buf, const struct kernel_param *kp)
-{
-	int sz;
-	struct nvm_dev *dev;
-
-	sz = sprintf(buf, "available devices:\n");
-	down_write(&nvm_lock);
-	list_for_each_entry(dev, &nvm_devices, devices) {
-		if (sz > 4095 - DISK_NAME_LEN - 2)
-			break;
-		sz += sprintf(buf + sz, " %32s\n", dev->name);
-	}
-	up_write(&nvm_lock);
-
-	return sz;
-}
-
-static const struct kernel_param_ops nvm_configure_by_str_event_param_ops = {
-	.set	= nvm_configure_by_str_event,
-	.get	= nvm_configure_get,
-};
-
-#undef MODULE_PARAM_PREFIX
-#define MODULE_PARAM_PREFIX	"lnvm."
-
-module_param_cb(configure_debug, &nvm_configure_by_str_event_param_ops, NULL,
-									0644);
-
-#endif /* CONFIG_NVM_DEBUG */
-
 static long nvm_ioctl_info(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_info *info;
-- 
2.7.4

