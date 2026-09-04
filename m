Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCE442FCE;
	Fri,  4 Sep 2026 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514443; cv=none; b=Q8UM3kBcUkk9ioSk04ti1VDUhGDe20xrhTGxBgDCj3i9XDi6L7c0MZGIcpB/vDFeFz/l6AtOBuS+4ewvYauGojh9kXwGDzHYsfLdSma7Tnm/PVxFHp29aYSaR9sZHw/KqPAcEICy2aw/lIfF+i1U+ul9ikX+lZ9y9GT7gHyYvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514443; c=relaxed/simple;
	bh=k42Tk6MTlkTssMZgPfZFgNk1ma+plDP0aOeZ8315Bt0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=qgJ68/HMoo91PaXGLU5KLyjl1Kg6Llovj5n4qjAdaIly0N3D+2mgAryCCsm5vTAT6k51msdjGqtRIpI6lHajk7o5yz9P72ss1Jdseo4OjAZtPdiXumdl4P6V0EloodzZYvArTA3E+l0VaKUOL98c8r278/d5bnKs+0f89G44Ys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t79qdFIA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t79qdFIA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 90FF8EC00E0;
	Fri,  4 Sep 2026 05:34:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 05:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514441; x=
	1788600841; bh=3/k6GW9Rf/OFdG6HQrf0fhr84k9b4329t4mbYPbl/fI=; b=t
	79qdFIApJPStedp80wkwp768tMf4YIll8R2+nmRXX2TZz2mc1mkWeEwsosGXhnJo
	d8mTOFXT5RVwnpZrhEO+KyyFS3YyhIflE6QEf6UPfedS5PrXrFILM/DmFUGtgjSq
	2B66SV39Gbnl54Gqnzkti4hj8lEDeMgxp6reG2J9HlTJ5XVAGSpDAvT6gTmjIxFT
	WDPJqkNjV5Ngby5Lrik0PUvxIz8Zg5DZpMKuPV/acvuuPzHwNdnMMlLy7mMvW/Gp
	xBWnwrdq8uTUsG+v+RNvqDpkbqaD7HhBXRciYS8rBDM2i8aFPiSteTyu2u7rTvi5
	vPSy+6xsuKWhd8Kr8gMdg==
X-ME-Sender: <xms:iZCaajA3Mgh_KG7-_mEVWOlqaQIMRFna10HrR6Ib-wVxqMaMsjdMWA>
    <xme:iZCaajn_g23IOo_vTNEvHD_L9w1z9jsbk3m1LmMAoJBQ1Tgpk4JtY-qFrbHkQ7Efg
    h01nhGeXIMOo4rb8_cWfSYs9oMqG4Z1b6eJizX4ZANepTrX_hgPu1w>
X-ME-Received: <xmr:iZCaauc852Iq2wWi-tup4_VAthJiJRhQymmuu_WlNKReCFP6KvJefynfgdQEC91e9oQRGoMVtqqhASgXZkgS1BWyBbaC7QW8r28>
X-ME-Proxy-Cause: dmFkZTE/Rtk6l3I9tqvKoBpTJTveLUphHYcAK1aitBUQpDNIkosRB8EZMISuuCMYAipC6D
    +/RTzVL2d8a+m6Bc5TLrlQP47Nx+3FOLDvdMZZODUHaNQCGx6Jl+5UqsvedKuq/7/WUY04
    OmEz+pLiYAf9GcyLmpfzp0aVKrXxd+9inPzR5hoQc0Z3i9dss0KA+I7vBV2rZxbdxVflTp
    xLONIFohUrs/qTWq43lfJzhGtby2UyWXImtl6Q7ZHyI+A0TXzowQGCvI570zM+3ljALuqE
    7N56HcamhyVJ6EIMvw6h3IZoA3f+em6U6oCLhwkvVheXLFnUHBZ2gdnuYSSZDXmPlOummp
    LXmCop1wfWL43P0SZAFCGA9gCr6wc1W5qJKSCs+Kn8MbIGBUixrlX9RcDl1ccQPFxWR+zG
    MXTBghguvoC9Zm4lyxrY0s3S7slBYdFGiv40Km5faLxmBsmJPioE1+z1CpVfUIz1Y+wLhi
    CpAD+g1n7KaTuaUwTqhImGXEAe4FWjwq3C+U4jojZsajZPQbs0nCy8GXFXaSe+pFIqIshW
    p5GCLbxePCtUzayCcQgBC7Hbf3Q1JELArbbVvI0fmIrv2mz2PZA9v25FnAlSEYgUKAmmVm
    fRNY2uzuMf+dLRO0ZKkWgwa/SXfc7ufmKJiHF63Dh/8FWMyCrJXgYr4S/nYQ
