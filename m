Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6B3FF8A7;
	Thu, 16 Jul 2026 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197179; cv=none; b=buED6yzTjShAVncoQyPWDHwkT5sPIHCM45RxqrYktWgRoTeBsHClADavsur4irVxTHYVJHbfHzoxJQFYMOGHywNm2BPjtuUXQVX8qk21RxoWXJjINIVCRB3Gs4v5DQGH2n8L8ojeKtJEiLgaD3jXzsYRq2DAhDCS0meccnUKeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197179; c=relaxed/simple;
	bh=nl2dMaMd/YjSSmQZ1XOZL/2UWtRPGmaeMMrhtOCmpQw=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=JWThE/lnLRd5W6hDuWvNF4Cck4CE4br90mLj7VgvXhtROfiSTzuLQlq0esxE808rbG7QCdfUWtA4hAbk0WBH4T/PNTUQ/au/bvF9x+Ja6GCnZekzAqFPQUoQDuSEq10WUn2NMtK+5TXGXB8kkTyuZeO30IyCjmAu2cnPED7cScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUv+aE/L; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUv+aE/L"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 89A94EC01A7;
	Thu, 16 Jul 2026 06:19:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 06:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197177; x=
	1784283577; bh=7p6ECjfEtCTzs/4hVX5xdJb+UbIrStDYTZW5Fvekq6s=; b=l
	Uv+aE/LeYpP1qltw+qqseGmiYakpJK3SPxZIemWEVQpcrb8EkrrhCJ6nnmt8SEuX
	y7NTL3+ym2YywZtZqsjsCToJig8nhRebpaAvrpkVqcP8ekgGiZFPhhzFTL5yjDJ7
	rBbPLunmf3OeCioKAMaYS4HKBJqy0Q26xZmATVm+omQyRdKqpGJtjpha9KE8/a/4
	AmJKgPeiKUZlNo2k40hIkztie3WLo32+uNGiLuAfavSefjMf6F7ICRx5aaAD0RdX
	G+QZDPVu1cOQy4R3pSjZZk+DMbZuyEzcr1Wr15HU2YmVFuz9h2aeqMx06kFKNjcj
	BAeMiKTzRo0uunwiRgNYg==
X-ME-Sender: <xms:ObBYagyiuafjSop9y4Nx-7_I2e8uSdXU51Sl_XQ4uIqXWWKOw0WDYA>
    <xme:ObBYauUm_k5bR36o9EmwiwNk2K6TfuHkL4onIrX2D5TOP_4ALkqUIXEn8f4qw_uPM
    RPnE4LSNjJZs26cswb-f8FQXK-lAwbpO7s7JH-AbiIanbYjJkLpbKM>
X-ME-Received: <xmr:ObBYaiOpHt6bMzM6OJ1xTcexUhOYdxlqZtwtdop7ixct3431ItpARvvwDq40Gvfilm2CZdC83KxYIIRzrHz1SsVszga_Fhl-4sk>
X-ME-Proxy-Cause: dmFkZTGG1WvACauGCOcM2B/yAZpkq1Vfshyu2QdkuCaTyi2sZ9jSR+0WfB558P/2bXY/VS
    /l1qB5vOBeKryAVKalTeyJUIfvtabXWu6jrcr+2H4GTdkKYe+JptuUNZSpgysWilnbi/cI
    sZmyh8BTZ6v6ENSZtu53jhYH3SM34CEqAxNsBxf9Ka6lLw4wL4lL9lT0urxseuG9CEv5eY
    33qM/na2kwcAMv21ZzGCraLWHNsZgN3tpnlM1/9p2Rsfp21N3eEqO59FH0/QWPWVOpB9LB
    hdEYqoxU/QM2iWDyKRhDRXEHagteHtZBwABFHC9S3zIVHiSTxI0NLw74c5KnA+8au5ydXC
    r/cGVHr81NQud1ZJPtbpuY4wuai9ojMd5xBB00l4fOintLkOUykmLNow+6oDOSKvA2hQ8+
    PCDZvzRPgwnRrRCamOuVbPZZStve1Wb/DaZEGR4KpHCmu89vIBzrV8jzg9HGM8t6ayhzVp
    rKAYLRQQufhFyGBsq+RazYzDtxXyhJNZp8VplT+MvoOn/4hAW7LkBDW9/YI1NKNG5u7lJF
    cG3nekzPqY8Iq3y58PDvGgdxPowxyWj5Bl+NTlV+jAFFJ09ELquCPm4l12FQ/sx8kJn78p
    nYgoL+a4NhCTm0Du9JhseUioLmuOTr+E8IvKVpl9n08rEQMDXWeIXKKInpOg
