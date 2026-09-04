Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2F450409;
	Fri,  4 Sep 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514614; cv=none; b=cArEu8y3BKt4SG+2ulQV5PVeQexVJXkybJ8ZO6lCnqVvx88MhRW6uNch1h3htBM588aYYxXuPec2Vvjo0V5wJF6dyaJgvCD/VYQaCAQaTgKd2xt670X8q3lIPkjelahkGnQ6T8RSluLmBMUiRmdRF0sZkL6jh8nC0n8lpqFeWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514614; c=relaxed/simple;
	bh=D7wrCCZ9JI5Cjc6MxSR7qNaRHAJnB4XNcHilwtnBemA=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=HLB3PMj7EcCKjB0sd+LaelRMfliCynrmnEmO8Iyw6w7eRXDI+kevuJ0UWBDvIMyomytM+kD1oN1lamFuFHOZAsVjgySd7hHoGKwinmSpgtp8FI3nW8AaVUgZOBhVg8CZNKkzILdtCjOumboYzW59U/qaodqMLBFaZeDatuIN9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tiGoHCCB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tiGoHCCB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D609140008F;
	Fri,  4 Sep 2026 05:36:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 05:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514611; x=
	1788601011; bh=iXrazyCh/11Z12ZzetWRHxSxQdJ0JtLx7eEGdovmzZg=; b=t
	iGoHCCB6tSRU+np/TK/r9nnHXJxvGnpZtQjL71T3Fw934Z+5OiFjRg9qOi7FFQuG
	0lMqijlW1XqUhXvd5v2ln/yzT0o7Ri8Rb+Ue1h39JcqYpX6Vtcx9MVKFCdie4qaJ
	b++zovDuIrxGE4/lSXV0DYS63iy36u3kFKQXhSzrY8el7ThEKrVuqIpB2I5K/Ttn
	wlqKomxxosdPDGrhXvsVmPHML9zcSfw8odoFO2pbAQDKFsova/FyT/BK0azIP9i6
	NiGnWO7zlpacGxZTRJnKKitotslb7rvUTjL+cXwGSiHufTJaukoNmlNsBEzrDOqX
	I77SUKLbaqbLLnAfSGkbg==
X-ME-Sender: <xms:M5Gaao_1Pu4VVAl8e5Mc-2E3UDczjS0B4blPvUxho2RqwFXjk1QQ2w>
    <xme:M5GaaqxnjrW1Gh_nVTqbZdzreqodAn7fF5JSXvexSxMSdgkk4z9oTsXcfDnWABClw
    FuFI5_4i97KHiHHvQ7APQkJ6u2D2X2gmWgyPHb82UFXqqdTqkzMe7i7Gw>
X-ME-Received: <xmr:M5Gaat4HMW0nRKIz03ZBtygvBeB7zV_KlLWLc1K4KrcJOGBL-bKG9mgdvUCStEuOKB1JNn3nYb9cdcDWz7INLz59fgsgcePaX7o>
X-ME-Proxy-Cause: dmFkZTES4bQ21oAzpNnp51xfFHSMQBPKtrMCV5iYYMBFJYMMGuku2wDZqHLDhf7MMkpQep
    sMe4CyNnIEY4dUJg6qGIApiDz7xq7NkSCScmKgrMc4345BLDBaaFf6c8TLqowSoQSjBNao
    tQAjHxJbuqzVv3VzZRZEacp4FA41Q9OcL5NDtbJMFMDUCcPGJR7zU6OainbhxZYK3NU11B
    Fa2x5PyGrJHtwPQxOc1oyHJXrbM2nyqpGGOSM3yceNTB7ODw+A07JKEQZT40T9t1sfxdOY
    Z+GEWRwgrC3pQuxmclLHPwxPnQJ8sX9Nh9G6tEyIm0Ldv+rMccWy5ZFRy0U8vBhf8uuzNN
    F2WMe0qRthExh6TdZPXb3m3FXkPtbpCwwYVznaBjm+aHyhdUHHA+ea1LtPr2OIDxKEp5kI
    +aqLRWwKTd3fklpa4rRueC2sMUZFZLLANbgQWQJI0EUnzxpRNawV59emu24A3EzZyCbV2Q
    CI36VPDhleCyTt9ibFBm3KJCRW9VSGuMQgwOC4EtWYtmX+moho1B3xbJDDsB8NtH07TIE2
    3FQhpuG9C3Z3i+jT8MDQJI+xvleWX1akNm8f756bxpGrvCfzfolq36bbCwkqnkW+fRiCao
    3QnFqxGA1IAwJwBD06JQPS7T2maDgF23F0MN3JLWWcP62vUbxYmALTit0R9Q
X-ME-Proxy: <xmx:M5Gaap_IAt4Bk_gbsFhUo7RJ-pkHQKdZucP_ZtIog6G1j2OKMC2qKA>
    <xmx:M5GaaqoDj29JhsxMxzCk5Z42H3eyv-9JboR_TAjd3Yf7-AdQv-_Dzw>
    <xmx:M5Gaaipp0D4wXHCFSVg7u_VMSOXVNu8fIO9cMqFOSI7Vyj_-ZW1d3Q>
    <xmx:M5Gaal0RL4SNX7cks8My9-xFmTpbKJZO7h_0-WBFF2VaAI6lgrAtVw>
    <xmx:M5GaansIPW-A_cY74kObEMF8SzIykrVgs4liA0bhv4amEQgo-MfZyECn>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:36:49 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <0810de0df2a670d4d9ccad4e747be2c4b46f6d6e.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 33/33] swim: Unexport global symbols
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

