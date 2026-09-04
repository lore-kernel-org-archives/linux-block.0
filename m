Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461C443AA8;
	Fri,  4 Sep 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514511; cv=none; b=H/AyfYdmfbrx1bJ/ZSorMoQHrE40OeTE1c0I48NrIm0FRts2buRf/N6vk98sN1EbJEzAe0tIoufsGdYrpZ7TdYIV0//dFLvmGEJMMX0P38Z4KNgmD02hvg3RoaW8Gp1dRebEXwyv/x8/RKddn9dUOTtSR9WqsDBFaNResKXOwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514511; c=relaxed/simple;
	bh=VKUoMlUUTM7260szLHaRYLxLOMjF1geleJ6OkdjJmmk=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=YJRHMXbXmiruIl1KYPaeVL35n3C+/1zfJrkp7KhDuZJQqlAfzdfVO0SiXuzBfLTe/wjPeNKbOqzC8hN+j2qB3hqRc3vr9RGnKaNiR3nrpt0vUtNswlJJ4UB2kBB7tvHOWw7kyDFeeUYWqp70aFAiV1UHrCgQDumiD0GRUyIHkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/SMOmL9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/SMOmL9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD07214000B7;
	Fri,  4 Sep 2026 05:35:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 04 Sep 2026 05:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514509; x=
	1788600909; bh=pQLrz/ACQ7lA3/uYHUfM3yuICJ2vi3NVBe7zO3B88y0=; b=e
	/SMOmL9KXsx6dtU/b/RFc0OcvnDGQsDMb+O34Gj0Pnar5uJjdlMn9aaU9jx0tkaT
	x/C91SSaBAISbtAUJa+El2BlcyEutcx7kcds4wUEAbzhjYntqgQv7m9vum7aOSYW
	GlTnbbPQ629R8C359Gf2sBtJ1XpMvmYtYw8FWBG3meiujkVtby0jp2zzSUZGrzMN
	e0bHgwRhs27oZpD+NPauT2B/ErU23iJ5sgoDvotXtKZQt79U3gHyj9QjIeJVoO9J
	igoSgi0IRSp2IWtcj+k6mG/MA4XydbNOnVT2aX1ts1ALTDza8/z87G3i7hnKKnCg
	lRH6Jq/dxeLuNtDAD+r0Q==
X-ME-Sender: <xms:zZCaapbw_XUIqOV4iQdpVKfp7CzNqcQyReJQ9lISsCGlkad530dVzw>
    <xme:zZCaaqeT25ND5I2hVLhmonyCUqYwKJH8RNQ4f6tRqGxMStGtjM8FkS-t4YNC6w1fo
    d1nezM8v0FmTplXV8IM9rWmRxRddnpweMRK1p7zHROW2H1WPgpMPo3gGA>
X-ME-Received: <xmr:zZCaar1D9J7ZUX5a69U9NB6Z-GqqlYStq9X1L1pvgd1ZcQDjpLTBvUfULHFNgTvePU5NawSMI4sgeO99cFQrk3Tv1aabXMSiQ7I>
X-ME-Proxy-Cause: dmFkZTEgSwz66V+qSU0onCxC1F8ShoiVzEkD4nv3k8arPvEJrRCttwK35Oooa03yDS3V7Z
    X24bDVU3zk97dZjGWhXiX/ncGofJJNeEuYKgl31r/eDK9q5L7nwuD3/hEQU4j57irJs8tO
    84Cp9nRkKueV+P/Zh+1MA5C3iN5rv0++YXPj7VEh4HRI8ixbdKjZUIuiKKcqpAq6/i16Ze
    PQjCFsqYVbtDn7r5YuWGcGxoEjqVvREju6nRSm6O4BMaQ0J9b6++FaFcvgP73aZ6WigYRi
    RlMdiJjw76SzlSBX2alJJ3NXs6ywRX0EZbPP0m8cGOgA5DoC4o+kLwJIiLSJDXjG4wSOTh
    NSoUr2pmqeELn0ju9SGsWSeiCKfDHLgRf8sUJfx+p2FIbgPXHgV2IEbLaK+jPZcQT4j9gK
    iy62hQ/e3Bzxau11hqVz3GdPe3j+B7qVgmBfoctLUnb6Ku1ltpkjbF9MzLS2Z5Om2GC2gl
    5IPWMZoyBooZRZt23ua2XA2uDpdGjNbXDAwzGNBiR08fOpxvZDTMBHmBXh5GVWNqflG8Ow
    WBk5nIsHatkW77dKx9WZDBgeuwa5nuFzO2p5Yr5KR0i+YldVTYlyrUiOBokppdQez7TH/R
    uQtEWL9ucSni21D7b8NvoLt8D5/SGfo+6S/ylkxvg+7hTR5hBOaXglcYEILQ
X-ME-Proxy: <xmx:zZCaapKggQkJT2jCSUOvKRTRuAICp9_cVwIgwJB3ziRR64vYEDN_jg>
    <xmx:zZCaaiFImbhl0stdaAZ-hKI70ap98TBip21hDjzNThdVusTh1fbK7A>
    <xmx:zZCaatV5ZuFj67-5ZuUOfPaAS4GOHJMKclxh9pTZw881x_IZxnJIUw>
    <xmx:zZCaaizMsTipFQhhi2f5_G_w1-egtOiFqWMGzyeFrtxr_260zlGVLA>
    <xmx:zZCaauJ7T-_cJ5BS1Ikrht15dSfrNtkrt5dZoI28L2kCvCmsAH4Kirn4>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:35:08 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <acf12b671bbdbf5b986e41846f62ed8019d8d90b.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 23/33] swim: Remove pointless mode0 register write
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This write has no effect so remove it. (If side == 0 then no mode bit gets
cleared. If side == 1 then mode bit 0 gets cleared but that's pointless
because that bit is already clear here.)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index a67ccd4504b7..9bfda4b07ba9 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -464,7 +464,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 
 	swim_track(fs, track);
 	swim_head(base, side);
-	swim_write(base, mode0, side);
 
 	local_irq_save(flags);
 	for (i = 0; i < 36; i++) {
-- 
2.52.0

