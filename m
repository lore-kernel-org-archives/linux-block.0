Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37047 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbeBUJ1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:23 -0500
Received: by mail-wr0-f196.google.com with SMTP id z12so2447814wrg.4
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:22 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 12/20] lightnvm: complete 2.0 values in sysfs
Date: Wed, 21 Feb 2018 10:26:50 +0100
Message-Id: <1519205218-26994-13-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add missing geometry values to sysfs. Namely, maxoc and maxocpu.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 70dc4740f0d3..88c71d0d0d8c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1059,6 +1059,10 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_min);
 	} else if (strcmp(attr->name, "ws_opt") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_opt);
+	} else if (strcmp(attr->name, "maxoc") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.maxoc);
+	} else if (strcmp(attr->name, "maxocpu") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.maxocpu);
 	} else if (strcmp(attr->name, "mw_cunits") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mw_cunits);
 	} else if (strcmp(attr->name, "write_typ") == 0) {
@@ -1158,6 +1162,8 @@ static NVM_DEV_ATTR_20_RO(chunks);
 static NVM_DEV_ATTR_20_RO(clba);
 static NVM_DEV_ATTR_20_RO(ws_min);
 static NVM_DEV_ATTR_20_RO(ws_opt);
+static NVM_DEV_ATTR_20_RO(maxoc);
+static NVM_DEV_ATTR_20_RO(maxocpu);
 static NVM_DEV_ATTR_20_RO(mw_cunits);
 static NVM_DEV_ATTR_20_RO(write_typ);
 static NVM_DEV_ATTR_20_RO(write_max);
@@ -1175,6 +1181,8 @@ static struct attribute *nvm_dev_attrs_20[] = {
 	&dev_attr_clba.attr,
 	&dev_attr_ws_min.attr,
 	&dev_attr_ws_opt.attr,
+	&dev_attr_maxoc.attr,
+	&dev_attr_maxocpu.attr,
 	&dev_attr_mw_cunits.attr,
 
 	&dev_attr_read_typ.attr,
-- 
2.7.4
