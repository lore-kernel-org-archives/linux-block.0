Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55800 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425112AbeCBPWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Mar 2018 10:22:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id q83so3829197wme.5
        for <linux-block@vger.kernel.org>; Fri, 02 Mar 2018 07:21:59 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 04/12] lightnvm: complete geo structure with maxoc*
Date: Fri,  2 Mar 2018 16:21:12 +0100
Message-Id: <1520004080-27760-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1520004080-27760-1-git-send-email-javier@cnexlabs.com>
References: <1520004080-27760-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Complete the generic geometry structure with the maxoc and maxocpu
felds, present in the 2.0 spec. Also, expose them through sysfs.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 17 +++++++++++++++++
 include/linux/lightnvm.h     |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index f7f7769e7588..41b38ebdb1f3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -323,6 +323,13 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	geo->ws_opt = sec_per_pg;
 	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC safe values */
 
+	/* Do not impose values for maximum number of open blocks as it is
+	 * unspecified in 1.2. Users of 1.2 must be aware of this and eventually
+	 * specify these values through a quirk if restrictions apply.
+	 */
+	geo->maxoc = geo->all_luns * geo->nr_chks;
+	geo->maxocpu = geo->nr_chks;
+
 	geo->mccap = le32_to_cpu(src->mccap);
 
 	geo->trdt = le32_to_cpu(src->trdt);
@@ -409,6 +416,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	geo->ws_min = le32_to_cpu(id->ws_min);
 	geo->ws_opt = le32_to_cpu(id->ws_opt);
 	geo->mw_cunits = le32_to_cpu(id->mw_cunits);
+	geo->maxoc = le32_to_cpu(id->maxoc);
+	geo->maxocpu = le32_to_cpu(id->maxocpu);
 
 	geo->trdt = le32_to_cpu(id->trdt);
 	geo->trdm = le32_to_cpu(id->trdm);
@@ -1050,6 +1059,10 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 		return scnprintf(page, PAGE_SIZE, "%u\n", geo->ws_min);
 	} else if (strcmp(attr->name, "ws_opt") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", geo->ws_opt);
+	} else if (strcmp(attr->name, "maxoc") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", geo->maxoc);
+	} else if (strcmp(attr->name, "maxocpu") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", geo->maxocpu);
 	} else if (strcmp(attr->name, "mw_cunits") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", geo->mw_cunits);
 	} else if (strcmp(attr->name, "write_typ") == 0) {
@@ -1147,6 +1160,8 @@ static NVM_DEV_ATTR_20_RO(chunks);
 static NVM_DEV_ATTR_20_RO(clba);
 static NVM_DEV_ATTR_20_RO(ws_min);
 static NVM_DEV_ATTR_20_RO(ws_opt);
+static NVM_DEV_ATTR_20_RO(maxoc);
+static NVM_DEV_ATTR_20_RO(maxocpu);
 static NVM_DEV_ATTR_20_RO(mw_cunits);
 static NVM_DEV_ATTR_20_RO(write_typ);
 static NVM_DEV_ATTR_20_RO(write_max);
@@ -1163,6 +1178,8 @@ static struct attribute *nvm_dev_attrs_20[] = {
 	&dev_attr_clba.attr,
 	&dev_attr_ws_min.attr,
 	&dev_attr_ws_opt.attr,
+	&dev_attr_maxoc.attr,
+	&dev_attr_maxocpu.attr,
 	&dev_attr_mw_cunits.attr,
 
 	&dev_attr_read_typ.attr,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index a073c0c76260..870959a58fef 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -296,6 +296,8 @@ struct nvm_geo {
 	u32	ws_min;		/* minimum write size */
 	u32	ws_opt;		/* optimal write size */
 	u32	mw_cunits;	/* distance required for successful read */
+	u32	maxoc;		/* maximum open chunks */
+	u32	maxocpu;	/* maximum open chunks per parallel unit */
 
 	/* device capabilities */
 	u32	mccap;
-- 
2.7.4
