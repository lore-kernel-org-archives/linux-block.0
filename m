Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8F2FE042;
	Mon, 17 Aug 2026 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931940; cv=none; b=Ww8vG3DY1hR9DVP4YurfNhcWG41/NNtJCpzEe28cKzLl9Ry4h/fvCzzHr1zGdgsbodn8vqtJ7M66vKOshb8g2veZOrMlG1hbQWF2f2eBGo8l/bNhb3KMjdppOL+u3WJQfQYWIs3SDFvigQ9P4OOIrPpSfFtiAjG+i0Eac5Vj8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931940; c=relaxed/simple;
	bh=FwZDEwmNglnkLDe5fuVmoSRNaZw9EmBOqqabBVimuDQ=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=cSC2IaOaLs0MBOqqM+Nv5Dc3UidheCrgIx0GJs85K4G5uarOu4ortM/TFjEJwLYCabIc9lgtxhEexUXyzJ11MIkmHUQSU6ytwOmuPngHJbUQY0elAbBzJor7tL65JMCpjEYXEPa7IFxLlmNB+ZaRRde8RbS2J+UmhXOpGFgisaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFrKr3cM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFrKr3cM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 075DCEC01FD;
	Sun, 16 Aug 2026 21:58:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 16 Aug 2026 21:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931937; x=
	1787018337; bh=pBoWBSTjBbUK2X8IBsJBEID+BjT/Bw79Z0RjWiWCmcA=; b=S
	FrKr3cMufXGNe1nl+LBLsNZKY3SiJ0S9C8SwiKpf3ErlsSOcIy9ioesCy0kRuRg7
	6WDfOIILANBk3Ih+KmKI85N0DOiu15ZklLFYhMM2/j6TBF6ujBFHuIMXDN3wI/vW
	iZWglxW/3N7nC8A8P4KB29Q7XmLPdB8h+ypjX5Un2suy6daQw9r5cf5KX1u1txbv
	V201jYQBZBndKvdubQ5dPge5ha/k70CSIk+s2QF1MB5xpN81+W6nNkaUdTQ3ZeUQ
	bbLMDbn30YCUBGqmJSceq83unjIdrTF+4Xfq12Mn6G/0fTrU9G/Hqze9TXawJX9L
	yz+N9VK40FVJDKEOFjS4A==
X-ME-Sender: <xms:4GqCaifqu6o4xF5gkVVDTpZtz4A6xELYhZVlLfjYHsIGxf8-P59RZg>
    <xme:4GqCamQco4aj_tVKPNI19gRBrt4AKexs3I-zSUE00BBRAZ4Q6_CmM63ruOEzgWrS9
    z82F8PRUPyERXOLJQrZfOe8vJeANNbfLpHjTtTaeq6-HwintJxTdeg>
X-ME-Received: <xmr:4GqCajZK_zYILXenjwWKwduFUxdD7vsPooXllVw-sq2XA4ZyxpKGFCjf5ktjiqVZ-0EovrYK7jq1yfA97GUATtujZ8WOuI_0n00>
X-ME-Proxy-Cause: dmFkZTEwVqJtQHEwNT59EY0ApYPfZBP0Ja94nLydKMHdJKlh4zUdbhZ4q8N1TJVlNLX3Jv
    UG9KBkDhcBzUW3289fayQ1J+ppWFRD446qIAFVyGuquh32EhwbVebEJGoODlbz4hP14Erq
    Tcjcfi9/5+2rPPMs1Rkxsj0k0e2xO2GH5lY4VVdKIG8VeU2vajU+FMxwg/fEJDgrz1L6RJ
    d1Tth/Mq5Cy68H4bxVP4faz7GKaqaQIynBu/2nSxBla0bgf41aEpoAjjJxWypL04u/vTxK
    x5WjWw0TaNT770B0rDvEjO+uKu7yRxr/X4qfgY6A9PKgCt1ahfj+WIbkeb4e64+QxwGFl8
    abUQjnnvdJOfJUO7ZqR1Tt1zl5DxA62Ks/zY5T8Y1ys4sGbGmBR8F+8n6SY/nk9MYfENNa
    6dCieEaMtrKz0P9UevWPiolEVTawukPv9BWY61c09f6PovTymSG/8a0j+Ce8byIoJTJmC9
    Qly5I9ncL0x7dEXrwe3SeCvPxI04QL+uTU0DjopBkE4Qhb8lptdRbGKAhgnZEh7cFEhPxO
    Fflb6f+4B3FaheE70Hyh1uXeLAkE+4F2Z/vxB9ruM5s2FAjv424CkUCR16z832U1xDcojH
    rFPo5gQ2KZwd0QJbRhzJV7p41coDFIGKbHZnMxQXOwI7yKL8jN3LG+JD2s9A
