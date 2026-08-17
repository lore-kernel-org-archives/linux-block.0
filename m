Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB25C613;
	Mon, 17 Aug 2026 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931960; cv=none; b=esQDrDa8Zi7WcOFVqbXSpJxCMgDZXyx1dYZbBNdNhvEhPY64QoxbzEs1wRVorSUDfQoCBhVy5q5ZoDgUSghRF7Y1EglMbXIEU/k4WXArAKuIzXmmjfuVGCalis9P87Kwu9C/nEk9nsQJmahhWGpjvm7pH+IDjU8ZPcGQduo36Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931960; c=relaxed/simple;
	bh=0xuk6TnKYAVzw5FvX0PIS3Cy5Fp5zmJy3gwVpmwgpOk=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=cHyw0GlL1CXvRtgJd7XaP6ohLXYRUVgpr7c8HKk/16eODBHf+/AgXw4wiXWlLJwa/9FasVlV/yu2eVSwCkuwKtTc5+b6laQqMfi31rTTIGxCqNwOS6KXydgTXFGLoN/YZZaOzQgBgJyWukYw0HAqAIauipPHBwr8yQm9x6lVmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqULysQJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqULysQJ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0752140007C;
	Sun, 16 Aug 2026 21:59:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 16 Aug 2026 21:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931954; x=
	1787018354; bh=SF5/27k6mqkcIknUDzTkpQ0LJAbABrpsXZAN5ZB4xw4=; b=e
	qULysQJnMFPwXRY5a0QhMCvqaHpz79tbjfjL6tPuW/IdP925rOB99V6nLilpTdnp
	SFFPp+GfPKPJzOKVuGaMBydgbXppw7iMfGIYR+lvdoHO2VmXPzPef5j0dkNAxb/q
	E3C2FbgLE9B3ww6+vW+S3hMz/RCvumNcZ8zSszMZi7KQbX/ASzZVRzRujbVurIGF
	kp8HiU3E1kF75lwL0jWhdsvJoAN8BlhLfmZtyPQKxQ3r+WP3wpquz+Evzurqt8ov
	Xq5k0KFOMftMzGsPjBpVU0oY33a5qP7aV/hHfa639/+xC9FvlOSvmr9adlNKKLti
	EtAgMBzx9cH1R3fCGpDZQ==
X-ME-Sender: <xms:8mqCauvBRxBfcqyrpPvuTM6deQdHiDUfZbl2lkygDl-Vg1caoFPJxw>
    <xme:8mqCatgSuEfGt3tOaPfUZNJKdqJCBgSUlcpdxguojzX0UIGgQfkhO0sdTMdxBHZE0
    2BM8lpnMqFqlL3Mf_OH8oh-rP6c-k9fL10LdwULii78EjaDo0NezjQ>
X-ME-Received: <xmr:8mqCappxSA3_Fk1zeELbusRdqro4xxIbGHXmldaQtzDwlymC9hK3NkDYbKvIqq3LL26MzjTmKMlZaQbazIY_MezyTBiAei4gGKg>
X-ME-Proxy-Cause: dmFkZTEwVqJtQHEwNT59EY0ApYPfZBP0Ja94nLydKMHdJKlh4zUdbhZ4q8N1TJVlNLX3Jv
    UG9KBkDhcBzUW3289fayQ1J+ppWFRD446qIAFVyGuquh32EhwbVebEJGoODlbz4hP14Erq
    Tcjcfi9/5+2rPPMs1Rkxsj0k0e2xO2GH5lY4VVdKIG8VeU2vajU+FMxwg/fEJDgrz1L6RJ
    d1Tth/Mq5Cy68H4bxVP4faz7GKaqaQIynBu/2nSxBla0bgf41aEpoAjjJxWypL04u/vTxK
    x5WjWw0TaNT770B0rDvEjO+uKu7yRxr/X4qfgY6A9PKgCt1ahfj+WIbkeb4e64+QxwGFCf
    f9NIuyQjvn28CSfxV+ol7tzRWPZj5u9Hrg40Jomn4ma1cPRt56gk5bgy2LnP4as8AMyWBG
    eMAUo4y++oSDSI3zrb8GvFhTiGe4GiaanVzN7XwqiNTy2/yfT8lMrBi7XdK6lN1MpK7kSf
    oZPXyKeAKxAQtpxmq70Xjs21iZxDlOfCdlLW5wBl5o2fgMlrxar/aQc3eEW+AlgsQBZCPh
    rqMA8Wni2h4a7B04xRQZOq9e5DK5X+PzVGmMiXVQ7p+BPNxhdoQCqP/Er2H0r/2pEpewjs
    e7Ut+zgTf0kqikuTiQyTeggSlIM5MrABF+o+t0v1qB+wlgX2qZ1TSTHswmZQ
X-ME-Proxy: <xmx:8mqCaqu1SZLrM-9CcG4Q3GTobHOjXuSkesIbvmmRVENZ-3zVp6T5zw>
    <xmx:8mqCasa5ytmmkVN21F7mCq9UcI0BqKtzIn-JtQBEEpk-M-SmkCqsbg>
    <xmx:8mqCahYbqkmnYmx0mS-XNUSi4ln52soU84e1kWAD4pM0smVOHaxoJA>
    <xmx:8mqCatnaSWaf-0q8-G37ekBmjOVLk617b0-ewuMGU0rVz-6Ow1Qmig>
    <xmx:8mqCalfeEhiVOFctWum6Udxn-RGXWgmDLexAhAu_kmPJAGKQAa1rBe38>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:59:12 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <8ff8fb2deceab8df1e3786105b291fdc15b7eaf3.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 31/32] swim: Define symbols for constants
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Define local symbols to give some meaning to anonymous constants.
No functional change.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index c8a89c0c4652..c78efc30082a 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -43,6 +43,10 @@
 	.equ	sector_size, 512
 	.equ	.Lmark_sequence_len,	4
 
+	.equ	.Lmr_clear_fifo,	0x01
+	.equ	.Lmr_action,		0x08
+	.equ	.Lmr_write_action,	0x18
+
 	.equ	.Lhr_crc_error,		0x02
 	.equ	.Lhr_fifo_2bytes,	0x40
 	.equ	.Lhr_fifo_1byte,	0x80
@@ -95,11 +99,11 @@ sector_data_mark:
 	lea	%a3@(read_data), %a5
 	lea	%a3@(read_mark), %a3
 
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
-	moveb	#0x01, %a3@(write_mode1 - read_mark)
-	moveb	#0x01, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
 	tstb	%a3@(read_error - read_mark)
-	moveb	#0x08, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
 
 	lea	sector_address_mark, %a1
 	moveq	#.Lmark_sequence_len, %d4
@@ -157,7 +161,7 @@ crc1:	moveb	%a2@, %d5
 
 	moveq	#0, %d0
 signal_nonyb:
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
 	rts
 
 	.global swim_read_sector_data
@@ -177,11 +181,11 @@ mfm_read_data:
 	lea	%a3@(read_data), %a5
 	lea	%a3@(read_mark), %a3
 
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
-	moveb	#0x01, %a3@(write_mode1 - read_mark)
-	moveb	#0x01, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
 	tstb	%a3@(read_error - read_mark)
-	moveb	#0x08, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
 
 	lea	sector_data_mark, %a1
 	moveq	#.Lmark_sequence_len, %d4
@@ -239,7 +243,7 @@ data_crc1:
 	subl	%d4, %d0
 
 data_exit:
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
 	rts
 
 .Lmaybe_store:
-- 
2.52.0

