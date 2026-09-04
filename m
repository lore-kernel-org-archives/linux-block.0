Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96809442FCE;
	Fri,  4 Sep 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514397; cv=none; b=S9HpD9ijtm+Uc5QCjWost2DlQisV7sz23RM3LzSP07YUYcD52biDYjD/0IQ+3pAZN6Hi0FzZ+mC/AZpFEtWLR4Wht47Wmo3OnwnADwQKlxYLSRZG9/lvb0a6mON83ZNSIAXjG5aWsooBWs7RkHmHx/Zftq9OKHtCbO87ZiYDFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514397; c=relaxed/simple;
	bh=nJY7w7cEh+7c64BYyL0LKpy2zDQj/yRgCMwLxC8ocPY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=SXYcOgFW5QMMhgHXu+eYBHHbyZUevB0eGzdH1pntdWBptnzV1q3YdkYUEt6jEi5JDDhcFC1ygcup2IqBv1cX/Zgga5ADA9dveMmTOLI0qV5fm8H50T+2a8ETnURrW7Ba2CYp5p0AuYCAiDAkTj7qWWBk3KM3/Ezp8kx54mDOOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0cusFMH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0cusFMH"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC3C41400060;
	Fri,  4 Sep 2026 05:33:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 04 Sep 2026 05:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514395; x=
	1788600795; bh=C0D7P8G6hTvt2FE5SH/vyr6jLBpriqH6H04iEj3x/3Y=; b=B
	0cusFMH0dJT9CkrhKlow2Hqh3tHMmJlpekBnZT7dyHK4Df/KM6f78G45G7Pt+qgS
	7sOqa2Hxgclok8gHWsfb6FVkRn7357bVJU45SORd7rb3DDVFrHmECeyoEycbBn2h
	BiPXYmT2O9OYghHBd9J4O8FcoUFpXq1BNpSFKhj14YX7Ggxz1/0+wRurI2MObUIy
	vvtN3WTP+RrQViRSFSYMumFVjeyg0o2RHm1Jro2/P9C0MsSFPb6rfztQNjp0F0F8
	Ym7mi0PsNT9HH9vHFDT0fAyJHzp79Burux62DLMSHjk/EXIj9i7PDpGRmkLcSaJ4
	jxtXUtBxw2DTWNWTgD8Nw==
X-ME-Sender: <xms:W5CaarMW_qD4QMvgJ-qcwk3-CzWhtdDx0MUp6RFYXEWfP6HnMxmIGA>
    <xme:W5CaagDc5U2G9REy7o7GdmjzdilZwVWLoVy4MqD3V7lBQ5g0vJY9RnkHn04ienPsj
    kMJR9UTcMMOrV8FmIkhhgWKDbNl4sRUsBH7aWR3CPNyZJdyAHHC0jLU>
X-ME-Received: <xmr:W5CaaqIHYfIviD3w80XdCAs2i1kx01qdSJhJSdcDwlm2usemFvfHqPRxqal8x1XibaraUdBDJVNyFqQ2vIQ4JVD7mGbtOKT3ccw>
X-ME-Proxy-Cause: dmFkZTEShLUtpn7KHoPqlWeaFg8DtB+/+ziGqKciJgq9h8mxt10y+H//Vk+lTV5bBElgOf
    OJVHuQ7kWguYfALzjze3yj08Q93Gx0vQ2Rc6DheMROSt10Fhzuw7qa6lOvsUomUINlECu7
    1gSGg3jE7tjuf54GQHw7Neo/DLHqg64dG+TJH3CTLFsovI7YuE6OvacA1XKtUXfCp5h+SI
    zMofHNYFCT0F3CzxXunyfBvVYDqHfQ37QvBka1g1fsKMciRCDxbiA2txribhyQoWCGZ98D
    NlAPrXmT5j9Wry+yrW1taOjx5QR3+y7SnDI1+hMrCGWBDRvDKvW4Xpge97CgPIwi5yzGWW
    leuE7IxeDEIr/b6eITb8Aj2OX1HXWvEQCgDNju5ZAKbcREX/c0Ue7Od2tCVNLsexU/IWT7
    h47XjqZHsXYEm+pV2gC/wRTfO/OAJdczBW+xZd+Ud2Elb0j3Vl8nkNOEtXWKZEvABhi5BC
    weqs5EdEGmFB5ZSRfGV6slv5AjVQENR8Wj/UDG2xLHTM2C0Kgp3ATnSxa0dcuOZ1OZDy7y
    QHc07lz0G08IRzlUDhpBezB+0zgZvA5dIpkXboZuvUNB5Dk1aBwIQ48waN31ylvBlSQ5M2
    4vNKvft71TuPYFxEKXZ82rG+tQzhEjypdzYmlukdV2XzldF1FPrf4YhwzVJw
X-ME-Proxy: <xmx:W5CaahPH7HNeG_N_tQxinIHN5eocAZAfIehy_hZ0DjEyKYCCFF1wRw>
    <xmx:W5Caag6TvKmdcI7qOwYl4T6__Zx240Ar3kKwSY2uR8PR-3bNhKFbYg>
    <xmx:W5Caar5OOtsCnfVN7sckijEhizYUemzyOHEX3kD6L9O-mv1EDuoong>
    <xmx:W5CaamHJ-D3LF6IOh1s7pBwrJSg87rYemp3eKRDWP03ZfEHblvcHug>
    <xmx:W5Caah-Q5a2jCTZN4-vZ79xsZcB9IS3vlY9KAU-29a7bOS9KBiudmYoC>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:33:13 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <aadb674d27d6e6d346d9b525597bf2e339c57e04.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 12/33] swim: Handle FIFO timeout error
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

When polling the FIFO for a mark byte in the sector header, don't
return zero if the timeout counter has expired, return an error code.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 3d7a2d87595a..208622ac4aeb 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -79,7 +79,7 @@ wait_addr_mark_byte:
 
 	tstb	%a2@
 	dbmi	%d2, wait_addr_mark_byte
-	bpl	header_exit
+	bpl	signal_nonyb
 
 	moveb	%a3@, %d3
 	cmpb	%a0@+, %d3
@@ -136,7 +136,6 @@ crc1:	tstb	%a2@
 
 	tstb	%a3@(read_error - read_mark)
 
-header_exit:
 	moveq	#0, %d0
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	rts
-- 
2.52.0

