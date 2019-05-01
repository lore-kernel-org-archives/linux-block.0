Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9E0C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8A021743
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n/mWNzlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfEAEdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEAEdm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685222; x=1588221222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69/d7WWIR6UCTY2tjgvwUS4nd0EYmhFlu6sKwGgSdQk=;
  b=n/mWNzlRNYlN4KV+Z+MxyBumBNvZ/W3fdRwK3YS2qDh1ZCmPhKypQ/ae
   TcchJ1h+93/2Pila1cYQj7LsDA9E1HTXPkmkUTIh2AccCKXbZ6yUcGOBG
   iPss4mOHzxODE4gShiOeX7lSxrPKjAPNyPIc206E9R1lrs9AzvY4ge95e
   0XHz2x7RcGKWxQKiLjRAmquflaIzum1Nm8RwshMMZT3mVsNErsZxgZJy7
   OXseJu9E0RpjON+HoOVz1fT1a2QbWM0bCJ864SaSLluzuXajwDPkQYnji
   Bp+V5id1obMvyqUt45QtEkcVc0WDElCN4Ksb/jRHM9/FytSR4JUmSoiYh
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229735"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:42 +0800
IronPort-SDR: rwxF38x82zXinTZReubnaNO6Br3PhwwTwnsmskvtPa6aJ/P9+N6RRdq41MFi1zl8kQroMKx+WA
 AayGVUg0tdwYVGg2vwq2EN+a0ov0PrwoSnyj6xGKzMkoCFnrpppeKtVodYrUoq9mWclyiy0Cbv
 slJVdrKEGE6q175C24QhfbqmLKwSiRnicjA9c2MPwpP8O6kVvqHyYkDc8rvL6IX4/HGENJtKv9
 R3BNEcfj/ggM4i/jwSvsTm3WDvPPMYwtW48li/neWJU6/4dvi9ZkgIgdoc1k/4kJvJoD3hXcOC
 ESx7WKwZHHVPTxlGabtXtYFV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:12:10 -0700
IronPort-SDR: mshUCzqvtBKe/9rD05ZfH1G64H7DoP8IEn0bVOiyPzkr6YqwMEEflIBAyj7CXgqqZ04iHhSoDK
 3y+5kx6GQYw9dxtDxUZ05h9N72Pc6WDk9226Qgf5AFXVNThix/Afx5uGIP6BzT4cMM6Ogql2Ar
 YnniszP58CQjfdkyXf2zniLDhzm1tWbyS52NiiPXyzc2yXym4lOBgJPdcppnO8hP7Q4kfS98CP
 jEbV6NshG3UZIGNIFIKqX9bmnNOryowZsvs5EU7/jHOKk+QsgzY3rrf+01lEzI/mjBw3B59STB
 Tc0=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:41 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 07/10] iowatcher/blkparse: add extension definitions
Date:   Tue, 30 Apr 2019 21:33:14 -0700
Message-Id: <20190501043317.5507-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here we synchronize the blktrace extension definitions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 iowatcher/blkparse.c | 70 +++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 41e20f0..fce7de3 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -52,29 +52,43 @@ extern int io_per_process;
 /*
  * Trace categories
  */
