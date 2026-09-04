Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B844E64C;
	Fri,  4 Sep 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514603; cv=none; b=VUmh3uGkk9o+dV/MDmGYZaQ99EXcAYsLnUeVGBlTzEYjfXEdp1CVmo3ktBuM0Wn53fy/J6pCTOla0dvcJ6F000S+v1ONI87edVAuAi0o9RNkQw66dzh++zOWvLLOwayznbzdL9mv7EGVOZ0piHNsoof8DeNP5wQT9IZFLjPj+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514603; c=relaxed/simple;
	bh=mzkDrXBH4RomLX+jHLh/d6zM58mnDl0YDinRD4ebPt0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Xc4l4/GUWPopxJLxZgZrLuis2gPWz6a6UCzpWKIAUNjMjxKstB5Rz9s70h/6P9bLxhw/ZZ/JRD8LhgKbjpVIP/ghx/eKeyDGqybsrOfaTA9w0Yp51in0OhApFwLNIXdYKpYMIc+VlAfl8casQaTlx6B5l81YnmFqjY+6ThFNiHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TAcnlCFl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TAcnlCFl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDEED1400067;
	Fri,  4 Sep 2026 05:36:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 05:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514600; x=
	1788601000; bh=51+l+4t/eDclkKVdvo5tHtz9ZQ1eAbR09EDfIyzxuiQ=; b=T
	AcnlCFlPRk58OZiX1k6sNHjsfy94RydcwXlGMJOAUU00MP/hDI72wDqwzTfD4j1K
	wXGm+f6B7JGAYMI9DQsOc4kcVrEzqoSYERByPqfdtXTtO5KxtMeQ6m+5E4BHr5Dt
	l6IsIyR6re6d9YdWL7zhHJlkUD3dN6iUdLHGA1/eqfzAWYKgqrG4pB5D5hvkp3t/
	FXvoluxr+0KVEwUkUIpLoejuvkSXYA55melQ/0uMLy1qk+EFJhLyzsqY9EsQKWlx
	FajEL7NWSygO4pHpZeWcUEwFL3uXsVULpoPA0PYaacVb8GgY9grKWSo7HWmm2Za6
	tMEJduedY6eiErWj1jAYg==
X-ME-Sender: <xms:KJGaapzYEF6QppkyzV8aIrDC_Ak7eVKdYvVWgzU38Zcs851IX9UIiA>
    <xme:KJGaajXC5Xlwle5MnPvkcJSNqYHYdaWbAxeMCSv7pFlc1OAUOJYD-KSFRgdnyzk8t
    JSxOIWTHgHEClNFONqTGz0A-XAiZ3rNjnNr7UUq0ao_8IwRrcfG_LY_>
X-ME-Received: <xmr:KJGaajOqBcZ6Du6BLWQGPGTvmxwlJ0NRxBPr_tLIz8KmRja3JuPv0UnWQ6aZ3723ZJknFCKxo62vq9NxPzZV6sMbEKBmWqUta6g>
X-ME-Proxy-Cause: dmFkZTES4bQ21oAzpNnp51xfFHSMQBPKtrMCV5iYYMBFJYMMGuku2wDZqHLDhf7MMkpQep
    sMe4CyNnIEY4dUJg6qGIApiDz7xq7NkSCScmKgrMc4345BLDBaaFf6c8TLqowSoQSjBNao
    tQAjHxJbuqzVv3VzZRZEacp4FA41Q9OcL5NDtbJMFMDUCcPGJR7zU6OainbhxZYK3NU11B
    Fa2x5PyGrJHtwPQxOc1oyHJXrbM2nyqpGGOSM3yceNTB7ODw+A07JKEQZT40T9t1sfxdOY
    Z+GEWRwgrC3pQuxmclLHPwxPnQJ8sX9Nh9G6tEyIm0Ldv+rMccWy5ZFRy0U8vBhf8uuzsH
    AVt6esPCMxKRONG3sfwnrkafd7I09OT5/lkgiGpE6UIVBwy4uskQObAJS0Dn4X7ghYHzaD
    KNHMbZeSVOZYXy20uQHrP2P4k7xgLJNl9xvR1k5641Me3/bkXkFGwe4bcna5Qvmp2QMe9P
    FQBZmj9ivzHkS/vRMftiMZLb+/Br7uDQ7eyh0T8Curi1/jvtmnTw51oFtBkxMaUUODomuF
    l5sBe7lWn/mCG3mMgBov1xbK3veV1wHVeR7npulmD6uEmVnm+S/35Mkilr1578PQSsvcAB
    KRAK8iVcsAPXpOlpEFKd2GXWKd2FABDiW8/EWlwrs1LH0n05OvKr/fUidSXw
X-ME-Proxy: <xmx:KJGaatBEwBarum6KR6xM-qjqWDPpgCYZ6R9GAYFMVn_FGBfi9AZuLw>
    <xmx:KJGaaofq_NDcONAMARtYeIQK7jEH8Lnzvf6-grerJUx-MsKNThHprw>
    <xmx:KJGaakNDwvGvCrkZfl5ALcVjWbcdppCvXcPNsf08qTF31sVJxY8gzg>
    <xmx:KJGaagJkJ7w19jTdeXL8t4kUhAJ02-mcaZ7s2IQIDFJqsAx56Mf0vQ>
    <xmx:KJGaaqgvmmDNUVImWrd1qmW2AF2yFw56-qJs90YXdaNAKCP5c-A-m4SF>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:36:38 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <7eee06428905fd7ad60909d9b5726c15cde1b844.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 32/33] swim: Define symbols for constants
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
index c373fb3fc750..a1879cfaa6f4 100644
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
@@ -157,7 +161,7 @@ crc1:	tstb	%a2@
 
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

