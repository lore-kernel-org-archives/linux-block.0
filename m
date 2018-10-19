Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60962 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeJSTZZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Oct 2018 15:25:25 -0400
From: Avri Altman <avri.altman@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] block: Bundle together NONE and NOT_SET writehint types
Date: Fri, 19 Oct 2018 14:19:37 +0300
Message-Id: <1539947977-4686-1-git-send-email-avri.altman@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There are 6 writehint types, but the size of the write_hints array
in the request queue is BLK_MAX_WRITE_HINTS = 5,
which causes the EXTREME type to be ignored when iterating
over the hints.

We only have effectively 5 hints.
Bundle together NONE and NOT_SET, since they end up in the same
bucket on the driver side.

fixes: f793dfd3f39a (blk-mq: expose write hints through debugfs)

v1->v2:
Bundle together NONE and NOT_SET, instead of making the write_hints
array of the request queue larger.
Change the commit title accordingly.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 fs/fcntl.c                       |  2 +-
 include/uapi/linux/fcntl.h       | 10 +++++-----
 tools/include/uapi/linux/fcntl.h | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 4137d96..163cf5fd 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -261,7 +261,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 static bool rw_hint_valid(enum rw_hint hint)
 {
 	switch (hint) {
-	case RWF_WRITE_LIFE_NOT_SET:
+	/* RWF_WRITE_LIFE_NOT_SET = RWH_WRITE_LIFE_NONE */
 	case RWH_WRITE_LIFE_NONE:
 	case RWH_WRITE_LIFE_SHORT:
 	case RWH_WRITE_LIFE_MEDIUM:
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6448cdd..ff048f8 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -58,11 +58,11 @@
  * used to clear any hints previously set.
  */
 #define RWF_WRITE_LIFE_NOT_SET	0
-#define RWH_WRITE_LIFE_NONE	1
-#define RWH_WRITE_LIFE_SHORT	2
-#define RWH_WRITE_LIFE_MEDIUM	3
-#define RWH_WRITE_LIFE_LONG	4
-#define RWH_WRITE_LIFE_EXTREME	5
+#define RWH_WRITE_LIFE_NONE	RWF_WRITE_LIFE_NOT_SET
+#define RWH_WRITE_LIFE_SHORT	1
+#define RWH_WRITE_LIFE_MEDIUM	2
+#define RWH_WRITE_LIFE_LONG	3
+#define RWH_WRITE_LIFE_EXTREME	4
 
 /*
  * Types of directory notifications that may be requested.
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 6448cdd..ff048f8 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -58,11 +58,11 @@
  * used to clear any hints previously set.
  */
 #define RWF_WRITE_LIFE_NOT_SET	0
-#define RWH_WRITE_LIFE_NONE	1
-#define RWH_WRITE_LIFE_SHORT	2
-#define RWH_WRITE_LIFE_MEDIUM	3
-#define RWH_WRITE_LIFE_LONG	4
-#define RWH_WRITE_LIFE_EXTREME	5
+#define RWH_WRITE_LIFE_NONE	RWF_WRITE_LIFE_NOT_SET
+#define RWH_WRITE_LIFE_SHORT	1
+#define RWH_WRITE_LIFE_MEDIUM	2
+#define RWH_WRITE_LIFE_LONG	3
+#define RWH_WRITE_LIFE_EXTREME	4
 
 /*
  * Types of directory notifications that may be requested.
-- 
1.9.1
