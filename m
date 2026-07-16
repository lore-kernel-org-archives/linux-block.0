Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD940313D;
	Thu, 16 Jul 2026 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197278; cv=none; b=ZJi65le3+CA3NYqXzv7J9DNN355LKNcbIvlNBGJTimKj9n+GVv1nYUN6CdUpGs06NM+M97jnA9hP+haoA33mVGIHsslhJ+8Pf9YFLAgOof58kqo6brCc7bBXmww0VPcmDWpriAUl+oR8B2DJtxgKO2kXHiPv/MYNctYjfRmdGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197278; c=relaxed/simple;
	bh=yhtj1BvnWqE6behwWjb+t5wSGAVzrKkmZConj7e+WrE=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=gjFmyhY4tXZs71P0BmTZUxouOb0KZc+znwMUai1oBRzfWx6pFoBh7QAiv7/3Q03hnYwJ+u1e/JC404lzCilCyQyle6gVOLvyQFZ5fDQ+LvlGteNxOl2lgbrU9FagoCKnrdSimS0CvNTaiP6thwd808NHHHs/tiGkHFP+i9YknB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qe/yzH5o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qe/yzH5o"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id F2DBEEC0079;
	Thu, 16 Jul 2026 06:21:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jul 2026 06:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197276; x=
	1784283676; bh=RvjOLHX3MDGcSBbcDZW7GFImD/Fsa4W8rkMgvJTWlCU=; b=Q
	e/yzH5oP5zuTZKm3hQFD/JeHZoxkJAdQzWgm4xAU+90gxiCGc6s43zSmDzJ3vcfo
	JlVW+hDiyeMFphbUk8Q6GXmq13G2225T2iwQ1LZAPZPx45KJjARD2M08vBihtnJN
	PaQoPb+PzJhEHgdZ32xqBY0zgsN/X2tsTVLlSOQgSz+wvhG7PS1FVedwKHQ31wPh
	UspTYxzHg978eC2H9cnRVIjg+wc1PdoKXOR/98wsPRsOWnD1F0K9gAsxs1DxbXcC
	YBdRQaFpLLod2wfVWqyGlhEMLMvMSu7K2oPQYPXNBorKMoKMLOJe34QkoXGG3/lj
	5/Th7jU2yl19r4UU9W2VQ==
X-ME-Sender: <xms:nLBYau-umWF4Xucbm9eFxqgtfdKc-nvJF7sbwWpmvsn_bBMrr2qHww>
    <xme:nLBYamWRyJvqt6eRVDNMTVx5Rh__qwIm-a5HFv0p0Td_wkwjogVQUQztGSSU2FCKU
    RfGW4Z4g_4I-oy2j3QwrBV88eZI-U75Iuyt_8f7XH7HtTIbnPMeXuk>
X-ME-Received: <xmr:nLBYahqhi7TKyYnv6OAtsbapTi4lyHW8Ae0VrVWPn44DX2STYEM5V0RDYbiQiNOzsXRul52bedvbQPJB34zGu_jP6bwkJmemP1E>
X-ME-Proxy-Cause: dmFkZTGjTgzaXEfYNBjEVriyw2q9F/uRW3a5OUTRrp/7MrDLeZQ6aO79fp7d+O4PdbSKdf
    /sLTmT8MbjPdH5UeFxt611a7A6umKHgcJd6FeutqKrXNZ/PQQaQksvgFoRxd576GHi7HM+
    niXc/DSD0ln5FX/1gfQCzakr/OY4GbKmIR5S3H4m1TalplR037EzqrEC5ugaHHCdJSwAUG
    pdkzcuL9P7MmjPf8R8bDG7rLu/XnFc/d/WpuqdmHHAEZRanbTznGD/JvqzCnsmivRMEyGu
    jqqkwlja73A9mkDbvEUvtIQMZf1HzzWjILAGhC6KxW3EueXJFmFQ3rgfN7nxGslmIl5fgQ
    vcK771fofk6pcY0jWkm0Z/yMpte90Gv2vyKY7iIyB9XNSpV+ZyURId83pxvuVnbLmJypog
    Njtjva4AaxY/JzH5zKeookOsNUcVNPeKI6R8DbRtGZNNgPkB5Ok3PWJGwlcOv9HwHa0BEs
    C7NeZH6MvuZwL7AuikBy0Bl0AiyZXcNIZrhsRFUnYxugYG2Yz3Ah/JrokiMnmoz+xgSlA1
    LuBCRT9wFXmMoycSG660HqhFWvHbQ9eL5CjD18KifDHk0QqsS/PvKKxlthX6sBGm4X6yrw
    5boAwgxTSBMTr39lVUNbDeat8h6sRK16xVGvnZo7HFwZVWqnkF3q2oipHBuQ
