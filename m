Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD593C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B83A20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="anHGu5eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfEAE3M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEAE3L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685022; x=1588221022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHJz1gu1DY5MrgVnO1zlJGFkkcpKjYfkpg/Bk05tFs4=;
  b=anHGu5eCoLbnPiPTrxHOYG6e5CzEzOtNB6lyxZe9HPJ32D50ehYXmmXD
   tRosfSVyxJd+k9VAuIkJkuG6HntZFzJC8TfCshEcn3OQOwE3cWlVNwVyT
   CnxXHiDRSTzktX88B5oKA2JwEeBoYajEeBaAn9pYTydARKvSzCzynGZXs
   9+V+FdJ3yxKsjoIU473yCevgUpLcvt8dmtesfELuH9IitV50nslLjUhif
   40pPPF7560UZlLjjayBGcbsTYVPL8MKUPmWt9ju9NE6gljQORd81jNM9A
   IDgV1VGcwoWDHPRam7A3FI7NXbovYv0KpbV/C75L22W/9y85kYq4Ml6GK
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432284"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:22 +0800
IronPort-SDR: YnOT15y/8RTDLZP6/uXXVnXt5vQyUmGwQ2Df/mGEgMpIjH8qqI/dvYVk4CigtdtFC4YyblJsDg
 fqY8RmA2rEc093MMdMLoYB9ZO0mqeoVDSl1AAqXpSxvkgsLRZxQ8tx7hIyU+pOBvrVypBAfCfO
 PzNnUsYKqh8vNoLH15lPCc/KsV/Q8VZ0ctlsmT2T706G9Tt/6Rql8TSzEBxWG/32xyvGhRpRwa
 Z/dx7FZNg3gOo+hMOn+xPP9mteGwRgaWNvbbG187btVKMahqHdNsfS0kdyDvWGVazGLqFs/VNC
 RwbQnGwr2ZDGtJ//cEJM5hHL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:40 -0700
IronPort-SDR: EkkEHvJAwx07Iw0xnV2nh5VNQoa405ImaESMwlAhDIBYnlbSQLAH0e+NxvAoM9o2iO9xrwE3PH
 O24tr/mcRwz702KU4pUDOOLp/nzc40HwJLoer2k0q7fliR5UwO6Q8Zwz/cULn6FIRjvl8bmTcP
 48eRkqZ/xR5lMeVoDgZ2JlsxYD6rgdvof4lw7GM33A/hvp42u5lp22mnp3OFqWJ5iZpd0B8+fJ
 EaTw5kyLB2iU06NQe9L8X0NYbo/ViCCpOFu8YweN8VyXRkt86WTelvILDf33U0sR1ZPUKvU6hU
 qtM=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:12 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 09/18] blktrace: add debug support for extension
Date:   Tue, 30 Apr 2019 21:28:22 -0700
Message-Id: <20190501042831.5313-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a new keconfig options to enable debug messages for
blktrace extension.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/Kconfig    | 11 +++++++++++
 kernel/trace/blktrace.c | 36 +++++++++++++++++++++++-------------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5f8c938e495f..d01bd7972638 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -481,6 +481,17 @@ config BLKTRACE_EXT
 
 	  If unsure, say N.
 
+config DEBUG_BLKTRACE_EXT
+	bool "Debug blktrace extension"
+	depends on BLK_DEV_IO_TRACE
+	depends on BLOCK
+	depends on BLKTRACE_EXT
+	select TRACEPOINTS
+	select GENERIC_TRACER
+	select STACKTRACE
+	help
+	  This enables debug messages for the blktrace extension.
+
 config KPROBE_EVENTS
 	depends on KPROBES
 	depends on HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 84163fa6a61f..d03473614b3c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -196,45 +196,51 @@ static bool prio_log_check(struct blk_trace *bt, u32 ioprio)
 
 	switch (IOPRIO_PRIO_CLASS(ioprio)) {
 	case IOPRIO_CLASS_NONE:
-	case IOPRIO_CLASS_RT:
-	case IOPRIO_CLASS_BE:
-	case IOPRIO_CLASS_IDLE:
-		break;
-	default:
-		/*XXX: print rate limit warn here */
-		ret = false;
-		goto out;
-	}
-
-	switch (IOPRIO_PRIO_CLASS(ioprio)) {
-	case IOPRIO_CLASS_NONE:
+#ifdef CONFIG_DEBUG_BLKTRACE_EXT
+		trace_printk("%s %d NONE %s\n", __func__, __LINE__,
+				bt->prio_mask & 0x01 ? "TRUE" : "FALSE");
+#endif /* CONFIG_DEBUG_BLKTRACE_EXT */
 		if (bt->prio_mask & 0x01)
 			ret = true;
 		else
 			ret = false;
 		break;
 	case IOPRIO_CLASS_RT:
+#ifdef CONFIG_DEBUG_BLKTRACE_EXT
+		trace_printk("%s %d REAL %s\n", __func__, __LINE__,
+				bt->prio_mask & 0x02 ? "TRUE" : "FALSE");
+#endif /* CONFIG_DEBUG_BLKTRACE_EXT */
 		if (bt->prio_mask & 0x02)
 			ret = true;
 		else
 			ret = false;
 		break;
 	case IOPRIO_CLASS_BE:
+#ifdef CONFIG_DEBUG_BLKTRACE_EXT
+		trace_printk("%s %d BEST %s\n", __func__, __LINE__,
+				bt->prio_mask & 0x03 ? "TRUE" : "FALSE");
+#endif /* CONFIG_DEBUG_BLKTRACE_EXT */
 		if (bt->prio_mask & 0x04)
 			ret = true;
 		else
 			ret = false;
 		break;
 	case IOPRIO_CLASS_IDLE:
+#ifdef CONFIG_DEBUG_BLKTRACE_EXT
+		trace_printk("%s %d IDLE %s\n", __func__, __LINE__,
+				bt->prio_mask & 0x04 ? "TRUE" : "FALSE");
+#endif /* CONFIG_DEBUG_BLKTRACE_EXT */
 		if (bt->prio_mask & 0x08)
 			ret = true;
 		else
 			ret = false;
 		break;
 	default:
+#ifdef CONFIG_DEBUG_BLKTRACE_EXT
+		trace_printk("%s %d ERROR\n", __func__, __LINE__);
+#endif /* CONFIG_DEBUG_BLKTRACE_EXT */
 		ret = false;
 	}
-out:
 	return ret;
 }
 
@@ -630,6 +636,10 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 #ifdef CONFIG_BLKTRACE_EXT
 	if (!bt->act_mask)
 		bt->act_mask = (u64) -1ULL;
+
+#ifdef CONFIG_DEBUG_BLKTRACE_EXT
+	trace_printk("blktrace: prio mask 0x%x\n", buts->prio_mask);
+#endif /* CONFIG_DEBUG_BLKTRACE_EXT */
 	bt->prio_mask = buts->prio_mask;
 #else
 	if (!bt->act_mask)
-- 
2.19.1

