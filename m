Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40469 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeBUJ1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:15 -0500
Received: by mail-wr0-f195.google.com with SMTP id o76so2432564wrb.7
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:14 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 04/20] lightnvm: add minor version to generic geometry
Date: Wed, 21 Feb 2018 10:26:42 +0100
Message-Id: <1519205218-26994-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Separate the version between major and minor on the generic geometry.
Also, add a "subversion" entry to sysfs to expose the minor version
without breaking user space.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      |  4 ++--
 drivers/nvme/host/lightnvm.c | 25 ++++++++++++++++++++-----
 include/linux/lightnvm.h     |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 42596afdf64c..dc9ec6baff45 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -897,8 +897,8 @@ static int nvm_init(struct nvm_dev *dev)
 		goto err;
 	}
 
-	pr_debug("nvm: ver:%u nvm_vendor:%x\n",
-				dev_geo->ver_id,
+	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
+				dev_geo->major_ver_id, dev_geo->minor_ver_id,
 				dev_geo->c.vmnt);
 
 	ret = nvm_core_init(dev);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 598abba66f52..71b4ac57a668 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -296,7 +296,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	}
 
 	/* 1.2 spec. only reports a single version id - unfold */
-	dev_geo->ver_id = id->ver_id;
+	dev_geo->major_ver_id = id->ver_id;
+	dev_geo->minor_ver_id = 2;
 
 	dev_geo->nr_chnls = src->num_ch;
 	dev_geo->nr_luns = src->num_lun;
@@ -377,7 +378,14 @@ static void nvme_nvm_set_addr_20(struct nvm_addr_format *dst,
 static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 			     struct nvm_dev_geo *dev_geo)
 {
-	dev_geo->ver_id = id->mjr;
+	dev_geo->major_ver_id = id->mjr;
+	dev_geo->minor_ver_id = id->mnr;
+
+	if (!(dev_geo->major_ver_id == 2 && dev_geo->minor_ver_id == 0)) {
+		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
+				dev_geo->major_ver_id, dev_geo->minor_ver_id);
+		return -EINVAL;
+	}
 
 	dev_geo->nr_chnls = le16_to_cpu(id->num_grp);
 	dev_geo->nr_luns = le16_to_cpu(id->num_pu);
@@ -913,7 +921,11 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
 	attr = &dattr->attr;
 
 	if (strcmp(attr->name, "version") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->ver_id);
+		return scnprintf(page, PAGE_SIZE, "%u\n",
+						dev_geo->major_ver_id);
+	} else if (strcmp(attr->name, "subversion") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n",
+						dev_geo->minor_ver_id);
 	} else if (strcmp(attr->name, "media_capabilities") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mccap);
 	} else if (strcmp(attr->name, "read_typ") == 0) {
@@ -1055,6 +1067,7 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 
 /* general attributes */
 static NVM_DEV_ATTR_RO(version);
+static NVM_DEV_ATTR_RO(subversion);
 static NVM_DEV_ATTR_RO(media_capabilities);
 
 static NVM_DEV_ATTR_RO(read_typ);
@@ -1085,6 +1098,7 @@ static NVM_DEV_ATTR_12_RO(max_phys_secs);
 
 static struct attribute *nvm_dev_attrs_12[] = {
 	&dev_attr_version.attr,
+	&dev_attr_subversion.attr,
 	&dev_attr_media_capabilities.attr,
 
 	&dev_attr_vendor_opcode.attr,
@@ -1134,6 +1148,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
 
 static struct attribute *nvm_dev_attrs_20[] = {
 	&dev_attr_version.attr,
+	&dev_attr_subversion.attr,
 	&dev_attr_media_capabilities.attr,
 
 	&dev_attr_groups.attr,
@@ -1167,7 +1182,7 @@ int nvme_nvm_register_sysfs(struct nvme_ns *ns)
 	if (!ndev)
 		return -EINVAL;
 
-	switch (dev_geo->ver_id) {
+	switch (dev_geo->major_ver_id) {
 	case 1:
 		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
 					&nvm_dev_attr_group_12);
@@ -1184,7 +1199,7 @@ void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_dev_geo *dev_geo = &ndev->dev_geo;
 
-	switch (dev_geo->ver_id) {
+	switch (dev_geo->major_ver_id) {
 	case 1:
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvm_dev_attr_group_12);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 18e3751b1632..5af0b8837095 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -242,7 +242,8 @@ struct nvm_common_geo {
 /* Device identified geometry */
 struct nvm_dev_geo {
 	/* device reported version */
-	u8	ver_id;
+	u8	major_ver_id;
+	u8	minor_ver_id;
 
 	/* full device geometry */
 	u16	nr_chnls;
-- 
2.7.4
