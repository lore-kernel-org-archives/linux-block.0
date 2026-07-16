Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CE3EFFCC;
	Thu, 16 Jul 2026 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197188; cv=none; b=QqL3FwewKi583HIb87Qq43YGDKppLSOOQfDoqx7UdJHMosuXrn2z04FkRirgvBc5AWxqoxiT+sguKuNWzvgovqE7NqL8BeivKJa+Znju3eaSeEiFthRAXXAicSA0w1vJpcTenvpleDkep5HqwqDJLobPvv6bViVIC6HfyL4Wjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197188; c=relaxed/simple;
	bh=28sPx2/VdPxny+rts4Y+F1rstcs3ZnaqGUGlCJy4Z6w=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=LhGFzh+UxtigT9HFBZEL3n6wsU8bFgDTVtM9Fm7vfWH2ekgD9s+AippHEpB/WKn1+byZraPJx4hg+3DQoD2QQeUnbEX1W7uQXkYeLRzfycQJqt6rmjcmSuWDid3QcQ7vTsYjYgUoozAOE2UTnDo0f0lFI8b2EsAe2+YB5jFuaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EkMjweXs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EkMjweXs"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F89714000F0;
	Thu, 16 Jul 2026 06:19:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 06:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197186; x=
	1784283586; bh=U/M5fArIIEJ8euDWuVbZOk3s90KZ9YDhqpJ+PSL+XCQ=; b=E
	kMjweXsAmOyHZLpZK2UQOyHJvYnM+BH++8w2h3byoedJZLONYz8mJXLJphc0P25Z
	6+qG5OyQ+C02iw05DRRtiSbAsY55pt8O+1kf90x1pPd4Jj5BIuvv0WRC7HiCBO3M
	lrmCBpXrB3IlsughG6VNpnINJsfug8oQjDyECQfgLUznQNScdHgyX9lESBLNfFUM
	J4/CvOJphR+r4Nf4efVhDtH5nhs2UlhAUkNg5Fc6AK9FB5D3NxH4h4thUzN8VOgs
	8pWJ3Qbie/R+vmfye2UVoSYiKzmaAvNYI+cJRZjP878ai7zQnjU1osxQH8X3Gbpr
	/LhNV5HZXqvPJPrsZHtOg==
X-ME-Sender: <xms:QrBYavbJxPyd5hbnWYV5tWArSvggPekAa5WE5Ddu_8Sknb3Fkcbbtg>
    <xme:QrBYaodhUkJlhM3igqz_6v5hFvcLzDyWhvfW-bFKXcyWwH56XjBo6Yg_ewC5CgdFG
    rVVoVLOVlEM1G51aBVKcGQMkK9oEupAavmU3LdMYOGzl45OS2S9gks>
X-ME-Received: <xmr:QrBYah0sAa-aZ2LjmIoRlfEd0g67FJQah5InHF57LtU2bhwkI-e27nA5R9ISmkS1szUFgL3HZfyaPnLD6ewePt0gT4f8-nDINH4>
X-ME-Proxy-Cause: dmFkZTG1pY5YrWHEb9mPBXb6bi8/VzGx58ImnKcrVBtMN5rwmev2AU79enQjP8UKZ35OLh
    jlGafQ1rpYgOW6wyLpdXUgkXZ+aBK4hprOrqS4+BK+9OtEFqfoAy3x4N2L2+ntHDl3TMYN
    KekK7dbc3efaVZoNOUsMglqLA8JU/1vyZS5+FP3QIcKGcH0dzKWNA1LpFTTv8K+hNe9vF6
    UQAiCaVntKdpyBZP5hUV3b+Ecy2g4vO2BjN3TFWbPP8PusBBAmP+yeVfJf+m9dRNsPVd1a
    qmtKhLdmhGWRYIKT78hreP2wYvj+CAI4j995I1WJMZ4jqLe68iyT28RXdGKQfSBtXtdCjg
    dKp7Vao7w1lncC2oK3sgAaHr0oYO5eMmXIgcrVagv9DFOaSXDZHyi7bicmd2qWqk6LcQwz
    xYKiY+9hcQyeOjNZ4pVQd0wwgU4tsmlbvlZ+lsuIJObbFcbZL+zvdqUpoo0NVqp/LquGqa
    sM+7Iy3GiRq76yCvh8U/BA2BcctwJmdUuI9n4DV+LQzVrOaCimpec1SSF2yzEVT5us3cpt
    dMfsZvuOcrcb+Dd46wlnBn9JeiPUFGnwoJYh55mXwyheBQ9ptCYmpnBDVUoYY2fx5eTU83
    52gTTFxGXxrdqKLhDUZayiT0uzxU8WtzBaUxiBjpLGj2bX9dXPI59U3KPphA
X-ME-Proxy: <xmx:QrBYanLRRvBhcCc_94nk1eP1YMj3colX7tbb--7k3MvbFjOPE6N__A>
    <xmx:QrBYaoFX-HJbMNkzhRJtda1d7wZqVZ8Wi7G10eSv3BHyHjUJAzCMwA>
    <xmx:QrBYarVFMBBfcZYV3mpLPnMoPDBAgI9MXWH2gPDdUWuqMBVW-vXVCQ>
    <xmx:QrBYaozaSKSw7qVdXRAoOPOksM_tiMNLXXqAhiBh0ir81CFg7GBwFw>
    <xmx:QrBYakKxtiJDyLt4Yfb5mK5n1vhT8Kk7gp0wexd48pverWQ1G8wpeMz3>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:19:44 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <c25cd3fe9919ad85d1e2147a294bfbd6ae2a2c21.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 15/31] swim: Don't use the mark register to read data
Date: Thu, 16 Jul 2026 20:02:15 +1000
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
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 1d394ee930d6..5caeba3a75d8 100644
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
 
@@ -133,7 +134,7 @@ crc1:	moveb	%a2@, %d5
 	dbmi	%d2, crc1
 	bpl	signal_nonyb
 
-	moveb	%a3@, %a4@(o_crc1)
+	moveb	%a5@, %a4@(o_crc1)
 
 	andb	#.Lhr_crc_error, %d5
 	bne	signal_nonyb
@@ -211,7 +212,7 @@ data_crc0:
 	dbmi	%d2, data_crc0
 	bpl	data_exit
 
-	moveb	%a3@, %d2
+	moveb	%a5@, %d2
 
 	moveq	#max_retry, %d2
 
@@ -221,7 +222,7 @@ data_crc1:
 	dbmi	%d2, data_crc1
 	bpl	data_exit
 
-	moveb	%a3@, %d2
+	moveb	%a5@, %d2
 
 	andb	#.Lhr_crc_error, %d5
 	bne	data_exit
-- 
2.52.0