These symbols aren't used outside of this file so use local ones.
No functional change.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 218 ++++++++++++++++++++-------------------
 1 file changed, 112 insertions(+), 106 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index a1879cfaa6f4..489512a0f561 100644
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
 	.equ	.Lmark_sequence_len,	4
 
 	.equ	.Lmr_clear_fifo,	0x01
@@ -63,7 +63,7 @@
 
 	moveq	#-1, %d1
 	subq	#1, %d4
-	movew	#seek_time, %d2
+	movew	#.Lseek_time, %d2
 
 5:	tstb	%a2@
 	dbmi	%d2, 5b
@@ -88,80 +88,86 @@ swim_read_sector_header:
 	unlk	%a6
 	rts
 
-sector_address_mark:
+.Lsector_address_mark:
 	.byte	0xa1, 0xa1, 0xa1, 0xfe
-sector_data_mark:
+.Lsector_data_mark:
 	.byte	0xa1, 0xa1, 0xa1, 0xfb
 
 .Lmfm_read_header:
 	movel	%a6@(0x08), %a3
-	lea	%a3@(read_handshake), %a2
-	lea	%a3@(read_data), %a5
-	lea	%a3@(read_mark), %a3
+	lea	%a3@(.Lread_handshake), %a2
+	lea	%a3@(.Lread_data), %a5
+	lea	%a3@(.Lread_mark), %a3
 
-	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
-	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
-	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
-	tstb	%a3@(read_error - read_mark)
-	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode1 - .Lread_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode0 - .Lread_mark)
+	tstb	%a3@(.Lread_error - .Lread_mark)
+	moveb	#.Lmr_action, %a3@(.Lwrite_mode1 - .Lread_mark)
 
-	lea	sector_address_mark, %a1
+	lea	.Lsector_address_mark, %a1
 	moveq	#.Lmark_sequence_len, %d4
 	bsr	.Lmfm_mark_check
 	tstl	%d1
-	bne	signal_nonyb
+	bne	.Lsignal_nonyb
 
 	/* read header */
 
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
-crc1:	tstb	%a2@
-	dbmi	%d2, crc1
-	bpl	signal_nonyb
+	moveq	#.Lmax_retry, %d2
+.Lcrc1:
+	tstb	%a2@
+	dbmi	%d2, .Lcrc1
+	bpl	.Lsignal_nonyb
 
-	moveb	%a5@, %a4@(o_crc1)
+	moveb	%a5@, %a4@(.Lo_crc1)
 
 	moveb	%a2@, %d5
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
@@ -170,80 +176,80 @@ swim_read_sector_data:
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
+	lea	%a3@(.Lread_handshake), %a2
+	lea	%a3@(.Lread_data), %a5
+	lea	%a3@(.Lread_mark), %a3
 
-	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
-	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
-	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
-	tstb	%a3@(read_error - read_mark)
-	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode1 - .Lread_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode0 - .Lread_mark)
+	tstb	%a3@(.Lread_error - .Lread_mark)
+	moveb	#.Lmr_action, %a3@(.Lwrite_mode1 - .Lread_mark)
 
-	lea	sector_data_mark, %a1
+	lea	.Lsector_data_mark, %a1
 	moveq	#.Lmark_sequence_len, %d4
 	bsr	.Lmfm_mark_check
 	tstl	%d1
-	bne	data_exit
+	bne	.Ldata_exit
 
 	/* read data */
 
-	movel	#sector_size - 1, %d4		/* sector size */
-	movew	#max_retry, %d2
-read_data_loop:
+	movel	#.Lsector_size - 1, %d4		/* sector size */
+	movew	#.Lmax_retry, %d2
+.Lread_data_loop:
 	moveb	%a2@, %d5
 	andb	#(.Lhr_fifo_1byte + .Lhr_fifo_2bytes), %d5
-	dbne	%d2, read_data_loop
-	beq	data_exit
+	dbne	%d2, .Lread_data_loop
+	beq	.Ldata_exit
 
-	moveq	#max_retry, %d2
+	moveq	#.Lmax_retry, %d2
 	moveb	%a5@, %d3
 	bsr	.Lmaybe_store
 	dbra	%d4, 1f
-	bra	data_crc0
+	bra	.Ldata_crc0
 1:	andb	#.Lhr_fifo_2bytes, %d5
-	beq	read_data_loop
+	beq	.Lread_data_loop
 	moveb	%a5@, %d3
 	bsr	.Lmaybe_store
-	dbra	%d4, read_data_loop
+	dbra	%d4, .Lread_data_loop
 
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
 
 	moveb	%a5@, %d5
 
-	moveq	#max_retry, %d2
-data_crc1:
+	moveq	#.Lmax_retry, %d2
+.Ldata_crc1:
 	tstb	%a2@
-	dbmi	%d2, data_crc1
-	bpl	data_exit
+	dbmi	%d2, .Ldata_crc1
+	bpl	.Ldata_exit
 
 	moveb	%a5@, %d5
 
 	moveb	%a2@, %d5
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
 
 .Lmaybe_store:
-- 
2.52.0