X-ME-Proxy: <xmx:nLBYagmytfVGK7r22RsziBcqSd8iLf4y0NCtuW272OfjkhelXmbLkg>
    <xmx:nLBYap0Bhj8t7Yt67MSqeIrdfTqIZtkPw25jw7me1LQLIP7rnspcsg>
    <xmx:nLBYalRMfDxauxCJDx3zWVmUedulbocDcFetZDmqgegjLsKLc7a-wQ>
    <xmx:nLBYaqz1p4Mig0PQtffxkUKQESfbJvK2MBHl3L6tS3IJWky7WfnPog>
    <xmx:nLBYaumaC-7p4qd3LSs74k1-i3F3FUCeAizBqzS8tG1-AI8Ho349_ABu>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:21:15 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <4c0b70c4f500c05d0b1a3430afc57e51e541ef36.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 24/31] swim: Remove pointless specifiers
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

If the compiler made these functions "as fast as possible" that wouldn't
actually help because they involve slow mechanical operations. Remove
pointless inline function specifiers.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index dae401e649d7..4679f554fec5 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -222,7 +222,7 @@ extern int swim_read_sector_data(struct swim __iomem *base,
 				 unsigned char *data);
 
 static DEFINE_MUTEX(swim_mutex);
-static inline void set_swim_mode(struct swim __iomem *base, int enable)
+static void set_swim_mode(struct swim __iomem *base, int enable)
 {
 	struct iwm __iomem *iwm_base = (struct iwm __iomem *)base;
 	unsigned long flags;
@@ -250,7 +250,7 @@ static inline void set_swim_mode(struct swim __iomem *base, int enable)
 	local_irq_restore(flags);
 }
 
-static inline int get_swim_mode(struct swim __iomem *base)
+static int get_swim_mode(struct swim __iomem *base)
 {
 	unsigned long flags;
 
@@ -324,7 +324,7 @@ static inline bool swim_readbit(struct swim __iomem *base, int bit)
 	ret; \
 })
 
-static inline void swim_drive(struct swim __iomem *base,
+static void swim_drive(struct swim __iomem *base,
 			      enum drive_location location)
 {
 	if (location == INTERNAL_DRIVE) {
@@ -343,8 +343,8 @@ static inline void swim_drive(struct swim __iomem *base,
 	udelay(1);
 }
 
-static inline void swim_motor(struct swim __iomem *base,
-			      enum motor_action action)
+static void swim_motor(struct swim __iomem *base,
+		       enum motor_action action)
 {
 	if (action == ON) {
 		swim_action(base, MOTOR_ON);
@@ -355,7 +355,7 @@ static inline void swim_motor(struct swim __iomem *base,
 	}
 }
 
-static inline void swim_eject(struct swim __iomem *base)
+static void swim_eject(struct swim __iomem *base)
 {
 	swim_action(base, EJECT);
 	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
@@ -370,14 +370,14 @@ static inline void swim_head(struct swim __iomem *base, enum head head)
 		swim_select(base, READ_DATA_0);
 }
 
-static inline int swim_step(struct swim __iomem *base)
+static int swim_step(struct swim __iomem *base)
 {
 	swim_action(base, STEP);
 	udelay(150);
 	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);
 }
 
-static inline int swim_track00(struct swim __iomem *base)
+static int swim_track00(struct swim __iomem *base)
 {
 	int try;
 
@@ -397,7 +397,7 @@ static inline int swim_track00(struct swim __iomem *base)
 	return -1;
 }
 
-static inline int swim_seek(struct swim __iomem *base, int step)
+static int swim_seek(struct swim __iomem *base, int step)
 {
 	if (step < 0) {
 		swim_action(base, SEEK_NEGATIVE);
@@ -422,7 +422,7 @@ static inline int swim_seek(struct swim __iomem *base, int step)
 	return 0;
 }
 
-static inline int swim_track(struct floppy_state *fs,  int track)
+static int swim_track(struct floppy_state *fs,  int track)
 {
 	struct swim __iomem *base = fs->swd->base;
 	int ret;
-- 
2.52.0

