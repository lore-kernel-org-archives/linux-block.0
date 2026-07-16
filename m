Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54AF400976;
	Thu, 16 Jul 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197319; cv=none; b=kfTRYb+N9lD66KG1L6N4XaCYausmABYJ+qw2gdJ9NeFCTxHI7KTsn7yCJgBwo68JqpSFCv3Kf+YCATK9J7eEoLpq8eFUoTYRO7WXJnqr3Q58tRN+UtVvQHwBtPjFDzXbQ4xMM1yL9MSiFlctjj7Mkt5HqxSBQytFFvtLPZ/KKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197319; c=relaxed/simple;
	bh=7SI6Q9FOnBpXLQyUF0ZQV9BFq1YM9vSgCWGvejBMv1I=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=WlwVtwHjV8PIlzhCLSrb4pHYHEkz17xBbLbWzzE6zsle8kGU+WvJ6YxgUvEdHMPKTw56O042XpXox2TP6qvGEfZjPVbjGNUQTzyAg7xQWQi+QUDzHdioatr/zeRyqQt+sXjyjmvAg8LC8j/ItqIUf9UU0oZSg9hN94Qrf2TWuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQMF8c0n; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQMF8c0n"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC0EA1400091;
	Thu, 16 Jul 2026 06:21:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jul 2026 06:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197315; x=
	1784283715; bh=AIQI9mq8MAuj4KBzE1sEJuXSLiiNjzGvFQhNSo7T96A=; b=U
	QMF8c0n9hkxpWX89UiIiaZ2LmT/3gBYXjfowLr+CaRS41c4HO8/xWiszx5nFXkv3
	HOWq+CWhuUN+WuWa8PYclbKw9OVXxYZxlc5Z4ozSA+4hiyTzgy2YOp4l7k6DSlrL
	SCnGhsZdmgqQUoSMiamD4klgQzAVKCcS4ZY+t9c/bsy4rf2lOImAKCnRtshB7yyV
	jbHQ+FWMLftlvENrubw+MuSBFrmBQDzAQfwOBMcoIFSLFmXHUa890PG+IrB2WmRy
	mj41WO54j+QNchnqMZjVf2bBsBkoEuf1byNexpi60UjmzeVmpljxQ22pBm0kC1EI
	3K1mdd1hoGk04M3IihYXw==
X-ME-Sender: <xms:w7BYauVVp0z5bhmSk2BGt94Y86gYgSkI2_x_C9UVleHMAJAO4Bk3OQ>
    <xme:w7BYakqw1BGtOPFxvgTtGx1i43hODY6uXqEfUuQlt9b1te4E-sBX5Tw7aUOSlrDeu
    Ra-9MRd4NfWC8pTWVKiZxj-aX8mCupjx_zRwZ2vLUGXSz8aPjc1Nno>
X-ME-Received: <xmr:w7BYaiTnA9JdRVEyhc7zu1B7KTV4ZRUagCMCgFwF18eKs4uXZINp84N9LiioMFsS24wgHL4U7zgsv6SIPYH0bt5yMPJddTWmtWQ>
X-ME-Proxy-Cause: dmFkZTGG1WvACauGCOcM2B/yAZpkq1Vfshyu2QdkuCaTyi2sZ9jSR+0WfB558P/2bXY/VS
    /l1qB5vOBeKryAVKalTeyJUIfvtabXWu6jrcr+2H4GTdkKYe+JptuUNZSpgysWilnbi/cI
    sZmyh8BTZ6v6ENSZtu53jhYH3SM34CEqAxNsBxf9Ka6lLw4wL4lL9lT0urxseuG9CEv5eY
    33qM/na2kwcAMv21ZzGCraLWHNsZgN3tpnlM1/9p2Rsfp21N3eEqO59FH0/QWPWVOpB9LB
    hdEYqoxU/QM2iWDyKRhDRXEHagteHtZBwABFHC9S3zIVHiSTxI0NLw74c5KnA+8au5ydaQ
    sStHStXhqtFev0GA2XCf0OgdqrowIXGj9ZVLx2rPhC1eMyToxDGRxOPQS7EKsJXPjpj9hw
    k1dCSZ1yId6UFjdeYfYNE3hjPV2TkARSJLvP7k95SqsPq9JZ1qOAnIslP+kL2GJC085jiR
    r38od5Kyw3gpvsQY2HUgwEjaGHwJFQu2zM3YBEyL70qNfVxzhSB2hOqEzGziUwAS/Hzr68
    mfIb24TlXStMigCR4CLIbO3FR+mDM3vExniLSN9GzW4F67FJloGj84aoSwf/0I0cgBL1XK
    Ulrh2ZHpb114Os/4RoIlWiYEIzow87YFNMzY/howDzJPVwgrhr1VBH4CO/JA
