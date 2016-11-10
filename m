Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32799 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754760AbcKJL1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 06:27:45 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so2492913wmu.0
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2016 03:27:17 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com
Cc: keith.busch@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH] lightnvm: invalid offset calculation for lba_shift
Date: Thu, 10 Nov 2016 12:26:57 +0100
Message-Id: <1478777217-11514-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The ns->lba_shift assumes its value to be the logarithmic of the
LA size. A previous patch duplicated the lba_shift calculation into
lightnvm. It prematurely also subtracted a 512byte shift, which commonly
is applied per-command. The 512byte shift being subtracted twice led to
data loss when restoring the logical to physical mapping table from
device and when issuing I/O commands using rrpc.

Fix offset by removing the 512byte shift subtraction when calculating
lba_shift.

Fixes: b0b4e09c1ae7 "lightnvm: control life of nvm_dev in driver"
Reported-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index f5e3011..5daf2f4 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -612,7 +612,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node,
 
 	ret = nvm_register(dev);
 
-	ns->lba_shift = ilog2(dev->sec_size) - 9;
+	ns->lba_shift = ilog2(dev->sec_size);
 
 	if (sysfs_create_group(&dev->dev.kobj, attrs))
 		pr_warn("%s: failed to create sysfs group for identification\n",
-- 
2.1.4