X-ME-Proxy: <xmx:ObBYagBxsPPlIrQJD98WZZ69VXXIUopHkZTYg7sMagG2DUfMyzy_tg>
    <xmx:ObBYavfaMgfBdvq6XR0bg6iQkEV9N5LSNoX_QKv02vmKZqOQ2s3JiA>
    <xmx:ObBYavNC_kONj3A7pAAvFikuU2CutxT_cGhDHilK2otW48STtC-dAg>
    <xmx:ObBYavJhq_3HP-a691mgq5elWtxrG9TAt3C5DbsReZfu3z7n8fWzfg>
    <xmx:ObBYahgfFrYUb6L02ZrpCi6aFNiHzAV96GGwG8J1f2Mx6BLei9NVXGuT>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:19:36 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <27750f91f40f6a276d777a91fda3c7e0a17fa396.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 14/31] swim: Check error register during sector read
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Clear the error register only once before a sector read operation. Don't
clear it afterwards -- the caller needs it. Check the error register in
swim_read_sector() and return the appropriate error when necessary. Fully
validate the sector header. Don't terminate the search loop early just
because an erroneous sector header showed up.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c     | 13 +++++++------
 drivers/block/swim_asm.S |  8 --------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 9755b86d4dd4..e2a8c4ba4e39 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -483,20 +483,21 @@ static inline int swim_read_sector(struct floppy_state *fs,
 
 	local_irq_save(flags);
 	for (i = 0; i < 36; i++) {
-		ret = swim_read_sector_header(base, &header);
-		if (!ret && (header.sector == sector)) {
+		if (swim_read_sector_header(base, &header) ||
+		    swim_read(base, error) || header.track != track ||
+		    header.side != side || header.size != 2)
+			continue;
+		if (header.sector == sector) {
 			/* found */
 
 			ret = swim_read_sector_data(base, buffer);
+			if (swim_read(base, error))
+				ret = -EIO;
 			break;
 		}
 	}
 	local_irq_restore(flags);
 
-	if ((header.side != side)  || (header.track != track) ||
-	     (header.sector != sector))
-		return 0;
-
 	return ret;
 }
 
diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index f40e19e48021..1d394ee930d6 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -67,7 +67,6 @@ mfm_read_addrmark:
 	movew	#seek_time, %d2
 
 wait_header_init:
-	tstb	%a3@(read_error - read_mark)
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	moveb	#0x01, %a3@(write_mode1 - read_mark)
 	moveb	#0x01, %a3@(write_mode0 - read_mark)
@@ -139,8 +138,6 @@ crc1:	moveb	%a2@, %d5
 	andb	#.Lhr_crc_error, %d5
 	bne	signal_nonyb
 
-	tstb	%a3@(read_error - read_mark)
-
 	moveq	#0, %d0
 signal_nonyb:
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
@@ -165,7 +162,6 @@ mfm_read_data:
 	movew	#seek_time, %d2
 
 wait_data_init:
-	tstb	%a3@(read_error - read_mark)
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	moveb	#0x01, %a3@(write_mode1 - read_mark)
 	moveb	#0x01, %a3@(write_mode0 - read_mark)
@@ -190,8 +186,6 @@ wait_data_mark_byte:
 
 	/* read data */
 
-	tstb	%a3@(read_error - read_mark)
-
 	movel	#sector_size-1, %d4		/* sector size */
 read_new_data:
 	movew	#max_retry, %d2
@@ -232,8 +226,6 @@ data_crc1:
 	andb	#.Lhr_crc_error, %d5
 	bne	data_exit
 
-	tstb	%a3@(read_error - read_mark)
-
 	/* return number of bytes read */
 
 	movel	#sector_size, %d0
-- 
2.52.0

