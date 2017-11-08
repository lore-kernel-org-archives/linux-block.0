Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:49633 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdKHJ7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 04:59:18 -0500
Received: by mail-wm0-f68.google.com with SMTP id b189so9095119wmd.4
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2017 01:59:18 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: hch@lst.de, sagi@grimberg.me, keith.busch@intel.com,
        joe@perches.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH v2] nvme: fix eui_show() print format
Date: Wed,  8 Nov 2017 10:59:04 +0100
Message-Id: <1510135144-1557-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1510135144-1557-1-git-send-email-javier@cnexlabs.com>
References: <1510135144-1557-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Fix print formatting, but keep the original output to prevent user
breakage as suggested by Joe Perches.

Change since v1:
  - Maintain the original output format printing spaces instead of dashes

Signed-off-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b3bc9fb39a6c..6c9d313c6f90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2109,7 +2109,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%8phd\n", ns->eui);
+	return sprintf(buf, "%8ph\n", ns->eui);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
-- 
2.7.4
