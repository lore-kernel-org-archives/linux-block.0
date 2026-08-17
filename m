Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDC313E21;
	Mon, 17 Aug 2026 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931804; cv=none; b=F+EIitxhFxluT4p2wX5GK15vcSOHY0ozgKLZGL7uXvSrI8DjB/64gqGB+BpEpA+YV4cdMwANLPjHAmKmy55uwsv/Dik+OigS4WOSz3vd7cFt237GXFUjVclHxYFQWDcEFZt45KRHFyn2f3NzdIfYOO4i+aMf5iMWtkCVCFWD9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931804; c=relaxed/simple;
	bh=gcbDJQKQWx/JiOl3ILmbvcSJFY9wfyx+GkxaXTMeBVY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=YeNcOF/+hqwQ+aZdZyHTDguuliuSdmNlVqOQd82139zcCsA2+4dz3nD/WLWYijiyqRyWnnx/uS1JNrOOFvTZweS4oOSJZbiR9TvBDFzi32WhmPlf6SIS4j+GLpbGCNYmIgAmhCl+yCJaey3KUwH68TkHwq67t96X+SuVk1Tj/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mDmWqzJ2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mDmWqzJ2"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id CF87EEC01FD;
	Sun, 16 Aug 2026 21:56:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 16 Aug 2026 21:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931801; x=
	1787018201; bh=w7f2wA8xRsSFLJ9OKOibNiHk2iHsT2ek6v8NeXeO6hA=; b=m
	DmWqzJ2vMLN5MGPPqa64YfzYfAEpKn0RETUqlz8YM+Lew6bEshAj8pghEkXNHvsJ
	2HmNZEc9WRF8vgR9FUXKRlIyJ3iqyfyW4qZcBFXKMvbebgOx4j2TgVLjnMIISrqa
	VqjUdgD6r4y+i22ZiFDJE85/jeZegotvjrFQPfsBXLaD7hJVIM56TvdmZWc0yN5b
	SxwLcMu+UlpIREtqgdDRu/NiPr0Ms+JI1CdKumgxPNJQFVk7PFUWL+9OVlA18AC1
	vkpDsuGpGY1vMEpzxJmIFvKTPFIZOCvS1EUnASOfgydjFoEx9xGYTUB+ru9Ca8+E
	FsD/7E8qZ9nnyGX3wRX+A==
X-ME-Sender: <xms:WWqCamAqFoEOH7UvZiPFq4EHpb21XEPNTbjjnNQa8mSD0TAaDuRaRw>
    <xme:WWqCaoKm3KQhJ6ZU9JriaDZIn-Ja3pHXbTxeZDMfXiWDgoz4ebobBaFqYfMKzbIsp
    fgagwoG9SvT0A2NW8cpxl5gTq_hbX3rQxgo2OuKUDQDR86SWrqkfASw>
X-ME-Received: <xmr:WWqCanOszDnvBzTmd48fN_2MBqi0svrudCedSM82YsukmqaRcaBg_9SlN6DQDtW74EsxNdtPi_fciAeRHnPzwceIpLSdLkCJPAM>
X-ME-Proxy-Cause: dmFkZTEwVqJtQHEwNT59EY0ApYPfZBP0Ja94nLydKMHdJKlh4zUdbhZ4q8N1TJVlNLX3Jv
    UG9KBkDhcBzUW3289fayQ1J+ppWFRD446qIAFVyGuquh32EhwbVebEJGoODlbz4hP14Erq
    Tcjcfi9/5+2rPPMs1Rkxsj0k0e2xO2GH5lY4VVdKIG8VeU2vajU+FMxwg/fEJDgrz1L6RJ
    d1Tth/Mq5Cy68H4bxVP4faz7GKaqaQIynBu/2nSxBla0bgf41aEpoAjjJxWypL04u/vTxK
    x5WjWw0TaNT770B0rDvEjO+uKu7yRxr/X4qfgY6A9PKgCt1ahfj+WIbkeb4e64+QxwGFiO
    ISF5btaHd4Gb4tlr5g+7o/kLyNXzva77ise47nGm4aFiHF/GPioLOWwx9R9fp22UUd5+c4
    B7U4gicp5oR4F/L/ntMWchirsJrldJtP2egDiKC8wK4qq2B1cws/wOFIzoSRoD61MzCoNB
    MwEOTGPlYphbW5onxC7XBo54CI5ILU3AV9qk9o0qxplBNISIUFK+oBpuYM10S2Bytz0oT9
    ebImHyOhLRnJKRaAdV+fnPlZrlG1Nza5Rmt10FNlK2PZX7+jOjhWMatSqKOktDSAMlThGM
    vTaZdIvV8KjDr2OmRWeAiwDqP7YIwtAvtL/7vcUA0TY8LFWr5qNxINSUJrKg
