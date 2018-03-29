Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35987 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbeC2WHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so10349236lff.3
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:07:45 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 37/37] lightnvm: remove function name in strings
Date: Fri, 30 Mar 2018 00:05:24 +0200
Message-Id: <20180329220524.30363-38-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
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
