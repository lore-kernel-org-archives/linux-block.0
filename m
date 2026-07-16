Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022640862A;
	Thu, 16 Jul 2026 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197348; cv=none; b=OG6gmipG2ZidFTtVgrt0F9DvXZMblxCAva1ZjgSlAySyIkJ8z6CDkiANpKNzqx38cXOF/mnv5YIxVP9OxJg7ra33MYgHlcpXGQti7TynSMvi1Wz/FtcG/sTHW9IYEqlR8oTwwQ6X3dBFRVqne1L5K/TnitCrpVclB19i4f3A6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197348; c=relaxed/simple;
	bh=vqOC1YwgN86tYETEJPYyyenXTDsjZT/W7s9PXplhCA0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=UKK6P71QzSGCrM9hWPoa5cbIt/MFNhqIqnqpe/8tqk8q71k9p47JWKbDbV1KKTUtoWUKSpsDRZ20sPABXPDzdmpEvX2g0k6FncxNgTqciKsdD/at0HZrI5HZItVg1EdFzlG3WPTRSytikhuRcDgTdfsuqZHdedus3BAZtQR0FIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V88FPCM6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V88FPCM6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53A001400085;
	Thu, 16 Jul 2026 06:22:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jul 2026 06:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197346; x=
	1784283746; bh=t49ZnLd6WTJlVchp6VxGiIKDmcn1xwP5ZVDBypuinVY=; b=V
	88FPCM6S3AoK0gt8EKOkGoJjBuqX/guwwz7gLE3Q9iOUvezxFzdia0owHThSvWGr
	PrI+rhLrb9eEkQCOdjxsdNkrz/1jC42Z594EESMO7uIOnw/mVDoJZY4qei+JxI/I
	DE/M4p67SH+KzAklY5G0fN1mJTbtX8DqLlirHzTS6MNU/O1BmWfc/7o12/6eeHI7
	MV5q5QuwMWvfCDae7J4YNBURILTUA1YJmITIu4JJtGeH2NZKzlLK7m34N8t6468g
	85J9oezuBsuLX2OvgDrT3eWupUucYlrq7+ic0lWHRtdi6imqg6vATDFqkdcrrWfM
	7kGRjsqYUG+cau4d2tTiQ==
X-ME-Sender: <xms:4rBYaljTb5pwT_ZDsav7LPmsgQAstnaglAqwHx1uzPP-qn8tyBMEgg>
    <xme:4rBYakFs67Dg324FDcZIr6L5HVcKZrmjnYXT17d2qXF_pFcq5bukB6s1AO4b1I7wg
    GK6H922r1_K4gkSyghS-Fvzo6vxpP_mCiuWa5gIW4qgVkFSqwd9nyY7>
X-ME-Received: <xmr:4rBYak_ZRXW-kzQk4moiEWSCsGKdK0YOErzeDYFM_QFUM_gi7Vf-IcPT-idRnb1wOLP3EhJJT9GAXtav_wrKMWtbMLI_9jML4sM>
X-ME-Proxy-Cause: dmFkZTG1pY5YrWHEb9mPBXb6bi8/VzGx58ImnKcrVBtMN5rwmev2AU79enQjP8UKZ35OLh
    jlGafQ1rpYgOW6wyLpdXUgkXZ+aBK4hprOrqS4+BK+9OtEFqfoAy3x4N2L2+ntHDl3TMYN
    KekK7dbc3efaVZoNOUsMglqLA8JU/1vyZS5+FP3QIcKGcH0dzKWNA1LpFTTv8K+hNe9vF6
    UQAiCaVntKdpyBZP5hUV3b+Ecy2g4vO2BjN3TFWbPP8PusBBAmP+yeVfJf+m9dRNsPVd1a
    qmtKhLdmhGWRYIKT78hreP2wYvj+CAI4j995I1WJMZ4jqLe68iyT28RXdGKQfSBtXtdCjw
    w2Yqye5FNtwWG5c2owMirBkXFEFkJeku6+B7tjCuGFJMDhcHBuO2k83fIK2yx6DrPfYrxz
    arJ5zAQsj9zKJdMZilYh7AhQeMakbaP7u64kvHKHaqUvp+duENMut6fvvWk51PwsZWuggn
    XQF3EoajJjBf0y12safABsUN40R5NiXYtSd4XLhVtR4YOsLMlp/U5PqTeH0ssF2rZZxNme
    USKZk+ihDMjMcPZqAdma012oRQKP4ovcj+BqxOhZSZ0ujVprc+gDJ3ceBiI0WZwCuxLebJ
    Xe8/2PCjkouoR9LtM/07f4FCP/BpR/xTw/2EuWl1uw4dFW/fY97ZM45NumXw
