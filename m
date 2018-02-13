Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50923 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964917AbeBMOGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Feb 2018 09:06:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id f71so16254910wmf.0
        for <linux-block@vger.kernel.org>; Tue, 13 Feb 2018 06:06:20 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/8] lightnvm: add support for 2.0 address format
Date: Tue, 13 Feb 2018 15:06:03 +0100
Message-Id: <1518530768-20956-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add support for 2.0 address format. Also, align address bits for 1.2 and 2.0 to
align.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 include/linux/lightnvm.h | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 6a567bd19b73..e035ae4c9acc 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -16,12 +16,21 @@ enum {
 	NVM_IOTYPE_GC = 1,
 };
 
-#define NVM_BLK_BITS (16)
-#define NVM_PG_BITS  (16)
-#define NVM_SEC_BITS (8)
-#define NVM_PL_BITS  (8)
-#define NVM_LUN_BITS (8)
-#define NVM_CH_BITS  (7)
+/* 1.2 format */
+#define NVM_12_CH_BITS  (8)
+#define NVM_12_LUN_BITS (8)
+#define NVM_12_BLK_BITS (16)
+#define NVM_12_PG_BITS  (16)
+#define NVM_12_PL_BITS  (4)
+#define NVM_12_SEC_BITS (4)
+#define NVM_12_RESERVED (8)
+
+/* 2.0 format */
+#define NVM_20_CH_BITS  (8)
+#define NVM_20_LUN_BITS (8)
+#define NVM_20_CHK_BITS (16)
+#define NVM_20_SEC_BITS (24)
+#define NVM_20_RESERVED (8)
 
 enum {
 	NVM_OCSSD_SPEC_12 = 12,
@@ -31,16 +40,26 @@ enum {
 struct ppa_addr {
 	/* Generic structure for all addresses */
 	union {
+		/* 1.2 device format */
 		struct {
-			u64 blk		: NVM_BLK_BITS;
-			u64 pg		: NVM_PG_BITS;
-			u64 sec		: NVM_SEC_BITS;
-			u64 pl		: NVM_PL_BITS;
-			u64 lun		: NVM_LUN_BITS;
-			u64 ch		: NVM_CH_BITS;
-			u64 reserved	: 1;
+			u64 ch		: NVM_12_CH_BITS;
+			u64 lun		: NVM_12_LUN_BITS;
+			u64 blk		: NVM_12_BLK_BITS;
+			u64 pg		: NVM_12_PG_BITS;
+			u64 pl		: NVM_12_PL_BITS;
+			u64 sec		: NVM_12_SEC_BITS;
+			u64 reserved	: NVM_12_RESERVED;
 		} g;
 
+		/* 2.0 device format */
+		struct {
+			u64 ch		: NVM_20_CH_BITS;
+			u64 lun		: NVM_20_LUN_BITS;
+			u64 chk		: NVM_20_CHK_BITS;
+			u64 sec		: NVM_20_SEC_BITS;
+			u64 reserved	: NVM_20_RESERVED;
+		} m;
+
 		struct {
 			u64 line	: 63;
 			u64 is_cached	: 1;
-- 
2.7.4
