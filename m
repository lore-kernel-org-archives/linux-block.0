Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AA442397;
	Fri,  4 Sep 2026 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514406; cv=none; b=rGneH+VFB5vfOPQh8zu0xkBlorUrGxvLnTfQ5r9i5QoA/Zw42w3MCHAG2uF+qmJSLkYV9MfmtFo+iCLqdWntvAlGKcSYrg4qbgXnQa6wvZPyB1zglgT+O0InViIWTp5yVve0Drdh9+ObEnIRiD45gMHGBE7mRysEcyzYeADVm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514406; c=relaxed/simple;
	bh=nOG4yfH5/Texvi3H9mlwkPnUvUaWqgsIEIoJ0CLpKC8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=W+BiNbqfAHiA0p7+huCeYLkrPvIHxDjwh7gNBbu+eApiUl0FQ1T2rBWfgVQg+5hWghtUB5WeaqpwF2eyJKzLP2hUq6SpMVTc1egTaORLMXsbW+k36UJ1cuWW6lqc0XqNsAVSxfa5mG9H3vY+WY/8EnZddioof0d6Y+NzhsR/QNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWTX2SOI; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWTX2SOI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 141A7EC00AD;
	Fri,  4 Sep 2026 05:33:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 05:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514404; x=
	1788600804; bh=dapjyK1m12iSEcR0ao3su9fLZHUPrMz/Un6E1mAq3DA=; b=I
	WTX2SOIMekA67bKLIrV5wo19wsdRtlz+cU/MQr6QNpwSiMAq0U2dviw/aQfsQaW6
	//dURvX8jfBf4bRTmnM6qeMECslkt9Z9dHa72x/ed8UkiAkEznVom+Ftp7t+xt8V
	qa+/oIwf9bGp2dV7r3a7Ns3zBq8lJi0bC3RxZTGYR6BXK4IlpEqZdHYIoHp+FxqA
	Vw0FX/tA4F6Tb5fLl1+EYcH9ZWGK4pm1fHNJiK0xgO3Os0VAN/4PdqIgQ0TxVAYf
	40djs+ejZu6SZOdb6CESWd9y7G2SbSFyEebAdI3ALGcuhPr2/4a2vIUf1y9yb6pA
	HHuKJysLvpfkUDN969a5Q==
X-ME-Sender: <xms:ZJCaakx-jXQt6L-5HiTsnNNSa_F_g4lmHYWwsCfQqnlkhary652GHQ>
    <xme:ZJCaaiVuFGiWgQpXpgaZz6zirn5YfFCx6BwFxFnUQoTM-1gvcryIlnX-DO5Xw3kgZ
    D_5ONwG2gfaLvGSaUyGdGzOI0U0fOoi6zUsbk-rO65iENhqrHtusHPu>
X-ME-Received: <xmr:ZJCaamN_nr9a6LLq1xiN0DaALLR44L1m6u6Hzv6aAAL1ljdGoihzJAS3anSbchqpIzNaKPENXnYSHwqrnxgQoK3Il-fU-ZjRupE>
X-ME-Proxy-Cause: dmFkZTEe+0K1AexRW5VKg6Igspc49h8df5hxyd+FQ2UxEzuyTDi2ZhdiSThGiBIwkdDgU9
    3rC08hmhwBNxNoNuM+ycNNv31fkYVLn6pBr27tqKRLQMq1NV3DFc39Iqyivnkegn2UfxIv
    roQdqcH3VVXGJWlrRZqsrGKoS9rmBFYj7GFxW36+XXMnxcw5HiNtvMvRco3OYXN6UY/K0t
    SqGzE69/GT65xt5VU7CUtrbe1RJV9Of5WXGGzQneXN7Ylc6viWLtf2PMOfqRj9Ut2W6+Hz
    DfFSoa/BAnz3IHwFnQcu4acvCfz7MIdPrcCNMUsADy4T129cFo7Yojs7dtan6e38DtGhl4
    tO5xlyppLlfD9dmZilBK/d51Px4d+XSzzVk9UJkUgSInlObRclmSiE9V/s82/DGbmeH99M
    SpMVh1ZiILJwtCeKs7dwVQ1PqSxUu4vB8CfqvaEb7rbUU90rxYcL6Ax3dkMMRwtLusKGcr
    Z8v6ttFyqvbhLbAWf/lH+bnfT6j5vdb43O2azrCCa/Q9Mpz+baHmQr9bIze/fN84I9IEeG
    98+ahh/2/rg7JgiAmqnOUi/MQYmSyaXMfUs1savUzjcRc+Wmp5iQWHAixqSLCdN5HhyOz4
    c7BG0gZmQ12jSrvGjdep1ClQ8bD+Sw1z9sEJAaN7NkXmlVBn7bFi+45hKHcQ
X-ME-Proxy: <xmx:ZJCaakAqnNS-vIIHnMvw5YczxfbP0cGbu8NhGkxe6oCTp6H-pbNW9A>
    <xmx:ZJCaajc7ANsRwQVFpnBCGsD6zaQtW6u7OhfZpT-OCs0TxLro6l7gEQ>
    <xmx:ZJCaajO-6TG4JUHBiSHyE-LBwH9GC45RDW3PzwcSeFnMI-gOAN4HJw>
    <xmx:ZJCaajJcqvpSI7G6FRRQ9iMHLjKQCLePjAJMKmNVso9PAO5xqga40Q>
    <xmx:ZJCaat_jLr_n3FVcXLEgFW0w7O9tUhdnD-MrFehNs0_Ii2NAD5DkSYfG>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:33:22 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <28322f0cbefd865bdfb679bab4352c111996795b.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 13/33] swim: Simplify return value initialization
Date: Fri, 04 Sep 2026 19:26:36 +1000
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