-enum {
-	BLK_TC_READ	= 1 << 0,	/* reads */
-	BLK_TC_WRITE	= 1 << 1,	/* writes */
-	BLK_TC_FLUSH	= 1 << 2,	/* flush */
-	BLK_TC_SYNC	= 1 << 3,	/* sync */
-	BLK_TC_QUEUE	= 1 << 4,	/* queueing/merging */
-	BLK_TC_REQUEUE	= 1 << 5,	/* requeueing */
-	BLK_TC_ISSUE	= 1 << 6,	/* issue */
-	BLK_TC_COMPLETE	= 1 << 7,	/* completions */
-	BLK_TC_FS	= 1 << 8,	/* fs requests */
-	BLK_TC_PC	= 1 << 9,	/* pc requests */
-	BLK_TC_NOTIFY	= 1 << 10,	/* special message */
-	BLK_TC_AHEAD	= 1 << 11,	/* readahead */
-	BLK_TC_META	= 1 << 12,	/* metadata */
-	BLK_TC_DISCARD	= 1 << 13,	/* discard requests */
-	BLK_TC_DRV_DATA	= 1 << 14,	/* binary driver data */
-	BLK_TC_FUA	= 1 << 15,	/* fua requests */
-
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
-};
-
+enum blktrace_cat {
+        BLK_TC_READ             = 1 << 0,       /* reads */
+        BLK_TC_WRITE            = 1 << 1,       /* writes */
+        BLK_TC_FLUSH            = 1 << 2,       /* flush */
+        BLK_TC_SYNC             = 1 << 3,       /* sync IO */
+        BLK_TC_SYNCIO           = BLK_TC_SYNC,
+        BLK_TC_QUEUE            = 1 << 4,       /* queueing/merging */
+        BLK_TC_REQUEUE          = 1 << 5,       /* requeueing */
+        BLK_TC_ISSUE            = 1 << 6,       /* issue */
+        BLK_TC_COMPLETE         = 1 << 7,       /* completions */
+        BLK_TC_FS               = 1 << 8,       /* fs requests */
+        BLK_TC_PC               = 1 << 9,       /* pc requests */
+        BLK_TC_NOTIFY           = 1 << 10,      /* special message */
+        BLK_TC_AHEAD            = 1 << 11,      /* readahead */
+        BLK_TC_META             = 1 << 12,      /* metadata */
+        BLK_TC_DISCARD          = 1 << 13,      /* discard requests */
+        BLK_TC_DRV_DATA         = 1 << 14,      /* binary per-driver data */
+        BLK_TC_FUA              = 1 << 15,      /* fua requests */
+#ifdef CONFIG_BLKTRACE_EXT
+        BLK_TC_WRITE_ZEROES     = 1 << 16,      /* write-zeores */
+        BLK_TC_ZONE_RESET       = 1 << 17,      /* zone-reset */
+
+        BLK_TC_END              = 1 << 31,      /* we've run out of bits! */
+#else
+        BLK_TC_END              = 1 << 16,      /* we've run out of bits! */
+#endif
+ };
+
+#ifdef CONFIG_BLKTRACE_EXT
+#define BLK_TC_SHIFT		(32)
+#define BLK_TC_ACT(act)		(((uint64_t)act) << BLK_TC_SHIFT)
+#else
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
+
+#endif
+
 #define BLK_DATADIR(a) (((a) >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE))
 
 /*
@@ -100,7 +114,12 @@ enum {
 	__BLK_TA_DRV_DATA,		/* binary driver data */
 };
 
+#ifdef CONFIG_BLKTRACE_EXT
+#define BLK_TA_MASK ((1ULL << BLK_TC_SHIFT) - 1)
+#else
 #define BLK_TA_MASK ((1 << BLK_TC_SHIFT) - 1)
+#endif
+
 
 /*
  * Notify events.
@@ -137,7 +156,11 @@ enum blktrace_notify {
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
+#ifdef CONFIG_BLKTRACE_EXT
+#define BLK_IO_TRACE_VERSION	0x08
+#else
 #define BLK_IO_TRACE_VERSION	0x07
+#endif
 /*
  * The trace itself
  */
@@ -147,7 +170,12 @@ struct blk_io_trace {
 	__u64 time;		/* in nanoseconds */
 	__u64 sector;		/* disk offset */
 	__u32 bytes;		/* transfer length */
+#ifdef CONFIG_BLKTRACE_EXT
+	__u64 action;		/* what happened */
+	__u32 ioprio;		/* ioprio */
+#else
 	__u32 action;		/* what happened */
+#endif
 	__u32 pid;		/* who did it */
 	__u32 device;		/* device identifier (dev_t) */
 	__u32 cpu;		/* on what cpu did it happen */
-- 
2.19.1

