Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899731354F;
	Mon, 17 Aug 2026 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931968; cv=none; b=OYhE1UlSU5F+hQtK2RGhpuu8r/NslxgP70gep1jt3URdSRjCXUV8P06CNhtRs4HbgIc6sBsEg4ac20SMuF9GkHXfxgIVLCTHiAyCgGhTydOQI2nM1MAIhSFX88KT7xLgxs/qteln3v7cIJeIvMNY3l8QPbQwjpbgILP8CecZGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931968; c=relaxed/simple;
	bh=JYVQf7fvkOCuD70ckUZ+Tee6mr6YFgeSoCDb6lseL1A=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=KKiUojvT4HAapiVimAjdJo6oa/+BEFEPP5WuriGXjnWVrGgC1srk6K8wUiOSa4wXVDw3+oZp8F9Fff0S9i8dAKJKDgiOg6caDE19WN8lnKjWQXsMpwrDhMkQROTJFX/Y5sdtycGRqFrcmFX0MvzWkF3A8iflqExQoXciLmYnKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mv+6PQx2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mv+6PQx2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C7DB2EC021D;
	Sun, 16 Aug 2026 21:59:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 21:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931965; x=
	1787018365; bh=DGXMdRF6S+MQtxWj5yA6UrDhKzcAAQ+/+Mg5sleoC6I=; b=M
	v+6PQx2vffMy5ECKgElbP4Rd/RvReXlC8U3TkKvgokigN7wkwUeyR/ti5TAsEKUa
	Wp4yJO8soyJRxSL7RY7Jw7D1kHwYNubQfWuR3ECCT4Gxg4W4y3nKqZqGT7u65ZqD
	bAB80Ga2lWGzAfqbIdKImRbx8Y7ohXT0JByElgRC1c1+U6u3cUse3clR+dQI97cX
	ZOFaZ9/4UIWgkgxAs4Uay2eedSVNIZ7jIrXJXwtpnpOQ6AldqLdoFzJV6WfADckm
	gTkN540Q81/OjLLuvpenlPT0pnXrf2qexsFXXPG62pPsiJD8EVPt1TkAoNaeginR
	GltYLDO0OVa1MHPuTw2Yg==
X-ME-Sender: <xms:_WqCaq65R1qyUDa20lZIwVr0hmnfffSZuIbqewuvAiEeiU2xRoxMCQ>
    <xme:_WqCat_CEUTSko7SrM9mX0Ge_lqBTkMBkun2CEcYxFfuu21Cc50e8sSU1iA-QtVf8
    Djvljhc_Rr9X_kUlM7neFSk8dG46fYuWvCvpkImiIf4bLjYGmZRWaL5>
X-ME-Received: <xmr:_WqCapWuEmwKYL5SwoILvXiVLWb0lEAKXD99EriHe0m8bqm11462qtDTUqOm>
X-ME-Proxy-Cause: dmFkZTEwVqJtQHEwNT59EY0ApYPfZBP0Ja94nLydKMHdJKlh4zUdbhZ4q8N1TJVlNLX3Jv
    UG9KBkDhcBzUW3289fayQ1J+ppWFRD446qIAFVyGuquh32EhwbVebEJGoODlbz4hP14Erq
    Tcjcfi9/5+2rPPMs1Rkxsj0k0e2xO2GH5lY4VVdKIG8VeU2vajU+FMxwg/fEJDgrz1L6RJ
    d1Tth/Mq5Cy68H4bxVP4faz7GKaqaQIynBu/2nSxBla0bgf41aEpoAjjJxWypL04u/vTxK
    x5WjWw0TaNT770B0rDvEjO+uKu7yRxr/X4qfgY6A9PKgCt1ahfj+WIbkeb4e64+QxwGFeX
    I/a70E8XKZ9xXPToGU9y/PQOq5Q3hyGTPt+U19pStskbaUwXw+jyTjWCR6BiUzvm4UbHrQ
    fQkAJ8719M9buy3cYJ/r/NYASuaAcoMTMpuySaZ8oIsAeyCB+RFlUR5iUiSsbXDdWT424W
    D+QT595HxkLGQ3xFnGafXj+6rrjTIPDMYH3t4Z4BczPTgexx+HsYqEcN+R/D4AcmKabZ9F
    4GgBVFnKBNZUdMw62oGZ5sfrX/tutWcCZWPt+iKLu/rywc20780PD+GKtAha7CXkgo5Dfo
    cZlJgRPI1JW4WJqaPCJkupRWrc7tWYXibx54AWDkNxdLBndz+ta8RCY8AEkQ
X-ME-Proxy: <xmx:_WqCaoouk4IvQRZegRcxkP9P4cm_x8J_nT0RDTs40EfmB4XcY0lFCw>
    <xmx:_WqCarmKP_vdbOomEe7wx3VoH4D-Y8bDNJKAN5uS9tbRAcb_neSO9g>
    <xmx:_WqCao1kJdY4VPXRyuxNZhqSBOLbQ11tkiAFrkRW3u8KVUBYH8lMfQ>
    <xmx:_WqCaoQMfeanBK5GJKWMSXVK3gGMdGnYS2svgEwW_nWjUjXc-F7AMA>
    <xmx:_WqCavoT_iLT2GyV7v_fqhexKMgf3J3-rk9stzidVN9oJpdHRTybgurD>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:59:23 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <771c797816910eac8e89646dbe35fc0604c64c5b.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 32/32] swim: Unexport global symbols
Date: Mon, 17 Aug 2026 11:17:10 +1000
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
index c78efc30082a..c3f1476948b5 100644
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
-crc1:	moveb	%a2@, %d5
-	dbmi	%d2, crc1
-	bpl	signal_nonyb
+	moveq	#.Lmax_retry, %d2
+.Lcrc1:
+	moveb	%a2@, %d5
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

