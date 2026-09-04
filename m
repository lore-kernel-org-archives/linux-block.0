Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961C442B23;
	Fri,  4 Sep 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514535; cv=none; b=m/IF3appzQZW+nCC6vDjfvhRlOqwioT443o8TD8+syxJNWdlbCxXUeT/QJ73Yrvt6LOW/v/SuKDHVN5zaUEuX05u/coQbcxN4J9faaHwJ69s+C74mXkpqamO88/Qn72FLRiz/lQvcx/f7KKaIMiYVkwWYNy2Hl9iLJ8nP8ewK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514535; c=relaxed/simple;
	bh=FVv8MuAOVa/siSFGcZALAEpqHf+wpAWHaXLRjoPbDYw=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=n/Uo+elBLobPbk7f2/UR9638cL6SiJsmrpk8xvExn6yvjYoHXkerAdBZwuncfPuhK7uo5Tj1FtsDjs6bkDfsAbRwcolBGGgph8GlMuBtQ0ISCXbuequo3P5wp/LK23ARhsRB21y9uTetAtMHnxqtOUhh+u4XMOcqQBiqRxd470s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9x8ZOyv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9x8ZOyv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 98179EC0195;
	Fri,  4 Sep 2026 05:35:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 05:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514532; x=
	1788600932; bh=JE0iFEaDh3BOMKgrYEkNtZofOa8oDEbLKuZlxvRlVNQ=; b=c
	9x8ZOyv0I4jwBD94kbdvBCfLntepu4fZPUc0Pq6hsN8RydJcog0MhYnC3beurA+F
	SZwqiw5qRy5G8p8ir39PToXSdHVf2TfAu+2KtvkfMaQHx0VGq8QZi+nXqu74EzCV
	aBu+IzTbyPO2BCMb7nPreeUXVqvUY0U7fOadXxFCZv+BzPHoh3OGsWZ2LiFQ8H1T
	QvdqXeyuj6WAvfPjUk3+D56PmlR5Ym/N6b2T7XMEVZckG+3VY+gADpVdtsIJwyVq
	q7j0nRrSZ7NlVP5092ADWpLAum8tmsD0tdAg6PxGlUBVVT+Vcost271SDOumRXH5
	E2sbkOvA1VgRH0z/alliw==
X-ME-Sender: <xms:5JCaatAu_wjTG8K65VfsSxM3wYQIIuppyAXRJvlh9KwOzy5IKXcmCA>
    <xme:5JCaalkuw_L9x5rAL1K6ej25U0iXujkge_6R8PJXopSxv1Qww5oZU0GxUQf5NZqbE
    EFuLzpCU4sMjLkqTKLArbxdFrnnnTlPBUp-FCjoMSMHoC_Opc5RIplD>
X-ME-Received: <xmr:5JCaaocNpRSdWmrAlVEG9Q9Dt8H90opQHNKtpfIH642HlKPFhcHt9_LL9b8yRLlt97PuE5dwsYEAIWQrNhSsYa4tXyNiJiZFw0o>
X-ME-Proxy-Cause: dmFkZTFhdXECWRYw3tVnCHePo/zYY4j+SuKUMgx56WEOg7qs2HvwD7oQucaotLGfMUi33o
    hHC1FeDfKnZlrGeiVT5Mqj2UUIPon0Gt5+731VYDwOvjgTrP7e/NeimjpJFjueb4IrDvAr
    +pOYqyhHNLMPTSUFxcsFks9onV/NJ5Li73uXKQqsCWOwh15/PCfntwYAWO6qxWE4//IIji
    NXIbET797+0vRU6iZolh0J1ljXWBPxs9DJdtAnGbTYyaGB2RK4T0pkOkMLz9iNZPu981Se
    KVCYoyZiCUf1f50VzPbl3H6+Bi6lZQNpv+anj8bDUR38j6YWwDvcULGU7FSQ92mlG+5FDB
    MRcEpxLDwZ9Immus/sLlKJZT9PSbZLkk1qsREGaLktKpMuNwNpb51CBHF9QDIOSgOSw9nY
    F0IkEbxaEr0FGqTJPXFMW3fxMDj5YS0I2rU/uVApTKZfFTpS6k5orCwVIFRCgxwk56NEIV
    o9fus5184ydtRy9K9ejKQlc7v1QsqJ4zfZeJ14q2guu5796WSptaqTXo1gtngnse2CBlSY
    80kLViOPmMin98vF2FpfF0PE+8WWu0lcIZPRUEi1sYFPNITASfstn3OgVrE2u4rHQT6vTF
    dyTX67hE7IlEWHuD81qGk/H/U+RZbdxaNc3cde7s2V/pyQghqJrO4URZ59HQ
X-ME-Proxy: <xmx:5JCaapQHSy3ZQ51SE94xstw6P05NhDUzUPpx40NODCf2fmK8ipQsIg>
    <xmx:5JCaavvvvZniVrfoRst4dQFS9XOn9z1atQlo-m9wy2jyj5YXqDxD2Q>
    <xmx:5JCaaqfNx3W87ZddauHdrRAI37lXfocoIyGhYY8wXh7ij34tieJMCA>
    <xmx:5JCaapYoCTmvNi4TzZTFh_WbLCFRsjhbUjrTwAkJuv_V7AdhguIzmw>
    <xmx:5JCaalzW67BmWXsEYtFxsLuoo01Ea5Q36NCrCMsKpOdkIeIV8u5Ikpyv>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:35:30 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <f6c97153faa0aceceffd3a61d85c0a82903a6b3e.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 25/33] swim: Don't search beyond the first data mark
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The ISM chip does an automatic MFM gap/sync search when the Action bit
is first set. That search may stop at any of a) post-index gap, b) address
field gap or c) data field gap. To find the next sector header, the
driver need not search at all. It only has to validate the mark bytes.

