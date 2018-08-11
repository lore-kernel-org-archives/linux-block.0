Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v3 15/17] bcache: add missing SPDX header
Date: Sat, 11 Aug 2018 13:19:58 +0800
Message-Id: <20180811052000.103680-16-colyli@suse.de>
In-Reply-To: <20180811052000.103680-1-colyli@suse.de>
References: <20180811052000.103680-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

The SPDX header is missing fro closure.c, super.c and util.c, this
patch adds SPDX header for GPL-2.0 into these files.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Shenghui Wang <shhuiw@foxmail.com>
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
index e3ecf08a10fc..e637d74e2908 100644
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