X-ME-Proxy: <xmx:iZCaanRzieKxbaWUjy4PGlcgVoo44RxK5dku3VPrnZH91J0rzzpXzQ>
    <xmx:iZCaalsevYwhWKdmUSwV-nzlTbm7np32C5WaBDHuR8NyThBOHbzlJw>
    <xmx:iZCaaofMmDBUMJEPseqPF5d0r7V-XpHk4LxWIYnFVm8Ch2iDzCkaWA>
    <xmx:iZCaavbtgr_1sW0gDfojLCmj3PeZ4uLjaUeSCXiBZhaSpYomVeLtDw>
    <xmx:iZCaarya0HqTCjT2VJAvFaMSnTdWEadKOq4tEY4XSrFX4j-H4TaUIhBj>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:33:59 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <d8fceda197b840f892d9b511175e824ca2549f01.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 17/33] swim: Fix buffer overflow
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The effect of this bug can be observed as swim_read_sector_data()
inexplicably returning -5, or an error flag indicating that a mark byte
was read from the data register, or other odd behviour.

When copying bytes from the chip FIFO to the read buffer, the driver
keeps count of the remaining buffer space using register %d4. A counter
in register %d2 serves as a timeout. The driver polls (%a2), the handshake
register, until flags indicate that byte(s) have arrived in the FIFO.

        movel   #sector_size-1, %d4
read_new_data:
        movew   #max_retry, %d2
read_data_loop:
        moveb   %a2@, %d5
        andb    #0xc0, %d5
        dbne    %d2, read_data_loop
        beq     data_exit
        moveb   %a5@, %a4@+
        andb    #0x40, %d5
        dbne    %d4, read_new_data
        beq     exit_loop

Note that the exit_loop branch depends upon a flag in the handshake
register and not on the remaining buffer space. Hence there may be no
branch to exit_loop after %d4 is decremented to -1 (i.e. full buffer).

        moveb   %a5@, %a4@+
        dbra    %d4, read_new_data
exit_loop:

Here is a second decrement of %d4 which can now reach -2. But the buffer
bounds check is a comparison with -1, which is now ineffective. Hence the
loop will continue copying until %d2 eventually reaches -1.

Fix this bug by terminating the loop as soon as %d4 or %d2 reach -1.
Reset the timeout whenever a byte is copied.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Avoid jumping to a redundant AND.B.
 - Avoid a second handshake register access when there's already a byte in
 the FIFO.

Changed since v2:
 - Dropped reviewed-by tag due to unreviewed changes made since v1.
---
 drivers/block/swim_asm.S | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 699f7c90dd1c..e06aadb411a1 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -43,6 +43,8 @@
 	.equ	sector_size, 512
 
 	.equ	.Lhr_crc_error,		0x02
+	.equ	.Lhr_fifo_2bytes,	0x40
+	.equ	.Lhr_fifo_1byte,	0x80
 
 	.global swim_read_sector_header
 swim_read_sector_header:
@@ -189,20 +191,20 @@ wait_data_mark_byte:
 	/* read data */
 
 	movel	#sector_size-1, %d4		/* sector size */
-read_new_data:
 	movew	#max_retry, %d2
 read_data_loop:
 	moveb	%a2@, %d5
-	andb	#0xc0, %d5
+	andb	#(.Lhr_fifo_1byte + .Lhr_fifo_2bytes), %d5
 	dbne	%d2, read_data_loop
 	beq	data_exit
+	moveq	#max_retry, %d2
 	moveb	%a5@, %a4@+
-	andb	#0x40, %d5
-	dbne	%d4, read_new_data
-	beq	exit_loop
+	dbra	%d4, 1f
+	bra	data_crc0
+1:	andb	#.Lhr_fifo_2bytes, %d5
+	beq	read_data_loop
 	moveb	%a5@, %a4@+
-	dbra	%d4, read_new_data
-exit_loop:
+	dbra	%d4, read_data_loop
 
 	/* read CRC */
 
-- 
2.52.0

