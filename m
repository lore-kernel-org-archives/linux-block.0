Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D6442FCE;
	Fri,  4 Sep 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514434; cv=none; b=mWvzE/UDNEVzXi9bo12fTM+c1/SVO3ZKO2+C6ktTZWluHQegLZrjpCaXE5F7DFkSGbpq27Zr6OfzQ5y+Lsva29N8ns+Rgk3b293EVxPCCLeNrI5lmHAzHGqPTkO2vI3rPclEQr5Nt7yDizy0WLy3Q+TRjlWymbEW5Gb0w90/UV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514434; c=relaxed/simple;
	bh=OR02IR2Ki2iJIWbzJO/vB+3NKZMXfd/Zt1dhikSy54I=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=NxQQWzAuAAP98gLPRfFAoVLq9yqcT/tXYOzEKO6KTG19TAG4qqBimFJibvydp+sNoWdgJ/JOcX0HDWdbXU3F6XFoo4tLQqQGBC2NfnNpmzPemgljeq25/8tMShP3WNyqhSxZZQpVvDjrczpMOUr1MX7CvrTbH3d7Lavxjo/0ZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jn3qWgHf; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jn3qWgHf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C9096EC0128;
	Fri,  4 Sep 2026 05:33:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 05:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514431; x=
	1788600831; bh=eC0zbKKdmy8sFOzLUz32yPzDGFoZ/jh9E06NlaGHXVE=; b=J
	n3qWgHf55w2a2K8WwH3CN592Ho06hnqvZ7zck7CExfFK0QiKneEgX64O1q56XuV9
	+44aFn2GT+ejvtxgBsfnyAterw30ScXmGiFvgjL5mtU1zdaQnM4oPT1LtbRPVeG+
	GWShT5jecO4di2shtQhEjMAsa8vAfQTrT7kiHM7I+dsQIy8kzI2wEaIsSfPt9xTD
	cJSNIjzRxQRqYVBUNZqs3GWGIjUqM2fZFe6ydO4Y7/YQXoIyI+9suqMp81tV/02c
	Xq4kXW+I4OSMW5x2YmZVxrAROQ9mLbku5kc8Tc1Koi9UwBv0Y5BHS0RG/LPF66L5
	9H2tUGYKZ59RUSVokB9tw==
X-ME-Sender: <xms:f5CaahTOj_L_EjtaORjRxfZ2YmE1jmFR6qsA-9hEmtAY4B648SuvEw>
    <xme:f5Caak0WHh9JR-xms9hZqgW2iQczPveUPWQjy6Ty1RFrDaPJZsl77SAZITyqFF6PP
    k_d9074Ar7TD-_EwzEIpr49fZJ8JTEkuWE8THHdSc8hkPwTZwtin8mr>
X-ME-Received: <xmr:f5CaamsIrxBdWk49VHwbCO6kM1hCUUf11R0xqrEmxSQXDrXbnWl1sNefVWkhzbxIs-BDSHmK2Az4azHURgbmXpS4-bFS_n_mJ2E>
X-ME-Proxy-Cause: dmFkZTEH2qZt5RyVMGIjuBkUGlmhN5ZJte6hmKxUze7L1uOD8wVg4SMRrxTJ86lIDfqtkL
    +QxQRDVzf2U9TmIQ6RtPZMIwlvA7gRnX5BNqWd8IMTbr8gAZBs2pDrGigg2W0qRzrNb5Cp
    7+bpE3THerIpIk7eJNCg621+gD7CzjDahrM0UG8DodY4HW+stGUYit3TjIW+xj1U8orIoK
    w2q1WP/Sx1+JLon679MHL/t6Dhlru/F6ofZ1XZZLdNU27UnoTb91jJA9rWObMTeLKoj14a
    1H2Yi9N/48EiTFkgpEwgKk64rBUnCJYdWUOh1TPTm/JhyhFwQgTGlTbFDmXmqgotVKcHUU
    jvx58pwd7qK/bIJF67HSTGMgZWJKcZHWorZguPhDjt+pRULwyEnre8B+fBD2t7PfJWh2Fe
    eZCi6Llh+1tLk82vQSHOsieMjZODq9roBF8FFHCaqq9IUoa6vhEQ9PZP4VB4IRlEk/6JGz
    0tUnm5eb/j80ZB1gVD2Y4lT/Lz2zjmourIf+9jj8xAxym5vcG7JZMHzEWcj5VeWlu6Rz5x
    Irvqbis4XnDkSxjUIrj5JGohRq4ej5BDFZuPGd76alZUXOnrkFzWI8GEMZDLeBGVgf/2sj
    5/a0lMt+XqR1Q1iJC0U4o2VeF2SSABVo+b2w3PNLkH2zZ3VMUSWJcRmYZZmQ
X-ME-Proxy: <xmx:f5CaaqiyI3fOTAhkMvzGk4vVNQfHfDMaOkm8k-VXx0LVZGfZFUGdHA>
    <xmx:f5Caan-_IsMKIY0W4OnDuBGPjI9LW5-71gXDB0v_FiMRCVNc5HfAJQ>
    <xmx:f5CaatvA1G2Hi7u6vsr_67CrOxl1DVEJIDsMo4k4CNwEt4V06unT-Q>
    <xmx:f5Caarpt_cSBxqfF85hKTsQlPaMeqJpoGLVre0KjjBqRiD5mNEor2w>
    <xmx:f5CaageF-c57ThX0QA9pEGGRKfJ7EBnq6SRPZytuAQ8hM3l7ERB4j0y6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:33:50 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <fecd77b141bdd8a59ebae5f9efffccb155afdc4c.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 16/33] swim: Don't use the mark register to read data
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
index fcf574ced85e..699f7c90dd1c 100644
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
 
@@ -133,7 +134,7 @@ crc1:	tstb	%a2@
 	dbmi	%d2, crc1
 	bpl	signal_nonyb
 
-	moveb	%a3@, %a4@(o_crc1)
+	moveb	%a5@, %a4@(o_crc1)
 
 	moveb	%a2@, %d5
 	andb	#.Lhr_crc_error, %d5
@@ -212,7 +213,7 @@ data_crc0:
 	dbmi	%d2, data_crc0
 	bpl	data_exit
 
-	moveb	%a3@, %d5
+	moveb	%a5@, %d5
 
 	moveq	#max_retry, %d2
 
@@ -222,7 +223,7 @@ data_crc1:
 	dbmi	%d2, data_crc1
 	bpl	data_exit
 
-	moveb	%a3@, %d5
+	moveb	%a5@, %d5
 
 	moveb	%a2@, %d5
 	andb	#.Lhr_crc_error, %d5
-- 
2.52.0

