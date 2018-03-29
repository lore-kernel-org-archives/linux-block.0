Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34812 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeC2WHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:25 -0400
Received: by mail-lf0-f66.google.com with SMTP id c78-v6so10371398lfh.1
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:24 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 24/37] lightnvm: add minor version to generic geometry
Date: Fri, 30 Mar 2018 00:05:11 +0200
Message-Id: <20180329220524.30363-25-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Separate the version between major and minor on the generic geometry and
represent it through sysfs in the 2.0 path. The 1.2 path only shows the
major version to preserve the existing user space interface.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      |  4 ++--
 drivers/nvme/host/lightnvm.c | 25 ++++++++++++++++++++-----
 include/linux/lightnvm.h     |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 9dec936ac1dc..103e0ad9622c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -890,8 +890,8 @@ static int nvm_init(struct nvm_dev *dev)
 		goto err;
 	}
 
-	pr_debug("nvm: ver:%u nvm_vendor:%x\n",
-				geo->ver_id,
+	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
+				geo->major_ver_id, geo->minor_ver_id,
 				geo->vmnt);
 
 	ret = nvm_core_init(dev);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 29c8f44eb25b..de4105544956 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -295,7 +295,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 		return -EINVAL;
 	}
 
-	geo->ver_id = id->ver_id;
+	/* 1.2 spec. only reports a single version id - unfold */
+	geo->major_ver_id = id->ver_id;
+	geo->minor_ver_id = 2;
 
 	geo->nr_chnls = src->num_ch;
 	geo->nr_luns = src->num_lun;
@@ -379,7 +381,14 @@ static void nvme_nvm_set_addr_20(struct nvm_addrf *dst,
 static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 			     struct nvm_geo *geo)
 {
-	geo->ver_id = id->mjr;
+	geo->major_ver_id = id->mjr;
+	geo->minor_ver_id = id->mnr;
+
+	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
+		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
+				geo->major_ver_id, geo->minor_ver_id);
+		return -EINVAL;
+	}
 
 	geo->nr_chnls = le16_to_cpu(id->num_grp);
 	geo->nr_luns = le16_to_cpu(id->num_pu);
@@ -914,7 +923,13 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
 	attr = &dattr->attr;
 
 	if (strcmp(attr->name, "version") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", geo->ver_id);
+		if (geo->major_ver_id == 1)
+			return scnprintf(page, PAGE_SIZE, "%u\n",
+						geo->major_ver_id);
+		else
+			return scnprintf(page, PAGE_SIZE, "%u.%u\n",
+						geo->major_ver_id,
+						geo->minor_ver_id);
 	} else if (strcmp(attr->name, "capabilities") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", geo->cap);
 	} else if (strcmp(attr->name, "read_typ") == 0) {
@@ -1167,7 +1182,7 @@ int nvme_nvm_register_sysfs(struct nvme_ns *ns)
 	if (!ndev)
 		return -EINVAL;
 
-	switch (geo->ver_id) {
+	switch (geo->major_ver_id) {
 	case 1:
 		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
 					&nvm_dev_attr_group_12);
@@ -1184,7 +1199,7 @@ void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *geo = &ndev->geo;
 
-	switch (geo->ver_id) {
+	switch (geo->major_ver_id) {
 	case 1:
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvm_dev_attr_group_12);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 6e650563b379..7ed8b92d6744 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -263,7 +263,8 @@ enum {
 /* Instance geometry */
 struct nvm_geo {
 	/* device reported version */
-	u8	ver_id;
+	u8	major_ver_id;
+	u8	minor_ver_id;
 
 	/* instance specific geometry */
 	int nr_chnls;
-- 
2.11.0