X-ME-Proxy: <xmx:4GqCahcYkJOR4IXZGfOxmY2Z5OcvoN-76LyW1NT4KmSXfP0jJPWBcA>
    <xmx:4GqCasKpvwRYIPeE4AeOWQbnlb-whnHzD9f-dQjQ2YLh2LE6hPeD6A>
    <xmx:4GqCamKx4GfMdl3XhOrAEi2TrbQxI3fWwK9s3dm37YHUlsCVUbncWg>
    <xmx:4GqCajUhoMQ847vjespk0meWlnepEGeNPIVxzsxt2FDiVK0b40QJOw>
    <xmx:4WqCahP8QxA68IHW0FJO-i3OZMnQc0JVljY-_pYMZ04-LaE182qu1q68>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:58:54 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <26e2373aca64ad3e7fbc3f170f26315d1e445d75.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 29/32] swim: Clean up whitespace
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

No functional changes.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c     | 46 +++++++++++++++++++++-------------------
 drivers/block/swim_asm.S | 14 +++---------
 2 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index aebebc7f5d60..73d11e827e5d 100644
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
 
 /* Bits in phase register */
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
@@ -402,7 +403,7 @@ static int swim_seek(struct swim __iomem *base, int step)
 	if (step == 0)
 		return 0;
 
-	for ( ; step > 0; step--) {
+	for (; step > 0; step--) {
 		if (swim_step(base))
 			return -1;
 	}
@@ -413,7 +414,7 @@ static int swim_seek(struct swim __iomem *base, int step)
 	return 0;
 }
 
-static int swim_track(struct floppy_state *fs,  int track)
+static int swim_track(struct floppy_state *fs, int track)
 {
 	struct swim __iomem *base = fs->swd->base;
 	int ret;
@@ -552,10 +553,10 @@ static blk_status_t swim_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -582,10 +583,11 @@ static void setup_medium(struct floppy_state *fs)
 
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
@@ -687,7 +689,7 @@ static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
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
@@ -957,7 +959,7 @@ static void swim_remove(struct platform_device *dev)
 static struct platform_driver swim_driver = {
 	.probe  = swim_probe,
 	.remove = swim_remove,
-	.driver   = {
+	.driver = {
 		.name	= CARDNAME,
 	},
 };
diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 4913470b63e8..c8a89c0c4652 100644
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
@@ -110,7 +110,6 @@ sector_data_mark:
 	/* read header */
 
 	moveq	#max_retry, %d2
-
 amark0:	tstb	%a2@
 	dbmi	%d2, amark0
 	bpl	signal_nonyb
@@ -118,7 +117,6 @@ amark0:	tstb	%a2@
 	moveb	%a5@, %a4@(o_track)
 
 	moveq	#max_retry, %d2
-
 amark1:	tstb	%a2@
 	dbmi	%d2, amark1
 	bpl	signal_nonyb
@@ -126,7 +124,6 @@ amark1:	tstb	%a2@
 	moveb	%a5@, %a4@(o_side)
 
 	moveq	#max_retry, %d2
-
 amark2:	tstb	%a2@
 	dbmi	%d2, amark2
 	bpl	signal_nonyb
@@ -134,7 +131,6 @@ amark2:	tstb	%a2@
 	moveb	%a5@, %a4@(o_sector)
 
 	moveq	#max_retry, %d2
-
 amark3:	tstb	%a2@
 	dbmi	%d2, amark3
 	bpl	signal_nonyb
@@ -142,7 +138,6 @@ amark3:	tstb	%a2@
 	moveb	%a5@, %a4@(o_size)
 
 	moveq	#max_retry, %d2
-
 crc0:	tstb	%a2@
 	dbmi	%d2, crc0
 	bpl	signal_nonyb
@@ -150,7 +145,6 @@ crc0:	tstb	%a2@
 	moveb	%a5@, %a4@(o_crc0)
 
 	moveq	#max_retry, %d2
-
 crc1:	moveb	%a2@, %d5
 	dbmi	%d2, crc1
 	bpl	signal_nonyb
@@ -197,13 +191,14 @@ mfm_read_data:
 
 	/* read data */
 
-	movel	#sector_size-1, %d4		/* sector size */
+	movel	#sector_size - 1, %d4		/* sector size */
 	movew	#max_retry, %d2
 read_data_loop:
 	moveb	%a2@, %d5
 	andb	#(.Lhr_fifo_1byte + .Lhr_fifo_2bytes), %d5
 	dbne	%d2, read_data_loop
 	beq	data_exit
+
 	moveq	#max_retry, %d2
 	moveb	%a5@, %d3
 	bsr	.Lmaybe_store
@@ -219,7 +214,6 @@ read_data_loop:
 
 	movew	#max_retry, %d2
 data_crc0:
-
 	tstb	%a2@
 	dbmi	%d2, data_crc0
 	bpl	data_exit
@@ -227,9 +221,7 @@ data_crc0:
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