X-ME-Proxy: <xmx:4rBYarx7NxW2EeCiAIL8tWBcxpmAuyT8VqjeOr9zT5Pgy5SKQ9uD6Q>
    <xmx:4rBYagNVp45u3r_xHPaVNeq53jyw74zpJR-SxqiST1nrrag7gZrw3g>
    <xmx:4rBYag8CTYFjXaEwxYccmfO7JAhrwlgN1c24I9NttXkM0cy39tcHVQ>
    <xmx:4rBYat7otU3n131WRL7NI-AQeEHyvfiOGZ5Mxxi3fABIeikdYs4BjQ>
    <xmx:4rBYauSvt8jAcBbBOzc00oTBYxRsdgLqn0tRzFrs1BDp3ygBnnVMgjUu>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:22:23 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <b1193c2e8e8850922bec72f7ea2b07710d9f0fdd.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 31/31] swim: Unexport global symbols
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

These symbols aren't used outside of this file so use local ones.
No functional change.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 251 ++++++++++++++++++++-------------------
 1 file changed, 128 insertions(+), 123 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index c17a25e1cd33..65b4e4658e10 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -14,33 +14,33 @@
  * 2008-11-05 (lv) - add get_swim_mode
  */
 
-	.equ	write_data,	0x0000
-	.equ	write_mark,	0x0200
-	.equ	write_CRC,	0x0400
-	.equ	write_parameter,0x0600
-	.equ	write_phase,	0x0800
-	.equ	write_setup,	0x0a00
-	.equ	write_mode0,	0x0c00
-	.equ	write_mode1,	0x0e00
-	.equ	read_data,	0x1000
-	.equ	read_mark,	0x1200
-	.equ	read_error,	0x1400
-	.equ	read_parameter,	0x1600
-	.equ	read_phase,	0x1800
-	.equ	read_setup,	0x1a00
-	.equ	read_status,	0x1c00
-	.equ	read_handshake,	0x1e00
-
-	.equ	o_side, 0
-	.equ	o_track, 1
-	.equ	o_sector, 2
-	.equ	o_size, 3
-	.equ	o_crc0, 4
-	.equ	o_crc1, 5
-
-	.equ	seek_time, 30000
-	.equ	max_retry, 40
-	.equ	sector_size, 512
+	.equ	.Lwrite_data,		0x0000
+	.equ	.Lwrite_mark,		0x0200
+	.equ	.Lwrite_CRC,		0x0400
+	.equ	.Lwrite_parameter,	0x0600
+	.equ	.Lwrite_phase,		0x0800
+	.equ	.Lwrite_setup,		0x0a00
+	.equ	.Lwrite_mode0,		0x0c00
+	.equ	.Lwrite_mode1,		0x0e00
+	.equ	.Lread_data,		0x1000
+	.equ	.Lread_mark,		0x1200
+	.equ	.Lread_error,		0x1400
+	.equ	.Lread_parameter,	0x1600
+	.equ	.Lread_phase,		0x1800
+	.equ	.Lread_setup,		0x1a00
+	.equ	.Lread_status,		0x1c00
+	.equ	.Lread_handshake,	0x1e00
+
+	.equ	.Lo_side,		0
+	.equ	.Lo_track,		1
+	.equ	.Lo_sector,		2
+	.equ	.Lo_size,		3
+	.equ	.Lo_crc0,		4
+	.equ	.Lo_crc1,		5
+
+	.equ	.Lseek_time,		30000
+	.equ	.Lmax_retry,		40
+	.equ	.Lsector_size,		512
 
 	.equ	.Lmr_clear_fifo,	0x01
 	.equ	.Lmr_action,		0x08
@@ -56,91 +56,96 @@ swim_read_sector_header:
 	moveml	%d1-%d5/%a0-%a5,%sp@-
 	movel	%a6@(0x0c), %a4
 	moveq	#-1, %d0
-	bsr	mfm_read_addrmark
+	bsr	.Lmfm_read_addrmark
 	moveml	%sp@+, %d1-%d5/%a0-%a5
 	unlk	%a6
 	rts
 
-sector_address_mark:
+.Lsector_address_mark:
 	.byte	0xa1, 0xa1, 0xa1, 0xfe
-sector_data_mark:
+.Lsector_data_mark:
 	.byte	0xa1, 0xa1, 0xa1, 0xfb
 
