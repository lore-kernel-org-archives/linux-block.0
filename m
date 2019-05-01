Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F59C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8042720866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="POlpbwT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfEAEd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:33:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63464 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAEd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685208; x=1588221208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AGWx/uUxm0nQ3i8lTTtjIdMK7mOGIchfY+XfJ9kd0iA=;
  b=POlpbwT8Mvgak6GMp2PE1Fz46nwFxVXfGQkzXghgL+6DugkKOOiLcNyC
   YqU1sOmoD/Shq5shtTMH+Oo6LDMbNKuPbHvPsFJZxT8Wj6Ji8rwi/5SuC
   leX95bfsQTYgG+lTNStQhJxguP1+vPeS75yRila8K7zEnqpIJqCu/LcPc
   NBPyIxZc0xwR1E5WB1mbGyXfF1LjAPt2/awXUX2bnTx2UgOzrhXICrcNu
   cfVDsljBialCNIaRRmtUCu1KAHJABbS1venbboSnnwAsdgKlL8FBlkZKs
   hoChTa1+C8FiptTYOjHQpiy0L33oYvP224XpbEmQgD8JvpiFcZXzL8fsp
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="107229721"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:33:28 +0800
IronPort-SDR: xNX1zAKL2VrDhD5dpMP9pxQLGHknn6BtzogGScM8TElkuMCVRBA3o2QevSmbH3Z6uZ+O5gAWMI
 uDIKtMpzpLgGw6Pn0X8nWIhOCjxmEHQtkWzI/f687piVwRiAuPZEBRnWuSPpEkntLcFNQp+yWb
 WGwkrkEeVDrRR/zuFZfOOOePwZIy8ade8Oj5d/AdAF/kc1z7Pd8dp1Ow0pGLi4YdK8gPgyAXkm
 R9Uqo5bh7Huc6+JZNyC4BJTUhTwHQ6nbTVPLqY4CTJDSdomO52jqnSfmTd9uVBf3ZLqC7fe7+d
 4Vp19W/JfP6C532F/YJusKj4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:11:56 -0700
IronPort-SDR: t6VNYlU/qQt0Nz/J0+tS5gj/aAFbbqSFgEFOhrDtiS1Za7CtRkflZlF+EJPgjbxyVy3BOTezfS
 3fsjozzMRy2RyaJEOT3ePAI01iR/8IE4J46PWu8H2hJ+LUIQZUV8WK77cYFilQ/bAgYdc+6n8C
 ad72bv42bNci1hBJUMugNZQaZb/AkZYv1HX40Fgl1hO62Sdt4EHjdFxfSkjDR1+0GabuK7FKsw
 T7cRPAcDWXevJQAJHVj4LYuxi3AXO6poaLExE768f6KSD9tExoDizhtuBIv3P/FnCegUVwtEIH
 Shk=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:33:28 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH blktrace-tools 02/10] blktrace_api.h: update blktrace API header
Date:   Tue, 30 Apr 2019 21:33:09 -0700
Message-Id: <20190501043317.5507-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
References: <20190501043317.5507-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds blktrace extension definitions to the blktrace_api.h
file. Here we add new block operations write-zeroes and zone reset.
Also, we update the size of the block trace action and add a new field
to mask the priorities.

Mainly we change the size of the action in the blk_io_trace and
size of action mask to keep it uniform across all the headers
and the kernel which allows us to add new trace actions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 blktrace_api.h | 66 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/blktrace_api.h b/blktrace_api.h
index b222218..ac2ea43 100644
--- a/blktrace_api.h
+++ b/blktrace_api.h
@@ -2,34 +2,47 @@
 #define BLKTRACEAPI_H
 
 #include <asm/types.h>
+#include <stdint.h>
 
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
+enum blktrace_cat {
+	BLK_TC_READ             = 1 << 0,       /* reads */
+	BLK_TC_WRITE            = 1 << 1,       /* writes */
+	BLK_TC_FLUSH            = 1 << 2,       /* flush */
+	BLK_TC_SYNC             = 1 << 3,       /* sync IO */
+	BLK_TC_SYNCIO           = BLK_TC_SYNC,
+	BLK_TC_QUEUE            = 1 << 4,       /* queueing/merging */
+	BLK_TC_REQUEUE          = 1 << 5,       /* requeueing */
+	BLK_TC_ISSUE            = 1 << 6,       /* issue */
+	BLK_TC_COMPLETE         = 1 << 7,       /* completions */
+	BLK_TC_FS               = 1 << 8,       /* fs requests */
+	BLK_TC_PC               = 1 << 9,       /* pc requests */
+	BLK_TC_NOTIFY           = 1 << 10,      /* special message */
+	BLK_TC_AHEAD            = 1 << 11,      /* readahead */
+	BLK_TC_META             = 1 << 12,      /* metadata */
+	BLK_TC_DISCARD          = 1 << 13,      /* discard requests */
+	BLK_TC_DRV_DATA         = 1 << 14,      /* binary per-driver data */
+	BLK_TC_FUA              = 1 << 15,      /* fua requests */
+
+#ifdef CONFIG_BLKTRACE_EXT
+	BLK_TC_WRITE_ZEROES	= 1 << 16,	/* write-zeores */
+	BLK_TC_ZONE_RESET	= 1 << 17,	/* zone-reset */
 
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_END		= 1 << 31,	/* we've run out of bits! */
+#else
+	BLK_TC_END		= 1 << 15,	/* we've run out of bits! */
+#endif /* CONFIG_BLKTRACE_EXT */
 };
 
+#ifdef CONFIG_BLKTRACE_EXT
+#define BLK_TC_SHIFT		(32)
+#define BLK_TC_ACT(act)		(((uint64_t)act) << BLK_TC_SHIFT)
+#else
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
-
+#endif /* CONFIG_BLKTRACE_EXT */
 /*
  * Basic trace actions
  */
@@ -88,7 +101,12 @@ enum blktrace_notify {
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
+
+#ifdef CONFIG_BLKTRACE_EXT
+#define BLK_IO_TRACE_VERSION	0x08
+#else
 #define BLK_IO_TRACE_VERSION	0x07
+#endif /* CONFIG_BLKTRACE_EXT */
 
 /*
  * The trace itself
@@ -99,7 +117,12 @@ struct blk_io_trace {
 	__u64 time;		/* in nanoseconds */
 	__u64 sector;		/* disk offset */
 	__u32 bytes;		/* transfer length */
+#ifdef CONFIG_BLKTRACE_EXT
+	__u64 action;		/* what happened */
+	__u32 ioprio;		/* ioprio */
+#else
 	__u32 action;		/* what happened */
+#endif /* CONFIG_BLKTRACE_EXT */
 	__u32 pid;		/* who did it */
 	__u32 device;		/* device identifier (dev_t) */
 	__u32 cpu;		/* on what cpu did it happen */
@@ -121,7 +144,12 @@ struct blk_io_trace_remap {
  */
 struct blk_user_trace_setup {
 	char name[32];			/* output */
+#ifdef CONFIG_BLKTRACE_EXT
+	__u64 act_mask;			/* input */
+	__u32 prio_mask;		/* input */
+#else
 	__u16 act_mask;			/* input */
+#endif /* CONFIG_BLKTRACE_EXT */
 	__u32 buf_size;			/* input */
 	__u32 buf_nr;			/* input */
 	__u64 start_lba;
-- 
2.19.1

