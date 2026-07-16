Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1519E7F7;
	Thu, 16 Jul 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197159; cv=none; b=YkVCSgWZBaMUEX9Xvk3npdBjmu3yLDDeCwUzNFmEv/uLRFTA8dvS/mw4iSOq/QB5dLKIsGSztwivVYXTFMk+Ha9znP8zzZ8EgbbPhEV6LUoMZSFfMMPD48ndpEW7bdIw+udTV60rDcdZCt1AfCOx3MWMb/TLOAMSktdTVj2roOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197159; c=relaxed/simple;
	bh=kE18M9EOk1xfNFBuasit0EyEPK1T2q4j5KOAZ+SU1f8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=UOU7+ISflvzB3g0NuvHt05PuU9kFV6TOe/kCkqxKwWkN5cpjlIbD2GmpqE7cFxoWkSjMnCuJLQiNgbiDmBGiULXQDQP/59fIL7CJvB33I4fqnZsDs72subKBM5j4cZcUkkRS/s/SpOoLI6l26UOSoStU11sI7opWBon6Lg8G8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEMuyaoe; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEMuyaoe"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CF44EC01AE;
	Thu, 16 Jul 2026 06:19:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 06:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197157; x=
	1784283557; bh=lu3waH2Iafpgai+I0ODLKBoYw0TbFtdZWRp8gdzVEKE=; b=L
	EMuyaoeQfLrVBRps0dRwhcGspD6sfiGYe/pDnXKsq0LDJJ4j3hnKbgwLKr19f4En
	0hGNcsgUfslomgrl9fVfPBx6hPUseSNoGfXkP9ZBqfBsXW/OJXxA9lIIfd9sm3Xs
	3sWVR+2ffUo65/etxW9sm8RWfSLmZLcZ1rtqPQU7SexscgoFBOipYunPqQBoTKXI
	+Oj65L918X6xvAtCoiWBwOnu7puxRL57NO03oeDV8i/Hhngd+qzpX3c8OJUJY65b
	w8Jp5p1CLah8yQwIRw0WRohOgmOmUpUcZ8v1/vYRRe7ctdIX5uILdOq+YOAgYy3/
	sG6AMGs5ddtCbjIHd81JA==
X-ME-Sender: <xms:JbBYaivm_BbA7JgFpcH5uBkhcfAiPssIwRGfbBOlwbBk-NhlA_M07g>
    <xme:JbBYavH99u22LfXHF5_Hi7HjqB3EUENniavCslNgV8TfEpXNn4O7M2ZlhbtgQOqkF
    Eabhlf2tO4RyFwLMcJS3eixCEU61x4G2iu2FuLJcoySakGB2j9zH5M>
X-ME-Received: <xmr:JbBYarag5eBAhynwWAhYB3oEBOnvPSHqlsj8gsT27PnzCePHhelHn-TDGdReb3U520IosiyyzOfvzHmAr7GzOmKci4S1rve3oNA>
X-ME-Proxy-Cause: dmFkZTFltWOiqi3GJy7/GjNP9KLpSvE6YkRxm2Q3A+Dj/aP0Z6dA9iIiBN0USRzNJCcteS
    K/D0kvNTDbqtTANaUA/xfgoZfMpszLplr5/pvHVqKKo5s0RVWCO2umMrR+nQZw0OKxwLXK
    KaQRMPKUEdI+qra509DzvjLAVS5kcbe0yFLHbQq8WitTPnaA9a//q0SseAu/arIDWD3AGb
    W1DzaVjmh3YVxjd6oh9EZ+C9JcqMLUvXWkcNjeyN/Zi7JLie6B4Pll4f+m9WsP9wdaNbE/
    iZiUd3GAI7vwYmV5kLRtY/IqoaNmE03sbAQ65XKcDP6gxXaEdq+cc/kMIqclO0/e7YtpA8
    cc8rEL7wOLxq5NoU5xKUcgRPcK2AHYOmUan8coKnEitd+HK+dTWbDY8n0f3Sr7/MOrArop
    L8PLVTsVP0d8IuHBAAvWYK4sLd+nq53GQBDvsPwPMAvi2rb8tYdIxpd4XHt0doW/zVm3HU
    nmm+krTBEhrzOEitWLUgNMXJGsCxLDSNW+DRFq1Ojrf0iF2cdlZdoctiCsab7po/wdSBL1
    sZ1BVGev2WDEjLXRDpjspM1KyLgkeV2IZqjhnXPLXkdUqcNjDWDpHNw4e8jlTezNN6IOS/
    0YGyWr7LqP+04yQlxP98JWoEReI5+sIETcCENkFHQu7uk1TqzbMMEzGlzsEQ
X-ME-Proxy: <xmx:JbBYanWvfZ-8kkgqqLYQGRevH0xaMUWvar3p-ClTQkpdBNKQ3J0vLg>
    <xmx:JbBYapnw636KLjTVQH5JkshPjGEuoL_xG8NrSeSWqTBJJCLJ65C2dw>
    <xmx:JbBYaqB16adnuyuPIswhWV_KyfEWbpv8g_i9qXb1gTAAeUutXFFZbA>
    <xmx:JbBYagjTTE50Ds7J03tUzdnH0JwkeTkOocIh5Q7b1l40sAbrDFYcBw>
    <xmx:JbBYaqUniZtXy-tyLjL4WlQO34x_HW-Jtc269wSRA6vfiQDwf_MHkHSl>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:19:16 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <c79e0ce999ba5e71583960f75189c8f7ce6b3fc8.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 12/31] swim: Simplify return value initialization
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Initialize the error result once only. Update the result only after a
successful read.

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

