Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52656 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755922AbdKCKDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2017 06:03:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id t139so370733wmt.1
        for <linux-block@vger.kernel.org>; Fri, 03 Nov 2017 03:03:00 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: hch@lst.de, sagi@grimberg.me, keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/3] nvme: fix eui_show() print format
Date: Fri,  3 Nov 2017 11:02:50 +0100
Message-Id: <1509703370-20379-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae8ab0a1ef0d..f05c81774abf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2108,7 +2108,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%8phd\n", ns->eui);
+	return sprintf(buf, "%8phD\n", ns->eui);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 
-- 
2.7.4