X-ME-Proxy: <xmx:WWqCau58pcaQKe9VYHUWmxH57Ocvk_P-4xd-mog7zIb7iqhC6BMp1w>
    <xmx:WWqCah4jBUdr2r1crlcYNx2WbM0lu0zOxqVVuEkyYPUvMsFbZISrxw>
    <xmx:WWqCakF2o2YwA55wqCaQ96HrFEc7MwDKrrm8-BZmRFCXTAy32iXeng>
    <xmx:WWqCapW9e9Kon-FxYrcM5GzYpBCqGRFi9cH4aL7qNO0iP22q7QsaHQ>
    <xmx:WWqCavpI7mhQaQdYEZVmGgM_K2f3xLjsGJTp_9i_8G9uHQjP74KP-ju3>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:56:39 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <ad1d9410d5f0fdd7da58081aa4a22bfe7f1c5072.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 15/32] swim: Don't use the mark register to read data
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

If an unexpected mark byte were to be read from the data register, an
error would be flagged. But no error gets flagged when such a byte is
read from the mark register, which is misleading. Always use the data
register except when a mark byte is expected.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index aa61ecc1af96..b12289bed2f0 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -47,11 +47,11 @@
 	.global swim_read_sector_header
 swim_read_sector_header:
 	link	%a6, #0
-	moveml	%d1-%d5/%a0-%a4,%sp@-
+	moveml	%d1-%d5/%a0-%a5,%sp@-
 	movel	%a6@(0x0c), %a4
 	moveq	#-1, %d0
 	bsr	mfm_read_addrmark
-	moveml	%sp@+, %d1-%d5/%a0-%a4
+	moveml	%sp@+, %d1-%d5/%a0-%a5
 	unlk	%a6
 	rts
 
@@ -63,6 +63,7 @@ sector_data_mark:
 mfm_read_addrmark:
 	movel	%a6@(0x08), %a3
 	lea	%a3@(read_handshake), %a2
+	lea	%a3@(read_data), %a5
 	lea	%a3@(read_mark), %a3
 	movew	#seek_time, %d2
 
@@ -93,7 +94,7 @@ amark0:	tstb	%a2@
 	dbmi	%d2, amark0
 	bpl	signal_nonyb
 
-	moveb	%a3@, %a4@(o_track)
+	moveb	%a5@, %a4@(o_track)
 
 	moveq	#max_retry, %d2
 
@@ -101,7 +102,7 @@ amark1:	tstb	%a2@
 	dbmi	%d2, amark1
 	bpl	signal_nonyb
 
-	moveb	%a3@, %a4@(o_side)
+	moveb	%a5@, %a4@(o_side)
 
 	moveq	#max_retry, %d2
 
@@ -109,7 +110,7 @@ amark2:	tstb	%a2@
 	dbmi	%d2, amark2
 	bpl	signal_nonyb
 
-	moveb	%a3@, %a4@(o_sector)
+	moveb	%a5@, %a4@(o_sector)
 
 	moveq	#max_retry, %d2
 
@@ -117,7 +118,7 @@ amark3:	tstb	%a2@
 	dbmi	%d2, amark3
 	bpl	signal_nonyb
 
-	moveb	%a3@, %a4@(o_size)
+	moveb	%a5@, %a4@(o_size)
 
 	moveq	#max_retry, %d2
 
@@ -125,7 +126,7 @@ crc0:	tstb	%a2@
 	dbmi	%d2, crc0
 	bpl	signal_nonyb
 
-	moveb	%a3@, %a4@(o_crc0)
+	moveb	%a5@, %a4@(o_crc0)
 
 	moveq	#max_retry, %d2
 
@@ -133,7 +134,7 @@ crc1:	moveb	%a2@, %d5
 	dbmi	%d2, crc1
 	bpl	signal_nonyb
 
-	moveb	%a3@, %a4@(o_crc1)
+	moveb	%a5@, %a4@(o_crc1)
 
 	moveb	%a2@, %d5
 	andb	#.Lhr_crc_error, %d5
@@ -212,7 +213,7 @@ data_crc0:
 	dbmi	%d2, data_crc0
 	bpl	data_exit
 
-	moveb	%a3@, %d2
+	moveb	%a5@, %d2
 
 	moveq	#max_retry, %d2
 
@@ -222,7 +223,7 @@ data_crc1:
 	dbmi	%d2, data_crc1
 	bpl	data_exit
 
-	moveb	%a3@, %d2
+	moveb	%a5@, %d2
 
 	moveb	%a2@, %d5
 	andb	#.Lhr_crc_error, %d5
-- 
2.52.0

