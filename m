Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057B4477F5;
	Fri,  4 Sep 2026 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514586; cv=none; b=UcnKSvpeDrUIASuDlzc+RbUoB362PATB3+LERda2xSUP9ScQ+ldPpC/pmn2+lwXPdHpoz9vDSFuC1dL+s8NX2SJ+JsPHDjUSeXuPTfESlLDiXKg7SjMHOC+RBOSRW5DHAgwCjLMcpVWHuSOV2OHxkgEfh3EdhOXi1WXD06NeiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514586; c=relaxed/simple;
	bh=KBXKxt6P0G5kYd3DMM5it9aUm8Y6FcNbZ50G8muC2AM=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=fsXBwzcGWgSEth0hq2VgW8Fd0ktIYTDntE0EgcQMWWN3YGqUsWtBeycbjQ/5XAUGCsIBUjo914MffDe7gGPN5a05NTRLbrMdK2vfO1FULi3yVLVajPdhcyEoICBBys0KK7k/cZ/CMh+nvShiMYcw6z0Io/w990PX1qlGqHUgASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGhUXsGR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGhUXsGR"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92FB814000B7;
	Fri,  4 Sep 2026 05:36:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 04 Sep 2026 05:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514583; x=
	1788600983; bh=hrRgqAeah4TNWLlkx6lLt/cNMnqAA85FE9HMuJS0LZs=; b=H
	GhUXsGRFMNXfU7eih37baWP2deB0oUrWCdp0MqiWl04VUp6ZfA2xPnLALxv9bSvW
	m5wsc4egok5ruIQeZsQzTxicEvTw5gPI9FQvphERGVc89wQ+d+vk+252Ubh/rFyL
	MqIyhXgSssJRNisMj3Iu1Egg5KUCHY0Gae76oN5MXpkBzxxYho0VrqEBC0BmYmHg
	vUPPwhFbei4Xn4/rbxJrtcm9d1Nz6oXtCLpSa4fz/iE1BJIbMdgmn8m8eMOSeCUq
	gI+kovZdNmZyFSCT7dyKsnck4+lD8a12n1dhTNllmcBcnuBRGMXvPZsk4wDygySw
	BTKvq1km/FnzEq36RH7+w==
X-ME-Sender: <xms:F5GaajhKjaXEAGYecxk_-b8CGXYigrjp8QAQgjYq0PPQVdcoeuvzxA>
    <xme:F5GaaqFJxLufnq4pOJdrmjaxsUqpAM186R7X-mbWQxesImg99leWx1fFvarRQz0LF
    fRns1JfbtUQ1YSxMJokH2WCd__Wq6yMQ87hEQ7p3u0TKRd0U23RzJOz>
X-ME-Received: <xmr:F5Gaai9bAD81slidb7sba55QCljCfLxqmxJaDy5-za3O65pU_INb4BXAykLpjaGtsyCdh15mQN73KeM6CpqNQdXpU6U8RTL0Nm4>
X-ME-Proxy-Cause: dmFkZTEe+0K1AexRW5VKg6Igspc49h8df5hxyd+FQ2UxEzuyTDi2ZhdiSThGiBIwkdDgU9
    3rC08hmhwBNxNoNuM+ycNNv31fkYVLn6pBr27tqKRLQMq1NV3DFc39Iqyivnkegn2UfxIv
    roQdqcH3VVXGJWlrRZqsrGKoS9rmBFYj7GFxW36+XXMnxcw5HiNtvMvRco3OYXN6UY/K0t
    SqGzE69/GT65xt5VU7CUtrbe1RJV9Of5WXGGzQneXN7Ylc6viWLtf2PMOfqRj9Ut2W6+Hz
    DfFSoa/BAnz3IHwFnQcu4acvCfz7MIdPrcCNMUsADy4T129cFo7Yojs7dtan6e38DtGhSs
    7UQpvgPBN2FcrZsm83Tk911BeeLF3EYIYBEOlh+EFXYf4BMXjhOzTAaogfXDPFwYlWlb1I
    S6SQ+PmI7GOtMeJd6jifMigYUPYOOlbvs/f/BXADu4KLeezuNVEXh4zReeOLDxbvvtmMCz
    MANm38k9ZemtQodT62zEdBAEAOYr+Uxwrm+DZq3X7Sx5B5au0x++D8CzrnzDhS0jENCfnh
    hL/AAvzIqbGOgU+2reQs507wBQQzRQUFbujSNoKag1LYj90Pp69qq643gmg77BwadZavoB
    +p6Qhwi5MtidPbnrfQYdu45VJhA5ZMqMtHwUyBaxLVDB5oHnkU2gKq4pSfpg
X-ME-Proxy: <xmx:F5GaahwI0IR_iKWx44HNm6LFRCbOuWdgdF_jhAgnnbNMIH8qdZEptg>
    <xmx:F5GaauNZOcl9YFz4UL-F86jzPniaCzwJRzGyQXVTksfqqbfsxBOHEQ>
    <xmx:F5Gaam9VWmDQSeUpiNeGAtYx9kYhdExJABugpZnukqIYppmI8-U2gg>
    <xmx:F5Gaar6oyltzdezP8RQXcQiqyTwnzsUKyIlBO_WfHOe7HxeRyrDJBA>
    <xmx:F5GaasTymZBaknUiNF0EfS-tkWqQ5NX2US5yM-pvIMbs8FownWrSkkcG>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:36:21 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <d33238b1b2c4a444ed3ae59d4444fafebb550921.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 30/33] swim: Clean up whitespace
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
index 1501444fe070..a5be31b732b5 100644
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
@@ -555,10 +556,10 @@ static blk_status_t swim_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -585,10 +586,11 @@ static void setup_medium(struct floppy_state *fs)
 
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
@@ -690,7 +692,7 @@ static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
 	int err;
 
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
-			return -EPERM;
+		return -EPERM;
 
 	switch (cmd) {
 	case FDEJECT:
@@ -809,7 +811,7 @@ static int swim_floppy_init(struct platform_device *pdev)
 	bool *data = pdev->dev.platform_data;
 	bool fast_fclk = data && *data;
 	struct queue_limits lim = {
-		.features		= BLK_FEAT_ROTATIONAL,
+		.features = BLK_FEAT_ROTATIONAL,
 	};
 	int err;
 	int drive;
@@ -961,7 +963,7 @@ static void swim_remove(struct platform_device *dev)
 static struct platform_driver swim_driver = {
 	.probe  = swim_probe,
 	.remove = swim_remove,
-	.driver   = {
+	.driver = {
 		.name	= CARDNAME,
 	},
 };
diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 241088b12829..c373fb3fc750 100644
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
 crc1:	tstb	%a2@
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
 	moveb	%a5@, %d5
 
 	moveq	#max_retry, %d2
-
 data_crc1:
-
 	tstb	%a2@
 	dbmi	%d2, data_crc1
 	bpl	data_exit
-- 
2.52.0

