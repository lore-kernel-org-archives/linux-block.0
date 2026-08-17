Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4504B048A;
	Mon, 17 Aug 2026 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931773; cv=none; b=tX/BM2siWa+ZfOwAqqybXbuOCd19uKPZngJWkFwMTwU0W6d/kiViamy8OfDuuQfzCjCjZ1JoQaHv9I1wu4i2pWDFNxXzZciWWq1pfsTlWNa0u8D4kTimnrmVT8roUspI4mMaJo1uWtuT6JSQ5P3JBYNkx3voqdpEi0kv3iQc2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931773; c=relaxed/simple;
	bh=nOG4yfH5/Texvi3H9mlwkPnUvUaWqgsIEIoJ0CLpKC8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=LwFzr2HVohDOTMoIk8pctYtTCnNa5mAN8gni4kr4J6kSs34uA3svUUXkXrJGPM61xUsFi9O056b2juAupKBT+QcUTQQ2rJUfZbXbZXM/g37tkp9eKGKFEsZgmWmBAN4BYbUml5etdiplaLlvnSMYw4GQsEPdmjp2eipmCa1hQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHhlzzFk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHhlzzFk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED42E1400031;
	Sun, 16 Aug 2026 21:56:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 21:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931771; x=
	1787018171; bh=dapjyK1m12iSEcR0ao3su9fLZHUPrMz/Un6E1mAq3DA=; b=A
	HhlzzFkQbH++QHvhYLZdOu3ti0XPUHnnIne+a3KP8TbcSjbAJszq3b51t7YEQ4KX
	RtcxYJiwyQABWbgI1MpebFsn2BUVSSMXb3zZ6K8ZApcNv+v281H2/tZ0PTeN0UT2
	aHaBMtIJeRHjXZEi+b/zTmnu6dr65Ab55xcJvQpaRLCFGyalgbHsvGAP3JAK+uzC
	ebJwxmDjVWu830kBT2ZYvOhOoetf8jTNOKbnNGn8izdp+rs3wUZLO2s7i8CocwvF
	M5ekK+n+9ExszJAZ6tozcbXAUb77E5kCdyG5aZSsZ7lCFT+/XEDUYH7GS/fpsZYI
	wJmC8jSNv1s/0MbmAoXQQ==
X-ME-Sender: <xms:O2qCau1A2B1ov6ryWWM7T0LQbWEL-mtPMWdCeCaI2r-phkS6DPtzgA>
    <xme:O2qCarLyMbIgUqTkCI4CSRsbkIGKS0DkznvZuxu4Q_V0mfLlZkQWt3TMLVJaVlX3J
    d6a6hk52kX85Zu4-snMtG4Y5_syjBHGk1F2fOJ5GLZkGGOYjbuNa-E>
X-ME-Received: <xmr:O2qCamydQkuLnCybrCChcjJdhuwuFZzirkzdBkdRPa0Lvdl-1tVJwRP_Y7UCSOhgaVaxRX0xQ8RZzRa1lATAeloh1MG9C4yG99Q>
X-ME-Proxy-Cause: dmFkZTEwVqJtQHEwNT59EY0ApYPfZBP0Ja94nLydKMHdJKlh4zUdbhZ4q8N1TJVlNLX3Jv
    UG9KBkDhcBzUW3289fayQ1J+ppWFRD446qIAFVyGuquh32EhwbVebEJGoODlbz4hP14Erq
    Tcjcfi9/5+2rPPMs1Rkxsj0k0e2xO2GH5lY4VVdKIG8VeU2vajU+FMxwg/fEJDgrz1L6RJ
    d1Tth/Mq5Cy68H4bxVP4faz7GKaqaQIynBu/2nSxBla0bgf41aEpoAjjJxWypL04u/vTxK
    x5WjWw0TaNT770B0rDvEjO+uKu7yRxr/X4qfgY6A9PKgCt1ahfj+WIbkeb4e64+QxwGFXW
    jJoJhToP5yLLQDzmONqQ3ohBCaS4C5wmbCZbLbTek6RnlMIFJZStbB/A7TrA4HroUVLhxR
    QQgdaf+WJQbdszO+NQjNYCschIhGNsaMKxPIXWOU7aLhEfNWT/xQPNBixryDq7Fe+Lq4F0
    WEtdrq+bbs2RKzv1w4seD3d/kEJ5H95Tc1+E9gH+goGWJctyDI/DkFnWEjQrpZE3cSyXj5
    YryldrqHqnKO4aq+3o92MTKz7rgNbPmeHq5MDm/XRMx4KrrwHJ1SdwxuF89zSnAiZCad2A
    XMrZBOIeFcYOqu2eh1HkLL5/1/tO+brm4mhJztxpqBS8qkJqsCrJU46wOUow
X-ME-Proxy: <xmx:O2qCahUKxTrR0vC5ZjSUZNe_sIWd2Zp_U3NtHRm5JCKJvq_Az8iDig>
    <xmx:O2qCaujm3CH7Ks_GhI5jUl7fAfCvgXlyaSOhUGKz_Zk_ClrxGrtNGg>
    <xmx:O2qCapDeS2V7WNU38mcEvwQ78yhVvHA7Y3rBhP2SSqzhPAb_6ut7cg>
    <xmx:O2qCasuxQYBf84qonyehhamWIRgms9NSOjYnv6aYJoFCN41UfKBSpg>
    <xmx:O2qCaplW_gAE6cmNDghxeZSQJBqoSfrqAfDBX2LPG8L-sZzQQvH7_yij>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:56:09 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <f57b3a82d81e1d4d897dce83fd7c162f02de6496.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 12/32] swim: Simplify return value initialization
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Initialize the error result once only. Update the result only after a
successful read.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 208622ac4aeb..31fc63b074dc 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -47,6 +47,7 @@ swim_read_sector_header:
 	link	%a6, #0
 	moveml	%d1-%d5/%a0-%a4,%sp@-
 	movel	%a6@(0x0c), %a4
+	moveq	#-1, %d0
 	bsr	mfm_read_addrmark
 	moveml	%sp@+, %d1-%d5/%a0-%a4
 	unlk	%a6
@@ -61,7 +62,6 @@ mfm_read_addrmark:
 	movel	%a6@(0x08), %a3
 	lea	%a3@(read_handshake), %a2
 	lea	%a3@(read_mark), %a3
-	moveq	#-1, %d0
 	movew	#seek_time, %d2
 
 wait_header_init:
@@ -137,10 +137,7 @@ crc1:	tstb	%a2@
 	tstb	%a3@(read_error - read_mark)
 
 	moveq	#0, %d0
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
-	rts
 signal_nonyb:
-	moveq	#-1, %d0
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	rts
 
@@ -149,6 +146,7 @@ swim_read_sector_data:
 	link	%a6, #0
 	moveml	%d1-%d5/%a0-%a5,%sp@-
 	movel	%a6@(0x0c), %a4
+	moveq	#-1, %d0
 	bsr	mfm_read_data
 	moveml	%sp@+, %d1-%d5/%a0-%a5
 	unlk	%a6
@@ -228,15 +226,12 @@ data_crc1:
 
 	tstb	%a3@(read_error - read_mark)
 
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
-
 	/* return number of bytes read */
 
 	movel	#sector_size, %d0
 	addw	#1, %d4
 	subl	%d4, %d0
-	rts
+
 data_exit:
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
-	moveq	#-1, %d0
 	rts
-- 
2.52.0

