Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB53C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA87320866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SmJ7kZe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfEAEdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfEAEdq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685226; x=1588221226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4TKDl3ZfrG9HRqxCP6mOmf3N3YcoFwbA4FxK3YEe+o=;
  b=SmJ7kZe26PNUVW2NWVtwsEOsz+opeKCZVMdonGPgFFbwp1hoZwOI9jHt
   e2SUagoGK91cGTRwqAtxxd+D5wHSl108CM3BIDr3v9uLB5GVPz2Qo3GH8
   0FewNJ2ON8DlDjf997f/hJV8RC/ZzzOQpTNvh9nkGJq3XEmguQNWeMeUS
   0wqua1ekUrMLpdKtaW57p3dBE4+aMl8DTIkIa6JnMSiKYjGVy4GfwzeXC
   N+jPVoedeAOhx09A1RZ9SfjMN0q+f/dCp1KjZrZ41UDpT85LbiqypHv5l
   f9ODXo+bj+997oKsj3g5236wdu8b/CMd1tBfFqwVcrbeZG6gSOy49GaAl
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229738"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:46 +0800
IronPort-SDR: NjGpTRrW6iJNAQQgfJZVk5/3Ej7FOsyG2jXxwWvmW8rxixUHOqsyTgaeSS4mYCwZGX6GI2h004
 rcweP0wnJZkXYxtidpMdhJI3Lkd8n8DymPxsi+N75oYAd2VGAob9l8By8q7dSTDq/benj/dWFn
 oeNbIiegTNiVI+M53VkBU1TI14qrGHa/AnNPH1bUgDb8bgDHuQCB8Pe6bA2KFCUwhzeVwmj8Kc
 mDS2tq0EdvfoMU2ty8hXUvS+2UY+1BpZMVNMpap7IbIDK6eY4sGfPBQYDDFmPOZ6+7Df8AERvq
 J2je/CFW5kXn9R6/SVShXBAV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:12:15 -0700
IronPort-SDR: tOw0cDyG8tqxhlHtMpjj3u1e5qOSmqvqWWbQuejA/g5EnLIILKq1nbw1PluuvLg5S2kamFzgOb
 4cv0SaMeNedxRF4pLieCShS+OMFnekuKlHxgKwenm0JGzhqRsgbl2JMsVOTn0ZNPFlITzYGoIN
 uJpryupRwY8TJA4aHZQ1ymn9B615hL8MpMA3QT3NOGO/DVuuFGPWBkEtEnk9gT9x/ghnlOek2G
 +NW/ESYgYtoGAOG0KFC7dSQknzU9I8HL1f8szgPE0OzKpC4BysHToPhBFwqz98kOBl4dnTJ4be
 KoY=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:46 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 09/10] blkrawverify: add extension support
Date:   Tue, 30 Apr 2019 21:33:16 -0700
Message-Id: <20190501043317.5507-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update blkrawverify to support blktrace extension.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blkrawverify.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/blkrawverify.c b/blkrawverify.c
index ed5d258..8fa16f0 100644
--- a/blkrawverify.c
+++ b/blkrawverify.c
@@ -19,6 +19,10 @@
  *
  */
 #include <stdio.h>
+
+#ifdef CONFIG_BLKTRACE_EXT
+#include <inttypes.h>
+#endif /* CONFIG_BLKTRACE_EXT */
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
@@ -51,6 +55,10 @@ static struct trace_info traces[] = {
 	TRACE_TO_STRING( BLK_TC_META ),
 	TRACE_TO_STRING( BLK_TC_DISCARD ),
 	TRACE_TO_STRING( BLK_TC_FUA ),
+#ifdef CONFIG_BLKTRACE_EXT
+	TRACE_TO_STRING( BLK_TC_WRITE_ZEROES ),
+	TRACE_TO_STRING( BLK_TC_ZONE_RESET ),
+#endif /* CONFIG_BLKTRACE_EXT */
 };
 #define N_TRACES (sizeof(traces) / sizeof(struct trace_info))
 
@@ -80,12 +88,22 @@ static struct act_info acts[] = {
 };
 #define N_ACTS (sizeof(acts) / sizeof(struct act_info))
 
+
+#ifdef CONFIG_BLKTRACE_EXT
+static char *act_to_str(__u64 action)
+#else
 static char *act_to_str(__u32 action)
+#endif /* CONFIG_BLKTRACE_EXT */
 {
 	static char buf[1024];
 	unsigned int i;
+#ifdef CONFIG_BLKTRACE_EXT
+	unsigned int act = action & 0xffffffff; /* validate this mask */
+	uint64_t trace = (action >> BLK_TC_SHIFT) & 0xffffffff;
+#else
 	unsigned int act = action & 0xffff;
 	unsigned int trace = (action >> BLK_TC_SHIFT) & 0xffff;
+#endif /* CONFIG_BLKTRACE_EXT */
 
 	if (act < N_ACTS) {
 		sprintf(buf, "%s ", acts[act].string);
@@ -95,9 +113,13 @@ static char *act_to_str(__u32 action)
 				sprintf(buf2, "| %s ", traces[i].string);
 				strcat(buf, buf2);
 			}
-	}
-	else
+	} else {
+#ifdef CONFIG_BLKTRACE_EXT
+		sprintf(buf, "Invalid action=%"PRIx64"", (long unsigned)action);
+#else
 		sprintf(buf, "Invalid action=%08x", action);
+#endif /* CONFIG_BLKTRACE_EXT */
+	}
 
 	return buf;
 }
-- 
2.19.1