Once the sector address mark has been validated, swim_read_sector_data()
is called to read the sector contents. Between the sector address and
data fields lies an intra-sector gap followed by a data field mark.
After this mark is validated, the 512-byte data area is read into the
IO request buffer.

Problem is, if any byte in the data field mark is mis-read, the driver
searches the whole sector and then reaches the data field mark in the
following sector. The wrong sector is then read into the buffer, and
swim_read_sector_data() returns success. The request is silently
corrupted.

The existing limit on polling loop iterations does constrain the search
distance but is inherently tied to CPU speed. This is probably the reason
why corruption was only observed on a 68030 system.

Discontinue the mark search when the mark bytes fail validation.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 73 ++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 73d5ced1abe3..241088b12829 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -41,18 +41,45 @@
 	.equ	seek_time, 30000
 	.equ	max_retry, 40
 	.equ	sector_size, 512
+	.equ	.Lmark_sequence_len,	4
 
 	.equ	.Lhr_crc_error,		0x02
 	.equ	.Lhr_fifo_2bytes,	0x40
 	.equ	.Lhr_fifo_1byte,	0x80
 
+.Lmfm_mark_check:
+	/*
+	 * This subroutine reads and validates a mark byte sequence.
+	 * On entry, %a1 and %d4 shall hold the location and length (resp.)
+	 * of the mark byte array.
+	 * %a2 and %a3 shall hold the locations of the handshake and mark
+	 * registers.
+	 * Returns zero in %d1 for success.
+	 */
+
+	moveq	#-1, %d1
+	subq	#1, %d4
+	movew	#seek_time, %d2
+
+5:	tstb	%a2@
+	dbmi	%d2, 5b
+	bpl	6f
+
+	moveb	%a3@, %d3
+	cmpb	%a1@+, %d3
+	dbne	%d4, 5b
+	bne	6f
+
+	moveq	#0, %d1
+6:	rts
+
 	.global swim_read_sector_header
 swim_read_sector_header:
 	link	%a6, #0
 	moveml	%d1-%d5/%a0-%a5,%sp@-
 	movel	%a6@(0x0c), %a4
 	moveq	#-1, %d0
-	bsr	mfm_read_addrmark
+	bsr	.Lmfm_read_header
 	moveml	%sp@+, %d1-%d5/%a0-%a5
 	unlk	%a6
 	rts
@@ -62,33 +89,25 @@ sector_address_mark:
 sector_data_mark:
 	.byte	0xa1, 0xa1, 0xa1, 0xfb
 
-mfm_read_addrmark:
+.Lmfm_read_header:
 	movel	%a6@(0x08), %a3
 	lea	%a3@(read_handshake), %a2
 	lea	%a3@(read_data), %a5
 	lea	%a3@(read_mark), %a3
-	movew	#seek_time, %d2
 
-wait_header_init:
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	moveb	#0x01, %a3@(write_mode1 - read_mark)
 	moveb	#0x01, %a3@(write_mode0 - read_mark)
 	tstb	%a3@(read_error - read_mark)
 	moveb	#0x08, %a3@(write_mode1 - read_mark)
 
-	lea	sector_address_mark, %a0
-	moveq	#3, %d1
-
-wait_addr_mark_byte:
-
-	tstb	%a2@
-	dbmi	%d2, wait_addr_mark_byte
-	bpl	signal_nonyb
+	lea	sector_address_mark, %a1
+	moveq	#.Lmark_sequence_len, %d4
+	bsr	.Lmfm_mark_check
+	tstl	%d1
+	bne	signal_nonyb
 
-	moveb	%a3@, %d3
-	cmpb	%a0@+, %d3
-	dbne	%d1, wait_addr_mark_byte
-	bne	wait_header_init
+	/* read header */
 
 	moveq	#max_retry, %d2
 
@@ -163,30 +182,18 @@ mfm_read_data:
 	lea	%a3@(read_handshake), %a2
 	lea	%a3@(read_data), %a5
 	lea	%a3@(read_mark), %a3
-	movew	#seek_time, %d2
 
-wait_data_init:
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	moveb	#0x01, %a3@(write_mode1 - read_mark)
 	moveb	#0x01, %a3@(write_mode0 - read_mark)
 	tstb	%a3@(read_error - read_mark)
 	moveb	#0x08, %a3@(write_mode1 - read_mark)
 
-	lea	sector_data_mark, %a0
-	moveq	#3, %d1
-
-	/* wait data address mark */
-
-wait_data_mark_byte:
-
-	tstb	%a2@
-	dbmi	%d2, wait_data_mark_byte
-	bpl	data_exit
-
-	moveb	%a3@, %d3
-	cmpb	%a0@+, %d3
-	dbne	%d1, wait_data_mark_byte
-	bne	wait_data_init
+	lea	sector_data_mark, %a1
+	moveq	#.Lmark_sequence_len, %d4
+	bsr	.Lmfm_mark_check
+	tstl	%d1
+	bne	data_exit
 
 	/* read data */
 
-- 
2.52.0