X-ME-Proxy: <xmx:w7BYam297MjcuazG22-HRZhq5n7unmFZyo3QWXsUZFo1eWwFs9PZOg>
    <xmx:w7BYamBTBfm-dJ8_yoxv0lilXjYQdeRVuZk3m753_r4l-o6swpkjnQ>
    <xmx:w7BYaqjdlWHAT52TgpQKbvIlOXhl7DVVTePUdvKCKha1GXkvIZFV-w>
    <xmx:w7BYagPfEmF_h55bBtrqM1XgNxARRLcraJM5TEhLr4kZFbvUTr0Y6Q>
    <xmx:w7BYapEmmKFbGzhV-zfYFlyQz3QJ10p5uOC3aGqRmZr_8V8XXqCu95dg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:21:53 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <638c40ba880bd6b2ed1641d54eb65be14e89e3da.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 28/31] swim: Clean up whitespace
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

No functional changes.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c     | 46 +++++++++++++++++++++-------------------
 drivers/block/swim_asm.S | 15 ++-----------
 2 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 9661d8f7a5ed..406792952e7f 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -2,7 +2,7 @@
 /*
  * Driver for SWIM (Sander Woz Integrated Machine) floppy controller
  *
- * Copyright (C) 2004,2008 Laurent Vivier <Laurent@lvivier.info>
+ * Copyright (C) 2004, 2008 Laurent Vivier <Laurent@lvivier.info>
  *
  * based on Alastair Bridgewater SWIM analysis, 2001
  * based on SWIM3 driver (c) Paul Mackerras, 1996
@@ -69,7 +69,7 @@ struct swim {
 	REG(read_handshake)
 } __attribute__((packed));
 
-#define swim_write(base, reg, v) 	out_8(&(base)->write_##reg, (v))
+#define swim_write(base, reg, v)	out_8(&(base)->write_##reg, (v))
 #define swim_read(base, reg)		in_8(&(base)->read_##reg)
 
 /* IWM registers */
@@ -93,7 +93,7 @@ struct iwm {
 	REG(q7H)
 } __attribute__((packed));
 
-#define iwm_write(base, reg, v) 	out_8(&(base)->reg, (v))
+#define iwm_write(base, reg, v)		out_8(&(base)->reg, (v))
 #define iwm_read(base, reg)		in_8(&(base)->reg)
 
 /* bits in phase register */
