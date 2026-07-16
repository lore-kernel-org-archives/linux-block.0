Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532523FFFB5;
	Thu, 16 Jul 2026 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197338; cv=none; b=h+jSOxIyLk0hczVfbzkC0ra9Z1Ed2azvqVtsXgRhAMRD5Rx3DEnjQxAN45gyxcdD1GqpfuSmxzjBz5I56FEoHVQORsCD/d3hDgobB7r4V5BjCg2/NNDmEBgEm4hyS+3ArLvUMRD1/OVwKEQo58CUvt5emYLUNUbkw/Pb5NQ5B8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197338; c=relaxed/simple;
	bh=9Sk/8Y33jUUwUv80tZV3+GyisRWO71axDHZnKPXfco0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=qsn9hmR2ApbNYMOYDHl35h0yeUX2APnaHrIdWurbkPurzduNQGt/2cY+PXTehUqDxK2UiJtafby7+hVDW4MPX63HtJQZeHUQLOSS2/kY62TLcP1ufxhFRfvflpss/xIOWiwQb2H5Es61x0yfuuJoQPYwBmmcZF5yx+lO3VbbQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ERu7GDsW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ERu7GDsW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 900BB1400085;
	Thu, 16 Jul 2026 06:22:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 06:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197336; x=
	1784283736; bh=jelPQMyKH+0g7J1r4px75opxOoD7FFhLcKrX9pOu8BU=; b=E
	Ru7GDsWDqh71yulB8+iC79rL6hcfGugZ1uzFppj5Y03Ur7IXObVnBfNgj3VYX6dz
	8KEGwJ224FRc07b/IxavRlB4jAPh5VavkRdflhEdXbaFyONkKEgyLIiu5stcXsxW
	Q/ABxzLB/q02cBAdUJTcazbbydXINyrisujfgyiLDfQNyFcJhP/ucIWGs6PoHN4h
	ny58Qo0/HduCWTAN8v+xxRAdp0OGNrnrcr2elBBs0Q7ejMTASgwpp1PyRBF+iWm9
	jiQazcERf3xcR+d5PAAOoX9b/jqe86xaXK+AlHoiRH63TvppVygd5trYRpLdHAsv
	VH5bqzFXQWEU3l+UXxIgA==
X-ME-Sender: <xms:2LBYakUjQ88g5NTGiNhNYal7sCjCoyQvyJytXk57q5tZyC58e6pMFA>
    <xme:2LBYaipiLz2Y-P7NFjYsuldl_yN6Xew8gbay6TY3RP1JAXwRryxO7-1Q70A2BSmMd
    dxqI6M2ncNWvt7axBWEDO_azhWq8RuSb7XalFYXDIQBU3uYGnEtIAk>
X-ME-Received: <xmr:2LBYaoTj8P10r9p2pDKDRN9swldVetW1Eo5e_uhofSfEP-Wq4MEQh2JR-Wnnj0QDyE6Hm66cadM7wh5h5jGKK7MCCeYNGWgpLog>
X-ME-Proxy-Cause: dmFkZTEOlClH7n/bi5HDyQzhfwqMVD47uIRtmyPHquBAePV073lU7Iu6N9omnUZSHlbl8/
    ZzJ8hnn7xG2qKOVCkIPRYbxeQVJiiqPiovzpxYj68rnbqwTbNSHay/bCbsqa1gWCBYzEMH
    spLwBtoeDIGiCkEB2CDArh5tewbYvLglKwL3vbwadFKMDoyo4/3IddU2zxTvJQ0rtVm2Ho
    FXEc2vrHjVkc16nvpFINTtfIkJxfg/tz4xU6A3DtqtIgIpOs2l9jHf86fZQ85YafBB+QHt
    W/+z3G1Vw4j6X7nW/F/jtiZxafSrPdTI5SvkjH5u53lXT601BzZfhxZdtXRNaxJ8bBDcsC
    BUzV0FrC1hXCf3hyzlTfs1mmq/2JGv2IPxNk2NTyJDWQ0yyV9hgVp53BzpsmOT1X/65wZs
    O/eG2QzdOroTfK7OYHflQrLmmvDtPkjNSLYIkBJSD1FRfUrlOisnsRlsdVZ+vGG7bAVtTr
    hyegu5tw+LsHm7YgyI9jn3wqDyzyYSbi9ixnLa8S2dGl+PMWR4/xQDX4KwzSF1IniqwVyg
    1vn9jEWVrt0amfWgpzcY2z1NtWZVJfHLbPhM032yeaSoNzsEG7QH4ACOuH4TTCZZkTJYLZ
    GpluEyr/5IPgrwIdHD2scWl+7t7gHFe8x4BRWf6uy2T7ckhrmAWaJNml2jzQ
X-ME-Proxy: <xmx:2LBYak1yElDnKbuc3XHbyqCnvDb-q_sGS1bVNwX-hYC8A86sYNrrzw>
    <xmx:2LBYasCWFGPaeTSD6wCm9pwiUtdfQ1n3-fWruBGRp1naOxEYpc2V4A>
    <xmx:2LBYaojNHZ1THdOux4agSNTJIXxI9cuuRHbVp1_fiMDvgSoI2YnJBw>
    <xmx:2LBYamNB9z1ywIijuEbGwqxqcA8H9wiN-Ez6S4OUGmHcoCLeNPttsA>
    <xmx:2LBYavHPXOSd_GBnBTN_jTwbL-oC5Rfc7oORIKKveS8qp8t5tfyA9O3->
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:22:14 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <c88ebe0f2d3d51bdab346451442b69b206845792.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 30/31] swim: Define symbols for constants
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Define local symbols to give some meaning to anonymous constants.
No functional change.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 3d5ad525ccde..c17a25e1cd33 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -42,6 +42,10 @@
 	.equ	max_retry, 40
 	.equ	sector_size, 512
 
+	.equ	.Lmr_clear_fifo,	0x01
+	.equ	.Lmr_action,		0x08
+	.equ	.Lmr_write_action,	0x18
+
 	.equ	.Lhr_crc_error,		0x02
 	.equ	.Lhr_fifo_2bytes,	0x40
 	.equ	.Lhr_fifo_1byte,	0x80
@@ -70,11 +74,11 @@ mfm_read_addrmark:
 	movew	#seek_time, %d2
 
 wait_header_init:
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
-	moveb	#0x01, %a3@(write_mode1 - read_mark)
-	moveb	#0x01, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
 	tstb	%a3@(read_error - read_mark)
-	moveb	#0x08, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
 
 	lea	sector_address_mark, %a0
 	moveq	#3, %d1
@@ -136,7 +140,7 @@ crc1:	moveb	%a2@, %d5
 
 	moveq	#0, %d0
 signal_nonyb:
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
 	rts
 
 	.global swim_read_sector_data
@@ -158,11 +162,11 @@ mfm_read_data:
 	movew	#seek_time, %d2
 
 wait_data_init:
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
-	moveb	#0x01, %a3@(write_mode1 - read_mark)
-	moveb	#0x01, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
 	tstb	%a3@(read_error - read_mark)
-	moveb	#0x08, %a3@(write_mode1 - read_mark)
+	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
 
 	lea	sector_data_mark, %a0
 	moveq	#3, %d1
@@ -226,5 +230,5 @@ data_crc1:
 	subl	%d4, %d0
 
 data_exit:
-	moveb	#0x18, %a3@(write_mode0 - read_mark)
+	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
 	rts
-- 
2.52.0

