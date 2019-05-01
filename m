Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591E6C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2904E21743
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eNC26ITG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfEAEda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAEda (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685211; x=1588221211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPie3xCE0DP4N8ZJOm6oXLeSI2TDSs0yR7ULxbyJoSE=;
  b=eNC26ITGO7MPb1K7Tv4gii3rxiHZUflyPCkfIsvXCFIi+gQkkR/aP4Oe
   ZH7TN7xX0kVui/SxzBIxOkgdoRyH+STCBLvRaYtAa/m9A+Xf87EsIZ4++
   NuIqxR4zGF4z+XmSE0El/mt4TKSEnIC6XMlXPPynZ7dzsiLCza5p8QpqE
   P69mhdt4e2ovRTcCsosWD9Mxc9AsnIbmVVdmP4wpUbVRDO5OX9dZQhze4
   qKGSkBwgjJVoZIFekgsGKocDNter0QkylO0JevMG/dvCxEEMV1JOAK23Q
   Pam1P92UPGpRK26qSTU6sQWIsoxMVUgIXlbxN6sdtvi+w1Hus1UmbMetN
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229725"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:31 +0800
IronPort-SDR: QeO+g/BJceKeyrCfXUiUlUNlfSBZ/jqeXM8pY/e3hyPKdKy+16JURkQ2CXmiKhj7z4R0vbyRKC
 VvOnoL/FTWCgmZ0gth8ZwFyvrWGXiarlxQY58JnbkOOLgl4ZBI6/yXS3FTRxs3zvUUgqsrCa+l
 UcKtsr9Mw68Kh3XeOLSpzEbipbcK7owEZVbm1nAyRuFw48DIlQyaT2lv7iDZ9OJSlPpjJxo3vM
 XRnLLxdg8IZD53fovubJcHz2rdvdV84nLkhjVGF4Wvh/6p80+oZrmeCJOebw8iCJ9evUSw33Sq
 dL2Lny0sXRZ5h+UvUOjow9gd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:11:59 -0700
IronPort-SDR: nGC4DRzTMXI/X0KcVPHRiCIIq6mMI98KkX2HkemfQqiP7LDZ+8EkVJjt5b8UVsEP0IkfHB1MVg
 75FCZijr62G6wSQc0qpmsTfQObd+IvFLLOylUXMUVgyx1oAAkKmM0oeV+DR0XTARAqKc0o/1ci
 GbwVq0gEMBY4y6sud6HGLAxXrIWnT/S2QDC4odC3pevAQutR7nDoo7hDYWhlOs9mD+FmabMPyy
 oBbePkIvxCXI6XSlZK7CqjR7AxPtrLFLuZANpkwilsPilTqmWFLNeKGOFHz5vMcuCw1hDuZUXa
 YqE=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:31 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 03/10] act-mask: add blktrace extension to act_mask
Date:   Tue, 30 Apr 2019 21:33:10 -0700
Message-Id: <20190501043317.5507-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds the support for blktrace action mask to accommodate
more operations like write-zeroes and zone reset etc.

Also, we add support to use the priority mask in the existing
infrastructure. We also update the existing helpers to manage
action mask and add similar helpers for priority mask.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 act_mask.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 blktrace.h |  6 ++++++
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/act_mask.c b/act_mask.c
index 8f1b8d7..09bda08 100644
--- a/act_mask.c
+++ b/act_mask.c
@@ -1,7 +1,15 @@
 #include <strings.h>
+
+#ifdef CONFIG_BLKTRACE_EXT
+#include <stdint.h>
+#endif /* CONFIG_BLKTRACE_EXT */
 #include "blktrace.h"
 
 #define DECLARE_MASK_MAP(mask)          { BLK_TC_##mask, #mask, "BLK_TC_"#mask }
+#ifdef CONFIG_BLKTRACE_EXT
+#define DECLARE_PRIO_CLASS_MASK_MAP(mask) \
+	{ (1 << IOPRIO_CLASS_##mask), #mask, "IOPRIO_CLASS_"#mask }
+#endif /* CONFIG_BLKTRACE_EXT */
 #define COMPARE_MASK_MAP(mmp, str)                                      \
         (!strcasecmp((mmp)->short_form, (str)) ||                      \
          !strcasecmp((mmp)->long_form, (str)))
@@ -29,20 +37,64 @@ static struct mask_map mask_maps[] = {
 	DECLARE_MASK_MAP(DISCARD),
 	DECLARE_MASK_MAP(DRV_DATA),
 	DECLARE_MASK_MAP(FUA),
+#ifdef CONFIG_BLKTRACE_EXT
+	DECLARE_MASK_MAP(WRITE_ZEROES),
+	DECLARE_MASK_MAP(ZONE_RESET),
+#endif /* CONFIG_BLKTRACE_EXT */
 };
 
-int find_mask_map(char *string)
+#ifdef CONFIG_BLKTRACE_EXT
+
+/**
+ * I/O Priority Map mask based on ${KERNEL_SRC_DIR}/include/linux/ioprio.h.
+ */
+static struct mask_map prio_map[] = {
+	DECLARE_PRIO_CLASS_MASK_MAP(NONE),
+	DECLARE_PRIO_CLASS_MASK_MAP(RT),
+	DECLARE_PRIO_CLASS_MASK_MAP(BE),
+	DECLARE_PRIO_CLASS_MASK_MAP(IDLE),
+};
+
+/**
+ * I/O Priority Map mask search for valid ioprio string value.
+ */
+int find_prio_mask_map(char *string)
 {
 	unsigned int i;
 
-	for (i = 0; i < sizeof(mask_maps)/sizeof(mask_maps[0]); i++)
-		if (COMPARE_MASK_MAP(&mask_maps[i], string))
-			return mask_maps[i].mask;
+	for (i = 0; i < sizeof(prio_maps)/sizeof(prio_maps[0]); i++)
+		if (COMPARE_MASK_MAP(&prio_map[i], string))
+			return prio_map[i].mask;
 
 	return -1;
 }
 
+/**
+ * I/O Priority Map mask search for valid ioprio mask.
+ */
+bool valid_prio_opt(uint32_t x)
+{
+	return (x & 0xFFFFFFF0) ? false : true;
+}
+
+uint64_t valid_act_opt(uint64_t x)
+{
+	return (1 <= x) && (x < (1ULL << BLK_TC_SHIFT));
+}
+#else
 int valid_act_opt(int x)
 {
 	return (1 <= x) && (x < (1 << BLK_TC_SHIFT));
 }
+#endif /* CONFIG_BLKTRACE_EXT */
+
+int find_mask_map(char *string)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(mask_maps)/sizeof(mask_maps[0]); i++)
+		if (COMPARE_MASK_MAP(&mask_maps[i], string))
+			return mask_maps[i].mask;
+
+	return -1;
+}
diff --git a/blktrace.h b/blktrace.h
index 17f9f8d..c860bf9 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -181,7 +181,13 @@ extern void set_all_format_specs(char *);
 extern int add_format_spec(char *);
 extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace *,
 			unsigned long long, int, unsigned char *);
+#ifdef CONFIG_BLKTRACE_EXT
+extern uint64_t valid_act_opt(uint64_t); /* adjusted act mask for extension */
+extern bool valid_prio_opt(uint32_t x);  /* validate priority mask */
+int find_prio_mask_map(char *string);    /* find prio mask from user input */
+#else
 extern int valid_act_opt(int);
+#endif /* CONFIG_BLKTRACE_EXT */
 extern int find_mask_map(char *);
 extern char *find_process_name(pid_t);
 
-- 
2.19.1

