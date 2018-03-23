Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41551 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754915AbeCWKsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Mar 2018 06:48:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id o102-v6so17594483lfg.8
        for <linux-block@vger.kernel.org>; Fri, 23 Mar 2018 03:48:46 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: remove function name in strings
Date: Fri, 23 Mar 2018 11:48:12 +0100
Message-Id: <20180323104812.31180-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For the sysfs functions, the function names are embedded into their
error strings. If the function name later changes, the string may
not be updated accordingly. Update the strings to use __func__
to avoid this.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index ffd64a83c8c3..41279da799ed 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1028,8 +1028,8 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
 	} else {
 		return scnprintf(page,
 				 PAGE_SIZE,
-				 "Unhandled attr(%s) in `nvm_dev_attr_show`\n",
-				 attr->name);
+				 "Unhandled attr(%s) in `%s`\n",
+				 attr->name, __func__);
 	}
 }
 
@@ -1103,8 +1103,8 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
 		return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
 	} else {
 		return scnprintf(page, PAGE_SIZE,
-			"Unhandled attr(%s) in `nvm_dev_attr_show_12`\n",
-			attr->name);
+			"Unhandled attr(%s) in `%s`\n",
+			attr->name, __func__);
 	}
 }
 
@@ -1149,8 +1149,8 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 		return scnprintf(page, PAGE_SIZE, "%u\n", geo->tbem);
 	} else {
 		return scnprintf(page, PAGE_SIZE,
-			"Unhandled attr(%s) in `nvm_dev_attr_show_20`\n",
-			attr->name);
+			"Unhandled attr(%s) in `%s`\n",
+			attr->name, __func__);
 	}
 }
 
-- 
2.11.0
