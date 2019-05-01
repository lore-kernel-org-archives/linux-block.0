Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B178C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B1421743
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QLRly1C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbfEAE2o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:28:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9392 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfEAE2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556684924; x=1588220924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MBk6K18Uyn4ARlj+46RxaJCBDhuvP+gA4umnf3f+qkk=;
  b=QLRly1C0yZuvDBakmwJcEDeavZwGcMCAW1WJ9PZTL70ujSY2/VrfTs5P
   aZpmnlCmfngt6CfS6Yv5k8HW63U931v6lnY2C0W3u6mUBSyNKogO8ZawJ
   HlWRBv8o2odV1HP2dO+U+F5zh6VnsOls+O5EN0+1vM5chMRLa73jA75YF
   0GIeeIjXzr3VS+Jr+hCXQQsVYKGg6b+urPWflTfW2nGDtHHhz1tLU2FPu
   4TFFfLNkRJLiKCWpq6CFn7xMKxzfm0hYw+93q5alnSUVg/ZZ3HNjutICg
   Xz1F299KWJlkFN3TSseIYm/VxocRIQzfslVUXIm2aAKQwenr7gh2kfO5K
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="108436744"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:28:44 +0800
IronPort-SDR: CZfbKC2oo6tP4RV61GK13tb0TH0OAJZGraxOlARRTUpHXBQsra2oVzgyRGaP+w8CElOrhGEls7
 ygB0nuLxzaH6acYpeAqs3YPtM62s7ZXEBsWcPwriX7NC8iKLAO+dIU1gqTgHHF/Yoa/V6A+8L4
 bFrW237i5kBpEfpNyJRs75/QDibFQN6b6vR29DXJuHRBd+T2xlsTqu0wjfRM/FqoKCs8CPrL7t
 d0PTCOJ9jh3AMTZhVn9AEHpqiz8YU1YXOwN6AJQHqc2jIHvGMLtpmu0zsRRLP0rk/xKj8x/BCP
 rNDwvRnZfxa0Dx0FFauspgUi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:13 -0700
IronPort-SDR: ROqmKl0Z1DbvyRzhZP58X7CBR+j2vWCG/BDKzpnnzezIVbqgdgPUwFXKPq0HdcEjOR56DTy3iG
 PbZrr4qqngIaD5yAOFiKGPXa0oW9MPN5/CTuDiI0W06jjoc8vsAeqOb1I3bq9bzjqrINhI5XLo
 JZ7LAOPNFkcTN/JJvReosqNKS07rvakLvWUR1RfxBokdqghrda4jHJ6INL9Ol8iRjD6dr5nLt+
 5J50zac1Y8lSBypIaOh8+bRSFD4qE++OOCVqqwjL1nQlwomX+t0y6Iw7z+46+pBAzq8zTIB35W
 lng=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:28:44 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 02/18] blktrace: add more definitions for BLK_TC_ACT
Date:   Tue, 30 Apr 2019 21:28:15 -0700
Message-Id: <20190501042831.5313-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have increase the size of action mask we can now safely add
new blktrace actions and extend the code to track more block layer
request flags.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 63 +++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 690621b610e5..c34cf752a9a1 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -8,30 +8,42 @@
  * Trace categories
  */
 enum blktrace_cat {
-	BLK_TC_READ	= 1 << 0,	/* reads */
-	BLK_TC_WRITE	= 1 << 1,	/* writes */
-	BLK_TC_FLUSH	= 1 << 2,	/* flush */
-	BLK_TC_SYNC	= 1 << 3,	/* sync IO */
-	BLK_TC_SYNCIO	= BLK_TC_SYNC,
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
-	BLK_TC_DRV_DATA	= 1 << 14,	/* binary per-driver data */
-	BLK_TC_FUA	= 1 << 15,	/* fua requests */
-
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_READ		= 1 << 0,	/* reads */
+	BLK_TC_WRITE		= 1 << 1,	/* writes */
+	BLK_TC_FLUSH		= 1 << 2,	/* flush */
+	BLK_TC_SYNC		= 1 << 3,	/* sync IO */
+	BLK_TC_SYNCIO		= BLK_TC_SYNC,
+	BLK_TC_QUEUE		= 1 << 4,	/* queueing/merging */
+	BLK_TC_REQUEUE		= 1 << 5,	/* requeueing */
+	BLK_TC_ISSUE		= 1 << 6,	/* issue */
+	BLK_TC_COMPLETE		= 1 << 7,	/* completions */
+	BLK_TC_FS		= 1 << 8,	/* fs requests */
+	BLK_TC_PC		= 1 << 9,	/* pc requests */
+	BLK_TC_NOTIFY		= 1 << 10,	/* special message */
+	BLK_TC_AHEAD		= 1 << 11,	/* readahead */
+	BLK_TC_META		= 1 << 12,	/* metadata */
+	BLK_TC_DISCARD		= 1 << 13,	/* discard requests */
+	BLK_TC_DRV_DATA		= 1 << 14,	/* binary per-driver data */
+	BLK_TC_FUA		= 1 << 15,	/* fua requests */
+
+#ifdef CONFIG_BLKTRACE_EXT
+	BLK_TC_WRITE_ZEROES	= 1 << 16,	/* write-zeores */
+	BLK_TC_ZONE_RESET	= 1 << 17,	/* zone-reset */
+
+	BLK_TC_END		= 1 << 31,	/* we've run out of bits! */
+#else
+	BLK_TC_END		= 1 << 16,	/* we've run out of bits! */
+#endif /* CONFIG_BLKTRACE_EXT */
 };
 
+#ifdef CONFIG_BLKTRACE_EXT
+#define BLK_TC_SHIFT		(32)
+#define BLK_TC_ACT(act)		(((u64)act) << BLK_TC_SHIFT)
+#else
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
 
+#endif /* CONFIG_BLKTRACE_EXT */
 /*
  * Basic trace actions
  */
@@ -93,7 +105,11 @@ enum blktrace_notify {
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
 #define BLK_IO_TRACE_MAGIC	0x65617400
+#ifdef CONFIG_BLKTRACE_EXT
+#define BLK_IO_TRACE_VERSION	0x08
+#else
 #define BLK_IO_TRACE_VERSION	0x07
+#endif /* CONFIG_BLKTRACE_EXT */
 
 /*
  * The trace itself
@@ -104,7 +120,12 @@ struct blk_io_trace {
 	__u64 time;		/* in nanoseconds */
 	__u64 sector;		/* disk offset */
 	__u32 bytes;		/* transfer length */
+
+#ifdef CONFIG_BLKTRACE_EXT
+	__u64 action;		/* what happened */
+#else
 	__u32 action;		/* what happened */
+#endif /* CONFIG_BLKTRACE_EXT */
 	__u32 pid;		/* who did it */
 	__u32 device;		/* device number */
 	__u32 cpu;		/* on what cpu did it happen */
@@ -135,7 +156,11 @@ enum {
  */
 struct blk_user_trace_setup {
 	char name[BLKTRACE_BDEV_SIZE];	/* output */
+#ifdef CONFIG_BLKTRACE_EXT
+	__u64 act_mask;			/* input */
+#else
 	__u16 act_mask;			/* input */
+#endif /* CONFIG_BLKTRACE_EXT */
 	__u32 buf_size;			/* input */
 	__u32 buf_nr;			/* input */
 	__u64 start_lba;
-- 
2.19.1

