Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388545C613;
	Mon, 17 Aug 2026 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931890; cv=none; b=M3Ym+1IqPWrcAwaeA204ZjdQCRbDVnjTlQWWyzUQ7hBkTYTKuSnM7RnUfcGIwpv7AEYUMH2XXeRk0kHgZtS5O4q0Qyr0jWltlS5bPIcb/RMGObfx+TlM7WRIwbp9A/3a6yD5LlBOHf26ZA+utNoFx+qZikRXC4KShWX0H8urjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931890; c=relaxed/simple;
	bh=Tg04qOzKzTL+yoyCwQO8PkeL32EGkM6VPDNoy2V0pnc=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=JJKDCgPMaMjfA1YKVSIEKP8SqJcIVd5o2ycGl969YzRTLbH/7qfr1aBhBtSRq7K9JwMBoevCchvhpbjBbeUD+WRhgKEy2wGI8nkQwaaAgv/kyFk62pDn/vK6tZ3x5YT/375oQajXBLOuqLC4gLPwG75B0pIQ5Al6BwA7xPbAbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImTXONqg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImTXONqg"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A4DEEC0203;
	Sun, 16 Aug 2026 21:58:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 16 Aug 2026 21:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931888; x=
	1787018288; bh=Ab7YBYirSafQd4LQ1mw+KQsbUndvGvyNf+gBAVQA8hw=; b=I
	mTXONqg8drQ1zc49H0GWXPALfElIv6jFNJnYIIznxfSfIB1np+R1MwIvUx0mUf4R
	03/PgtT1mWOtU40dUYsC1fU9Ffj0wsd0jGynB5WeTH3KfRuVXP09hIh5h0UG3R9b
	Jj7exr0dDn6oBmNBV5UhCSb++vI+kisUVxadXuTl6eQTTbNOQqSoQn765qKqAPD4
	EoiQ4iJr/Py86oOA5PQbvNQAzulOAqic+gFxEBsBbKio3Way5nDWgu3jqMieTyrk
	Dxd2tFVsqctvv0srOBRnqEw+c9I2icxOri+kVHO6r/ZzGl64vLIr9j3Of0Kc6RbU
	C4svRqDItUQp5v3DUAUWw==
X-ME-Sender: <xms:sGqCaglhLR68UlmTXxkY9-K8iawKGS0Azks-yZmbQgMSjY6qDHttJA>
    <xme:sGqCap7GGTO6a5pdCEYqo-MmjBYvUSCf5BvBt5d6cxd3Ip4An50tc02ahloLLmel-
    wYQcnwVzuem1w9J8MWuhBxBmiIQhxCzNdWdM-twwyS7IANcH33pFn8>
X-ME-Received: <xmr:sGqCaujg7Xsgov5JdH7mcuUTqHviwSntODv05b7Z7uuPQPdSwGZWiSKLF8Tnpb-XfmLkwhZ1Cp933dTHEZod7hnK5fZmnmzGbhY>
X-ME-Proxy-Cause: dmFkZTEwVqJtQHEwNT59EY0ApYPfZBP0Ja94nLydKMHdJKlh4zUdbhZ4q8N1TJVlNLX3Jv
    UG9KBkDhcBzUW3289fayQ1J+ppWFRD446qIAFVyGuquh32EhwbVebEJGoODlbz4hP14Erq
    Tcjcfi9/5+2rPPMs1Rkxsj0k0e2xO2GH5lY4VVdKIG8VeU2vajU+FMxwg/fEJDgrz1L6RJ
    d1Tth/Mq5Cy68H4bxVP4faz7GKaqaQIynBu/2nSxBla0bgf41aEpoAjjJxWypL04u/vTxK
    x5WjWw0TaNT770B0rDvEjO+uKu7yRxr/X4qfgY6A9PKgCt1ahfj+WIbkeb4e64+QxwGFNi
    W1LsbbiikYkHQOcqnEuOPXcB9b2PJedzLa7Af10YusxjecRNJeO/UHzkzu1OZ8a1M2HJ7A
    5OlWP/+mYxjhuF9ogldempGmg4oyiqeThEP6rXu5abMInp6Pyyzz9RAYZtQDKAqfdIfMv3
    jSq7jctbNEMqL2C6g8bFpbVTXY0Qcs5Vpidfpkhoo3k6I0e391fF43C/JWX0d0i5K7E4it
    3ONjX1ztdQghscvgFLHGd+PyRvVKWP6Sul1XzcyU4QnlNDx9irTrLpnPzRAoTwClRAO9/C
    SJ355aYyg5r2t00wowaMd2E3Bu/as1HZqad6+mwB5HuaJi5FZCHqLBeW5uEw
X-ME-Proxy: <xmx:sGqCauEtopBLNEOysWsuMumFlLEsnNWHuG4PU3UpPPW5pcsTjgj5uA>
    <xmx:sGqCasRsPkd3NYKuyeNXUTZ2Vcwgk00UvG0smuMhwIRRRExtThh2kA>
    <xmx:sGqCajyF5RzFT5ybjrD2GwDdTiXB-0vjVHXhVHLqWiYRRIrnuWEmkA>
    <xmx:sGqCagcx_Ibj0KEyZJlmBp2Q5TryRuBvWQH-_xWkrN9kmuAJLksaIQ>
    <xmx:sGqCajXY0YsM1qvNBaXvAy_axO8hfix4SJYR1BqlwYsKQlugc96j4isL>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:58:06 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <424125c0edf495ccea123ab062b9501ebc5ed06e.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 24/32] swim: Don't search beyond the first data mark
Date: Mon, 17 Aug 2026 11:17:10 +1000
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
index 10f4c42ee3ab..4913470b63e8 100644
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