-mfm_read_addrmark:
+.Lmfm_read_addrmark:
 	movel	%a6@(0x08), %a3
-	lea	%a3@(read_handshake), %a2
-	lea	%a3@(read_data), %a5
-	lea	%a3@(read_mark), %a3
-	movew	#seek_time, %d2
-
-wait_header_init:
-	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
-	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
-	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
-	tstb	%a3@(read_error - read_mark)
-	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
-
-	lea	sector_address_mark, %a0
+	lea	%a3@(.Lread_handshake), %a2
+	lea	%a3@(.Lread_data), %a5
+	lea	%a3@(.Lread_mark), %a3
+	movew	#.Lseek_time, %d2
+
+.Lwait_header_init:
+	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode1 - .Lread_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode0 - .Lread_mark)
+	tstb	%a3@(.Lread_error - .Lread_mark)
+	moveb	#.Lmr_action, %a3@(.Lwrite_mode1 - .Lread_mark)
+
+	lea	.Lsector_address_mark, %a0
 	moveq	#3, %d1
 
-wait_addr_mark_byte:
+.Lwait_addr_mark_byte:
 	tstb	%a2@
-	dbmi	%d2, wait_addr_mark_byte
-	bpl	signal_nonyb
+	dbmi	%d2, .Lwait_addr_mark_byte
+	bpl	.Lsignal_nonyb
 
 	moveb	%a3@, %d3
 	cmpb	%a0@+, %d3
-	dbne	%d1, wait_addr_mark_byte
-	bne	wait_header_init
+	dbne	%d1, .Lwait_addr_mark_byte
+	bne	.Lwait_header_init
 
-	moveq	#max_retry, %d2
-amark0:	tstb	%a2@
-	dbmi	%d2, amark0
-	bpl	signal_nonyb
+	moveq	#.Lmax_retry, %d2
+.Lamark0:
+	tstb	%a2@
+	dbmi	%d2, .Lamark0
+	bpl	.Lsignal_nonyb
 
-	moveb	%a5@, %a4@(o_track)
+	moveb	%a5@, %a4@(.Lo_track)
 
-	moveq	#max_retry, %d2
-amark1:	tstb	%a2@
-	dbmi	%d2, amark1
-	bpl	signal_nonyb
+	moveq	#.Lmax_retry, %d2
+.Lamark1:
+	tstb	%a2@
+	dbmi	%d2, .Lamark1
+	bpl	.Lsignal_nonyb
 
-	moveb	%a5@, %a4@(o_side)
+	moveb	%a5@, %a4@(.Lo_side)
 
-	moveq	#max_retry, %d2
-amark2:	tstb	%a2@
-	dbmi	%d2, amark2
-	bpl	signal_nonyb
+	moveq	#.Lmax_retry, %d2
+.Lamark2:
+	tstb	%a2@
+	dbmi	%d2, .Lamark2
+	bpl	.Lsignal_nonyb
 
-	moveb	%a5@, %a4@(o_sector)
+	moveb	%a5@, %a4@(.Lo_sector)
 
-	moveq	#max_retry, %d2
-amark3:	tstb	%a2@
-	dbmi	%d2, amark3
-	bpl	signal_nonyb
+	moveq	#.Lmax_retry, %d2
+.Lamark3:
+	tstb	%a2@
+	dbmi	%d2, .Lamark3
+	bpl	.Lsignal_nonyb
 
-	moveb	%a5@, %a4@(o_size)
+	moveb	%a5@, %a4@(.Lo_size)
 
-	moveq	#max_retry, %d2
-crc0:	tstb	%a2@
-	dbmi	%d2, crc0
-	bpl	signal_nonyb
+	moveq	#.Lmax_retry, %d2
+.Lcrc0:
+	tstb	%a2@
+	dbmi	%d2, .Lcrc0
+	bpl	.Lsignal_nonyb
 
-	moveb	%a5@, %a4@(o_crc0)
+	moveb	%a5@, %a4@(.Lo_crc0)
 
-	moveq	#max_retry, %d2
-crc1:	moveb	%a2@, %d5
-	dbmi	%d2, crc1
-	bpl	signal_nonyb
+	moveq	#.Lmax_retry, %d2
+.Lcrc1:	moveb	%a2@, %d5
+	dbmi	%d2, .Lcrc1
+	bpl	.Lsignal_nonyb
 
-	moveb	%a5@, %a4@(o_crc1)
+	moveb	%a5@, %a4@(.Lo_crc1)
 
 	andb	#.Lhr_crc_error, %d5
