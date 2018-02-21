Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36999 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeBUJ1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:14 -0500
Received: by mail-wr0-f194.google.com with SMTP id z12so2446563wrg.4
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:13 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Date: Wed, 21 Feb 2018 10:26:41 +0100
Message-Id: <1519205218-26994-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Both 1.2 and 2.0 specs define a field for media and controller
capabilities. Also, 1.2 defines a separate field dedicated to device
capabilities.

In 2.0 sysfs, this values have been mixed. Revert them to the right
value.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 969bb874850c..598abba66f52 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -914,8 +914,8 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
 
 	if (strcmp(attr->name, "version") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->ver_id);
-	} else if (strcmp(attr->name, "capabilities") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.cap);
+	} else if (strcmp(attr->name, "media_capabilities") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mccap);
 	} else if (strcmp(attr->name, "read_typ") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.trdt);
 	} else if (strcmp(attr->name, "read_max") == 0) {
@@ -993,8 +993,8 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.tbem);
 	} else if (strcmp(attr->name, "multiplane_modes") == 0) {
 		return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.mpos);
-	} else if (strcmp(attr->name, "media_capabilities") == 0) {
-		return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.mccap);
+	} else if (strcmp(attr->name, "capabilities") == 0) {
+		return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.cap);
 	} else if (strcmp(attr->name, "max_phys_secs") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
 	} else {
@@ -1055,7 +1055,7 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 
 /* general attributes */
 static NVM_DEV_ATTR_RO(version);
-static NVM_DEV_ATTR_RO(capabilities);
+static NVM_DEV_ATTR_RO(media_capabilities);
 
 static NVM_DEV_ATTR_RO(read_typ);
 static NVM_DEV_ATTR_RO(read_max);
@@ -1080,12 +1080,12 @@ static NVM_DEV_ATTR_12_RO(prog_max);
 static NVM_DEV_ATTR_12_RO(erase_typ);
 static NVM_DEV_ATTR_12_RO(erase_max);
 static NVM_DEV_ATTR_12_RO(multiplane_modes);
-static NVM_DEV_ATTR_12_RO(media_capabilities);
+static NVM_DEV_ATTR_12_RO(capabilities);
 static NVM_DEV_ATTR_12_RO(max_phys_secs);
 
 static struct attribute *nvm_dev_attrs_12[] = {
 	&dev_attr_version.attr,
-	&dev_attr_capabilities.attr,
+	&dev_attr_media_capabilities.attr,
 
 	&dev_attr_vendor_opcode.attr,
 	&dev_attr_device_mode.attr,
@@ -1108,7 +1108,7 @@ static struct attribute *nvm_dev_attrs_12[] = {
 	&dev_attr_erase_typ.attr,
 	&dev_attr_erase_max.attr,
 	&dev_attr_multiplane_modes.attr,
-	&dev_attr_media_capabilities.attr,
+	&dev_attr_capabilities.attr,
 	&dev_attr_max_phys_secs.attr,
 
 	NULL,
@@ -1134,7 +1134,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
 
 static struct attribute *nvm_dev_attrs_20[] = {
 	&dev_attr_version.attr,
-	&dev_attr_capabilities.attr,
+	&dev_attr_media_capabilities.attr,
 
 	&dev_attr_groups.attr,
 	&dev_attr_punits.attr,
-- 
2.7.4