@@ -165,23 +165,23 @@ struct floppy_state {
 	/* physical properties */
 
 	enum drive_location location;	/* internal or external drive */
-	int		 head_number;	/* single- or double-sided drive */
+	int head_number;		/* single- or double-sided drive */
 
 	/* media */
 
-	int		 disk_in;
-	int		 ejected;
-	enum media_type	 type;
-	int		 write_protected;
+	int disk_in;
+	int ejected;
+	enum media_type type;
+	int write_protected;
 
-	unsigned int	 total_secs;
-	unsigned int	 secpercyl;
-	unsigned int	 secpertrack;
+	unsigned int total_secs;
+	unsigned int secpercyl;
+	unsigned int secpertrack;
 
 	/* in-use information */
 
-	int		track;
-	int		ref_count;
+	int track;
+	int ref_count;
 	bool registered;
 
 	struct gendisk *disk;
@@ -216,6 +216,7 @@ extern int swim_read_sector_data(struct swim __iomem *base,
 				 unsigned char *data);
 
 static DEFINE_MUTEX(swim_mutex);
+
 static void set_swim_mode(struct swim __iomem *base, int enable)
 {
 	struct iwm __iomem *iwm_base = (struct iwm __iomem *)base;
@@ -405,7 +406,7 @@ static int swim_seek(struct swim __iomem *base, int step)
 	if (step == 0)
 		return 0;
 
-	for ( ; step > 0; step--) {
+	for (; step > 0; step--) {
 		if (swim_step(base))
 			return -1;
 	}
@@ -416,7 +417,7 @@ static int swim_seek(struct swim __iomem *base, int step)
 	return 0;
 }
 
-static int swim_track(struct floppy_state *fs,  int track)
+static int swim_track(struct floppy_state *fs, int track)
 {
 	struct swim __iomem *base = fs->swd->base;
 	int ret;
@@ -560,10 +561,10 @@ static blk_status_t swim_queue_rq(struct blk_mq_hw_ctx *hctx,
 }
 
 static struct floppy_struct floppy_type[4] = {
-	{    0,  0, 0,  0, 0, 0x00, 0x00, 0x00, 0x00, NULL }, /* no testing   */
+	{    0,  0, 0,  0, 0, 0x00, 0x00, 0x00, 0x00, NULL }, /* no testing */
 	{  720,  9, 1, 80, 0, 0x2A, 0x02, 0xDF, 0x50, NULL }, /* 360KB SS 3.5"*/
-	{ 1440,  9, 2, 80, 0, 0x2A, 0x02, 0xDF, 0x50, NULL }, /* 720KB 3.5"   */
-	{ 2880, 18, 2, 80, 0, 0x1B, 0x00, 0xCF, 0x6C, NULL }, /* 1.44MB 3.5"  */
+	{ 1440,  9, 2, 80, 0, 0x2A, 0x02, 0xDF, 0x50, NULL }, /* 720KB 3.5" */
+	{ 2880, 18, 2, 80, 0, 0x1B, 0x00, 0xCF, 0x6C, NULL }, /* 1.44MB 3.5" */
 };
 
 static int get_floppy_geometry(struct floppy_state *fs, int type,
@@ -590,10 +591,11 @@ static void setup_medium(struct floppy_state *fs)
 
 	if (swim_readbit(base, DISK_IN)) {
 		struct floppy_struct *g;
+
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
 		fs->type = swim_readbit(base, TWOMEG_MEDIA) ?
-			HD_MEDIA : DD_MEDIA;
+			   HD_MEDIA : DD_MEDIA;
 		fs->head_number = swim_readbit(base, SINGLE_SIDED) ? 1 : 2;
 		get_floppy_geometry(fs, 0, &g);
 		fs->total_secs = g->size;
@@ -695,7 +697,7 @@ static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
 	int err;
 
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
-			return -EPERM;
+		return -EPERM;
 
 	switch (cmd) {
 	case FDEJECT:
@@ -805,7 +807,7 @@ static int swim_floppy_init(struct platform_device *pdev)
 	struct swim_priv *swd = platform_get_drvdata(pdev);
 	unsigned int *data = pdev->dev.platform_data;
 	struct queue_limits lim = {
-		.features		= BLK_FEAT_ROTATIONAL,
+		.features = BLK_FEAT_ROTATIONAL,
 	};
 	int err;
 	int drive;
@@ -963,7 +965,7 @@ static void swim_remove(struct platform_device *dev)
 static struct platform_driver swim_driver = {
 	.probe  = swim_probe,
 	.remove = swim_remove,
-	.driver   = {
+	.driver = {
 		.name	= CARDNAME,
 	},
 };
diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index ae767da671e3..3d5ad525ccde 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -5,7 +5,7 @@
  * needs assembly language because is very timing dependent
  * this controller exists only on macintosh 680x0 based
  *
- * Copyright (C) 2004,2008 Laurent Vivier <Laurent@lvivier.info>
+ * Copyright (C) 2004, 2008 Laurent Vivier <Laurent@lvivier.info>
  *
  * based on Alastair Bridgewater SWIM analysis, 2001
  * based on netBSD IWM driver (c) 1997, 1998 Hauke Fath.
@@ -80,7 +80,6 @@ wait_header_init:
 	moveq	#3, %d1
 
 wait_addr_mark_byte:
-
 	tstb	%a2@
 	dbmi	%d2, wait_addr_mark_byte
 	bpl	signal_nonyb
@@ -91,7 +90,6 @@ wait_addr_mark_byte:
 	bne	wait_header_init
 
 	moveq	#max_retry, %d2
-
 amark0:	tstb	%a2@
 	dbmi	%d2, amark0
 	bpl	signal_nonyb
@@ -99,7 +97,6 @@ amark0:	tstb	%a2@
 	moveb	%a5@, %a4@(o_track)
 
 	moveq	#max_retry, %d2
-
 amark1:	tstb	%a2@
 	dbmi	%d2, amark1
 	bpl	signal_nonyb
@@ -107,7 +104,6 @@ amark1:	tstb	%a2@
 	moveb	%a5@, %a4@(o_side)
 
 	moveq	#max_retry, %d2
-
 amark2:	tstb	%a2@
 	dbmi	%d2, amark2
 	bpl	signal_nonyb
@@ -115,7 +111,6 @@ amark2:	tstb	%a2@
 	moveb	%a5@, %a4@(o_sector)
 
 	moveq	#max_retry, %d2
-
 amark3:	tstb	%a2@
 	dbmi	%d2, amark3
 	bpl	signal_nonyb
@@ -123,7 +118,6 @@ amark3:	tstb	%a2@
 	moveb	%a5@, %a4@(o_size)
 
 	moveq	#max_retry, %d2
-
 crc0:	tstb	%a2@
 	dbmi	%d2, crc0
 	bpl	signal_nonyb
@@ -131,7 +125,6 @@ crc0:	tstb	%a2@
 	moveb	%a5@, %a4@(o_crc0)
 
 	moveq	#max_retry, %d2
-
 crc1:	moveb	%a2@, %d5
 	dbmi	%d2, crc1
 	bpl	signal_nonyb
@@ -177,7 +170,6 @@ wait_data_init:
 	/* wait data address mark */
 
 wait_data_mark_byte:
-
 	tstb	%a2@
 	dbmi	%d2, wait_data_mark_byte
 	bpl	data_exit
@@ -189,7 +181,7 @@ wait_data_mark_byte:
 
 	/* read data */
 
-	movel	#sector_size-1, %d4		/* sector size */
+	movel	#sector_size - 1, %d4		/* sector size */
 read_new_data:
 	movew	#max_retry, %d2
 read_data_loop:
@@ -210,7 +202,6 @@ read_data_loop:
 
 	movew	#max_retry, %d2
 data_crc0:
-
 	tstb	%a2@
 	dbmi	%d2, data_crc0
 	bpl	data_exit
@@ -218,9 +209,7 @@ data_crc0:
 	moveb	%a5@, %d2
 
 	moveq	#max_retry, %d2
-
 data_crc1:
-
 	moveb	%a2@, %d5
 	dbmi	%d2, data_crc1
 	bpl	data_exit
-- 
2.52.0