-	bne	signal_nonyb
+	bne	.Lsignal_nonyb
 
 	moveq	#0, %d0
-signal_nonyb:
-	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
+.Lsignal_nonyb:
+	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
 	rts
 
 	.global swim_read_sector_data
@@ -149,86 +154,86 @@ swim_read_sector_data:
 	moveml	%d1-%d5/%a0-%a5,%sp@-
 	movel	%a6@(0x0c), %a4
 	moveq	#-1, %d0
-	bsr	mfm_read_data
+	bsr	.Lmfm_read_data
 	moveml	%sp@+, %d1-%d5/%a0-%a5
 	unlk	%a6
 	rts
 
-mfm_read_data:
+.Lmfm_read_data:
 	movel	%a6@(0x08), %a3
-	lea	%a3@(read_handshake), %a2
-	lea	%a3@(read_data), %a5
-	lea	%a3@(read_mark), %a3
-	movew	#seek_time, %d2
-
-wait_data_init:
-	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
-	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
-	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
-	tstb	%a3@(read_error - read_mark)
-	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
-
-	lea	sector_data_mark, %a0
+	lea	%a3@(.Lread_handshake), %a2
+	lea	%a3@(.Lread_data), %a5
+	lea	%a3@(.Lread_mark), %a3
+	movew	#.Lseek_time, %d2
+
+.Lwait_data_init:
+	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode1 - .Lread_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode0 - .Lread_mark)
+	tstb	%a3@(.Lread_error - .Lread_mark)
+	moveb	#.Lmr_action, %a3@(.Lwrite_mode1 - .Lread_mark)
+
+	lea	.Lsector_data_mark, %a0
 	moveq	#3, %d1
 
 	/* wait data address mark */
 
-wait_data_mark_byte:
+.Lwait_data_mark_byte:
 	tstb	%a2@
-	dbmi	%d2, wait_data_mark_byte
-	bpl	data_exit
+	dbmi	%d2, .Lwait_data_mark_byte
+	bpl	.Ldata_exit
 
 	moveb	%a3@, %d3
 	cmpb	%a0@+, %d3
-	dbne	%d1, wait_data_mark_byte
-	bne	wait_data_init
+	dbne	%d1, .Lwait_data_mark_byte
+	bne	.Lwait_data_init
 
 	/* read data */
 
-	movel	#sector_size - 1, %d4		/* sector size */
-read_new_data:
-	movew	#max_retry, %d2
-read_data_loop:
+	movel	#.Lsector_size - 1, %d4		/* sector size */
+.Lread_new_data:
+	movew	#.Lmax_retry, %d2
+.Lread_data_loop:
 	moveb	%a2@, %d5
 	andb	#(.Lhr_fifo_2bytes + .Lhr_fifo_1byte), %d5
 	beq	1f
-	movew	#max_retry, %d2
+	movew	#.Lmax_retry, %d2
 	moveb	%a5@, %a4@+
 	dbra	%d4, 1f
-	bra	data_crc0
+	bra	.Ldata_crc0
 1:	andb	#.Lhr_fifo_2bytes, %d5
-	dbne	%d2, read_data_loop
-	beq	data_exit
+	dbne	%d2, .Lread_data_loop
+	beq	.Ldata_exit
 	moveb	%a5@, %a4@+
-	dbra	%d4, read_new_data
+	dbra	%d4, .Lread_new_data
 
 	/* read CRC */
 
-	movew	#max_retry, %d2
-data_crc0:
+	movew	#.Lmax_retry, %d2
+.Ldata_crc0:
 	tstb	%a2@
-	dbmi	%d2, data_crc0
-	bpl	data_exit
+	dbmi	%d2, .Ldata_crc0
+	bpl	.Ldata_exit
 
 	moveb	%a5@, %d2
 
-	moveq	#max_retry, %d2
-data_crc1:
+	moveq	#.Lmax_retry, %d2
+.Ldata_crc1:
 	moveb	%a2@, %d5
-	dbmi	%d2, data_crc1
-	bpl	data_exit
+	dbmi	%d2, .Ldata_crc1
+	bpl	.Ldata_exit
 
 	moveb	%a5@, %d2
 
 	andb	#.Lhr_crc_error, %d5
-	bne	data_exit
+	bne	.Ldata_exit
 
 	/* return number of bytes read */
 
-	movel	#sector_size, %d0
+	movel	#.Lsector_size, %d0
 	addw	#1, %d4
 	subl	%d4, %d0
 
-data_exit:
-	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
+.Ldata_exit:
+	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
 	rts
-- 
2.52.0

