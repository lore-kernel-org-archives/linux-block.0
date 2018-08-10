Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbeHJJyW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 05:54:22 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, shhuiw@foxmail.com,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 15/17] bcache: add missing SPDX header
Date: Fri, 10 Aug 2018 15:23:55 +0800
Message-Id: <20180810072357.19823-16-colyli@suse.de>
In-Reply-To: <20180810072357.19823-1-colyli@suse.de>
References: <20180810072357.19823-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The SPDX header is missing fro closure.c, super.c and util.c, this
patch adds SPDX header for GPL-2.0 into these files.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/closure.c | 1 +
 drivers/md/bcache/super.c   | 1 +
 drivers/md/bcache/util.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 034067e0e9ce..73f5319295bc 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Asynchronous refcounty things
  *
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 18fa72e88342..d09c5fe4f758 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bcache setup/teardown code, and some metadata io - read a superblock and
  * figure out what to do with it.
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 18016e7bb32c..e873b0f7a82a 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * random utiility code, for bcache but in theory not specific to bcache
  *
-- 
2.18.0
